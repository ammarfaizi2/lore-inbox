Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318845AbSHREio>; Sun, 18 Aug 2002 00:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318847AbSHREio>; Sun, 18 Aug 2002 00:38:44 -0400
Received: from waste.org ([209.173.204.2]:53217 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318845AbSHREin>;
	Sun, 18 Aug 2002 00:38:43 -0400
Date: Sat, 17 Aug 2002 23:42:42 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818044242.GI21643@waste.org>
References: <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com> <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:25:55PM -0700, Linus Torvalds wrote:
> 
> Hmm.. After more reading, it looks like (if I understood correctly), that
> since network activity isn't considered trusted -at-all-, your average
> router / firewall / xxx box will not _ever_ get any output from
> /dev/random what-so-ever. Quite regardless of the context switch issue,
> since that only triggers for trusted sources. So it was even more
> draconian than I expected.

But it will get data of _equal quality_ to the current approach from
/dev/urandom.
 
> Are you seriously trying to say that a TSC running at a gigahertz cannot 
> be considered to contain any random information just because you think you 
> can time the network activity so well from the outside?

Yes. The clock of interest is the PCI bus clock, which is not terribly
fast next to a gigabit network analyzer.

> Oliver, I really think this patch (which otherwise looks perfectly fine)  
> is just unrealistic. There are _real_ reasons why a firewall box (ie one
> that probably comes with a flash memory disk, and runs a small web-server
> for configuration) would want to have strong random numbers (exactly for
> things like generating host keys when asked to by the sysadmin), yet you
> seem to say that such a user would have to use /dev/urandom.
> 
> If I read the patch correctly, you give such a box _zero_ "trusted" 
> sources of randomness, and thus zero bits of information in /dev/random. 
> It obviously won't have a keyboard or anything like that.

Anyone who'd have that problem has it today. Current kernels only add
entropy for a small number of rare cards. Grep for SA_SAMPLE_RANDOM:

./net/e1000/e1000_main.c
./net/3c523.c
./net/ibmlana.c
./net/sk_mca.c

In reality, most apps are using /dev/urandom for routine entropy as
they should be.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
