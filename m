Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVBIUCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVBIUCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 15:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVBIUCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 15:02:37 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:29913
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261905AbVBIUCd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 15:02:33 -0500
Date: Wed, 9 Feb 2005 12:01:57 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Einar =?ISO-8859-1?Q?L=FCck?= <lkml@einar-lueck.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 2/2] ipv4 routing: multipath with cache support,
 2.6.10-rc3
Message-Id: <20050209120157.18dc75c1.davem@davemloft.net>
In-Reply-To: <420A1011.1030602@einar-lueck.de>
References: <41C6B54F.2020604@einar-lueck.de>
	<20050202172333.4d0ad5f0.davem@davemloft.net>
	<420A1011.1030602@einar-lueck.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Feb 2005 14:28:49 +0100
Einar Lück <lkml@einar-lueck.de> wrote:

> The scenarios we have in mind are setups in which a set of collaborating 
> servers steadly establish connections among each other with a very high rate. 
> This high rate requirement drove us to consider the inclusion of all 
> alternative routes into the routing cache because the corresponding delay 
> for each connection establishment is low and the load is balanced over all
> available routes. That's why we did not consider a slow lookup in the fib 
> for each connection established.

So essentially you want per-flow multipathing.  Except that you're implementation
is over-optimizing it to the point where it's only per-flow for your specific
case where the connections are short lived and high rate.

This hurts long lasting connections.

So I'm pretty much against this change.  Do it right by making it occur
per-connection attempt, it's not my problem to figure out how to do that
efficiently, it's your's :-)
