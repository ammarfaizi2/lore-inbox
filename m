Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266152AbRGGNSp>; Sat, 7 Jul 2001 09:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266157AbRGGNSf>; Sat, 7 Jul 2001 09:18:35 -0400
Received: from 35.roland.net ([65.112.177.35]:26637 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S266152AbRGGNS3>;
	Sat, 7 Jul 2001 09:18:29 -0400
Message-ID: <002201c106e7$4a64da20$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3B469D66.7B100BD3@megsinet.net>
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
Date: Sat, 7 Jul 2001 08:18:19 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Activating an IDE drive in an older BIOS (newer ones have a SCSI option in
the "A/C/CDROM" options) will always force an IDE drive boot with older
BIOSes.  Older BIOSes are written to stop looking for a boot device once it
has found one, and it's own IDE is where it says "Ok, I have boot
capability", otherwise no IDE drive, means it passes boot control to other
system BIOSes (like your SCSI or NIC cards).  This is by default with older
systems.

I expect someone will rebut my comments about the kernel (which is fine, I'm
not a Kernel hacker--PROPERLY USED TERM HERE (not the media's term) <grin>),
but it is my understanding that the kernel uses your system BIOS for actual
reads/writes at the hardware level, this way it does not have to account for
EVERY possible BIOS out there.  (Other OSes use BIOS system calls for this
purpose as well)  When you turn BIOS to <NONE> the OS does what it can, but
the BIOS in your system *SHOULD* refuse to process the call, instead it's
doing the read/writes, but not the same way as if IDE was turned on.

My suggestion is that you install the OS onto the IDE drive, let it boot,
and use it for a boot only drive.  Mount user data from your SCSI drive onto
the IDE's mount points.  Otherwise, since your reason for doing this is that
you're out of space, add another SCSI drive.

Are you getting IDE corruption with the BIOS set to <AUTO> for your IDE
drive?

Regards,
Jim Roland, RHCE


----- Original Message -----
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
To: <linux-kernel@vger.kernel.org>
Sent: Saturday, July 07, 2001 12:25 AM
Subject: Does kernel require IDE enabled in BIOS to access HD, FS errors?


> Hi,
>
> I have a SMP P166 system that has been running for years with an AIC7xxx
SCSI card as
> opposed to the native IDE interface.  The BIOS has the IDE 0,1,2,3 set to
<NONE>.
> Running out of disk space I installed one of the original IDE drives. The
kernel
> booted and ID'd the drive correctly.  Kernel version 2.4.5/6 behave the
same.
>
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
> CMD646: IDE controller on PCI bus 00 dev 10
> CMD646: chipset revision 1
> CMD646: not 100% native mode: will probe irqs later
> CMD646: chipset revision 0x01, MultiWord DMA Limited, IRQ workaround
enabled
> CMD646: simplex device:  DMA disabled
> ide0: CMD646 Bus-Master DMA disabled (BIOS)
> CMD646: simplex device:  DMA disabled
> ide1: CMD646 Bus-Master DMA disabled (BIOS)
> hdb: CD-ROM CDU76E, ATAPI CD/DVD-ROM drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
> hdc: WDC AC2850F, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hdc: 1667232 sectors (854 MB) w/64KiB Cache, CHS=1654/16/63
> hdb: packet command error: status=0x51 { DriveReady SeekComplete Error }
> hdb: packet command error: error=0x44
> hdb: ATAPI 4X CD-ROM drive, 256kB Cache
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hdc: [PTBL] [827/32/63] hdc1
>
> However I can't boot from the SCSI drives if the IDE HD is enabled due to
deficiencies
> in the BIOS... boot "A: then C:" or "C: then A:" are the only choices, if
neither are
> present the system boots from the SCSI card, otherwise it fails to boot.
>
> PROBLEM: cannot reliably R/W to the HD unless the BIOS is set to <auto>
recognize.
> I consistently see MD5SUM errors and FS corruption and other strange FS
symptoms
> when the BIOS is set to <NONE> for the drive and _never_ see any errors
with the
> setting set to <AUTO>.  There are no messages emitted by the kernel that
there
> were any system errors encountered leading one to believe that all is
well, when
> it isn't.
>
> What is interesting, is that the I/O writes increase from once every 14
seconds to
> once every 2-3 seconds and the FS corruption diminishes but don't
disappear
> if a background "dd if=/dev/zero of=/dev/null" is running.
>
> Is this expected kernel behavior?
>
> VMSTAT follow... when copying files from SCSI drives to IDE drive.
>
> More info available if needed...
>
> Thanks,
> Martin
>
> The waiting processes are kupdated and bdflush. (I have Alt-SysRq- trace
of them)
>
> VMSTAT 1 for the case w/ BIOS set to <NONE> looks like (w/o dd running):
>
>    procs                      memory    swap          io     system
cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
>  0  0  0      0  83180   1056  39800   0   0   261     3   83    43   5
8  87
>  0  0  0      0  83176   1056  39800   0   0     0     0  119    20   3
2  95
>  0  0  0      0  83176   1056  39800   0   0     0     0  116    20   2
2  96
>  0  1  0      0  83012   1096  39812   0   0   329     0  196   183   3
8  89
>  0  1  0      0  81268   1128  41444   0   0  1021     0  309   275   3
17  80
>  0  1  0      0  74464   1200  47716   0   0  3131    27  292   264   6
25  69
>  2  0  0      0  67772   1276  53632   0   0  2962     0  397   245  12
25  63
>  2  0  0      0  64016   1324  56900   0   0  1602     0  414   155  48
27  26
>  1  1  0      0  53924   1372  66608   0   0  4960     0  200   165  14
40  46
>  1  0  0      0  42260   1448  77556   0   0  5493     0  232   210   3
35  62
>  0  1  0      0  30276   1480  88748   0   0  5616     0  201   124   4
34  62
>  2  0  0      0  22580   1496  96044   0   0  3671  2868  307    96   2
33  65
>  0  1  0      0  12392   1528 105492   0   0  4771  4852  276   164   5
37  58
>  1  0  0      0   3056   1560 114232   0   0  4641  4861  328   200   2
43  54
>  1  1  0      0   3056   1588 114192   0   0  5011  4744  281   139   5
39  57
>  1  0  1      0   3056   1612 114168   0   0  5269  1728  256   115   4
35  60
>  0  1  1      0   3056   1680 114084   0   0  4827     0  271   193   2
33  64
>  1  0  1      0   3056   1708 114056   0   0  5268     0  236   106   3
38  59
>  2  0  1      0   3056   1748 113864   0   0  3817  3968  315   132   7
44  49
>  2  0  1      0   3056   1760 113604   0   0  2955     0  348    63  41
50   9
>  1  0  1      0   3056   1788 113940   0   0  4258     0  247    97  41
46  13
>  1  0  1      0   3056   1844 113880   0   0  4246     0  281   168   4
36  60
>  0  1  1      0   3064   1856 113868   0   0  2955     0  209    69   3
19  78
>  0  1  2      0   3064   1856 113868   0   0     0     0  149    27   2
3  95
>  0  1  2      0   3064   1856 113868   0   0     0     0  147    19   2
3  95
>  0  1  2      0   3064   1856 113868   0   0     0     0  152    18   2
3  95
>  0  1  2      0   3064   1856 113868   0   0     0     0  147    16   2
4  94
>  0  1  2      0   3064   1856 113868   0   0     0     0  147    16   1
4  94
>  0  1  1      0   3060   1856 113868   0   0     0  3613  156    28   1
5  94
>  0  1  1      0   3060   1856 113868   0   0     0     0  148    14   2
2  96
>  0  1  1      0   3060   1856 113868   0   0     0     0  150    18   2
4  94
>  0  1  1      0   3060   1856 113868   0   0     0     0  151    18   1
5  94
>  0  1  1      0   3060   1856 113868   0   0     0     0  147    18   2
3  95
>  0  1  1      0   3060   1856 113868   0   0     0     0  151    18   2
2  96
>  0  1  1      0   3060   1856 113868   0   0     0     0  183    27   2
4  94
>  0  1  1      0   3060   1856 113868   0   0     0     0  183    18   2
2  95
>  0  1  1      0   3064   1856 113864   0   0     0     0  186    18   2
3  95
>  0  1  1      0   3064   1856 113864   0   0     0     0  182    23   1
4  95
>  0  1  1      0   3064   1856 113864   0   0     0     0  184    18   2
4  94
>  0  1  1      0   3064   1856 113864   0   0     0     0  185    20   2
1  96
>  0  1  1      0   3064   1856 113864   0   0     0     0  181    18   2
1  96
>  0  1  1      0   3064   1856 113864   0   0     0  3852  184    21   2
3  95
>  0  1  2      0   3064   1856 113864   0   0     0     0  181    24   1
4  94
>  0  1  2      0   3064   1856 113864   0   0     0     0  165    16   1
2  96
>  0  1  2      0   3064   1856 113864   0   0     0     0  184    14   1
4  95
>  0  1  2      0   3064   1856 113864   0   0     0     0  183    24   1
3  95
>  0  1  2      0   3060   1856 113868   0   0     0     0  185    12   2
4  94
>  0  1  2      0   3056   1856 113864   0   0     3     0  195    53   3
4  93
>  0  1  2      0   3056   1856 113864   0   0     0     0  183    24   2
2  96
>  0  1  2      0   3056   1856 113864   0   0     0     0  184    18   2
3  94
>  0  1  2      0   3056   1856 113864   0   0     0     0  185    16   2
3  95
>  0  1  2      0   3056   1856 113864   0   0     0     0  184    20   2
2  95
>  0  1  2      0   3056   1856 113864   0   0     0     0  191    20   2
4  94
>  0  1  2      0   3056   1856 113864   0   0     0     0  186    14   2
3  95
>  0  1  2      0   3056   1856 113864   0   0     0     0  182    24   1
2  96
>  0  1  2      0   3056   1856 113864   0   0     0  3964  183    18   1
5  93
>  0  1  2      0   3056   1856 113864   0   0     0     0  183    24   1
2  97
>  0  1  2      0   3144   1856 113864   0   0     0     0  173    20   2
5  93
>  0  1  2      0   3160   1856 113848   0   0     0     0  160    19   2
5  94
>  0  1  2      0   3160   1856 113848   0   0     0     0  158    18   1
3  96
>  0  1  2      0   3160   1856 113848   0   0     0     0  152    24   2
3  95
>
>
> Here is VMSTAT 1 for the case where the IDE is set to <AUTO> in the bios:
>
>    procs                      memory    swap          io     system
cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
>  0  0  0      0  82928   1048  39776   0   0   202     3   78    35   5
6  89
>  0  0  0      0  82824   1052  39784   0   0     6     0  135    51   3
1  95
>  0  1  0      0  82684   1068  39796   0   0    38     0  127    43   3
4  93
>  0  1  0      0  82652   1092  39796   0   0   364     0  223   208   3
4  93
>  1  0  0      0  78776   1164  43392   0   0  1957     0  331   316   4
14  82
>  1  0  1      0  71684   1224  49956   0   0  3231     0  309   239   5
20  75
>  0  1  0      0  65376   1304  55752   0   0  2835     0  340   250   1
18  80
>  1  0  0      0  55412   1364  65056   0   0  4746     2  233   187   4
29  67
>  1  0  0      0  43460   1432  76220   0   0  5560     0  207   181   3
31  66
>  1  0  0      0  31276   1472  87680   0   0  5806     0  194   125   1
35  64
>  0  1  0      0  21084   1496  97216   0   0  4685   157  234   102   4
29  67
>  1  0  0      0  13580   1520 104244   0   0  3628  3328  615   126   3
56  41
>  1  0  0      0   6352   1552 111072   0   0  3417  3584  709   123   3
59  38
>  1  0  0      0   3056   1560 114148   0   0  2951  3072  577   138   4
59  38
>  1  0  0      0   3056   1580 114128   0   0  3086  2940  611    82   4
52  45
>  1  0  0      0   3056   1600 114108   0   0  4182  4352  647    94   3
71  26
>  1  0  0      0   3056   1636 114064   0   0  3217  3072  701   150   3
60  37
>  1  0  1      0   3056   1676 114016   0   0  3666  3840  674   141   3
58  39
>  1  0  0      0   3056   1700 113992   0   0  3691  3328  600   102   3
58  39
>  1  0  0      0   3056   1720 113972   0   0  3729  3578  639   110   2
62  36
>  1  0  0      0   3056   1752 113936   0   0  3464  3627  674   142   6
58  36
>  1  0  0      0   3056   1772 113916   0   0  3598  3532  627   102   3
64  34
>  1  0  0      0   3056   1804 113880   0   0  3296  3328  610   130   4
61  35
>  3  0  0      0   3056   1836 113796   0   0  3392  3584  697   140   3
61  37
>  2  0  0      0   3056   1848 113604   0   0  2827  2816  594   105  12
62  27
>  1  1  0      0   3056   1880 113404   0   0  2234  2551  604   107  34
59   8
>  2  0  0      0   3056   1912 113364   0   0  2838  2816  565   139  40
51   8
>  1  0  0      0   3056   1988 113648   0   0  3148  3328  667   213  11
57  32
>  1  0  0      0   3056   2032 113600   0   0  2761  3328  612   162   2
59  39
>  0  1  1      0   3056   2088 113540   0   0  3061  3322  676   180   2
56  42
>  1  0  0      0   3056   2120 113504   0   0  3542  3789  670   137   4
57  39
>  1  0  0      0   3056   2164 113452   0   0  3102  3325  668   147   4
49  47
>  1  0  0      0   3056   2192 113424   0   0  3602  3575  678    99   3
59  38
>  1  0  0      0   3056   2224 113388   0   0  3311  3539  703   134   0
61  39
>  1  0  0      0   3056   2212 113396   0   0  3451  3584  615   114   4
62  34
>  1  0  0      0   3056   2252 113348   0   0  3675  3840  672   126   3
57  40
>  1  0  0      0   3056   2292 113304   0   0  3066  3328  695   162   3
56  42
>  1  0  0      0   3056   2324 113272   0   0  3347  3262  628   129   4
54  42
>  1  0  1      0   3056   2340 113244   0   0  2755  3072  612   103   3
60  38
>  1  0  0      0   3056   2352 113244   0   0  3830  3581  681   125   4
60  36
>  1  0  0      0   3056   2400 113196   0   0  3408  3584  656   144   4
56  39
>  1  0  0      0   3056   2424 113172   0   0  3758  3840  671   136   2
59  39
>  1  0  0      0   3056   2432 113164   0   0  2726  2780  611   108   3
57  40
>  1  0  0      0   3056   2492 113052   0   0  2432  3072  659   299   2
49  49
>  2  0  0      0   3056   2612 112820   0   0  2355  3072  830   651   6
54  41
>  1  0  0      0   3056   2748 112596   0   0  2041  2816  708   421   6
46  49
>  1  0  1      0   3056   2908 112380   0   0  2839  3304  716   364   3
58  39
>  0  1  1      0   3056   3060 112184   0   0  3121  3840  729   352   3
62  35
>  1  0  1      0   3056   3164 112060   0   0  2204  2816  570   179   4
43  53
>  1  0  1      0   3056   3260 111840   0   0  2094  2560  684   335   4
50  46
>  1  0  1      0   3056   3320 111764   0   0  2867  3584  675   207   3
59  38
>  1  0  0      0   3056   3364 111240   0   0   430  2268  857   823   3
51  45
>  1  0  0      0   3056   3424 110928   0   0  1460  2560  707   551   5
42  53
>  1  0  0      0   3056   3512 110728   0   0  2267  2816  783   592   3
50  47
>  0  1  0      0   3056   3564 110448   0   0  1952  3069  897   836   5
49  46
>  1  0  1      0   3056   3708 110248   0   0  2424  3145  743   357   3
50  47
>  0  1  1      0   3056   3864 110116   0   0  2552  3328  727   430   3
49  49
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

