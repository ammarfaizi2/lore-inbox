Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSEZAaM>; Sat, 25 May 2002 20:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSEZAaM>; Sat, 25 May 2002 20:30:12 -0400
Received: from ns.suse.de ([213.95.15.193]:273 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315483AbSEZAaK>;
	Sat, 25 May 2002 20:30:10 -0400
Date: Sun, 26 May 2002 02:30:10 +0200
From: Dave Jones <davej@suse.de>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: Luigi Genoni <kernel@Expansa.sns.it>, "J.A. Magallon" <jamagallon@able.es>,
        Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4}
Message-ID: <20020526023009.G16102@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
	Luigi Genoni <kernel@Expansa.sns.it>,
	"J.A. Magallon" <jamagallon@able.es>,
	Luca Barbieri <ldb@ldb.ods.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205260128110.2047-100000@Expansa.sns.it> <Pine.LNX.4.44.0205260044270.10923-100000@sharra.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 12:49:57AM +0100, Ruth Ivimey-Cook wrote:

 > For the CONFIG_<<cputype>> options, is it only gcc compiler-type settings that 
 > are affected? I thought the assembly parts of the kernel were also switched on 
 > occasion.

Typically the MMX/3dnow/SSE memory copies get enabled where possible.

 > I was wondering whether anyone has checked that these assembly snippets were 
 > decently optimal for the cpu type selected...

Arjan and a few others spent weeks tuning the memset/memcpy functions,
there's really not that much room for improvement with them imo.
I spent a week or so a while back trying in vain to squeeze out just a
few more MB/s, and failed to get good results across the board.
There are a few tricks that can be pulled to do things like copying
backwards to trick hardware prefetchers, but this starts to get into
voodoo land.
For now, the i386 optimised memcpy is probably a closed book.
x86-64 may reopen that book to revisit some lessons learned..

 > > > In a lot of cases, the kernel 'knows better' and is adding the
 > Be careful about 'knowing better' than compilers. I really don't want to start
 > a flamefest, but modern compilers are very good at doing all sorts of
 > optimisations, and hand-coded 'optimisations' can _sometimes_ actually hurt
 > performance over the unadorned version of the code.
 
I would be (pleasantly) surprised to see gcc turn a C memcpy into faster
assembly than our current implementation. And I'll bet
$beverage_of_choice it'll stay that way for some time.
gcc has come on in leaps and bounds, but for something as performance
critical as memory copying/clearing, hand tuned assembly wins hands down.
Even AMD's/Intel's performance guides suggest doing this. It's the only
way to fly.
 
    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
