Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUJFAal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUJFAal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUJFAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:30:40 -0400
Received: from mail-7.tiscali.it ([213.205.33.27]:25440 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S266491AbUJFAaE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:30:04 -0400
Date: Wed, 6 Oct 2004 02:30:01 +0200
Message-ID: <4136E4660006E2F7@mail-7.tiscali.it>
In-Reply-To: <4136E7EF00073144@mail-3.tiscali.it>
From: "Gianluca Cecchi" <gianluca.cecchi@tiscali.it>
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,
please CC me to your replies as I'm not currently a subscriber; thanks in
advance.
Excuse me for the long text: it contains information about behaviour of
my system.
This thread had no news about 1) dma settings considerations and 2) heavy
cpu load during
heavy I/O operations 3) summary on performance/smartness of system.

My system is a Dual Athlon 1800MHz with 1Gb of ram.
There are 2xsata disks (Maxtor 6Y120M0 120Gb each) and I have a Magnex KW571S
PCI ATA RAID card, that is based on Sil Image 3112a chipset (two indipendent
sata
 channels).
I'm not planning to use the raid provided by the card.
My os is a Slackware 10.0 upgraded to -current (01/10/04) with kernel.org
2.6.8.1
 kernel.
Eventually I can provide config. Btw, I'm using udev and kernel preemption.
The os was transferred and LILO reinstalled from a previous 18Gb scsi disk.
At this moment I'm using only the first sata disk.
Output of my dmesg is:

libata version 1.02 loaded.
sata_sil version 0.54
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 16 (level, low) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xF8811080 ctl 0xF881108A bmdma 0xF8811000 irq
177
ata2: SATA max UDMA/100 cmd 0xF88110C0 ctl 0xF88110CA bmdma 0xF8811008 irq
177
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
88:207f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata1: dev 0 configured for UDMA/100
scsi2 : sata_sil
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003
88:207f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata2: dev 0 configured for UDMA/100
scsi3 : sata_sil
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 >
Attached scsi disk sdb at scsi3, channel 0, id 0, lun 0

Point 1)
Jeff Garzik confirmed that DMA is always enabled when sata drives are seen
as
scsi devices.
But do I have to worry or not about the lines
ata1: SATA max UDMA/100 cmd 0xF8811080 ctl 0xF881108A bmdma 0xF8811000 irq
177
...
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors:
ata1: dev 0 configured for UDMA/100
and the same for ata2?

Shouldn't I see max UDMA/133 for the controller, instead of 100?
I have also an IDE disk in the system.
hdparm -i on it gives:
/dev/hdb:

 Model=SAMSUNG SP0411N, FwRev=TW100-07, SerialNo=0611J1AW931372
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=66055248
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=no WriteCache=enabled
 Drive conforms to: (null):

Does this interfere in some way with sata disk udma settings?
I'm not able to detach it at the moment, but as soon as I can, I'll let
you know
eventually.

Point 2)
As Petr Sebor, I also have serious  problems when doing heavy I/O, especially
in read operations. Any hints?

My hdparm -tT values are good, I think:

hdparm -tT /dev/sda

/dev/sda:
 Timing cached reads:   960 MB in  2.00 seconds = 479.59 MB/sec
 Timing buffered disk reads:  170 MB in  3.00 seconds =  56.62 MB/sec

When doing:
time dd if=/dev/sda of=/dev/null bs=1024k count=4096
4096+0 records in
4096+0 records out

real    1m12.378s
user    0m0.029s
sys     0m21.280s
So confirmed the 56MB/s reading.

But taking in parallel top with refresh 1s in another window, during the
80
seconds elapsed above, I had two freezes in top session: one of 20sec and
another
of 15 sec: about the half of the time of the total I/O operation!
During this time there was one cpu used at about 30%, no other cpu constraints.
I repeated the operation with similar behaviour. Sometimes also 50 contiguos
secs
of freeze, until I/O operation finished.
The freeze is not about all system itself, but only certian things.
For example I tried also a vmstat session in another window with 3secs of
delay
and it had no problems while top was blocked:

gcecchi@tkamd:~$ vmstat 3
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
0  2   4360  87100 737100  53728    0    0 58283     0 2223  2726  0 19
45 36
 1  1   4360  87036 737128  53768    0    0 58197     5 2227  2655  0 19
46 35
 0  2   4360  86128 738148  53700    0    0 58240     0 2232  2677  0 19
47 35
 0  2   4360  86048 738156  53760    0    0 58283     1 2228  2391  1 19
45 36
 1  2   4360  86332 737928  53716    0    0 58197     0 2233  2434  1 19
47 34
 0  2   4360  86524 737708  53800    0    0 58283     0 2343  2662  1 19
46 34
 0  3   4360  87036 737244  53788    0    0 57603     0 2243  2483  1 19
46 34
 0  1   4360  86252 738032  53748    0    0 57429     7 2232  2482  1 18
