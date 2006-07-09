Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161190AbWGIWTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161190AbWGIWTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 18:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbWGIWTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 18:19:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161190AbWGIWTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 18:19:18 -0400
Date: Sun, 9 Jul 2006 15:18:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Albert Cahalan <acahalan@gmail.com>, tglx@linutronix.de,
       joe.korty@ccur.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <20060709211023.GC5759@ucw.cz>
Message-ID: <Pine.LNX.4.64.0607091506250.5623@g5.osdl.org>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
 <20060708094556.GA13254@tsunami.ccur.com> <1152354244.24611.312.camel@localhost.localdomain>
 <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com>
 <1152383487.24611.337.camel@localhost.localdomain>
 <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com>
 <Pine.LNX.4.64.0607081256170.3869@g5.osdl.org> <20060709211023.GC5759@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Pavel Machek wrote:
> 
> volatile int a; a=1; a=2;
> 
> ...under old definition, there's nothing to optimize but AFAICT, your
> definition allows optimizing out a=1.

If 'a' can alias anything, then by definition the first 'a=1' could have 
changed something else than the second one. Otherwise, it couldn't have 
aliased "anything", it would have aliased only something _particular_. 

IOW, you can think of "aliasing anything" as being equivalent to saying 
"the address is indeterminate". Two writes could literally go to two 
different things.

But yeah, maybe that's not really perfect either. It leaves the 
read-vs-read orderign still open.

			Linus
