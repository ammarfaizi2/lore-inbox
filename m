Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUGTUJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUGTUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 16:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUGTUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 16:08:55 -0400
Received: from dyn-128-59-150-112.dyn.columbia.edu ([128.59.150.112]:28289
	"EHLO linux.site") by vger.kernel.org with ESMTP id S266244AbUGTUD7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 16:03:59 -0400
Message-ID: <40FD7AA4.4090206@plasma.ap.columbia.edu>
Date: Tue, 20 Jul 2004 16:03:48 -0400
From: David Lazanja <lazanja@plasma.ap.columbia.edu>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Craig I. Hagan" <hagan@cih.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: firewire drive / sbp2 module
References: <200407190231.19269.lazanja@plasma.ap.columbia.edu> <Pine.LNX.4.58.0407201226250.25199@svr.cih.com>
In-Reply-To: <Pine.LNX.4.58.0407201226250.25199@svr.cih.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig I. Hagan wrote:
>>I compiled 2.6.7 using the configuration from suse's 2.6.5-7.95-default kernel 
>>but still have no success.  All of the correct modules are loading.
> 
> 
> I'm using stock 2.6.7 on top of gentoo and have had no problems with firewire
> drives (i'm using a pci fw card)
> 
> 

Just wanted to clarify, I compiled a "vanilla" kernel from www.kernel.org.
I used the config file from suse so that I do not have to go through all
the configuration options.

>>>From the kernel messages (below), it seems that sbp2 is failing.  I was 
>>looking around on the list and found some others are also having problems
>>with sbp2.  I'm trying to find out if this is a known general problem under 
>>2.6 or if it's specific to the drive that I'm using (Buslink 80GB usb2 / 
>>firewire combo).
> 
> 
> I've not had problems with 2.6.x and firewire, otoh, i'm running pci vs. pcmcia
> devices. have you confirmed your drive works on a different system or os?
> 
The drive works with usb1 using kernel 2.4.xx on the same laptop.
It works with usb2 (pci) using kernel 2.4.xx on a different laptop.
The drive worked with the Belkin F5U512 pcmcia firewire using kernel 
2.4.xx on both laptops.

I'm trying to determine if the firewire modules are causing the problem 
or if it's sbp2.  Below is part of the kernel log.  The only thing that 
I can find about the firewrie card is
"ieee1394: unsolicited response packet received - no tlabel match".  I 
don't know if this os OK.

Kernel Log:

Jul 18 18:32:21 linux kernel: ieee1394: Initialized config rom entry 
`ip1394'
Jul 18 18:32:21 linux kernel: ohci1394: $Rev: 1203 $ Ben Collins 
<bcollins@debian.org>
Jul 18 18:32:21 linux kernel: PCI: Enabling device 0000:02:00.0 (0000 -> 
0002)
Jul 18 18:32:21 linux kernel: PCI: Setting latency timer of device 
0000:02:00.0 to 64
Jul 18 18:32:21 linux kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): 
IRQ=[9]  MMIO=[18804000-188047ff]  Max Packet=[2048]
Jul 18 18:32:22 linux kernel: ieee1394: Host added: ID:BUS[0-00:1023] 
GUID[000030bd00000000]
Jul 18 18:33:07 linux kernel: ieee1394: Node added: ID:BUS[0-00:1023] 
GUID[0006ca0e04002625]
Jul 18 18:33:07 linux kernel: ieee1394: Node changed: 0-00:1023 -> 0-01:1023
Jul 18 18:33:07 linux kernel: ieee1394: unsolicited response packet 
received - no tlabel match
Jul 18 18:33:12 linux kernel: sbp2: $Rev: 1205 $ Ben Collins 
<bcollins@debian.org>
Jul 18 18:33:12 linux kernel: scsi4 : SCSI emulation for IEEE-1394 SBP-2 
Devices
Jul 18 18:33:13 linux kernel: ieee1394: sbp2: Logged into SBP-2 device
Jul 18 18:33:13 linux kernel: ieee1394: Node 0-00:1023: Max speed [S400] 
- Max payload [2048]
Jul 18 18:33:13 linux kernel:   Vendor: SAMSUNG   Model: SP0802N 
    Rev:
Jul 18 18:33:13 linux kernel:   Type:   Direct-Access 
    ANSI SCSI revision: 06
Jul 18 18:33:13 linux kernel: SCSI device sda: 156368016 512-byte hdwr 
sectors (80060 MB)
Jul 18 18:33:13 linux kernel: sda: asking for cache data failed
Jul 18 18:33:13 linux kernel: sda: assuming drive cache: write through
Jul 18 18:33:43 linux kernel:  sda:<3>ieee1394: sbp2: aborting sbp2 command
Jul 18 18:33:43 linux kernel: Read (10) 00 00 00 00 00 00 00 08 00
Jul 18 18:34:13 linux kernel: ieee1394: sbp2: aborting sbp2 command
Jul 18 18:34:13 linux kernel: Test Unit Ready 00 00 00 00 00
Jul 18 18:34:13 linux kernel: ieee1394: sbp2: reset requested
Jul 18 18:34:13 linux kernel: ieee1394: sbp2: Generating sbp2 fetch 
agent reset
Jul 18 18:34:43 linux kernel: ieee1394: sbp2: aborting sbp2 command

