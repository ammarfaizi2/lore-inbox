Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130512AbRBWWA2>; Fri, 23 Feb 2001 17:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRBWWAS>; Fri, 23 Feb 2001 17:00:18 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:12687 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id <S130512AbRBWWAG>;
	Fri, 23 Feb 2001 17:00:06 -0500
Date: Fri, 23 Feb 2001 13:59:50 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
To: Jasmeet Sidhu <jsidhu@arraycomm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DMA blues...System lockup on setting DMA mode using hdparam
In-Reply-To: <5.0.2.1.2.20010223120954.025fa3b0@pop.arraycomm.com>
Message-ID: <Pine.LNX.4.30.0102231347140.8914-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Feb 2001, Jasmeet Sidhu wrote:

> Also another question related to IDE:
> 	Is there anyway we can see how good/bad the system performance is while
> the system is working?

that information (what the disk subsytem as a whole is doing) is collected
in /proc/stat something like xosview can help you visualize it.

>  I am not talking about a benchmarking tool like
> bonnie that simply tries to figure out how good a system can perform.  I
> would like to see something, maybe in /proc/ide/, that shows me the current
> throughput of the ide subsystem.  For example how many kb of data is going
> in, how much coming out of each device.  Any ideas on how to go about maybe
> adding this?  Where would be an ideal place to add such functionality?  In
> the ide code or maybe in the raid section?  Or maybe these two should be
> kept separate.  Any thoughts guys?
>
> Any additional required information can be posted, let me know.
>
> Anybody else out there with a similar situation?  Your thoughts on this
> would be really appreciated.

I actually have a similar situation although without hanging, with three
controllers. the kernels detects the two devices on the third controller
as udma rather than udma(100) with 2.4.1.

hda: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=1867/255/63, UDMA(33)
hdc: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=29765/16/63, UDMA(33)
  first two are on the server-works chipset controller

hde: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdg: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdi: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdk: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
hdm: 30003120 sectors (15362 MB) w/1916KiB Cache, CHS=29765/16/63, (U)DMA
hdo: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, (U)DMA
  these 6 are on three promise contollers... all with 18" 80pin cable

hdd: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)


> Here's the setup:
>
> ide0 at 0x3800-0x3807,0x3402 on irq 11	PDC20265
> ide1 at 0x3000-0x3007,0x2802 on irq 11
> ide2 at 0x5400-0x5407,0x5002 on irq 15	PDC20267
> ide3 at 0x4800-0x4807,0x4402 on irq 15
> ide4 at 0x7000-0x7007,0x6802 on irq 11	PDC20267
> ide5 at 0x6400-0x6407,0x6002 on irq 11
> ide6 at 0x8800-0x8807,0x8402 on irq 14	PDC20267
> ide7 at 0x8000-0x8007,0x7802 on irq 14
> ide8 at 0xa400-0xa407,0xa002 on irq 10	PDC20267
> ide9 at 0x9800-0x9807,0x9402 on irq 10
>
> hda: 40188960 sectors (20577 MB) w/1916KiB Cache, CHS=39870/16/63, UDMA(100)
> hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hde: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hdg: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hdi: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hdk: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hdm: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hdo: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hdq: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
> hds: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(100)
>
> # Raid-5 configuration
> #
> raiddev                 	/dev/md0
> raid-level              	5
> chunk-size           	4
> parity-algorithm     	left-symmetric
> persistent-superblock 	1
> nr-raid-disks           	8
> nr-spare-disks        	1
> device          		/dev/hde1
> raid-disk       		0
> device          		/dev/hdg1
> raid-disk       		1
> device          		/dev/hdi1
> raid-disk       		2
> device          		/dev/hdk1
> raid-disk       		3
> device          		/dev/hdm1
> raid-disk       		4
> device          		/dev/hdo1
> raid-disk       		5
> device          		/dev/hdq1
> raid-disk      		 6
> device          		/dev/hds1
> raid-disk       		7
> device          		/dev/hdc1
> spare-disk      		0
>
> [root@bertha hdparm-3.9]# df -k
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/hda3             19072868   3589612  14514392  20% /
> /dev/hda1               198313     11667    176392   7% /boot
> /dev/md0             525461076 108657156 416803920  21% /raid
> sj-f760-1:/vol/vol03/data01
>                       142993408 140675648   2317760  99% /mnt/netapps
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli				       joelja@darkwing.uoregon.edu
Academic User Services			     consult@gladstone.uoregon.edu
     PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E
--------------------------------------------------------------------------
It is clear that the arm of criticism cannot replace the criticism of
arms.  Karl Marx -- Introduction to the critique of Hegel's Philosophy of
the right, 1843.


