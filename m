Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318812AbSHRDSp>; Sat, 17 Aug 2002 23:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318814AbSHRDSp>; Sat, 17 Aug 2002 23:18:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55820 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318812AbSHRDSo>; Sat, 17 Aug 2002 23:18:44 -0400
Date: Sat, 17 Aug 2002 20:25:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm.. After more reading, it looks like (if I understood correctly), that
since network activity isn't considered trusted -at-all-, your average
router / firewall / xxx box will not _ever_ get any output from
/dev/random what-so-ever. Quite regardless of the context switch issue,
since that only triggers for trusted sources. So it was even more
draconian than I expected.

Are you seriously trying to say that a TSC running at a gigahertz cannot 
be considered to contain any random information just because you think you 
can time the network activity so well from the outside?

Oliver, I really think this patch (which otherwise looks perfectly fine)  
is just unrealistic. There are _real_ reasons why a firewall box (ie one
that probably comes with a flash memory disk, and runs a small web-server
for configuration) would want to have strong random numbers (exactly for
things like generating host keys when asked to by the sysadmin), yet you
seem to say that such a user would have to use /dev/urandom.

If I read the patch correctly, you give such a box _zero_ "trusted" 
sources of randomness, and thus zero bits of information in /dev/random. 
It obviously won't have a keyboard or anything like that.

This is ludicrous.

		Linus

