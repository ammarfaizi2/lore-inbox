Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVF0XYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVF0XYY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVF0XVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:21:35 -0400
Received: from magic.adaptec.com ([216.52.22.17]:15300 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262126AbVF0XTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:19:32 -0400
Message-ID: <42C0897A.8010705@adaptec.com>
Date: Mon, 27 Jun 2005 19:19:22 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Question on "embedded" classes
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jun 2005 23:18:34.0612 (UTC) FILETIME=[8A41E340:01C57B6E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was wondering what the reason was for allowing
class and classdev to only be at level 3 and level
4 respectively of sysfs (/ is level 0)?

1) Some devices would not have any relevance
ouside the scope of the "parent" device.
2) "Hooking" them all at /sys/class/ level
would create quite a lot of symlinks (and with
cryptic names in order to reference the proper
"parent" device in the same directory).

E.g. Some devices, like SAS host adapters, have "devices
inside devices" and I'd like to represent this in
sysfs.

/sys/class/sas          (a class)
/sys/class/sas/ha0/     (a classdev)
/sys/class/sas/ha1/     (a classdev)

/sys/class/sas/ha0/device -> symlink to PCI device
/sys/class/sas/ha0/device_name    (text attribute)

/sys/class/sas/ha0/phys/     (a class)
/sys/class/sas/ha0/phys/0/   (a classdev)

etc.

Question: how does one "marry" the class to the classdev?

Or what is the alternative?

Thanks,
	Luben

