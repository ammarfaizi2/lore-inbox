Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267280AbTBQTAS>; Mon, 17 Feb 2003 14:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTBQTAS>; Mon, 17 Feb 2003 14:00:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45327 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267280AbTBQTAR>; Mon, 17 Feb 2003 14:00:17 -0500
Date: Mon, 17 Feb 2003 11:06:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <3E508308.4020400@colorfullife.com>
Message-ID: <Pine.LNX.4.44.0302171059290.2581-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Feb 2003, Manfred Spraul wrote:
>
> I'm not convinced that exec is correct.

No, I think you're right. And I think just fixing send_sig_info() to take 
the tasklist lock is the right thing to do.

That still leaves force_sig_info() without the tasklist lock, but since 
that is only used for page faults etc synchronous errors, that's fine (if 
we get a synchronous error in the kernel, we have bigger problems than 
signal locking).

		Linus

