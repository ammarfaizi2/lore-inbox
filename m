Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVLNLRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVLNLRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 06:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLNLRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 06:17:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29085 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932276AbVLNLRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 06:17:23 -0500
Subject: Re: [RFC][PATCH 3/3] TCP/IP Critical socket communication mechanism
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0512140052470.31720@w-sridhar.beaverton.ibm.com>
References: <Pine.LNX.4.58.0512140052470.31720@w-sridhar.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 11:17:19 +0000
Message-Id: <1134559039.25663.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 01:12 -0800, Sridhar Samudrala wrote:
> Pass __GFP_CRITICAL flag with all allocation requests that are critical.
> - All allocations needed to process incoming packets are marked as CRITICAL.
>   This includes the allocations
>      - made by the driver to receive incoming packets
>      - to process and send ARP packets
>      - to create new routes for incoming packets

But your user space that would add the routes is not so protected so I'm
not sure this is actually a solution, more of an extended fudge. In
which case I'm not clear why it is any better than the current
GFP_ATOMIC approach.

> +#define SK_CRIT_ALLOC(sk, flags) ((sk->sk_allocation & __GFP_CRITICAL) | flags)

Lots of hidden conditional logic on critical paths. Also sk should be in
brackets so that the macro evaluation order is defined as should flags

> +#define CRIT_ALLOC(flags) (__GFP_CRITICAL | flags)

Pointless obfuscation


