Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUFWSzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUFWSzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 14:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266644AbUFWSyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 14:54:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47806 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266650AbUFWSvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 14:51:17 -0400
Date: Wed, 23 Jun 2004 11:50:27 -0700
From: "David S. Miller" <davem@redhat.com>
To: rahul b jain cs student <rbj2@oak.njit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about ip_rcv() function
Message-Id: <20040623115027.11ef0902.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.58.0406231441500.7099@chrome.njit.edu>
References: <20040622212403.21346.qmail@lwn.net>
	<Pine.GSO.4.58.0406231441500.7099@chrome.njit.edu>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004 14:45:47 -0400 (EDT)
rahul b jain cs student <rbj2@oak.njit.edu> wrote:

> can anyone explain what is the difference between the following two pieces
> of code.
> 
> 1. if (!pskb_may_pull(skb, sizeof(struct iphdr)))
>                 goto inhdr_error;
> 
>    iph = skb->nh.iph;
> 
> 2. if (!pskb_may_pull(skb, iph->ihl*4))
>                 goto inhdr_error;
> 
>    iph = skb->nh.iph;

We can't dereference any of the iphdr fields (such as iph->ihl) until
we know that at least "sizeof(struct iphdr)" bytes are there first.
