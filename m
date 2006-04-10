Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWDJWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWDJWH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDJWH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 18:07:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:62159 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751204AbWDJWH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 18:07:28 -0400
X-Authenticated: #704063
Subject: [Patch] leak in net/dccp/ipv4.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: acme@conectiva.com.br
Content-Type: text/plain
Date: Tue, 11 Apr 2006 00:07:26 +0200
Message-Id: <1144706846.31667.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

we dont free req if we cant parse the options.
This fixes coverity bug id #1046

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc1/net/dccp/ipv4.c.orig	2006-04-11 00:05:39.000000000 +0200
+++ linux-2.6.17-rc1/net/dccp/ipv4.c	2006-04-11 00:06:08.000000000 +0200
@@ -498,7 +498,7 @@ int dccp_v4_conn_request(struct sock *sk
 		goto drop;
 
 	if (dccp_parse_options(sk, skb))
-		goto drop;
+		goto drop_and_free;
 
 	dccp_openreq_init(req, &dp, skb);
 


