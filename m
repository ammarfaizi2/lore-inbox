Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263983AbTDYU2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbTDYU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:28:12 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:55534 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S263983AbTDYU2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:28:09 -0400
Date: Fri, 25 Apr 2003 13:44:34 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: John Bradford <john@grabjohn.com>
Cc: Timothy Miller <miller@techsource.com>, Steven Augart <steve@augart.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Simple x86 Simulator (was: Re: Flame Linus to a crisp!)
Message-ID: <20030425114434.GG6009@wind.cocodriloo.com>
References: <3EA9565B.9020905@techsource.com> <200304251610.h3PGAiri001509@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304251610.h3PGAiri001509@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25, 2003 at 05:10:44PM +0100, John Bradford wrote:
> > > We could not.  Consider just the 8 32-bit-wide legacy x86 registers, 
> > > excluding the MMX and FPU registers:
> > > (AX, BX, CX, DX, BP, SI, DI, SP).  32 bits x 8 = 2^256 independent 
> > > states to look up in the table, each state having 256 bits of 
> > > information.  2^264 total bits of information needed.  Assume 1 GB 
> > > dimms (2^30 * 8 bits each = 2^33 bits of info), with a volume of 10 
> > > cm^3 per DIMM (including a tiny amount of space for air circulation.).
> > > Need 34508731733952818937173779311385127262255544860851932776 cubic 
> > > kilometers of space.
> > >
> > > Considerably larger than the volume of the earth, although admittedly 
> > > smaller than the total volume of the universe.
> > > --Steven Augart
> > 
> > If this could be done, someone would have done it already.
> 
> It's certainly possible to implement most of the functionality of a
> very simple processor this way, but applying the idea to an X86
> compatible processor was a joke.
> 
> What interests me now is whether we could cache the results of certain
> opcode strings in a separate memory area.
> 
> Say for example, you have a complicated routine that runs in to
> hundreds of opcodes, which is being applied to large amounts of data,
> word by word.  If one calculation doesn't depend on another, you could
> cache the results, and then merely fetch them from the results cache
> when the input data repeats itself.
> 
> I.E. the processor dynamically makes it's own look-up tables.

This is called dynamic programming and is done by keeping a cache
for previous results. Take for example a simple fibonacci function:

int fib(n){
  return fib(n-2) + fib(n-1);
}


Now hook up a direct-mapped cache:


int cache[65536];

int fib(n){
  int x = cache[n];
  if(x) return x;

  x = fib(n-2) + fib(n-1);

  cache[n] = x;
  return x;
}


Of course, this limits the range too much, so coding a LRU or
some other cache system would consume less memory and give
better speed.

Your idea, applying this to general hardware execution could
be _really_ nice in fact :)

Greets, Antonio.

ps. I recall that todays hardware does it for some stuff:
    the TBL cache replaces an expensive and sometimes
    complex page-table-tree walk (m68030 mmu-docs come
    to mind)
