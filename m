Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVEKP0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVEKP0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEKP0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:26:10 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:21136 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261858AbVEKPZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:25:24 -0400
Message-ID: <428223E0.2070200@sw.ru>
Date: Wed, 11 May 2005 19:25:20 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] mm acct accounting fix
Content-Type: multipart/mixed;
 boundary="------------000609070909080301010501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000609070909080301010501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, forgot to write that all these patches are against 2.6.12-rc4...

This patch fixes mm->total_vm and mm->locked_vm acctounting in case
when move_page_tables() fails inside move_vma().

Signed-Off-By: Kirill Korotaev <dev@sw.ru>

--------------000609070909080301010501
Content-Type: text/plain;
 name="diff-mainstream-mmacct-20050325"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-mainstream-mmacct-20050325"

--- ./mm/mremap.c.mmacct	2005-05-10 16:10:40.000000000 +0400
+++ ./mm/mremap.c	2005-05-10 18:12:13.000000000 +0400
@@ -213,6 +213,7 @@ static unsigned long move_vma(struct vm_
 		old_len = new_len;
 		old_addr = new_addr;
 		new_addr = -ENOMEM;
+		new_len = 0;
 	}
 
 	/* Conceal VM_ACCOUNT so old reservation is not undone */

--------------000609070909080301010501--

