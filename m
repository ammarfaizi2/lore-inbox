Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUDLHSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 03:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUDLHSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 03:18:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261340AbUDLHSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 03:18:10 -0400
Date: Mon, 12 Apr 2004 00:15:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeremy Martin <martinjd@csc.uvic.ca>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tuntap oversight
Message-Id: <20040412001551.05476658.davem@redhat.com>
In-Reply-To: <20040412065947.GC18810@net-ronin.org>
References: <20040412065947.GC18810@net-ronin.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Apr 2004 23:59:47 -0700
Jeremy Martin <martinjd@csc.uvic.ca> wrote:

> +static int tun_mac_addr(struct net_device *dev, void *p)
> +{
> +	struct sockaddr *addr=p;
> +	if (netif_running(dev))
> +		return -EBUSY;
> +	memcpy(dev->dev_addr, addr->sa_data,dev->addr_len);
> +	return 0;
> +}

This netif_running() check is not necessary, and in fact
wrong.

In fact, if ethernet drivers erroneously do this, this causes
them to fail to support the ALB bonding driver modes which
require on-the-fly MAC address changes while the interface is
up.

