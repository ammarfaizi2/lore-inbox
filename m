Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVLVRlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVLVRlm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVLVRlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:41:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030223AbVLVRlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:41:42 -0500
Date: Thu, 22 Dec 2005 09:40:22 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       mingo@elte.hu, linux-kernel@vger.kernel.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, alan@lxorguk.ukuu.org.uk,
       bcrl@kvack.org, rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <1135266369.2806.212.camel@tglx.tec.linutronix.de>
Message-ID: <Pine.LNX.4.64.0512220937390.4827@g5.osdl.org>
References: <20051222114147.GA18878@elte.hu>  <20051222035443.19a4b24e.akpm@osdl.org>
 <20051222122011.GA20789@elte.hu>  <20051222050701.41b308f9.akpm@osdl.org> 
 <1135257829.2940.19.camel@laptopd505.fenrus.org>  <20051222054413.c1789c43.akpm@osdl.org>
 <1135266369.2806.212.camel@tglx.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Dec 2005, Thomas Gleixner wrote:
> 
> Semaphores need a counter, mutexes only a binary representation of the
> locked/unlocked state

Actually, that's not true.

A _spinlock_ only needs a binary representation of the locked/unlocked 
state.

A mutex needs a _ternary_ representation. It needs an additional 
"contention" state to tell the wakeup that extra action is needed.

If you don't handle contention (and do extra action all the time), you're 
screwed from a performance standpoint.

			Linus
