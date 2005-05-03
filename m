Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVECXvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVECXvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVECXvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:51:03 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:5309
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261927AbVECXu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:50:57 -0400
Date: Tue, 3 May 2005 16:39:16 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, jk@blackdown.de, akpm@osdl.org, oleg@tv-sign.ru,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
Message-Id: <20050503163916.30d64630.davem@davemloft.net>
In-Reply-To: <1115163893.7568.49.camel@gaston>
References: <42748B75.D6CBF829@tv-sign.ru>
	<20050501023149.6908c573.akpm@osdl.org>
	<87vf61kztb.fsf@blackdown.de>
	<1115079230.6155.35.camel@gaston>
	<873bt5xf9v.fsf@blackdown.de>
	<17014.59016.336852.31119@cargo.ozlabs.ibm.com>
	<20050503115103.7461ae5e.davem@davemloft.net>
	<1115163893.7568.49.camel@gaston>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 May 2005 09:44:53 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Nothing prevents it ? well, I wouldn't be that optimistic :) The USB
> stuff is a bit complex, it inlcudes doing DMAs, so manipulating the
> iommu, dealing with URB queues (and thus allocating/releasing them)
> etc... and especially in the context of xmon, that mean letting the
> driver do a lot of these at any time whatever state the system is...

I think doing calls to the USB interrupt handler would work.
I'm not being crazy :)

But yeah we could do a micro-stack as well, but as you noted the
transfer to/from the real USB HCI driver would be non-trivial.

I truly believe just calling the real USB HCI driver interrupt
handler in a polling fashion is the way to go.
