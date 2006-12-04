Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936051AbWLDLuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936051AbWLDLuS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936133AbWLDLuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:50:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47833 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S936051AbWLDLuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:50:15 -0500
Date: Mon, 4 Dec 2006 12:48:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061204114851.GA25859@elte.hu>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org> <1165082803.24604.54.camel@localhost.localdomain> <20061202181957.GK3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061202181957.GK3078@ftp.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@ftp.linux.org.uk> wrote:

> > This is going to make a lot of data structures smaller, when the 
> > timer_list is embedded in the structure itself and for the lot, 
> > which ignores the timer callback argument anyway.
> 
> container_of => still lousy type safety.  All over the sodding place.

the question is: which is more important, the type safety of a 
container_of() [or type cast], which if we get it wrong produces a 
/very/ trivial crash that is trivial to fix - or embedded timers data 
structure size all around the kernel? I believe the latter is more 
important.

and we could have a runtime debugging option to tie the type of the 
structure to the timer list entry. For example by using 
__builtin_classify_type(), sizeof() and offsetof() to fingerprint timer 
structs at init_timer time, and then checking for that at container_of() 
time - or something like that. In fact, gcc should really give us a 
better way to categorize types than __builtin_classify_type(). We could 
probably improve the situation by having some global registry of types 
known to the kernel, via a huge switch() around 
__builtin_types_compatible_p().

	Ingo
