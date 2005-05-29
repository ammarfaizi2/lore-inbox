Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVE2Uxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVE2Uxp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 16:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVE2Uxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 16:53:45 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22175
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261437AbVE2Uxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 16:53:41 -0400
Date: Sun, 29 May 2005 13:52:57 -0700 (PDT)
Message-Id: <20050529.135257.98862077.davem@davemloft.net>
To: phdm@macqel.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH : ppp + big-endian = kernel crash
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200505291948.j4TJmgZ25169@mail.macqel.be>
References: <200505291948.j4TJmgZ25169@mail.macqel.be>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Philippe De Muyter" <phdm@macqel.be>
Date: Sun, 29 May 2005 21:48:42 +0200 (CEST)

> +		/* If the address of the packet is odd now, fix it. */
> +		if ((unsigned long)skb->data & 1) {
> +			unsigned char *p;

And now it will crash when a packet is only 2-byte aligned
when the input packet processing does the first access
to the IP address in the packet header.

Please make your m68k port handle unaligned memory accesses
in kernel mode properly instead.
