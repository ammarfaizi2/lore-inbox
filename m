Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVCWIoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVCWIoy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVCWIok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:44:40 -0500
Received: from koto.vergenet.net ([210.128.90.7]:51147 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S262880AbVCWIod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:44:33 -0500
Date: Wed, 23 Mar 2005 16:52:43 +0900
From: Horms <horms@verge.net.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch] Fix ATM copy-to-user usage in 2.4
Message-ID: <20050323075242.GB3092@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applologies if this is already pending, but the signdness fix for
atm_get_addr() in  2.6 seems to be needed for 2.4 as well.

This relates to the bugs reported in this document
http://www.guninski.com/where_do_you_want_billg_to_go_today_3.html

-- 
Horms

Backport of  ATM copy-to-user signedness fix from 2.6

Signed-off-by: Simon Horman <horms@verge.net.au>

===== net/atm/addr.h 1.2 vs edited =====
--- 1.2/net/atm/addr.h	2002-02-05 16:39:14 +09:00
+++ edited/net/atm/addr.h	2005-03-23 13:40:46 +09:00
@@ -13,6 +13,6 @@
 void atm_reset_addr(struct atm_dev *dev);
 int atm_add_addr(struct atm_dev *dev,struct sockaddr_atmsvc *addr);
 int atm_del_addr(struct atm_dev *dev,struct sockaddr_atmsvc *addr);
-int atm_get_addr(struct atm_dev *dev,struct sockaddr_atmsvc *u_buf,int size);
+int atm_get_addr(struct atm_dev *dev,struct sockaddr_atmsvc *u_buf,size_t size);
 
 #endif
===== net/atm/addr.c 1.4 vs edited =====
--- 1.4/net/atm/addr.c	2003-09-04 12:31:04 +09:00
+++ edited/net/atm/addr.c	2005-03-23 13:41:03 +09:00
@@ -114,7 +114,7 @@
 }
 
 
-int atm_get_addr(struct atm_dev *dev,struct sockaddr_atmsvc *u_buf,int size)
+int atm_get_addr(struct atm_dev *dev,struct sockaddr_atmsvc *u_buf,size_t size)
 {
 	unsigned long flags;
 	struct atm_dev_addr *walk;
