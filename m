Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSFOJgs>; Sat, 15 Jun 2002 05:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSFOJgr>; Sat, 15 Jun 2002 05:36:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:10226 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S315213AbSFOJgp>; Sat, 15 Jun 2002 05:36:45 -0400
Date: Sat, 15 Jun 2002 11:36:17 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Lionel Bouton <Lionel.Bouton@inet6.fr>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 hardlock w/ hdparm
In-Reply-To: <Pine.LNX.4.44.0206150948140.30400-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.SOL.4.30.0206151135060.11233-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Jun 2002, Zwane Mwaikambo wrote:

> Hi Lionel, Martin,
> 2.5.20, hdparm + IDE deadlocks on my testbox
>
> kernel:Linux version 2.5.20+prempt (zwane@montezuma.mastecende.com) (gcc version
> 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #24 SMP Wed Jun 5 21:48:07 SAST 2002
>
> ata subsys:
> ATA/ATAPI device driver v7.0.0
> ATA: PCI bus speed 33.3MHz
> ATA: Silicon Integrated Systems [SiS] 5513 [IDE], PCI slot 00:00.1
> PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try using pci=biosirq.
> ATA: chipset rev.: 208
> ATA: non-legacy mode: IRQ probe delayed
> SiS620
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
> hda: WDC WD75DA-00AWA1, DISK drive
> hdb: WDC AC11200L, DISK drive
> hdc: ST310212A, DISK drive
> hdd: ATAPI CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
>  hda: 14666400 sectors w/2048KiB Cache, CHS=15520/15/63, UDMA(66)
>  hda: [PTBL] [912/255/63] hda1 hda2 hda3 hda4
>  hdb: 2503872 sectors w/256KiB Cache, CHS=2484/16/63, DMA
>  hdb: [PTBL] [621/64/63] hdb1
>  hdc: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
>  hdc: [PTBL] [1245/255/63] hdc1 hdc2 hdc3
>  hdc2: <netbsd: hdc5 hdc6 >
> hdd: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
>
> strace hdparm /dev/hda:
> lseek(3, 0, SEEK_SET)                   = 0
> lseek(3, 0, SEEK_SET)                   = 0
> lseek(3, 0, SEEK_SET)                   = 0
> lseek(3, 0, SEEK_SET)                   = 0
> getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={993, 770000}}) = 0
> write(1, "128 MB in  4.35 seconds = 29.43 "..., 39128 MB in  4.35 seconds = 29.43 MB/sec) = 39
> fsync(3)                                = 0
> ioctl(3, BLKFLSBUF, 0)                  = 0
> ioctl(3, 0x31f, 0)                      = 0
> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> nanosleep({1, 0}, {1, 0})               = 0
> shmdt(0x4001f000)                       = 0
> shmget(IPC_PRIVATE, 1048576, 0x180|0600) = 32768
> shmctl(32768, 0x10b /* SHM_??? */, 0)   = 0
> shmat(32768, 0, 0)                      = 0x4001f000
> shmctl(32768, 0x100 /* SHM_??? */, 0)   = 0
> sync()                                  = 0
> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> nanosleep({3, 0}, {3, 0})
> *** dead as a doorpost ***
> write(1, " Timing buffered disk reads:  ", 30 Timing buffered disk reads:  ) = 30
> setitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 0}}, NULL) = 0
> getitimer(ITIMER_REAL, {it_interval={1000, 0}, it_value={1000, 0}}) = 0
> read(3, "3\300\216\320\274\0|\373P\7P\37\374\276\33|\277\33\6PW"..., 1048576) = 1048576
>
> I was going to test a disk w/o DMA (try to cover all the bases) but i got the
> following repeatedly until it locks up again;
> hdb: lost interrupt
> hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdb: drive not ready for command
>
> Now i'm not 100% sure wether this is even an ATA problem (although my SCSI
> based testbox survived) and pretty certain its not an SiS controller
> problem but i'll try and find the point where it deadlocks, pretty bad
> bug report, please tell me which information you'd really want.
>
> btw Martin you seem to like pain so get ready for when i whip out the old
> Quantum mavericks, 486 (SiS) and Opti621 card ;)
				   ^^^^^^^^^^^^
I'm just cleaning driver for it :-)


>
> Thanks,
> 	Zwane Mwaikambo
> --
> http://function.linuxpower.ca
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

