Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293464AbSB1WyL>; Thu, 28 Feb 2002 17:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310185AbSB1Wwa>; Thu, 28 Feb 2002 17:52:30 -0500
Received: from h24-83-222-158.vc.shawcable.net ([24.83.222.158]:11667 "EHLO
	me.bcgreen.com") by vger.kernel.org with ESMTP id <S310193AbSB1Wth>;
	Thu, 28 Feb 2002 17:49:37 -0500
Message-ID: <3C7EB3C2.5090401@bcgreen.com>
Date: Thu, 28 Feb 2002 14:48:34 -0800
From: Stephen Samuel <samuel@bcgreen.com>
Organization: Just Another Radical
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lonely wolf <wolfy@pcnet.ro>
CC: linux-kernel@vger.kernel.org
Subject: Re: disk transfer speed problem
In-Reply-To: <3C7D4666.6D35B124@pcnet.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Picking nits, perhaps -- but after giving us data on hdc,
you did the test on hdd.  I realize you said that it is identical
for both, but if you missed something critical, we'll never see it.

lonely wolf wrote:
> initial data: one brand new intel bonham motherboard (i815) , 900 MHz
> celeron processor
> 2 new 80 GB Seagate Barracuda used as raid1, 7200 RPM,ext3 filesystem,
> RedHat 2.4.9-21 kernel from  RH 7.2 updates.
> 
> settings (identical for hdc and hdd), as detected by the kernel (except
> for I/O support  =  3):
> #hdparm /dev/hdc
>  multcount    = 16 (on)
>  I/O support  =  3 (32-bit w/sync)
>  unmaskirq    =  0 (off)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 23989/16/63, sectors = 156301488, start = 0
> 
> #hdparm -i /dev/hdc
> 
>  Model=ST380021A, FwRev=3.05, SerialNo=3HV080KH
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=156301488
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
> 
>  #dmesg|grep UDMA
> hda: 14668290 sectors (7510 MB) w/418KiB Cache, CHS=913/255/63, UDMA(66)
> (this is the boot disk)
> 
> hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> UDMA(100
> hdd: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
> UDMA(100)
> 
> The IDE cables have 80 wires. I am not sure that they are ATA100, but I
> think they do.
> 
> The problem:
> #/sbin/hdparm -tTf /dev/hdd
> 
> /dev/hdd:
>  Timing buffer-cache reads:   128 MB in  1.17 seconds =109.40 MB/sec
>  Timing buffered disk reads:  64 MB in  3.24 seconds = 19.75 MB/sec
> 
> 
> Even after issuing raidstop and umounting the partition placed on the
> RAID, the speed does not exceed 22 MB/sec.
> 
> With hdparm -c1 performances are almost identical
> 
> Tests were performed in initlevel 3, with NFS started, but no one but
> root  using the machine (from console). In production, the speed is also
> very, very slow
> 
> Any idea what might limit the transfer speed ?
> 
> 
> --
>       Manuel Wolfshant       linux registered user #131416
>        network administrator    NoBug Consulting Romania
>              Beware the fury of a patient man.
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Stephen Samuel +1(604)876-0426                samuel@bcgreen.com
		   http://www.bcgreen.com/~samuel/
Powerful committed communication, reaching through fear, uncertainty and
doubt to touch the jewel within each person and bring it to life.

