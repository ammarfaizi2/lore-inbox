Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWC1NgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWC1NgF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWC1NgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:36:04 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55019 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932080AbWC1NgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:36:03 -0500
Date: Tue, 28 Mar 2006 16:35:49 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Yi Yang <yang.y.yi@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [2.6.16 PATCH] Filesystem Events Connector v4
Message-ID: <20060328123549.GA22116@2ka.mipt.ru>
References: <4427FF42.8070100@gmail.com> <20060328075126.GA11334@2ka.mipt.ru> <44293A5B.3090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44293A5B.3090604@gmail.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 28 Mar 2006 16:35:50 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 09:30:03PM +0800, Yi Yang (yang.y.yi@gmail.com) wrote:
> Evgeniy Polyakov 写道:

> >>--- a/drivers/connector/connector.c.orig	2006-03-27 
> >>21:35:15.000000000 +0800
> >>+++ b/drivers/connector/connector.c	2006-03-27 21:35:53.000000000 +0800
> >>@@ -111,9 +111,7 @@ int cn_netlink_send(struct cn_msg *msg, 
> >> 
> >> 	NETLINK_CB(skb).dst_group = group;
> >> 
> >>-	netlink_broadcast(dev->nls, skb, 0, group, gfp_mask);
> >>-
> >>-	return 0;
> >>+	return (netlink_broadcast(dev->nls, skb, 0, group, gfp_mask));
> >> 
> >> nlmsg_failure:
> >> 	kfree_skb(skb);
> >>    
> >
> >This error value is propageted back in current connector code already.
> >  
> Which version of kernel do you mean? for 2.6.16, it doesn't return 
> netlink_broadcast's return value.

It was committeed in 2.6.17 timeframe.
b191ba0d599928372be5a89f75486eb58efab48a commit id.

It also includes new netlink_has_listeners() call usage, which allows to
check in advance if there are listeners or not for given netlink group.
netlink_has_listeners() can return false positives, which will be caught
by netlink_broadcast().

-- 
	Evgeniy Polyakov
