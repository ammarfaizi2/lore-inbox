Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTGKOSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTGKOQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:16:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:4280
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261769AbTGKOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:14:14 -0400
Subject: Re: 2.5 'what to expect'
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030711140219.GB16433@suse.de>
References: <20030711140219.GB16433@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 Jul 2003 15:26:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-11 at 15:02, Dave Jones wrote:
> - An additional bug biting some people is that NICs fail to receive packets
>   (usually notable by a NIC not getting a DHCP lease for eg, despite being
>    sent one by the server). Booting with "noapic" "acpi=off" or a combination
>   of both fixes this for most people. Additional breakage reports should go
>   to Jeff Garzik <jgarzik@pobox.com>

For 3com that was fixed in 2.4-ac months ago. There is a mostly
undocmented power management bitflag that some bioses seem to know about
for ACPI

> - (Possibly linked to above bug) VIA APIC routing is currently broken.
>   boot with 'noapic'.

Does 2.5 not have the INTD routing fix yet ?

> - The hptraid/promise RAID drivers are currently non functional, and
>   will probably be converted to use device-mapper.
> - Some filesystems still need work (Intermezzo, UFS, HFS, HPFS..)
The hfsplus file system is missing from 2.5 at the moment

> - Some people seem to have trouble running rpm, most notably Red Hat 9 users.
>   This is a known bug of rpm.
>   Workaround: run "export LD_ASSUME_KERNEL=2.2.5", before running rpm.

or upgrade to rpm 4.2 (which I'd recommend everyone does anyway as it
fixes a load of other problems) - ftp.rpm.org

> - Older Direct Rendering Manager (DRM) support (For XFree86 4.0)
>   has been removed. Upgrade to XFree86 4.1.0 or higher.

The current 2.5 DRM doesnt seem to work with 4.1, but does with  4.3 at
least on my testing of i810. I need to double check the results unless
others see the same

> Modules.
> ~~~~~~~~

> - For Red Hat users, there's another pitfall in "/etc/rc.sysinit".
>   During startup, the script sets up the binary used to dynamically load
>   modules stored at "/proc/sys/kernel/modprobe". The initscript looks
>   for "/proc/ksyms", but since it doesn't exist in 2.5 kernels, the
>   binary used is "/sbin/true" instead.

Better to cite the explanation and fix in the FAQ/README for the new
module tools 8)

> Enhanced coredumping. 
> ~~~~~~~~~~~~~~~~~~~~~
> - 2.5 offers you the ability to configure the way core files are
>   named through a /proc/sys/kernel/core_pattern file.
>   You can use various format identifiers in this name to affect
>   how the core dump is named.

So does 2.4 8)
2.4-ac also offers setuid core dump facilities I need to forward port


> - Multithreaded processes can now dump core

> IDE.
> ~~~~
> - Known problems with the current IDE code. 
>   o  Serverworks OSB4 may panic on bad blocks or other non fatal errors
FIXED
>   o  PCMCIA IDE hangs on eject
Should be fixed in 2.5, fixed(ish) in 2.4
>   o  ide_scsi is completely broken in 2.5.x. Known problem. If you need it
>      either use 2.4 or fix it 8)
> - IDE disk geometry translators like OnTrack, EZ Partition, Disk Manager
>   are no longer supported. The only way forward is to remove the translator
>   from the drive, and start over.

Or to use device mapper to remap the disk.


> CD Recording.
> ~~~~~~~~~~~~~
> - Jens Axboe added the ability to use DMA for writing CDs on
>   ATAPI devices. Writing CDs should be much faster than it
>   was in 2.4, and also less prone to buffer underruns and the like.

Currently generally crashes the machine on problems or if you have
anything touching the other channel

> - gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
>   kmalloc optimisation introduced in 2.5.71
>   See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410

This URL appears wrong!

> to 2.5. For this reason 2.5.x kernels should not be tested on
> untrusted systems.  Testing known 2.4 exploits and reporting results
> is useful.

There is at least one known local root exploit in 2.5.75


> Ports.
> ~~~~~~
> - 2.5 features support for several new architectures.
>   - x86-64 (AMD Hammer)
>   - ppc64
>   - UML (User mode Linux)
>     See http://user-mode-linux.sf.net for more information.
>   - uCLinux: m68k(w/o MMU), h8300 and v850.  sh also added a uCLinux option.
> - The 64 bit s390x port got collapsed into a single port, appearing
>   as a config option in the base s390 arch.
> - In the opposite direction, arm26 was split out from arm.

sh64 ?