46 35
 0  1   4360  87220 737024  53804    0    0 58197     3 2159  2205  2 18
48 33
 0  2   4360  86012 738292  53692    0    0 58240    29 2212  2401  1 19
48 32
 1  1   4360  86256 738036  53744    0    0 58325     0 2249  2643  0 19
47 34
 0  2   4360  86956 737304  53796    0    0 58197     0 2226  2727  0 19
46 35
 0  2   4360  87148 737092  53736    0    0 58240     0 2255  2748  0 19
45 36
 0  2   4360  87284 736900  53724    0    0 58283     3 2299  2995  2 19
45 34
 2  1   4360  86772 737440  53796    0    0 57097     0 2506  3284  2 20
42 36
 0  2   4360  86700 737572  53732    0    0 57771     1 2324  3290  2 20
43 35
 0  2   4360  86428 737780  53796    0    0 57899     0 2271  3002  2 19
45 34
 2  3   4360  86748 737464  53772    0    0 58284     0 2237  2764  1 18
47 34
 0  2   4360  86356 737800  53776    0    0 57436     0 2291  3048  2 19
44 34
 0  0   4360  88104 737132  53832    0    0 44675    47 2005  2582  2 15
58 25

But if I try to open another knosole window it freezes...
time dd if=/dev/zero of=/data/testfile bs=1024k count=4096
4096+0 records in
4096+0 records out

real    1m31.687s
user    0m0.024s
sys     0m23.517s
About 44.6MB/s.

No problems with top during the write operation. At least it looses 1sec
every
30 secs.
Cpu used about 25-30% and kswapd about 2%.
If I do a dd on both sda and sdb at the same time:

root@tkamd:/data# time dd if=/dev/sda of=/dev/null bs=1024k count=4096
4096+0 records in
4096+0 records out

real    1m14.899s
user    0m0.033s
sys     0m23.820s

root@tkamd:~# time dd if=/dev/sdb of=/dev/null bs=1024k count=4096
4096+0 records in
4096+0 records out

real    1m15.849s
user    0m0.036s
sys     0m23.419s

So in absolute is good, but in the top session I had a freeze of about 8secs
every 10secs.
vmstat gives in this situation:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
0  3  12604 211124 629152  46744    0    0 111787     0 3050  4204  2 37
 1 61
 0  3  12972  96196 743340  46088    0  123 111104   123 3121  4658  3 41
 1 56
 2  2  12972  96524 743336  46120    0    0 111360     5 3046  4153  1 39
 0 60
 1  2  12972  96388 743468  46056    0    0 111659     1 3090  4260  3 40
 0 57
 1  2  12972  96532 743292  46124    0    0 111360     4 2973  3928  3 40
27 31
 2  1  12972  96180 743804  46088    0    0 109909     1 3092  4422  3 41
27 30
 0  3  12972  95836 744088  46008    0    0 111659     4 2979  3847  1 39
11 49
 0  3  12972  95896 744032  45996    0    0 109745    16 3047  4141  3 40
15 42
 2  3  12972  96540 743440  45976    0    0 111872    19 3072  4091  1 41
30 28
 2  2  12972  96892 743032  46044    0    0 112939     0 3066  4198  0 40
32 28
 0  3  12972  96796 743192  46020    0    0 110807     9 3046  3682  1 39
24 36
 1  2  12972  96220 743768  45988    0    0 111787     0 3046  3768  1 40
 1 58
 2  2  12972  96796 743196  46016    0    0 111019    16 3123  3987  2 40
 1 58

With parallel write on sda and sdb:
root@tkamd:/data# time dd if=/dev/zero of=/data/testfile bs=1024k count=4096
4096+0 records in
4096+0 records out

real    1m29.197s
user    0m0.034s
sys     0m26.680s

root@tkamd:~# time dd if=/dev/zero of=/mnt/testfile bs=1024k count=4096
4096+0 records in
4096+0 records out

real    1m38.726s
user    0m0.039s
sys     0m28.976s

No problems with top, vmstat or new konsole operations.
Each cpu about 30% loaded and vmstat gives:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
1  0  12972 491516 328980  61232    0    0     0    51 1173  1556  2  1
97  0
 0  0  12972 491384 328980  61232    0    0     0     0 1271  1955  4  2
95  0
 1  1  12972 316000 502300  61176    0    0 57797    17 2139  2800  4 20
57 19
 4  2  12972  74164 743904  61244    0    0 112696    24 2881  3439  1 38
34 27
 1  3  12972  74344 743980  61236    0    0 112256     0 3063  4126  1 41
31 28
 0  3  12972  75296 742956  61308    0    0 112597     0 3046  4415  0 41
15 44
 1  1  12972  75416 742976  61220    0    0 112469     7 3032  4246  0 40
 6 54
 1  1  12972  74052 744252  61236    0    0 111445    21 3041  3825  3 41
