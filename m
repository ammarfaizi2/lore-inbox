Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSFSWPR>; Wed, 19 Jun 2002 18:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318036AbSFSWPP>; Wed, 19 Jun 2002 18:15:15 -0400
Received: from mail.science.uva.nl ([146.50.4.51]:28053 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S318035AbSFSWPP>; Wed, 19 Jun 2002 18:15:15 -0400
Message-Id: <200206192213.g5JMDu823286@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rvandijk@science.uva.nl>
Reply-To: rvandijk@science.uva.nl
Organization: UvA
To: Dave Jones <davej@suse.de>
Subject: Re: Linux 2.5.23-dj2
Date: Thu, 20 Jun 2002 00:16:59 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020619205136.GA18903@suse.de> <200206192133.g5JLXH814796@mail.science.uva.nl> <20020619234035.R29373@suse.de>
In-Reply-To: <20020619234035.R29373@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 23:40, Dave Jones wrote:
> On Wed, Jun 19, 2002 at 11:36:20PM +0200, Rudmer van Dijk wrote:
>  > Ok I can run -dj2, but I cannot use X 8-( although this time no BUG or
>  > panic.
>
> 1, any agpgart related messages in the logs/dmesg ?

output from dmesg (didn't cut too much I hope):
Linux version 2.5.23-dj2 (rudmer@gandalf) (gcc version 2.95.3 20010315 
(release)) #1 Wed Jun 19 23:16:06 CEST 2002
Video mode to be used for restore is ffff
<snip>
255MB LOWMEM available.
<snip>
Kernel command line: BOOT_IMAGE=lin2.5 ro root=302 hdc=ide-scsi 2
<snip>
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router SIS [1039/0008] at 00:02.0
__iounmap: bad address d0802030
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
<snip>
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected SiS 735 chipset
agpgart: AGP aperture is 32M @ 0xd0000000
[drm] AGP 0.99 on SiS @ 0xd0000000 32MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
block: 256 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 512K size 1024 blocksize

I just saw the iounmap error, maybe related??


> 2. Can you disable agpgart, and try again. I'm fairly certain this
>    is the cause, but just in case..

Did not try this yet (will do it tomorrow evening), but the X failure was 
related to my mouse setup: /dev/mouse pointed to /dev/psaux which is not 
available in 2.5.xx-djX. when I corrected this to /dev/mouse0 I got a working 
X again 8-)

however, when I started X from the bootscript, that is the bootscript starts 
kdm which in turn starts the X server, I got the same oops as before...
the process that causes the oops appears to be chmod, if you want the whole 
oops, please tell and I will write it down (cannot use a serial console...).

so the agpgart split seems to work fine here, but there is clearly something 
wrong when kde2 tries to start.

	Rudmer
