Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVAVABG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVAVABG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 19:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVAUXcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:32:00 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:31696
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262586AbVAUXXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:23:12 -0500
Date: Fri, 21 Jan 2005 15:20:45 -0800
From: "David S. Miller" <davem@davemloft.net>
To: David Dillow <dave@thedillows.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, dave@thedillows.org
Subject: Re: [RFC 2.6.10 5/22] xfrm: Attempt to offload bundled xfrm_states
 for outbound xfrms
Message-Id: <20050121152045.5c92ee05.davem@davemloft.net>
In-Reply-To: <20041230035000.14@ori.thedillows.org>
References: <20041230035000.13@ori.thedillows.org>
	<20041230035000.14@ori.thedillows.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2004 03:48:35 -0500
David Dillow <dave@thedillows.org> wrote:

> +static void xfrm_accel_bundle(struct dst_entry *dst)
> +{
> +	struct xfrm_bundle_list bundle, *xbl, *tmp;
> +	struct net_device *dev = dst->dev;
> +	INIT_LIST_HEAD(&bundle.node);
> +
> +	if (dev && netif_running(dev) && (dev->features & NETIF_F_IPSEC)) {

netif_running() is only steady while the RTNL semaphore is held,
which is not necessarily true when xfrm_lookup() is invoked.
