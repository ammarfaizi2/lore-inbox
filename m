Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUL1S1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUL1S1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 13:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUL1S1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 13:27:20 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:62894
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261212AbUL1S1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 13:27:18 -0500
Date: Tue, 28 Dec 2004 10:25:50 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       alan@lxorguk.ukuu.org.uk, mingo@redhat.com
Subject: Re: PATCH: 2.6.10 - Misrouted IRQ recovery for review
Message-Id: <20041228102550.42dbb028.davem@davemloft.net>
In-Reply-To: <200412281228.27307.dtor_core@ameritech.net>
References: <1104249508.22366.101.camel@localhost.localdomain>
	<1104253919.4173.11.camel@laptopd505.fenrus.org>
	<200412281228.27307.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 12:28:27 -0500
Dmitry Torokhov <dtor_core@ameritech.net> wrote:

> From what I saw the only thing that presently uses pt_rergs is SysRq
> handler to print the call trace and if we slightly change the semantics
> (instead of printing the trace immediately raise a flag and when next
> interrupt arrives check it in do_IRQ and print the trace from there -
> I even had some patches) we could drop pt_regs. I would very much like
> to do so at least for input drivers.

Are you going to take a snapshot at IRQ time?  If not, then I'm
pretty much against this change.  When I do a sysrq regs dump,
I want the exact pt_regs values at interrupt time, not some
random value later in time.

Perhaps instead you could raise a flag in the input driver, and
at the top-level interrupt dispatch arch code do the register
sysrq dump.  This gives the same semantics as present, and also
allows you what you want for the input drivers.

But, even with this, there is the x86 interrupt handler Alan
mentioned which wants the pt_regs too.
