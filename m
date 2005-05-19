Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVESOnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVESOnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVESOnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:43:03 -0400
Received: from graphe.net ([209.204.138.32]:21769 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262532AbVESOl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:41:58 -0400
Date: Thu, 19 May 2005 07:41:41 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: linux-kernel@vger.kernel.org, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>, shai@scalex86.org
Subject: Re: [PATCH] Optimize sys_times for a single thread process
In-Reply-To: <428C3ABB.61B552E@tv-sign.ru>
Message-ID: <Pine.LNX.4.62.0505190737500.28714@graphe.net>
References: <428B09A6.DD188E8D@tv-sign.ru> <Pine.LNX.4.62.0505181503520.10958@graphe.net>
 <428C3ABB.61B552E@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005, Oleg Nesterov wrote:

> > The thread ist needs to contain only one element which is current.
> > thread_group_empty checks for no threads.
> 
> I think that thread_group_empty() means that there are no *other*
> threads in the thread group, that means that we have only one thread.
> 
> In any case (p == next_thread(p)) == thread_group_empty(p).
> 
> But it is a very minor issue indeed, let's forget it.

No no. If you are right then you are right and I am 
wrong.

Index: linux-2.6.12-rc4/kernel/sys.c
===================================================================
--- linux-2.6.12-rc4.orig/kernel/sys.c	2005-05-19 03:23:29.000000000 +0000
+++ linux-2.6.12-rc4/kernel/sys.c	2005-05-19 14:40:32.000000000 +0000
@@ -920,7 +920,7 @@
 		cputime_t utime, stime, cutime, cstime;
 
 #ifdef CONFIG_SMP
-		if (current == next_thread(current)) {
+		if (thread_group_empty(current)) {
 			/*
 			 * Single thread case without the use of any locks.
 			 *
