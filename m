Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLOB5e>; Thu, 14 Dec 2000 20:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbQLOB5Z>; Thu, 14 Dec 2000 20:57:25 -0500
Received: from coruscant.franken.de ([193.174.159.226]:41999 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S129325AbQLOB5T>; Thu, 14 Dec 2000 20:57:19 -0500
Date: Fri, 15 Dec 2000 02:25:29 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Netfilter is broken (was Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback))
Message-ID: <20001215022529.H6775@coruscant.gnumonks.org>
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu> <200012141955.LAA08814@pizda.ninka.net> <20001215012000.B6775@coruscant.gnumonks.org> <200012150011.QAA12767@pizda.ninka.net> <20001215014832.A27064@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001215014832.A27064@gruyere.muc.suse.de>; from ak@suse.de on Fri, Dec 15, 2000 at 01:48:32AM +0100
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Setting Orange, the 53rd day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2000 at 01:48:32AM +0100, Andi Kleen wrote:
> 
> Also is it sure that the backtrace involves ip_rcv ? A more likely
> guess is that it happens during the IP_LOCAL_OUT hook, when skb->dev 
> isn't set yet, but conntrack already has to already reassemble fragments.

Oh, thanks Andi. This is the key, of course. I'm always way too focused
on forwarded packets ;)

This is definitely the problem. 

We could set skb->dev to skb->dst->dev, but this sounds more like a 
hack than a real solution...

> -Andi

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
