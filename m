Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUIIQIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUIIQIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 12:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266199AbUIIQIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 12:08:16 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:10117
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S266155AbUIIQIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 12:08:00 -0400
Date: Thu, 9 Sep 2004 09:07:43 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Miquel van Smoorenburg" <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-bk15: kernel BUG at net/ipv4/tcp_output.c:271!
Message-Id: <20040909090743.7c39c3ee.davem@davemloft.net>
In-Reply-To: <chpgok$pdq$1@news.cistron.nl>
References: <chpgok$pdq$1@news.cistron.nl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Sep 2004 12:02:28 +0000 (UTC)
"Miquel van Smoorenburg" <miquels@cistron.nl> wrote:

> I tried 2.6.9-rc1-bk15 on one of my servers, and it soon crashes
> with "kernel BUG at net/ipv4/tcp_output.c:271!". 2.6.9-rc1
> is fine. Line 271 is
> 
> 	BUG_ON(!TCP_SKB_CB(skb)->tso_factor);
> 
> .. it appears that the tso_factor stuff was added somewhere
> after 2.6.9-rc1.

Thanks for the report (although please use netdev@oss.sgi.com
next time).  The patch below should fix it.

===== net/ipv4/tcp_output.c 1.52 vs edited =====
--- 1.52/net/ipv4/tcp_output.c	2004-09-09 08:37:00 -07:00
+++ edited/net/ipv4/tcp_output.c	2004-09-09 08:47:27 -07:00
@@ -434,7 +434,7 @@
 		unsigned int factor;
 
 		factor = skb->len + (mss_std - 1);
-		factor /= mss;
+		factor /= mss_std;
 		TCP_SKB_CB(skb)->tso_factor = factor;
 	}
 }

