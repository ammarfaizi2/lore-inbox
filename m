Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWJBPWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWJBPWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 11:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWJBPWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 11:22:30 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27788 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964779AbWJBPW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 11:22:29 -0400
From: Andi Kleen <ak@suse.de>
To: Wink Saville <wink@saville.com>
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with 2.6.18 kernel
Date: Mon, 2 Oct 2006 17:22:21 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <45206777.7020405@saville.com> <p733ba7hwlh.fsf@verdi.suse.de> <45212BFB.3080708@saville.com>
In-Reply-To: <45212BFB.3080708@saville.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021722.21987.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 17:10, Wink Saville wrote:
> Andi,
> 
> Attached is the log file captured via a serial port with initcall_debug 
> enabled and loglevel=7. 


[  106.985759] Calling initcall 0xffffffff80460a30: nvidiafb_init+0x0/0x240()
[  106.992698] ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[  107.000200] nvidiafb: Device ID: 10de0391 
[  107.008307] nvidiafb: CRTC0 analog found
[  107.016390] nvidiafb: CRTC1 analog not found
[  107.042392] nvidiafb: EDID found from BUS1
[  107.200423] nvidiafb: EDID found from BUS2
[  107.204509] nvidiafb: CRTC 0 appears to have a CRT attached
[  107.210067] nvidiafb: Using CRT on CRTC 0
[  107.214820] nvidiafb: MTRR set to ON

It seems to lock up in the nvidia fb driver. Can you disable that
and if that helps contact the maintainer of it?

It might be also just the MTRR so possibly booting 
with video=nvidiafb:nomtrr might help too.


> BTW, if I didn't have a serial port what other  
> mechanisms are available to capture the logs if the kernel won't boot?

If you have a ieee1394 port and a cable you can use firescope
from a second box (ftp://ftp.firstfloor.org/pub/ak/firescope/) 

If it crashes late enough at boot you can use ethernet netconsole
(/usr/src/linux/Documentation/networking/netconsole.txt) 

Or a lot of people use a digital camera to photograph the oopses.
If you do that make sure to either use frame buffer with a small
font or CONFIG_VIDEO_SELECT=y vga=ask select smallest resolution possible,
otherwise the oopses typically don't fit on the screen.  

.jpgs should be only last resort though, the other options
are definitely preferred.

-Andi
