Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbUL3A6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbUL3A6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbUL3A6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:58:05 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:46304 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261453AbUL3A6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:58:02 -0500
Date: Thu, 30 Dec 2004 01:58:19 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Zhenyu Wu <y030729@njupt.edu.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VQs in Gred!
Message-ID: <20041230005819.GL32419@postel.suug.ch>
References: <304370586.05150@njupt.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304370586.05150@njupt.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok. Then, if the average packet(qave) does not exceed the threshhold, that is, the
> packet has not been dropped, it will be enqueued into the physical queue, right?
> So we can't see the different process of scheduling packets which are from
> different kinds of traffic, we just know which packet might be dropped, right?

Right, all packets, regardless of type, colour, flavour, whatever are enqueued
onto the same skb queue. You can always put a cbq/htb qdisc underneath
and have gred be the leaf qdisc so you can do the prioritizing before gred.
Be warned, heavy dropping in a gred leaf qdisc corrupts any rate estimations
in prio qdiscs.

> what does "the more aggressive set of parameters" mean? The parameters to Gred?

Yes, struct gred_sched_data.
