Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSBZXeU>; Tue, 26 Feb 2002 18:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289046AbSBZXeB>; Tue, 26 Feb 2002 18:34:01 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:15859 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S288967AbSBZXdl>;
	Tue, 26 Feb 2002 18:33:41 -0500
Date: Tue, 26 Feb 2002 16:33:23 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] enable uptime display > 497 days on 32 bit
Message-ID: <20020226163323.G12832@lynx.adilger.int>
Mail-Followup-To: george anzinger <george@mvista.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202261754030.14645-100000@gans.physik3.uni-rostock.de> <3C7BE53E.BB789BC6@mvista.com> <20020226135006.R12832@lynx.adilger.int> <3C7C16AC.D08F8152@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C7C16AC.D08F8152@mvista.com>; from george@mvista.com on Tue, Feb 26, 2002 at 03:13:48PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 26, 2002  15:13 -0800, george anzinger wrote:
> Andreas Dilger wrote:
> > Do you think that doing a 64-bit add-with-carry to memory on each
> > timer interrupt and doing multiple volatile reads is faster than
> > doing a spinlock with an optional 32-bit increment?  
> 
> I think the memory cycle is "almost" free as we are also updating
> jiffies which is in the same cache line, so, yes, in the overall scheme
> of things the overhead of the additional add-with-carry is very small. 
> On the read side of things, the issue is not so much the lock, but the
> irq nature of it.  This will be VERY long, much longer than the double
> load of the high order bits, again from the same cache line.

I was wondering about that myself when looking at the code again.  I'm
not quite sure why we need to use the irq spinlock, since we already
make a local copy of jiffies so another timer IRQ changing the jiffies
value shouldn't affect the return value of get_jiffies64().  Then again,
that isn't exactly stuff I'm familiar with, so I could be totally
off-base here.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

