Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161157AbWGIVKv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWGIVKv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbWGIVKv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:10:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58129 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1161158AbWGIVKu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:10:50 -0400
Date: Sun, 9 Jul 2006 21:10:24 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <acahalan@gmail.com>, tglx@linutronix.de,
       joe.korty@ccur.com, linux-kernel@vger.kernel.org, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060709211023.GC5759@ucw.cz>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com> <20060708094556.GA13254@tsunami.ccur.com> <1152354244.24611.312.camel@localhost.localdomain> <787b0d920607080849p322a6349g7a5fd98f78aa9f32@mail.gmail.com> <1152383487.24611.337.camel@localhost.localdomain> <787b0d920607081233w3e0e99a9n706ff510c3de458b@mail.gmail.com> <Pine.LNX.4.64.0607081256170.3869@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607081256170.3869@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Btw, I think that the whole standard definition of "volatile" is pretty 
> weak and useless. The standard could be improved, and a way to improve the 
> definition of volatile would actually be to say something like
> 
> 	"volatile" implies that the access to that entity can alias with 
> 	any other access.
> 
> That's actually a lot simpler for a compiler writer (a C compiler already 
> has to know about the notion of data aliasing), and gives a lot more 
> useful (and strict) semantics to the whole concept.
> 
> So to look at the previous example of
> 
> 	extern int a;
> 	extern int volatile b;
> 
> 	void testfn(void)
> 	{
> 		a++;
> 		b++;
> 	}
> 
> _my_ definition of "volatile" is actually totally unambiguous, and not 
> just simpler than the current standard, it is also stronger. It would make 
> it clearly invalid to read the value of "b" until the value of "a" has 
> been written, because (by my definition), "b" may actually alias the value 
> of "a", so you clearly cannot read "b" until "a" has been updated.
...
> In contrast, the current C standard definition of "volatile" is not only 
> cumbersome and inconvenient, it's also badly defined when it comes to 
> accesses to _other_ data, making it clearly less useful.
> 
> I personally think that my simpler definition of volatile is actually a 
> perfectly valid implementation of the current definition of volatile, and 
> I suggested it to some gcc people as a better way to handle "volatile" 
> inside gcc while still being standards-conforming (ie the "can alias 
> anything" thing is not just clearer and simpler, it's strictly a subset of 
> what the C standard allows, meaning that I think you can adopt my 
> definition _without_ breaking any old programs or standards).

Are you sure?

volatile int a; a=1; a=2;

...under old definition, there's nothing to optimize but AFAICT, your
definition allows optimizing out a=1.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
