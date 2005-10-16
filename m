Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbVJPCL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbVJPCL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 22:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbVJPCL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 22:11:57 -0400
Received: from mail2.genealogia.fi ([194.100.116.229]:59299 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1750827AbVJPCL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 22:11:57 -0400
Date: Sat, 15 Oct 2005 19:11:10 -0700
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Better fixup for the orinoco driver
Message-ID: <20051016021110.GC10699@jm.kir.nu>
References: <1129401680.17923.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129401680.17923.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.8i
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 07:41:20PM +0100, Alan Cox wrote:

> The latest kernel added a pretty ugly fix for the orinoco etherleak bug
> which contains bogus skb->len checks already done by the caller and
> causes copies of all odd sized frames (which are quite common)
> 
> While the skb->len check should be ripped out the other fix is harder to
> do properly so I'm proposing for this the -mm tree only until next 2.6.x
> so that it gets tested.
> 
> Instead of copying buffers around blindly this code implements a padding
> aware version of the hermes buffer writing function which does padding
> as the buffer is loaded and thus more cleanly and without bogus 1.5K
> copies.

While working on this area, shouldn't we just finally get rid of the
bogus ETH_ZLEN padding? There is no such requirement for IEEE 802.11.
This would remove need for the extra padding code you have in
hermes_bap_pwrite_pad(). The only requirement is to be able to add one
extra byte if the packet length is odd.

-- 
Jouni Malinen                                            PGP id EFC895FA
