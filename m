Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269967AbRHJSOZ>; Fri, 10 Aug 2001 14:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269966AbRHJSOP>; Fri, 10 Aug 2001 14:14:15 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:56286 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S269967AbRHJSN6>; Fri, 10 Aug 2001 14:13:58 -0400
Message-ID: <794826DE8867D411BAB8009027AE9EB91011431F@FMSMSX38>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: linux-kernel@vger.kernel.org
Subject: free_task_struct() called too early?
Date: Fri, 10 Aug 2001 11:13:53 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a process terminates, it appears that the task structure is freed too
early.  There are memory references to the kernel task area (task_struct and
stack space) after free_task_struct(p) is called.

If I modify the following line in include/asm-i386/processor.h

#define free_task_struct(p)   free_pages((unsigned long) (p), 1) to
#define free_task_struct(p)   memset((void*) (p), 0xf, PAGE_SIZE*2);
free_pages((unsigned long) (p), 1)
then kernel will boot to init and lockup on when first task terminates.

Has anyone looked into or aware of this issue?

