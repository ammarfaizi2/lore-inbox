Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWAGAgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWAGAgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbWAGAgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:36:46 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:48320 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S932457AbWAGAgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:36:44 -0500
Message-ID: <43BF0D41.6060003@f2s.com>
Date: Sat, 07 Jan 2006 00:37:21 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051219)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix arm26 THREAD_SIZE
References: <20060106161608.GG12131@stusta.de>
In-Reply-To: <20060106161608.GG12131@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

Looks good to me. cant recall why that got that way, but the div by zero 
definately went away at the time. certainly its wrong as-is, the 
implication is that an 8 MB machine would get a max_threads of about 4 :)

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Ian Molton <spyro@f2s.com>

--- linux-2.6.15-mm1-full/include/asm-arm26/thread_info.h.old	2006-01-06 
16:45:40.000000000 +0100
+++ linux-2.6.15-mm1-full/include/asm-arm26/thread_info.h	2006-01-06 
16:46:07.000000000 +0100
@@ -80,8 +80,7 @@
  	return (struct thread_info *)(sp & ~0x1fff);
  }

-/* FIXME - PAGE_SIZE < 32K */
-#define THREAD_SIZE		(8*32768) // FIXME - this needs attention (see 
kernel/fork.c which gets a nice div by zero if this is lower than 8*32768
+#define THREAD_SIZE	PAGE_SIZE
  #define task_pt_regs(task) ((struct pt_regs *)(task_stack_page(task) + 
THREAD_SIZE - 8) - 1)

  extern struct thread_info *alloc_thread_info(struct task_struct *task);



