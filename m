Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSL3NIp>; Mon, 30 Dec 2002 08:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbSL3NIp>; Mon, 30 Dec 2002 08:08:45 -0500
Received: from cibs9.sns.it ([192.167.206.29]:518 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S266964AbSL3NIi>;
	Mon, 30 Dec 2002 08:08:38 -0500
Date: Mon, 30 Dec 2002 14:16:48 +0100 (CET)
From: venom@sns.it
To: Paul Rolland <rol@as2917.net>
cc: "'John Stoffel'" <stoffel@lucent.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.53] So sloowwwww......
In-Reply-To: <00bf01c2af60$cc842a10$2101a8c0@witbe>
Message-ID: <Pine.LNX.4.43.0212301414030.24660-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same scsi controller on a tbird Athlon
1300 Mhz with 1GB of RAM, and i found it (2.5.53 compiled with gcc 3.2.1)
a little faster (full kernel preemption is not enabled),
except for some process using a lot of fork().

Luigi

On Sun, 29 Dec 2002, Paul Rolland wrote:

> Date: Sun, 29 Dec 2002 18:36:19 +0100
> From: Paul Rolland <rol@as2917.net>
> To: 'John Stoffel' <stoffel@lucent.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [2.5.53] So sloowwwww......
>
> Hello,
>
> > Paul> I'm just playing a little bit with Kernel 2.5.53, and I've been
> > Paul> afraid of finding it quite slow...
> >
> > Not a bad report, but you didn't give any info on the machine
> > configuration in terms of:
> >
> > - CPU type and speed
> > - memory
> > - disk
> >
> Correct. Here are some more :
> 6 [18:34] rol@donald:/kernels> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 2
> model name      : Intel(R) Pentium(R) 4 CPU 2.40GHz
> stepping        : 4
> cpu MHz         : 2423.933
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 4836.55
>
> 7 [18:34] rol@donald:/kernels> cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  526839808 516452352 10387456        0 18071552 403718144
> Swap: 3764346880  2527232 3761819648
> MemTotal:       514492 kB
> MemFree:         10144 kB
> MemShared:           0 kB
> Buffers:         17648 kB
> Cached:         392980 kB
> SwapCached:       1276 kB
> Active:         289588 kB
> Inactive:       167568 kB
> HighTotal:           0 kB
> HighFree:            0 kB
> LowTotal:       514492 kB
> LowFree:         10144 kB
> SwapTotal:     3676120 kB
> SwapFree:      3673652 kB
>
> 8 [18:34] rol@donald:/kernels> df -aT
> Filesystem    Type   1K-blocks      Used Available Use% Mounted on
> /dev/hda2     ext3     2063536   1210488    748224  62% /
> none          proc           0         0         0   -  /proc
> /dev/hda8     ext3    46267844   7936068  35981472  19% /data
> none        devpts           0         0         0   -  /dev/pts
> none         tmpfs      257244         0    257244   0% /dev/shm
> /dev/hda4     ext3    12317944    404104  11288112   4% /usr/local
> /dev/hda7     ext3     2063504     99620   1859064   6% /var
> /dev/sda1     ext3    10320888    692592   9103960   8% /kernels
> /dev/sda3     ext3     7740648    630368   6717016   9% /witbe
> /dev/sda6 reiserfs    10919580     32840  10886740   1% /divers
> /dev/hdb6 reiserfs    29406044  19067932  10338112  65% /mp3
> /dev/hda1     ntfs     2096450   1279606    816844  62% /diskC
> /dev/hda5     ntfs    10241404   4065772   6175632  40% /diskF
> /dev/hdb2     vfat     5122732   3047232   2075500  60% /diskD
> /dev/hdb5     vfat     5122704    900844   4221860  18% /diskE
> /dev/cdrom iso9660       60760     60760         0 100% /mnt/cdrom
>
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> SIS5513: IDE controller on PCI bus 00 dev 15
> SIS5513: chipset revision 0
> SIS5513: not 100% native mode: will probe irqs later
> SiS5513
>     ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:DMA
> hda: WDC WD800BB-00CAA1, ATA DISK drive
> hdb: IC35L040AVER07-0, ATA DISK drive
> hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
> hdd: TDK CDRW4800B, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=9729/255/63
> hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=5005/255/63
> hdc: ATAPI 32X DVD-ROM drive, 512kB Cache
> Uniform CD-ROM driver Revision: 3.12
> ide-cd: passing drive hdd to ide-scsi emulation.
> ide-floppy driver 0.99.newide
> Partition check:
>  hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 > hda4
>  hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 >
> ...
> SCSI subsystem driver Revision: 1.00
> scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
>         <Adaptec 2940 Ultra2 SCSI adapter>
>         aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
>
> (scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
>   Vendor: FUJITSU   Model: MAN3367MP         Rev: 5507
>   Type:   Direct-Access                      ANSI SCSI revision: 03
> scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
> ...
>
> Hope this helps,
> Regards,
> Paul
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

