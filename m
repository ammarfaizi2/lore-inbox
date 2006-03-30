Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWC3ITT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWC3ITT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWC3IRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:17:46 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:20051 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932095AbWC3IRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:17:41 -0500
Message-Id: <20060330081729.063394000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
Date: Thu, 30 Mar 2006 16:16:06 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 1/8] introduce hlist_move_head()
Content-Disposition: inline; filename=hlist-move-head.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the function hlist_move_head().
This function deletes from one hash list and add as another's head

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/linux/list.h |    5 +++++
 1 files changed, 5 insertions(+)

Index: 2.6-git/include/linux/list.h
===================================================================
--- 2.6-git.orig/include/linux/list.h
+++ 2.6-git/include/linux/list.h
@@ -656,6 +656,11 @@ static inline void hlist_add_head(struct
 	n->pprev = &h->first;
 }
 
+static inline void hlist_move_head(struct hlist_node *n, struct hlist_head *h)
+{
+	__hlist_del(n);
+	hlist_add_head(n, h);
+}
 
 /**
  * hlist_add_head_rcu - adds the specified element to the specified hlist,

--
