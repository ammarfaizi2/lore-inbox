Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268675AbUGXPca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268675AbUGXPca (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 11:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268676AbUGXPca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 11:32:30 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:61482 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268675AbUGXPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 11:32:29 -0400
Date: Sat, 24 Jul 2004 11:31:53 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: device_suspend() levels [was Re: [patch] ACPI work on aic7xxx]
In-reply-to: <1090357324.1993.15.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Message-id: <410280E9.5040001@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
References: <40FD38A0.3000603@optonline.net>
 <20040720155928.GC10921@atrey.karlin.mff.cuni.cz>
 <40FD4CFA.6070603@optonline.net>
 <20040720174611.GI10921@atrey.karlin.mff.cuni.cz>
 <40FD6002.4070206@optonline.net> <1090347939.1993.7.camel@gaston>
 <40FD65C2.7060408@optonline.net> <1090350609.2003.9.camel@gaston>
 <40FD82B1.8030704@optonline.net> <1090356079.1993.12.camel@gaston>
 <40FD85A3.2060502@optonline.net> <1090357324.1993.15.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>save_state is a nonsense, didn't we kill it ? queue quiescing must be
>done by the upper level, which is a bit nasty with things like md &
>multipath... basically, the low level driver must have a way to notify
>it's functional parent (as opposed to it's bus parent) that it's going
>to sleep, and any path using this low level driver must then be
>quiesced, the parent must resume only when all the drivers it relies
>on are back up.
>
Isn't sysfs supposed to take care of this for us? IOW, I shouldn't have 
to call up to the SCSI midlayer from pcidev->suspend in order to notify 
it of a suspend, the midlayer should call the driver before we ever try 
to suspend. This may become important some day when the upper layers 
need to decide which order to bring pci devices down

Looking in /sys/devices shows that sysfs already knows that 'host0' is a 
child of a SCSI PCI device.

$ ls 
/sys/devices/pci0000\:00/0000\:00\:1e.0/0000\:02\:02.0/host0/0\:0\:0\:0/
block   detach_state    model  queue_depth  rev         state    type
delete  device_blocked  power  rescan       scsi_level  timeout  vendor

