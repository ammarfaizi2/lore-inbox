Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHLHY2>; Mon, 12 Aug 2002 03:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSHLHY2>; Mon, 12 Aug 2002 03:24:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:58496 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317468AbSHLHY1>;
	Mon, 12 Aug 2002 03:24:27 -0400
Date: Mon, 12 Aug 2002 11:26:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: [PATCH] Simplified scalable cpu bitmasks
In-Reply-To: <20020812000347.A99CE2C185@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0208121119010.2067-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i'd suggest to introduce one more helper define:

	#define BITS_TO_LONG(bits) \
		(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)

this IMO simplifies some of the initializers, eg. the all-1 cpu-mask:

	#define CPU_MASK_ALL \
		{ [0 ... BITS_TO_LONG(NR_CPUS)-1] = ~0UL }

    Ingo