34 23
 1  3  12972  74544 743760  61184    0    0 111232     4 3241  4312  5 43
25 28
 1  2  12972  74184 744028  61256    0    0 112981    20 3186  4493  1 42
 0 56
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 2  3  12972  74724 743504  61168    0    0 110080     0 3138  4351  6 43
 1 51
 0  3  12972  74116 744160  61192    0    0 111829     0 3162  4517  1 42
 1 56
 1  3  12972  74420 743784  61228    0    0 110464     0 3161  4587  2 41
 1 56
 2  2  12972  75088 743136  61196    0    0 110848     0 3191  4704  3 43
 1 53
 0  0  12972 483420 336572  61324    0    0 69248     7 2341  3334  3 28
31 37
 0  0  12972 483252 336620  61344    0    0     9     0 1120  1373  2  1
96  1

Any hints or I/O operations to be done to give further info on behaviour
are
welcome.
Next days I'm able to do some tests if necessary.
Thanks in advance for your help.
Bye,
Gianluca

>-- Messaggio Originale --

>
>Hello,
>
>Alan wrote> Make sure you enable the SCSI later, SATA drivers and VIA SATA
>driver
>Alan wrote> otherwise you may end up using PIO with the PCI generic IDE
>driver.
>
>Yes, this is up and running, no problem here:
>
>libata version 1.02 loaded.
>sata_via version 0.20
>ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 185
>sata_via(0000:00:0f.0): routed to hard irq line 11
>ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 185
>ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 185
>ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
>88:203f
>ata1: dev 0 ATA, max UDMA/100, 488397168 sectors: lba48
>ata1: dev 0 configured for UDMA/100
>scsi0 : sata_via
>ata2: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
>88:407f
>ata2: dev 0 ATA, max UDMA/133, 72303840 sectors: lba48
>ata2: dev 0 configured for UDMA/133
>scsi1 : sata_via
>Vendor: ATA Model: WDC WD2500JD-00F Rev: 02.0
>Type: Direct-Access ANSI SCSI revision: 05
>Vendor: ATA Model: WDC WD360GD-00FN Rev: 35.0
>Type: Direct-Access ANSI SCSI revision: 05
>SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
>SCSI device sda: drive cache: write back
>sda: sda1 sda2
>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
>SCSI device sdb: 72303840 512-byte hdwr sectors (37020 MB)
>SCSI device sdb: drive cache: write back
>sdb: sdb1
>Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
>
>
>Tomita, Haruo wrote:
>
>    Hi all,
>
>
>    VIA/KT800 chipset is not checking.
>
>    It seems that it cannot perform in combine mode at the ata_piix driver
>of a version 1.02.
>    In this case, although a piix driver should work, ESB_3 is not recognized
>in a piix driver.
>    Therefore, it can work only by PIO mode.
>
>    Petr, I think that it is necessary to check a setup of BIOS parameters.
>    Or how about making this patch reference?
>
>    http://marc.theaimsgroup.com/?l=linux-ide&m=109290653905964&w=2
>
>    Best regards,
>    Haruo
>
>
>Haruo,
>
>I am not using the combine mode on the sata drives (or at least, I don't
>know about it). I was implying that
>when I connect another pure IDE drive to the motherboard, then the situation
>gets better.
>
>Whats wrong here (or ... what feels wrong) is that the system slows down
>noticeably when transferring data
>to/from the sata drives. It 'feels' like using an old ide disk with pio
>mode only. I am not saying that the transfer rates
>are low though... hdparm -t on the sata drives gives me following:
>
>/dev/sda:
>Timing buffered disk reads: 140 MB in 3.01 seconds = 46.46 MB/sec
>
>/dev/sdb:
>Timing buffered disk reads: 164 MB in 3.00 seconds = 54.60 MB/sec
>
>this is not the best, but I think it is acceptable for SATA/PATA drives
>and onboard SATA controller.
>
>It is quite hard to describe what is going wrong here... It might not be
>even related to the sata itself...
>
>One example of the 'slow' system is that when I run 'top -d 1' (top with
>1 second updates), it sometimes
>takes ~4 seconds for the screen to update when the disk io is on action.
>(on dual processor opteron x86_64 machine :-) .Kernel vanilla 2.6.8.
>
>Best Regards,
>Petr
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>in
>the body of a message to majordomo@xxxxxxxxxxxxxxx
>More majordomo info at http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at http://www.tux.org/lkml/
>



__________________________________________________________________
Tiscali Adsl 640 Free: fino al 15 novembre i consumi sono GRATIS!
Se sottoscrivi un'Adsl Free 640 entro il 14 ottobre avrai gratis tutti
i consumi fino al 15/11/04 compreso! In piu' sono gratis il modem
in comodato e l'attivazione. Cosa aspetti? Prima attivi, piu' risparmi!
http://abbonati.tiscali.it/adsl/



