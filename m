Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVLOQ3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLOQ3S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLOQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:29:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750792AbVLOQ3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:29:17 -0500
Date: Thu, 15 Dec 2005 08:28:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Nikita Danilov <nikita@clusterfs.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, pj@sgi.com,
       mingo@elte.hu, hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
In-Reply-To: <4743.1134662116@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0512150817170.3292@g5.osdl.org>
References: <17313.37200.728099.873988@gargle.gargle.HOWL> 
 <1134559121.25663.14.camel@localhost.localdomain> <13820.1134558138@warthog.cambridge.redhat.com>
 <20051213143147.d2a57fb3.pj@sgi.com> <20051213094053.33284360.pj@sgi.com>
 <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org>
 <20051213075441.GB6765@elte.hu> <20051213090219.GA27857@infradead.org>
 <20051213093949.GC26097@elte.hu> <20051213100015.GA32194@elte.hu>
 <6281.1134498864@warthog.cambridge.redhat.com> <14242.1134558772@warthog.cambridge.redhat.com>
 <16315.1134563707@warthog.cambridge.redhat.com> <1134568731.4275.4.camel@tglx.tec.linutronix.de>
 <43A0AD54.6050109@rtr.ca> <20051214155432.320f2950.akpm@osdl.org>
 <17313.29296.170999.539035@gargle.gargle.HOWL> <1134658579.12421.59.camel@localhost.localdomain>
  <4743.1134662116@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Dec 2005, David Howells wrote:
> 
> But what to do about DECLARE_MUTEX? :-/

It's correctly named right now (it _does_ declare a mutex, despite the 
insane noise from the sidelines).

I would suggest that if you create a new "mutex" type, you just keep the 
lower-case name. Don't re-use the DECLARE_MUTEX format, just do

	struct mutex my_mutex = UNLOCKED_MUTEX;

for new code that uses the new stuff.

Think about it a bit. We don't have DECLARE_SPINLOCK either. Why?

Hint: we have DECLARE_MUTEX exactly because it's also DOCUMENTATION that 
we use a semaphore as a pure binary mutex. Not because we need it.

If you create a real "struct mutex", then something like the current 
DECLARE_MUTEX() is simply not relevant for the new type.

			Linus
