Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129513AbQKFTLM>; Mon, 6 Nov 2000 14:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129572AbQKFTLC>; Mon, 6 Nov 2000 14:11:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20753 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129513AbQKFTKv>; Mon, 6 Nov 2000 14:10:51 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: setup.S: A20 enable sequence (once again)
Date: 6 Nov 2000 11:10:32 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8u6vn8$70i$1@cesium.transmeta.com>
In-Reply-To: <00110618083400.11022@rob>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <00110618083400.11022@rob>
By author:    Robert Kaiser <rob@sysgo.de>
In newsgroup: linux.dev.kernel
>
> Hi all,
> 
> a while ago, I posted a request here to add the "fast A20" enable
> sequence to setup.S in order to enable booting Linux on boards that
> don't have a keyboard controller. I was happy to see that this has
> been added into 2.4.0-test10 already. However, on some embedded
> boards, booting 2.4.0-test10 does work, but it takes several minutes
> which the board spends in complete silence (it took me almost a day
> to realize that I only had to wait long enough for the system to
> boot ...)
> 
> The reason for this is that the A20 enable sequence in setup.S is still
> accessing the (in my case not existing) keyboard controller. It times out
> eventually, but the timeout takes *very* long, especially on a slowish
> embedded 386EX@25MHz.
> 
> The attached patch fixes this by doing "fast A20" enable first and
> then checking if A20 already is enabled. If it is, the keyboard
> controller sequence is skipped. This works for me, so, could people
> please have a look at this.
> 

This doesn't really work.  Neither the fast A20 gate nor the KBC is
guaranteed to have immediate effect (on most systems they won't.)

What's worse, once you have done an "out" to the KBC you need to
finish the sequence.  I need to think about this for a bit.

(Arguably, what you're doing is running on completely nonstandard
hardware, which may need a CONFIG_ option.  However, if we can avoid
it I guess it's better.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
