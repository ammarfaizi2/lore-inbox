Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWAIOm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWAIOm0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWAIOm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:42:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:9495 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932294AbWAIOmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:42:25 -0500
Message-ID: <43C27662.2030400@openvz.org>
Date: Mon, 09 Jan 2006 17:42:42 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Dmitry Mishin" <dim@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: [PATCH] netlink oops fix due to incorrect error code
Content-Type: multipart/mixed;
 boundary="------------080505070207050802030609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505070207050802030609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fixed oops after failed netlink socket creation.
Wrong parathenses in if() statement caused err to be 1,
instead of negative value.
Trivial fix, not trivial to find though.

Signed-Off-By: Dmitry Mishin <dim@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Kirill
P.S. against 2.6.15


--------------080505070207050802030609
Content-Type: text/plain;
 name="diff-ms-netlink-create-fix-20060109"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-netlink-create-fix-20060109"

--- ./net/netlink/af_netlink.c.nlfix	2006-01-06 18:37:28.000000000 +0300
+++ ./net/netlink/af_netlink.c	2006-01-09 16:40:49.000000000 +0300
@@ -416,7 +416,7 @@ static int netlink_create(struct socket 
 	groups = nl_table[protocol].groups;
 	netlink_unlock_table();
 
-	if ((err = __netlink_create(sock, protocol) < 0))
+	if ((err = __netlink_create(sock, protocol)) < 0)
 		goto out_module;
 
 	nlk = nlk_sk(sock->sk);


--------------080505070207050802030609--

