Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbTJJFg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 01:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTJJFg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 01:36:28 -0400
Received: from ns1.triode.net.au ([202.147.124.1]:42706 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP id S262419AbTJJFgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 01:36:25 -0400
Message-ID: <3F864525.3040009@torque.net>
Date: Fri, 10 Oct 2003 15:35:33 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: Chris Friesen <chris_friesen@sympatico.ca>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: problems with scsi disk, scsi generic, and compact flash reader
References: <3F860227.3040909@sympatico.ca>
In-Reply-To: <3F860227.3040909@sympatico.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> I have a 2.6.0-test6 kernel with the jumpshot card reader.  I can
> compile the generic scsi driver no problem, and when I insert the flash
> card I get the following log entry:
> 
> Oct  9 20:33:30 doug kernel: hub 2-1:1.0: new USB device on port 2,
> assigned address 4
> Oct  9 20:33:30 doug kernel: scsi1 : SCSI emulation for USB Mass Storage
> devices
> Oct  9 20:33:30 doug kernel:   Vendor: Lexar     Model: Jumpshot USB CF
>   Rev: 0001
> Oct  9 20:33:30 doug kernel:   Type:   Direct-Access
>   ANSI SCSI revision: 02
> Oct  9 20:33:30 doug kernel: Attached scsi generic sg1 at scsi1, channel
> 0, id 0, lun 0,  type 0
> 
> 
> When I try and load the sd_mod module, that terminal just simply freezes
> and I can't break out.  Similarly, if I compile scsi disk support right
> into the kernel, it sits forever at boot time. 

Chris,
The compact flash probably doesn't like a MODE SENSE
command it is being sent by the sd driver. When sd is
a module then if your other (pseudo) terminals are alive
after 'modprobe sd_mod' locks up then perhaps you could
try 'ps -eo cmd,wchan' on another terminal and report
the result for that modprobe.

Some patches went into sd recently (and more are being discussed)
to lower the MODE SENSE traffic during sd initialization. There
is a very wide range of devices that use the scsi command set
and there is no easy way to know during scan/initialization
how well a device will handle some commands (scsi_level ??).

Another thing you could do is fetch sg3_utils from
http://www.torque.net/sg and report the result of
'sg_modes -a /dev/sg1'. That will report the MODE SENSE
commands the device claims to support. [BTW Run 'sg_modes'
before you try to 'modprobe sd_mod'.]

Doug Gilbert



