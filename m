Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTA2RGJ>; Wed, 29 Jan 2003 12:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266693AbTA2RGJ>; Wed, 29 Jan 2003 12:06:09 -0500
Received: from mail.ithnet.com ([217.64.64.8]:22791 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266638AbTA2RGH>;
	Wed, 29 Jan 2003 12:06:07 -0500
Date: Wed, 29 Jan 2003 18:15:17 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: hahn@physics.mcmaster.ca, linux-kernel@vger.kernel.org
Subject: Re: no more MTRRs available ?
Message-Id: <20030129181517.32f0ea49.skraw@ithnet.com>
In-Reply-To: <20030129162013.GA1856@codemonkey.org.uk>
References: <20030129164552.182e0cb8.skraw@ithnet.com>
	<Pine.LNX.4.44.0301291046490.18828-100000@coffee.psychology.mcmaster.ca>
	<20030129170554.08dc6393.skraw@ithnet.com>
	<20030129162013.GA1856@codemonkey.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jan 2003 16:20:13 +0000
Dave Jones <davej@codemonkey.org.uk> wrote:

> On Wed, Jan 29, 2003 at 05:05:54PM +0100, Stephan von Krawczynski wrote:
> 
>  > Mark Hahn <hahn@physics.mcmaster.ca> wrote:
> 
> (odd, I'm not getting Mark's mails to l-k).

He does not send them there. I know it is a no-no to forward his writings to
the list, but I thought it may be of use to others, too (and he did not shoot
me for it so far ;-)

>  > > that your bios is stupid, I think.  mtrr's handle areas that are 
>  > > powers of two in size (and >= 1M, I think).  the problem here is that
>  > > the bios is trying to represent 4G of write-back ram and a 16M of 
>  > > uncachable IO area (AGP aperture, I'm guessing).  the correct way
>  > > to do this is a single 4G mtrr with an overlapping 16M one.
> 
> That does seem to make more sense. Perhaps too much sense.
> ISTR there were ordering rules in how you layer MTRRs on top of each
> other.

Ok, after reading your thoughts and re-reading the bios stuff I found and "DRAM
alignment" option, and voila:

reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
reg02: base=0x200000000 (8192MB), size=8192MB: write-back, count=1
reg03: base=0x400000000 (16384MB), size=16384MB: write-back, count=1
reg04: base=0x800000000 (32768MB), size=32768MB: write-back, count=1
reg05: base=0xfb000000 (4016MB), size=   8MB: write-combining, count=1

The table got obviously shorter and significantly "better". It seems the
onboard VGA stuff is now mapped out of the normal DRAM range. 

I must admit though that some of this bios looks fishy, because now I cannot
find the original DRAM caching entries any longer, no matter what I switch on
or off (you know those "write-back, write-through" stuff).

Now I think one can really be content with this setup. Thanks a lot to Mark and
Dave.
In case anyone is interested, this is an Asus TRL-DLS mb.

-- 
Regards,
Stephan
