Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUBCK6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 05:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUBCK5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 05:57:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:22710 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265974AbUBCK5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 05:57:48 -0500
Date: Tue, 3 Feb 2004 11:58:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jos Hulzink <josh@stack.nl>
Subject: Re: [PATCH] 2.6.1 Hyperthread smart "nice" 2
Message-ID: <20040203105758.GA7783@elte.hu>
References: <200401291917.42087.kernel@kolivas.org> <200402022027.10151.kernel@kolivas.org> <20040202103122.GA29402@elte.hu> <200402032152.46481.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402032152.46481.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin 2.60
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> At least it appears Intel are well aware of the priority problem, but
> full priority support across logical cores is not likely. However I
> guess these new instructions are probably enough to work with if
> someone can do the coding.

these instructions can be used in the idle=poll code instead of rep-nop. 
This way idle-wakeup can be done via the memory bus in essence, and the
idle threads wont waste CPU time. (right now idle=poll wastes lots of
cycles on HT boxes and is thus unusable.)

for lowprio tasks they are of little use, unless you modify gcc to
sprinkle mwait yields all around the 'lowprio code' - not very practical
i think.

	Ingo
