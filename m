Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVBJUcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVBJUcH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbVBJUcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:32:07 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:44518
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261812AbVBJUbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:31:55 -0500
Date: Thu, 10 Feb 2005 12:30:45 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Andrew Morton <akpm@osdl.org>
Cc: clemens@endorphin.org, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       michal@logix.cz, adam@yggdrasil.com
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
 crypto_tfm
Message-Id: <20050210123045.1e6b2ca3.davem@davemloft.net>
In-Reply-To: <20050210023344.390fb358.akpm@osdl.org>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
	<1107997358.7645.24.camel@ghanima>
	<20050209171943.05e9816e.akpm@osdl.org>
	<1108028923.14335.44.camel@ghanima>
	<20050210023344.390fb358.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 02:33:44 -0800
Andrew Morton <akpm@osdl.org> wrote:

> > Is there an easy way to bring pages to lowmem? The cryptoapi is called
> > from the backlog of the networking stack, which is assigned in irq
> > context first and processed softirq context.
> 
> Are networking frames ever allocated from highmem?  Don't think so.

It is absolutely possible, especially over loopback.

It can happen on the send side for any device which indicates
the NETIF_F_HIGHDMA capability, and because loopback indicates
this feature this means we'll see such highmem pages in packets
on receive too.

There is thus also nothing preventing a real hardware device
from feeding highmem packets into the networking stack.
