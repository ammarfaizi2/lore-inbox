Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUL1SzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUL1SzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbUL1SzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:55:02 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:50351
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261229AbUL1Sy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:54:59 -0500
Date: Tue, 28 Dec 2004 10:53:30 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, mingo@redhat.com
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
Message-Id: <20041228105330.6da0f0ea.davem@davemloft.net>
In-Reply-To: <200412281350.44195.dtor_core@ameritech.net>
References: <1104249508.22366.101.camel@localhost.localdomain>
	<200412281228.27307.dtor_core@ameritech.net>
	<20041228102550.42dbb028.davem@davemloft.net>
	<200412281350.44195.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 13:50:40 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> Please look at the patch below (handful of arches only and against
> some old tree, but you'll see what I wanted to do). What I meant
> by changing the semantics is that reporting is delayed by 1 interrupt.

This looks exactly like what I was looking for.  I think I misunderstood
your original description, which is why it is always best to communicate
ideas using patches :)

My misunderstanding what that I thought that your flag would work
like this:

1) input interrupt occurs, flag is set
2) IRQ handling completes
3) some new IRQ arrives, and this is when we test
   the flag for dumping sysrq regs

That, fortunately, is not what your patch is doing.

> This is for only one IRQ handler I believe which I think we can
> do special-case for. Is it for math-emulation only?

I rather believe it is for vm86 IRQ handling.
