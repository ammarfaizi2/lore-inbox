Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWAPTJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWAPTJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWAPTJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:09:31 -0500
Received: from [63.81.120.158] ([63.81.120.158]:28911 "EHLO hermes.mvista.com")
	by vger.kernel.org with ESMTP id S1750762AbWAPTJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:09:30 -0500
In-Reply-To: <20060114122521.39f86ed5.akpm@osdl.org>
References: <b324b5ad0601131316m721f959eu37b741f9e5557a2e@mail.gmail.com> <20060113132704.207336d7.akpm@osdl.org> <43C9233A.20504@gmail.com> <20060114122521.39f86ed5.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <961FB9D6-86C3-11DA-B27C-000A959BB91E@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: robustmutexes@lists.osdl.org, chaosite@gmail.com,
       linux-kernel@vger.kernel.org, daviado@gmail.com
From: david singleton <dsingleton@mvista.com>
Subject: Re [robust-futex-2] : interdiff for memory leak fix
Date: Mon, 16 Jan 2006 11:09:15 -0800
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Here is an interdiff for a memory leak fix in register_futex.  The 
nice thing
about the slab caches are the ability to spot leaks easily.

diff -u linux-2.6.15/kernel/futex.c linux-2.6.15/kernel/futex.c
--- linux-2.6.15/kernel/futex.c
+++ linux-2.6.15/kernel/futex.c
@@ -1129,6 +1133,8 @@
         if (vma->vm_file && vma->vm_file->f_mapping) {
                 if (vma->vm_file->f_mapping->robust_head == NULL)
                         init_robust_list(vma->vm_file->f_mapping, 
file_futex);
+               else
+                       kmem_cache_free(file_futex_cachep, file_futex);
                 head = 
&vma->vm_file->f_mapping->robust_head->robust_list;
                 sem = &vma->vm_file->f_mapping->robust_head->robust_sem;
         } else {

although Safari seems to always translates tabs to spaces.

David

