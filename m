Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVLVPj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVLVPj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVLVPj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:39:27 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:43661
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751181AbVLVPis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:38:48 -0500
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       bcrl@kvack.org, rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051222054413.c1789c43.akpm@osdl.org>
References: <20051222114147.GA18878@elte.hu>
	 <20051222035443.19a4b24e.akpm@osdl.org> <20051222122011.GA20789@elte.hu>
	 <20051222050701.41b308f9.akpm@osdl.org>
	 <1135257829.2940.19.camel@laptopd505.fenrus.org>
	 <20051222054413.c1789c43.akpm@osdl.org>
Content-Type: text/plain
Organization: linutronix
Date: Thu, 22 Dec 2005 16:46:09 +0100
Message-Id: <1135266369.2806.212.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 05:44 -0800, Andrew Morton wrote:

> There's no need for two sets of behaviour.  What I'm saying is that we
> could add similar debugging features to semaphores (if useful).  Yes, we
> would have to tell the kernel at the source level to defeat that debugging
> if a particular lock isn't being used as a mutex.  That's rather less
> intrusive than adding a whole new type of lock.  But I'd question the value
> even of doing that, given the general historical non-bugginess of existing
> semaphore users.

Semaphores need a counter, mutexes only a binary representation of the
locked/unlocked state, which makes it possible to use instructions like
xchg, swap, test_and_set_bit depending on what atomic operations are
available on the architecture. On many architectures this is more
efficient than the counter based implementation.

Also the wakeup rules allow smaller and faster implementations for
mutexes.

	tglx


