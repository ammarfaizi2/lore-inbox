Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130143AbRBQJ7G>; Sat, 17 Feb 2001 04:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129204AbRBQJ64>; Sat, 17 Feb 2001 04:58:56 -0500
Received: from p3EE3C95E.dip.t-dialin.net ([62.227.201.94]:14596 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S130143AbRBQJ6n>; Sat, 17 Feb 2001 04:58:43 -0500
Date: Sat, 17 Feb 2001 10:58:40 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM-DTLA-307045 very slow under 2.2.x
Message-ID: <20010217105840.B1436@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010217011854.B719@daikokuya.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217011854.B719@daikokuya.demon.co.uk>; from neil@daikokuya.demon.co.uk on Sat, Feb 17, 2001 at 01:18:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001, Neil Booth wrote:

> I have a SOYO "SY-5EMA+ Super 7" motherboard, with a K6-2 processor.
> The 45 Gig IBM drive hangs the BIOS if I let it autodetect it, so I
> turn off autodetection for IDE2 primary where it sits.  This is probably
> not relevant.

Not really. IBM has software which can make the drive available if you
need the BIOS to detect (if you want to boot from it) which "works for
my sister", on an old PCChips M577 (IBM 6x86 MX/233).

> My problem is that "hdparm -tT dev/hdc" gives atrocious
> performance:-
> 
> /dev/hdc:
>  Timing buffered disk reads:  64 MB in 22.81 seconds =  2.81 MB/sec

It's very low. I've never tried hooking my IBM to my Tyan Trinity K6-2
board because, reportedly, that one crashes with drives larger than 36
GB as well (Award 4.51 crap), and the board only has FreeBSD on its
attached disks.

sudo /sbin/hdparm -X69 -t /dev/hde

/dev/hde:
 setting xfermode to 69 (UltraDMA mode5)
 Timing buffered disk reads:  64 MB in  1.79 seconds = 35.75 MB/sec

/dev/hde:
 setting xfermode to 66 (UltraDMA mode2)
 Timing buffered disk reads:  64 MB in  2.70 seconds = 23.70 MB/sec

This is on a Promise PDC 20265R. On VIA, you might not get more than
like 18 MB/s.

> hda: QUANTUM FIREBALL CR13.0A, 12416MB w/418kB Cache, CHS=1582/255/63
> hdc: IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=5606/255/63

It does not tell anything about DMA here,

> Model=IBM-DTLA-307045, FwRev=TX6OA50C, SerialNo=YM0YML23878
> Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
> RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
> BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
> CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=90069840
> IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
> PIO modes: pio0 pio1 pio2 pio3 pio4 
> DMA modes: mdma0 mdma1 *mdma2 udma0 udma1 udma2 udma3 udma4 udma5 
> 
> Trying to set the DMA mode with -X34 and -d1 seems to have no effect.

but here, it's using multi-word DMA. Why don't you set UDMA? Try -X66
-d1.

If your kernel does not have the IDE patches, get them from
ftp.XX.kernel.org/pub/linux/kernel/people/hedrick/ and rebuild your
kernel and see if that helps.

-- 
Matthias Andree
