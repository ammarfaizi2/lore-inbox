Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTIEMhf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 08:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTIEMhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 08:37:19 -0400
Received: from [213.39.233.138] ([213.39.233.138]:23988 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262514AbTIEMhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 08:37:12 -0400
Date: Fri, 5 Sep 2003 14:37:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Fruhwirth Clemens <clemens-dated-1063627487.e072@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nasm over gas?
Message-ID: <20030905123710.GC10415@wohnheim.fh-wedel.de>
References: <20030904104245.GA1823@leto2.endorphin.org> <20030905114220.GB10415@wohnheim.fh-wedel.de> <20030905120446.GA3111@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030905120446.GA3111@leto2.endorphin.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 September 2003 14:04:46 +0200, Fruhwirth Clemens wrote:
> On Fri, Sep 05, 2003 at 01:42:20PM +0200, Jörn Engel wrote:
> > On Thu, 4 September 2003 12:42:45 +0200, Fruhwirth Clemens wrote:
> >
> > Do some benchmarks on lots of different machines and measure the
> > performance of the asm and c code.  If it's faster on PPro but not on
> > PIII or Athlon, forget about it.
> >
> > How big is the .text of the asm and c variant?  If the text of yours
> > is much bigger, you just traded 2fish performance for general
> > performance.  Everything else will suffer from cache misses.  Forget
> > your microbenchmark, your variant will make the machine slower.
> 
> Men! Why is everyone doubting the usefulness of assembler optimized parts?

Because assembler is such a pain. :)

In general, you don't want any code to be in assembler, so it is your
duty to prove that this is a valid exception.

> It's twice as fast on my Athlon. I assert the same is true for P3/P4. Just
> test.

Again, that is your job.  It is faster and smaller on Athlon, good.
How about i386?  Does it even run on that machine?  If not, you need
Kconfig to make sure it isn't compiled in for i386.  Repeat for all
other platforms.

Repeat for all the other cpus.

> twofish-i586.ko's .text section is smaller than the kernel's twofish.ko's. 945
> bytes to be precise. Please note that twofish-i586 includes TWO
> implementations: C and assembler. Just think about how much smaller it will
> be when I rip out the C part. 
> 
> So much for that.

Ok, that is good.  It might still be bigger, depending on the target
cpu, but that is unlikely.

> > How many bugs are in your code?  
> 
> 42... Is this a serious question?

It is.  You code should at least survive test runs against a different
implementation to make sure the good case is working correctly.  I
guess you have done it, but have you really?  Didn't tell us yet.

> > Are there any buffer overflows or other security holes? 
> > How can you be sure about it?  
> 
> How can you be sure? Mathematical program verification applies quite badly to
> assembler.

I'm not sure about the rest of the kernel either, but I have a much
better feeling.  The encryption implementations in the kernel were
based on existing and tested code, got some more testing, were
reviewed by several people...

If noone else ever went over your code, I will assume there are some
security holes left and a machine using that code is at least
vulnerable to local users.  This may still be ok, but it should be
noted in BIG LETTERS: DANGEROUS.

> > If your code fails on any one of these questions, forget about it.  If
> > it survives them, post your results and have someone else verify them.
> 
> I'm sorry, your critique is too generel to be useful.

Sorry, I don't feel like going through intel assembler in nasm syntax
in my free time, especially if I have to go and fetch the code myself.

Your idea looks promising - the reason why I bother to answer at all -
but if it should go in, it still needs a lot of work.  The fun part is
finished, you are 20% done. ;)

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius
