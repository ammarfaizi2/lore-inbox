Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVLVONt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVLVONt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 09:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLVONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 09:13:49 -0500
Received: from [81.2.110.250] ([81.2.110.250]:2779 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932502AbVLVONs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 09:13:48 -0500
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051222054413.c1789c43.akpm@osdl.org>
References: <20051222114147.GA18878@elte.hu>
	 <20051222035443.19a4b24e.akpm@osdl.org> <20051222122011.GA20789@elte.hu>
	 <20051222050701.41b308f9.akpm@osdl.org>
	 <1135257829.2940.19.camel@laptopd505.fenrus.org>
	 <20051222054413.c1789c43.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Dec 2005 14:11:49 +0000
Message-Id: <1135260709.10383.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-22 at 05:44 -0800, Andrew Morton wrote:
> > semaphores have had a lot of work for the last... 10 years. To me that
> > is a sign that maybe they're close to their limit already.
> 
> No they haven't - they're basically unchanged from four years ago (at
> least).

Point still holds

> It's plain dumb for us to justify a fancy-pants new system based on
> features which we could have added to the old one, no?

The old one does one job well. Mutex wakeups are very different in
behaviour because of the single waker rule and the fact you can do stuff
like affine wakeups.

You could make it one function but it would inevitably end up full of

	if(mutex) {
	}

so you'd make it slower, destabilize both and not get some of the
winnings like code size.

Oh and of course you no doubt break the semaphores while doing it, while
at least this seperate way as Linus suggested you don't break the
existing functionality.

> There's no need for two sets of behaviour. 

The fundamental reason for mutexes in terms of performance and
scalability requires the different wake up behaviours. The performance
numbers are pretty compelling. I was against the original proposal but
now the gradual changeover is proposed I'm for.


Alan

