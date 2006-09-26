Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWIZKvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWIZKvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIZKvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:51:08 -0400
Received: from mail.gmx.de ([213.165.64.20]:17877 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750714AbWIZKvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:51:07 -0400
X-Authenticated: #704063
Subject: [Patch] Possible dereference in net/core/rtnetlink.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:50:51 +0200
Message-Id: <1159267851.5558.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another possible dereference spotted by coverity (#cid 1390).
if the nlmsg_parse() call fails, we goto errout, where we call
dev_put(), with dev still initialized to NULL.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/net/core/rtnetlink.c.orig	2006-09-26 12:48:03.000000000 +0200
+++ linux-2.6.18-git5/net/core/rtnetlink.c	2006-09-26 12:48:28.000000000 +0200
@@ -562,7 +562,7 @@ static int rtnl_getlink(struct sk_buff *
 
 	err = nlmsg_parse(nlh, sizeof(*ifm), tb, IFLA_MAX, ifla_policy);
 	if (err < 0)
-		goto errout;
+		return err;
 
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index >= 0) {


