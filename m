Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132919AbREEQnM>; Sat, 5 May 2001 12:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132934AbREEQnC>; Sat, 5 May 2001 12:43:02 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:34322 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S132919AbREEQmv>; Sat, 5 May 2001 12:42:51 -0400
Date: Sat, 5 May 2001 18:42:22 +0200
From: Kurt Roeckx <Q@ping.be>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Athlon possible fixes
Message-ID: <20010505184222.A26477@ping.be>
In-Reply-To: <E14vwaq-0000Jk-00@the-village.bc.nu> <200105051626.SAA16651@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <200105051626.SAA16651@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 06:26:30PM +0200, Rogier Wolff wrote:
> 
> As all this is trying to avoid bus turnarounds (i.e. switching from
> reading to writing), wouldn't it be fastest to just trust that the CPU
> has at least 4k worth of cache? (and hope for the best that we don't
> get interrupted in the meanwhile).
> 
> void copy_page (char *dest, char *source)
> {
> 	long *dst = (long *)dest, 
> 		*src=(long *)source, 
> 		*end= (long *)(source+PAGE_SIZE);
> #if 1
> 	register int  i;
> 	long t=0;
> 	static long tt;
> 
>   	for (i=0;i<PAGE_SIZE/sizeof (long);i += cache_line_size()/sizeof(long))
> 	/* Actually the innards of this loop should be:
> 		(void) from[i];
> 	   however, the compiler will probably optimize that away. */ 
>      		t += src[i];
> 
> 	tt = t;
> #endif
> 	while (src < end)
> 		*dst++ = *src++;
> 
> }
> 
> So, this is 15 lines of C, and it'd be interesting to benchmark this
> against the assembly.
> 
> I'm assuming that the "loop variable handling" is not going to
> influence the overall performance: that would run at 500 - 1000MHz,
> and around 1 clock cycle (1-2ns) per loop. Set this against the stalls
> against the memory unit whose output buffer is full, and memory writes
> that take on the order of 30 ns per 64bits.

Can't you use volatile to prevent the compiler from optimizing
it?


Kurt

