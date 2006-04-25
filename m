Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWDYSV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWDYSV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWDYSV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:21:57 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:58238 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932105AbWDYSV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:21:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:from;
        b=gSx4z4IP6S2v1+9zUyezYdKehNPd4bLKqgIq69wczGWqBFEBLy3bdhTJcwydOXB7icpowx5MBvzGVXP5CpYPncMSShkAETp7IZpZTYGipIVsR61k7WDeClaIX4bn2hwowO0M3hsdQw17qPM4BVcNfWfZZ/sOOxSQazmSsFiu18g=
Date: Tue, 25 Apr 2006 11:20:38 -0700 (PDT)
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, linux-mm@vger.kernel.org
Subject: [PATCH] likely cleanup: remove unlikely in sys_mprotect()
Message-ID: <Pine.LNX.4.64.0604251118110.5810@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Hua Zhong <hzhong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With likely/unlikely profiling (see the recent patch dwalker@mvista.com sent), on my not-so-busy-typical-developmentsystem there are 5k misses vs 2k hits. So I guess we should remove the unlikely.

Signed-off-by: Hua Zhong <hzhong@gmail.com>

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 4c14d42..5faf01a 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -205,8 +205,7 @@ sys_mprotect(unsigned long start, size_t
  	/*
  	 * Does the application expect PROT_READ to imply PROT_EXEC:
  	 */
-	if (unlikely((prot & PROT_READ) &&
-			(current->personality & READ_IMPLIES_EXEC)))
+	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
  		prot |= PROT_EXEC;

  	vm_flags = calc_vm_prot_bits(prot);
