Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVCNVyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVCNVyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 16:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVCNVyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 16:54:12 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:44209
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261932AbVCNVvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 16:51:46 -0500
Date: Mon, 14 Mar 2005 13:50:21 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sparsemem intro patches
Message-Id: <20050314135021.639d1533.davem@davemloft.net>
In-Reply-To: <1110834883.19340.47.camel@localhost>
References: <1110834883.19340.47.camel@localhost>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2005 13:14:43 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> Three of these are i386-only, but one of them reorganizes the macros
> used to manage the space in page->flags, and will affect all platforms.
> There are analogous patches to the i386 ones for ppc64, ia64, and
> x86_64, but those will be submitted by the normal arch maintainers.

Sparc64 uses some of the upper page->flags bits to store D-cache
flushing state.

Specifically, PG_arch_1 is used to set whether the page is scheduled
for delayed D-cache flushing, and bits 24 and up say which CPU the
CPU stores occurred on (and thus which CPU will get the cross-CPU
message to flush it's D-cache should the deferred flush actually
occur).

I imagine that since we don't support the domain stuff (yet) on sparc64,
your patches won't break things, but it is something to be aware of.
