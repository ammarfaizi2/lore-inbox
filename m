Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbUK2QHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbUK2QHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 11:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUK2QHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 11:07:23 -0500
Received: from spc1-leed3-6-0-cust18.seac.broadband.ntl.com ([80.7.68.18]:54985
	"EHLO fentible.pjc.net") by vger.kernel.org with ESMTP
	id S261743AbUK2QFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 11:05:24 -0500
Date: Mon, 29 Nov 2004 16:05:22 +0000
From: Patrick Caulfield <patrick@tykepenguin.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org,
       DECnet list <linux-decnet-user@lists.sourceforge.net>
Subject: [PATCH 2.6] DECnet typo in accept causes oops
Message-ID: <20041129160522.GP16269@tykepenguin.com>
Mail-Followup-To: davem@redhat.com, linux-kernel@vger.kernel.org,
	DECnet list <linux-decnet-user@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typo which can cause a rare oops in accept. dn_accept returns
a pointer instead of an error if dn_wait_for_connect() is interrupted.
This confuses sys_accept which calls dn_getname with a incomplete struct socket,
this then oopses.

patrick


Signed-off-by: Patrick Caulfield <patrick@tykepenguin.com>

===== net/decnet/af_decnet.c 1.45 vs edited =====
--- 1.45/net/decnet/af_decnet.c	2004-11-06 07:43:31 +00:00
+++ edited/net/decnet/af_decnet.c	2004-11-29 15:56:40 +00:00
@@ -1075,7 +1075,7 @@ static int dn_accept(struct socket *sock
 		skb = dn_wait_for_connect(sk, &timeo);
 		if (IS_ERR(skb)) {
 			release_sock(sk);
-			return PTR_ERR(sk);
+			return PTR_ERR(skb);
 		}
 	}
 
