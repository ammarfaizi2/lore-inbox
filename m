Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVF1LKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVF1LKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVF1LKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:10:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261293AbVF1LKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:10:09 -0400
Date: Tue, 28 Jun 2005 04:03:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "d binderman" <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re:
Message-Id: <20050628040313.3c808093.akpm@osdl.org>
In-Reply-To: <BAY19-F12535FB21F6E7AB66158479CE10@phx.gbl>
References: <BAY19-F12535FB21F6E7AB66158479CE10@phx.gbl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"d binderman" <dcb314@hotmail.com> wrote:
>
> 
> Hello there,
> 
> I just tried to compile the Linux Kernel version 2.6.11.12
> with the gcc 4.0 compiler. The compiler said
> 
> drivers/net/depca.c:1829: warning: operation on 'i' may be undefined
> 
> The source code is
> 
> for (i = entry; i != end; i = (++i) & lp->txRingMask) {
> 
> I agree with the compiler. Better code is
> 
> for (i = entry; i != end; i = (i + 1) & lp->txRingMask) {
> 

Someone already fixed it.

		/* set up the buffer descriptors */
		len = (skb->len < ETH_ZLEN) ? ETH_ZLEN : skb->len;
		for (i = entry; i != end; i = (i+1) & lp->txRingMask) {

