Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbUCKEJu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 23:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262987AbUCKEJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 23:09:49 -0500
Received: from ns.suse.de ([195.135.220.2]:23018 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262982AbUCKEJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 23:09:47 -0500
Date: Thu, 11 Mar 2004 05:09:43 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix a 64bit bug in kobject module request
Message-ID: <20040311040943.GB8581@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From Takashi Iwai

kobj_lookup had a 64bit bug, which caused the request of a unknown
character device to burn CPU instead of failing quickly.

diff -burpN -X ../KDIFX linux-vanilla/drivers/base/map.c linux-2.6.4-amd64/drivers/base/map.c
--- linux-vanilla/drivers/base/map.c	2003-09-23 08:03:40.000000000 +0200
+++ linux-2.6.4-amd64/drivers/base/map.c	2004-03-08 15:23:45.000000000 +0100
@@ -96,7 +96,7 @@ struct kobject *kobj_lookup(struct kobj_
 {
 	struct kobject *kobj;
 	struct probe *p;
-	unsigned best = ~0U;
+	unsigned long best = ~0UL;
 
 retry:
 	down_read(domain->sem);
