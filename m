Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTEZU46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 16:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbTEZU46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 16:56:58 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:45467 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262254AbTEZU44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 16:56:56 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Kimmo Sundqvist <rabbit80@mbnet.fi>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.20-ck7] good compressed caching experience
Date: Tue, 27 May 2003 07:11:34 +1000
User-Agent: KMail/1.5.1
References: <200305262150.04552.rabbit80@mbnet.fi>
In-Reply-To: <200305262150.04552.rabbit80@mbnet.fi>
Cc: rcastro@users.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200305270711.34608.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003 04:50, Kimmo Sundqvist wrote:
> Hello

Hi Kimmo

> I just decided to tell everyone that I've been able to run 2.4.20-ck7 with
> compressed caching enabled in my little brother's Pentium 133MHz, for
> hours, doing stress testing, compiling kernels and using the Internet under
> X.
>
> I had pre-empt enabled.  Compressed swap worked also.  I used 4kB pages
> without compressed swap, and 8kB with it.
>
> This was with Con's ck7pre versions released on 24th and 25th of May.
>
> Now running 2.4.20-ck7pre with compressed cache in a dual CPU machine with
> SMP disabled (compressed caching and SMP support are still mutually
> exclusive), 1GB of RAM but "mem=128M" for testing purposes.  Been stable
> for 6 hours now, and done even some stress testing.  Try 128 instances of
> burnBX with 1MB each, like "for ((A=128;A--;A<1)) do burnBX J & done".  A
> nice brute force or "if you don't behave I'll push all my buttons" method
> :)
>
> Wondering if Pentium 133MHz (64MB RAM) is fast enough to benefit from
> compressed caching.  I know there's a limit, depending on the speed of the
> CPU and the speed of the swap partition (doing random accesses), which
> determines if compressed caching is beneficial or not.
>
> This machine has a Seagate Barracuda V 80GB, which does sequential reads at
> 40MB/s.  I could drive this into trashing, then type "sar -B 1 1000" and
> see how the swap is doing.  Now, compressed caching brings me benefit if,
> and only if, it can compress and decompress pages faster than that in this
> CPU, which it sure does, since this is a Pentium III 933MHz, but I'm not
> sure about the little brother's Pentium 133MHz.  It has a 4GB Seagate that
> does 6MB/s sequentially.  Did I figure it out correctly?  Of course
> swapping to a partition gets slower as the swap usage increases.  Longer
> seeks and the like.

What you describe has been my experience with cc as well. I haven't had any 
crashes or unusual problems with it since removing the AA vm changes as well 
- it seemed to be the combination that caused hiccups on extreme testing. 
>From what I can see, no matter how slow your cpu you will still get benefit 
from cc as the hard drives on those machines are proportionately slower as 
well. The one limitation of cc is that it does require _some_ ram to actually 
store swap pages in, and it seems that you need more than 32Mb ram to start 
deriving benefit.

One minor thing, though - my vm hacks make compressed caching work much less 
than it normally does as they try to avoid swapping quite aggressively. It is 
when the vm attempts to start swapping that cc looks to see if it should take 
pages into compressed cache instead.

I've cc'ed the actual developer of cc as he has indicated that he is actively 
working on compressed caching again.

> Just a warning... both systems have only ReiserFS partitions.  Other FSes
> might still get hurt.

This is definitely the case! If you try out compressed caching with ck7 please 
do not enable preempt if you are using ext2/3 or vfat.

Cheers,
Con
