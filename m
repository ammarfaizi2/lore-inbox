Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSEPHrX>; Thu, 16 May 2002 03:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSEPHrW>; Thu, 16 May 2002 03:47:22 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:61858 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S316598AbSEPHrU> convert rfc822-to-8bit;
	Thu, 16 May 2002 03:47:20 -0400
Date: Thu, 16 May 2002 09:47:14 +0200 (MEST)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] 2.4.19-pre8-jp12
In-Reply-To: <200205150007.AWD57178@netmail.netcologne.de>
Message-ID: <Pine.GSO.4.30.0205160941040.956-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I tried it. First I had a lot of compile problems (everything as module),
I had to disable at least 5 drivers (sorry I don't know exactly which were
them).
After compiling, depmod -a says:

unresolved symbols in
/drivers/char/drm/sis.o
/drivers/hotplug/pcihpacpi.o
/net/tux/tux.o

So even tux is unusable :(.


But the worst problem for is supermount:
# mount -t supermount -o dev=/dev/cdrom none /mnt/cdrom
# ls -l /mnt/cdrom
ls: .: Stale NFS handle                (~or something similar)
[...]                                  (and it lists the file)

But:
# cd /mnt/cdrom
# ls -l
ls: .: Stale NFS handle
#                                      (and it doesn't even list the files)



On Wed, 15 May 2002, [iso-8859-15] Jörg Prante wrote:

> Linux kernel patch set 2.4.19pre8-jp12
>
> This is the twelvth release of the -jp patch set.
>
> http://infolinux.de/jp12/
>
> Status: 15 May 2002 00:45 CEST
>
> Changes from jp11 to jp12
>
> Updates: XFS update to CVS as of 13 May 2002, new IDE convert all 10,
> Alsa compile fix, IDE CD DMA upgrade. New patches included in this
> version: Momchil Velikov/Christoph Hellwig's radix tree pagecache
> (adapted to work with rmap/preempt/lockbreak and XFS), Jens Axboe's
> IDE tagged command queue support, Robert Love's latest additional
> miscellanous scheduler patches.
>
> Known Issues
>
> The miroSound PCM20 radio audio driver depends on OSS sound include
> file and is no longer compileable. IDE CD should be fixed. I did not
> find the bug but it could be in the IDE patch, or some interaction
> with it I did not understand. Anyway, cdfs does not work, it will
> mount, but oops when stat()ing a directory. The drive will be locked
> until reboot. This is caused by an interaction between the new code
> in IDE, supermount, and cdfs and must be investigated.
>
> What is it?
>
> The -jp kernels are development kernels for testing purpose only. They
> will appear regularly two or three times a month. Their purpose is to
> provide a service for developers who can't keep up to date with the
> latest kernel and patch versions, but want to test new features and
> evaluate enhancements that are not to be expected for inclusion into
> the mainstream 2.4 kernel.
>
> Download
>
> http://infolinux.de/jp12/patch-2.4.19-pre8-jp12.tar.bz2
>
>
> Patch set overview
>
> 01_kernel-sound-remove-0-pre8  34_llseek
> 01_kernel-sound-remove-1-pre7  35_mount
> 01_kernel-sound-remove-2-pre6  36_device
> 01_kernel-sound-remove-3-pre5  37_supermount
> 01_kernel-sound-remove-4-pre4  38_xfs-kdb-from-cvs-04May2002
> 01_kernel-sound-remove-5-pre3  39_xfs-13May2002
> 01_kernel-sound-remove-6-pre2  40_xfs-kdb-adapt
> 01_kernel-sound-remove-7-core  41_xfs-kdb-fixups
> 02_alsa-sound-0.9.0rc1         42_jfs-1.0.14-0
> 03_alsa-adapt                  43_jfs-1.0.14-15
> 04_TIOCGDEV                    44_jfs-1.0.15-16
> 05_boot-time-ioremap           45_jfs-1.0.16-17
> 06_via-northbridge-fixup       46_jfs-adapt
> 07_jiffies-for-i386            47_ftpfs-0.6.2
> 08_rmap-13                     48_cdfs-0.5b
> 09_rmap13a                     49_cdfs-0.5bc
> 10_sched-O1-K3                 50_patch-int-2.4.18.2
> 11_up-apic-fix                 51_loop-jari
> 12_remove-wake-up-sync         52_grsecurity-1.9.5-pre3
> 13_need-resched-abstraction    53_grsecurity-adapt
> 14_frozen-lock                 54_i2c-2.6.3
> 15_sched-yield                 55_lmsensors-2.6.3
> 16_more-sched-yield            56_freeswan-1.97
> 17_need-resched-check          57_ide-cd-dma-4
> 18_maxrtprio-1                 58_lowlatency-mini
> 19_maxrtprio                   59_lowlatency-fixes-5
> 20_migration-thread            60_mmx-init
> 21_updated-migration-init      61_p4-xeon
> 22_misc-stuff                  62_x86-fast-pte
> 23_preempt-2.4.19pre8          63_acpi-20020503
> 24_lockbreak                   64_acpi-pciirq-17
> 25_ide-all-convert-10          65_remove-khttpd
> 26_md-locks                    66_tux2-final-A3
> 27_raid-split                  67_sis-740-961
> 28_md-part                     68_radix-tree-pagecache-2.4.19pre5ac3
> 29_mdp-major                   69_radix-tree-pagecache-xfs-fix
> 30_autofs4                     70_block-tag-2.4.19pre8
> 31_isrdonly                    71_ide-tag-2.4.19pre8
> 32_new-stat                    98_tkparse-4096
> 33_mediactl                    99_VERSION
>
> More info available at
>
> http://infolinux.de/jp12
>
>
> Jörg Prante
> joerg@infolinux.de
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Balazs Pozsar

