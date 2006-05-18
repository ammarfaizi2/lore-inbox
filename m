Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWEQVn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWEQVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 17:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWEQVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 17:43:59 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:3003 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751158AbWEQVn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 17:43:58 -0400
Date: Thu, 18 May 2006 05:44:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: akpm@osdl.org
Cc: porpoise.chiang@gmail.com, mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] cascade: use list_replace_init()
Message-ID: <20060518014400.GA896@oleg>
References: <200605152130.k4FLUQTe018341@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152130.k4FLUQTe018341@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On top of Porpoise's
	when-config_base_samll=1-the-kernel-261611-cascade-in-kernel-timerc-may-enter-the-infinite-loop.patch

Microoptimization, cascade() can use list_replace_init()
instead of list_splice_init().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/timer.c~	2006-05-15 00:03:53.000000000 +0400
+++ MM/kernel/timer.c	2006-05-18 05:12:35.000000000 +0400
@@ -385,9 +385,9 @@ static int cascade(tvec_base_t *base, tv
 {
 	/* cascade all the timers from tv up one level */
 	struct timer_list *timer, *tmp;
-	LIST_HEAD(tv_list);
+	struct list_head tv_list;
 
-	list_splice_init(tv->vec + index, &tv_list);
+	list_replace_init(tv->vec + index, &tv_list);
 
 	/*
 	 * We are removing _all_ timers from the list, so we

