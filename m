Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbTEMG5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbTEMG5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:57:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:16516 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263246AbTEMG5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:57:47 -0400
Date: Tue, 13 May 2003 00:11:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm4
Message-Id: <20030513001135.2395860a.akpm@digeo.com>
In-Reply-To: <87vfwf8h2n.fsf@lapper.ihatent.com>
References: <20030512225504.4baca409.akpm@digeo.com>
	<87vfwf8h2n.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 07:10:27.0931 (UTC) FILETIME=[BB57C2B0:01C3191E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> net/core/dev.c:1496: conflicting types for `handle_bridge'
>  net/core/dev.c:1468: previous declaration of `handle_bridge'

argh, sorry, stupid.

diff -puN net/core/dev.c~handle_bridge-fix net/core/dev.c
--- 25/net/core/dev.c~handle_bridge-fix	2003-05-13 00:10:47.000000000 -0700
+++ 25-akpm/net/core/dev.c	2003-05-13 00:10:57.000000000 -0700
@@ -1491,7 +1491,7 @@ static inline void handle_diverter(struc
 #endif
 }
 
-static inline int handle_bridge(struct sk_buff *skb,
+static inline int __handle_bridge(struct sk_buff *skb,
 			struct packet_type **pt_prev, int *ret)
 {
 #if defined(CONFIG_BRIDGE) || defined(CONFIG_BRIDGE_MODULE)
@@ -1548,7 +1548,7 @@ int netif_receive_skb(struct sk_buff *sk
 
 	handle_diverter(skb);
 
-	if (handle_bridge(skb, &pt_prev, &ret))
+	if (__handle_bridge(skb, &pt_prev, &ret))
 		goto out;
 
 	list_for_each_entry_rcu(ptype, &ptype_base[ntohs(type)&15], list) {

_

