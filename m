Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVE3Cxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVE3Cxs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 22:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVE3Cxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 22:53:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:63360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbVE3Cxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 22:53:46 -0400
Date: Sun, 29 May 2005 19:52:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: phdm@macqel.be, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: PATCH : ppp + big-endian = kernel crash
Message-Id: <20050529195245.33f36253.akpm@osdl.org>
In-Reply-To: <20050529.145509.82051753.davem@davemloft.net>
References: <20050529.135257.98862077.davem@davemloft.net>
	<200505292138.j4TLcrJ28536@mail.macqel.be>
	<20050529.145509.82051753.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> From: "Philippe De Muyter" <phdm@macqel.be>
> Date: Sun, 29 May 2005 23:38:53 +0200 (CEST)
> 
> > Do you mean that ip_rcv may not assume that packets are properly aligned ?
> > 
> > And some non-mmu m68k (Coldfires) do not provide enough information in
> > exception frames to restart instructions on an address error in the general
> > case.
> 
> So many variants of tunneling and protocol encapsulation can result in
> unaligned packet headers, and as a result platforms really must
> provide proper unaligned memory access handling in kernel mode in
> order to use the networking fully.

As Philippe mentioned, old 68k's simply cannot do this.

> All these patches to PPP and friends are merely papering over the
> larger problem.

It's not a thing we want to do in the general case, sure.  But it's
reasonable to identify those bits of net code which the nommu people care
about and look to see if there's some sane workaround to get them going.

Otherwise, things like PPP will simply unavailable to some architectures...
