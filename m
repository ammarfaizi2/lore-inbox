Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbSKUTeZ>; Thu, 21 Nov 2002 14:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbSKUTeZ>; Thu, 21 Nov 2002 14:34:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:12816 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S267007AbSKUTeX>;
	Thu, 21 Nov 2002 14:34:23 -0500
Date: Thu, 21 Nov 2002 20:41:27 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Willy Tarreau <willy@w.ods.org>, David Zaffiro <davzaffiro@netscape.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling x86 with and without frame pointer
Message-ID: <20021121194127.GA22442@alpha.home.local>
References: <19005.1037854033@kao2.melbourne.sgi.com> <20021121050607.GA1554@mark.mielke.cc> <3DDCA7C9.9040501@netscape.net> <20021121192045.GE3636@alpha.home.local> <20021121193231.GE14063@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021121193231.GE14063@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 02:32:31PM -0500, Doug Ledford wrote:
> On Thu, Nov 21, 2002 at 08:20:45PM +0100, Willy Tarreau wrote:
> > On Thu, Nov 21, 2002 at 10:30:49AM +0100, David Zaffiro wrote:
> > > I use -momit-leaf-frame-pointer for optimization in some own projects, 
> > > instead of the "-fomit-frame-pointer". For me, this results in better 
> > > codesize/speed compared to both "-fomit-frame-pointer" or no option at 
> > > all. Actually gcc-2.95 seems to support this feature as well, but it 
> > > never made it into the 2.95 docs... It makes debugging a lot easier too.
> > > 
> > > So anyone "caring to benchmark", could you please test the 
> > > "-momit-leaf-frame-pointer" option for x86 as well...
> > 
> > Well, I tried on a 2.4.18+patches with gcc 2.95.3. bzImage is :
> > 538481 bytes with -fomit-frame-pointer
> > 538510 bytes with no particular flag
> > 542137 bytes with -momit-leaf-frame-pointer.
> 
> These numbers are useless.  Since a change in frame pointer setup changes 
> the code sequences in the text section, it is likely to also change 
> maximum acheived compression.  Therefore, the size of the compressed 
> images can not be compared and result in any useable data, you need to 
> compare the size of the uncompressed images.

Yes, you're quite right about this. I had my mind obsessed all the day reducing
a bzImage to fit it on a diskette, and didn't immediately realise that other
people were speaking pure vmlinux in this discussion :-)

So I retried, and the difference in vmlinux between -fomit-frame-pointer and
-momit-leaf-frame-pointer is nearly 1 kB LESS for the last one (difference
in text only). So David was right here. Please also node that the code is
really less compressible because 1 kB less gives 4 kB more after compression.
Even after upx, the difference is still 3 kB between the two images.

Anyway, the compressed size is sometimes more relevant than the vmlinux one,
when it comes to put it on very limited devices such as diskettes. In my case,
I don't need this extra 1 kB ram, I prefer those 4 kB floppy image for another
NIC driver !

I haven't benchmarked anything with these options. Maybe David's suggestion
is interesting for userland where compression is rarely used.

Cheers,
Willy

