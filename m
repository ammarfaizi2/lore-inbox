Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131118AbRAUKwB>; Sun, 21 Jan 2001 05:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132201AbRAUKvm>; Sun, 21 Jan 2001 05:51:42 -0500
Received: from mserv1c.vianw.co.uk ([195.102.240.33]:50087 "EHLO
	mserv1c.vianw.co.uk") by vger.kernel.org with ESMTP
	id <S131118AbRAUKvb>; Sun, 21 Jan 2001 05:51:31 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [preview] Latest AMD & VIA IDE drivers with UDMA100 support
Date: Sun, 21 Jan 2001 10:51:12 +0000
Organization: [private individual]
Message-ID: <neel6tgsvv861oon326ggetmf82v1inu1v@4ax.com>
In-Reply-To: <cv8k6ts9oeb72pmhh9hsfjta6uen511a0j@4ax.com> <Pine.LNX.4.10.10101202015510.1776-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10101202015510.1776-100000@coffee.psychology.mcmaster.ca>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2001 20:18:34 -0500 (EST), you wrote:


>that's not the topic: Andre's talking about pci-clock-based timing
>constants the the driver programs into the ide controller - a matter
>of an extra few/more nanoseconds.

I know, but when looking hard for a problem in one place and not
finding it, it is sometimes helpful to consider other options.

I am getting errors under 2.4.0 which didn't appear in 2.2.17 - and as
far as I could see from hdparm - both were at UDMA mode 2 (I assume
thats what the * means - the man page wasn't very clear).  My drives
only handle up to this mode, and I was wondering if the new driver was
trying to run them at a mode higher than they were supposed to go.

This massive difference in timing  seemed significant.
>
>quite slow in either case, at least for modern hardware (which is 
>all in the 20-40 MB/s range).  this looks like a PIO vs DMA difference
>to me, not even UDMA.  of course, hdparm can tell you what mode you're in.
>

I did discover a difference - 2.2.17 set the drives with multisector
off, 2.4.0 was setting multisector on.  However, I have redone the
timing with multisector turned on in the 2.2.17 case and the
difference is still there.

Under 2.2.17 with multisector turned on


/dev/hda:

 Model=IBM-DHEA-38451, FwRev=HP8OA20C, SerialNo=SH0SH0X1795
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=28
 BuffType=3(DualPortCache), BuffSize=472kB, MaxMultSect=16,
MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16514064
 tDMA={min:120,rec:120}, DMA modes: sword0 sword1 sword2 mword0 mword1
mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 *mode2 

------------------

/dev/hda:
 Timing buffered disk reads:  64 MB in 19.88 seconds =  3.22 MB/sec


Under 2.4.0


/dev/hda:

 Model=IBM-DHEA-38451, FwRev=HP8OA20C, SerialNo=SH0SH0X1795
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=28
 BuffType=3(DualPortCache), BuffSize=472kB, MaxMultSect=16,
MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=16514064
 tDMA={min:120,rec:120}, DMA modes: sword0 sword1 sword2 mword0 mword1
mword2 
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
 UDMA modes: mode0 mode1 *mode2 

------------------

/dev/hda:
 Timing buffered disk reads:  64 MB in  6.58 seconds =  9.73 MB/sec



I don't suppose the fact that my hdparm is oldish (3.6 I think) have
any bearing on this?
Alan

alan@chandlerfamily.org.uk
http://www.chandler.u-net.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
