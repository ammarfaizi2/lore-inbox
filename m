Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBAQrb>; Thu, 1 Feb 2001 11:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129205AbRBAQrV>; Thu, 1 Feb 2001 11:47:21 -0500
Received: from winds.org ([207.48.83.9]:16909 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129189AbRBAQrI>;
	Thu, 1 Feb 2001 11:47:08 -0500
Date: Thu, 1 Feb 2001 11:46:08 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: safemode <safemode@voicenet.com>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <3A794945.5F652819@voicenet.com>
Message-ID: <Pine.LNX.4.21.0102011137590.27273-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, safemode wrote:

> Vojtech Pavlik wrote:
> 
> > Ugh. What chips your KA7 has? As far as I know the KX133 chip (vt8731)
> > can't do asynchronous PCI, allowing for 2x, 3x and 4x FSB/PCI divisors
> > only. So I don't a way to have your FSB at 114 and your PCI at 34 with
> > this chip.
> 
> Actually it can and it's a simple bios option.  I'd show you but it's in the manual and
> it's hard to scan stuff without a scanner.     You can have asynchronous FSB up to
> 28Mhz    so i can have 128Mhz FSB with 33Mhz PCI      after that i have to use the
> synchronous increase which changes PCI as i change the FSB value   but the other value
> gets added onto that asynchronously.  It's really a standard feature of this board.
> I'm not making it up and the proof is me not changing idebus at all and still working
> after a day at full load and semi-constant usage and MANY compiles.   also the bios
> screen doesn't lie.

Yeah, by bios does the same thing too on the Abit KT7(a). But you might not
want to run your PCI clock at 34 instead of 33. Two problems can occur. If you
don't specify idebus=34 on the kernel prompt, the IDE timings might eventually
get a DMA reset under 100% disk access. If you do say idebus=34, then you drop
your maximum throughput from 33 MB/s to 27MB/s.

I was curious and compiled a list of timings from Vojtech's formula for certain
idebus=xx MHz ratings (I _think_ the UDMA-66 timings are correct, maybe you can
check on these, Vojtech..)

Clock | Setup  Active  Recover  Cycle  UDMA | UDMA-33  UDMA-66  UDMA-100
   21 |    1       2        1      3    0   |   28.0     56.0      84.0
   22 |    1       2        1      3    0   |   29.3     58.6      88.0
   23 |    1       2        1      3    0   |   30.6     61.2      92.0
   24 |    1       2        1      3    0   |   32.0     64.0      96.0
   25 |    1       2        1      3    0   |   33.3     66.6     100.0
   26 |    1       2        2      4    0   |   26.0     52.0      78.0
   27 |    1       2        2      4    0   |   27.0     54.0      81.0
   28 |    1       2        2      4    0   |   28.0     56.0      84.0
   29 |    1       3        1      4    0   |   29.0     58.0      87.0
   30 |    1       3        1      4    0   |   30.0     60.0      90.0
   31 |    1       3        1      4    0   |   31.0     62.0      93.0
   32 |    1       3        1      4    0   |   32.0     64.0      96.0
   33 |    1       3        1      4    0   |   33.0     66.0      99.0
   34 |    1       3        2      5    0   |   27.2     54.4      81.6
   35 |    1       3        2      5    0   |   28.0     56.0      84.0
   36 |    1       3        2      5    0   |   28.8     57.6      86.4
   37 |    1       3        2      5    0   |   29.6     59.2      88.8
   38 |    1       3        2      5    0   |   30.4     60.8      91.2
   39 |    1       3        2      5    0   |   31.2     62.4      93.6
   40 |    1       3        2      5    0   |   32.0     64.0      96.0
   41 |    2       3        2      5    0   |   32.8     65.6      98.4
   42 |    2       4        2      6    0   |   28.0     56.0      84.0
   43 |    2       4        2      6    0   |   28.6     57.2      86.0
   44 |    2       4        2      6    1   |   29.3     58.6      88.0
   45 |    2       4        2      6    1   |   30.0     60.0      90.0
   46 |    2       4        2      6    1   |   30.6     61.2      92.0
   47 |    2       4        2      6    1   |   31.3     62.6      94.0
   48 |    2       4        2      6    1   |   32.0     64.0      96.0
   49 |    2       4        2      6    1   |   32.6     65.2      98.0
   50 |    2       4        2      6    1   |   33.3     66.6     100.0
   51 |    2       4        3      7    1   |   29.1     58.2      87.4
   52 |    2       4        3      7    1   |   29.7     59.4      89.1
   53 |    2       4        3      7    1   |   30.2     60.4      90.8
   54 |    2       4        3      7    1   |   30.8     61.6      92.5
   55 |    2       4        3      7    1   |   31.4     62.8      94.2
   56 |    2       5        3      8    1   |   28.0     56.0      84.0
   57 |    2       5        3      8    1   |   28.5     57.0      85.5
   58 |    2       5        3      8    1   |   29.0     58.0      87.0
   59 |    2       5        3      8    1   |   29.5     59.0      88.5
   60 |    2       5        3      8    1   |   30.0     60.0      90.0

Personally I like the 113 MHz FSB setting, which runs PCI at 37 and memory at
150 (133*1.13). It helps to have memory rated for 150. :) I've had a system
run at this rate for the past 4 months now and I've never had any problems.
Of course, your results may vary.

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
