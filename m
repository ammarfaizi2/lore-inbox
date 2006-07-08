Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWGHKVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWGHKVS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGHKVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:21:18 -0400
Received: from www.osadl.org ([213.239.205.134]:49828 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932320AbWGHKVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:21:17 -0400
Subject: Re: [patch] spinlocks: remove 'volatile'
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: joe.korty@ccur.com
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-os@analogic.com,
       khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org, arjan@infradead.org
In-Reply-To: <20060708094556.GA13254@tsunami.ccur.com>
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	 <20060708094556.GA13254@tsunami.ccur.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 12:24:04 +0200
Message-Id: <1152354244.24611.312.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 05:45 -0400, Joe Korty wrote:
> On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> > That's all theoretical though. Today, gcc's volatile does
> > not follow the C standard on modern hardware. Bummer.
> > It'd be low-performance anyway though.
> 
> But gcc would follow the standard if it emitted a 'lock'
> insn on every volatile reference.  It should at least
> have an option to do that.

Wrong. The only thing which is guaranteed by "volatile" according to the
standard is that the compiler does not optimize and cache seemingly
static values, which is just sufficient for the usual C for dummies
example: 

	while(stop == 0);

volatile works fine on trivial microcontrollers and for the basic C
course lesson, but there is no way for the compiler to decide which of
the 'lock' mechanisms should be used in complex situations.

In low level system programming there is no fscking way for the compiler
to figure out if this is in context of a peripheral bus, cross CPU
memory or whatever. All those things have hardware dependend semantics
and the only way to get them straight is to enforce the correct handling
with handcrafted assembler code.

	tglx


