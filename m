Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVA1A7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVA1A7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 19:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVA1A5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 19:57:12 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:63170
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261360AbVA1AxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 19:53:13 -0500
Date: Thu, 27 Jan 2005 16:48:43 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       greg@kroah.com, akpm@osdl.org
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100,
 xircom_tulip_cb, iph5526
Message-Id: <20050127164843.08bdb307.davem@davemloft.net>
In-Reply-To: <20050128001430.C22695@flint.arm.linux.org.uk>
References: <41F952F4.7040804@pobox.com>
	<20050127225725.F3036@flint.arm.linux.org.uk>
	<20050127153114.72be03e2.davem@davemloft.net>
	<20050128001430.C22695@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 00:14:30 +0000
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> The fact of the matter is that eepro100.c works on ARM, e100.c doesn't.
> There's a message from me back on 30th June 2004 at about 10:30 BST on
> this very list which generated almost no interest from anyone...

I see.  Since eepro100 just uses a fixed set of RX buffers in the
ring (ie. the DMA links are never changed) it works.

This adapter was definitely developed for a system that has to have
PCI device DMA and CPU cached data accesses in the same coherency
space in order to use their weird RX chaining thing.

So essentially, e100 needs to have it's RX logic rewritten so that
it uses a static RX descriptor set of buffers and skb_copy()'s them
to push the packets into the stack.
