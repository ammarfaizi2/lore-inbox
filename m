Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261833AbTCYJkb>; Tue, 25 Mar 2003 04:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbTCYJka>; Tue, 25 Mar 2003 04:40:30 -0500
Received: from AMarseille-201-1-1-200.abo.wanadoo.fr ([193.252.38.200]:9255
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S261833AbTCYJk3>; Tue, 25 Mar 2003 04:40:29 -0500
Subject: Re: [patch] oprofile + ppc750cx perfmon
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bryan Rittmeyer <bryanr@bryanr.org>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030325085759.GB30294@bryanr.org>
References: <20030325050900.GA30294@bryanr.org>
	 <20030325085759.GB30294@bryanr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048585501.581.16.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 10:45:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 09:57, Bryan Rittmeyer wrote:

> wow. inside of open_pic.c, I bet it's code like this
> 
>         while (openpic_read(addr) & OPENPIC_ACTIVITY);
> 
> that's showing up.

That's interesting. You are raising again an old debate of
wether to disable the IRQ during handling on openpic or not,
I beleive we don't need to disable it on this PIC, but we
do this for "safety" reasons.

In fact, I think our

openpic_ack_irq() should do something like

  if (edge)
	openpic_eoi();

and our openpic_end_irq() something like

  if (level)
	openpic_eoi();

Also, the fact that PIC access is slow is a generic "feature"
of such chips, I also think we could actually be smarter and only
soft-disable IRQs with a flag in the descriptor, and hard disable
them if and only if they actually occur while disabled.

Ben.

