Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261960AbRFPPZ4>; Sat, 16 Jun 2001 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbRFPPZr>; Sat, 16 Jun 2001 11:25:47 -0400
Received: from [212.18.228.90] ([212.18.228.90]:1039 "HELO
	carrot.linuxgrrls.org") by vger.kernel.org with SMTP
	id <S261960AbRFPPZd>; Sat, 16 Jun 2001 11:25:33 -0400
Message-ID: <3B2B7A33.8000902@linuxgrrls.org>
Date: Sat, 16 Jun 2001 16:24:35 +0100
From: Rachel Greenham <rachel@linuxgrrls.org>
Organization: LinuxGrrls.Org
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac6 i686; en-US; rv:0.9.1) Gecko/20010607 Netscape6/6.1b1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Thomas Molina <tmolina@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A crash *post* 2.4.3-ac6
In-Reply-To: <Pine.LNX.4.33.0106160827100.13727-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thomas Molina wrote:

>I've tried most of the tests you all have been discussing, with a couple
>of exceptions.  I haven't tried bonnie ( don't even know where to get it
>or what it is supposed to test ).
>
Well, it's part of the SuSE distribution at least, and it tests hard 
disk performance - you need to give it a test size greater than your 
system's memory or all you're testing is Linux's ability to buffer reads 
and writes. :-) So for my 512Mb system I use "bonnie -s 1024"

>><redundant>as long as you're sure you do have DMA enabled that is - SuSE
>>at least leaves it disabled by default, under which conditions all
>>kernels are stable for me</redundant>
>>
>
>Fairly certain.  I could be misinterpreting things, though.  Here is some
>output I'm seeing:
>
Compare:

>[root@localhost /root]# hdparm -tT /dev/hde
>
>/dev/hde:
> Timing buffer-cache reads:   128 MB in  0.70 seconds =182.86 MB/sec
> Timing buffered disk reads:  64 MB in  2.31 seconds = 27.71 MB/sec
>
root@hex:/home/rachel > hdparm -tT /dev/hde
 
/dev/hde:
 Timing buffer-cache reads:   128 MB in  0.66 seconds =193.94 MB/sec
 Timing buffered disk reads:  64 MB in  2.11 seconds = 30.33 MB/sec

>[root@localhost /root]# hdparm /dev/hde
>
>/dev/hde:
> multcount    =  0 (off)
> I/O support  =  0 (default 16-bit)
> unmaskirq    =  0 (off)
> using_dma    =  1 (on)
> keepsettings =  0 (off)
> nowerr       =  0 (off)
> readonly     =  0 (off)
> readahead    =  8 (on)
> geometry     = 3649/255/63, sectors = 58633344, start = 0
>

root@hex:/home/rachel > hdparm /dev/hde

/dev/hde:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 79780/16/63, sectors = 80418240, start = 0

I have 32-bit IO (with sync) and multiple sector transfers enabled, 
where you don't. I don't expect that's the cause of the problem though - 
For instance, I can run reliably with any kernel with those enabled, as 
long as DMA is disabled.

>
>[root@localhost /root]# hdparm -i /dev/hde
>
>/dev/hde:
>
> Model=WDC WD300BB-00AUA1, FwRev=18.20D18, SerialNo=WD-WMA6W1592536
> Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq
>}
> RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
> BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
> CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=58633344
> IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> PIO modes: pio0 pio1 pio2 pio3 pio4
> DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>
root@hex:/home/rachel > hdparm -i /dev/hde
 
/dev/hde:
 
 Model=IBM-DTLA-305040, FwRev=TW4OA60A, SerialNo=YJEYJLG3070
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=380kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=79780/16/63 PhysicalCHS=79780/16/63

. o O ( Dont' suppose any of this is useful to anyone... )

-- 
Rachel



