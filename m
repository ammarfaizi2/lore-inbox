Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUA1Alb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUA1Alb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:41:31 -0500
Received: from ssa8.serverconfig.com ([209.51.129.179]:44780 "EHLO
	ssa8.serverconfig.com") by vger.kernel.org with ESMTP
	id S265658AbUA1Al2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:41:28 -0500
From: "Joseph D. Wagner" <theman@josephdwagner.info>
To: linux-kernel@vger.kernel.org
Subject: Trouble with for_each_process(p) funciton
Date: Tue, 27 Jan 2004 18:39:42 -0600
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401271839.42873.theman@josephdwagner.info>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ssa8.serverconfig.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - josephdwagner.info
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing some analysis of various memory management tequiniques and 
allocation algorithims.  I'm trying to edit the sys_brk function in mmap.c.  
I added the following function to mmap.c and the appropriate function call 
in the sys_brk function immediately after set_brk:.

static inline void decrement_prealloc_pages(void)
{
	struct task_struct *p;

	for_each_process(p)
	{
		p->mm->prealloc_pages = 0;
	}
}

Everything works OK without the line:

p->mm->prealloc_pages = 0;

which doesn't make any sense to me because it's only an assignment.

A similar line directly in the sys_brk function:

mm->prealloc_pages |= 0x80;

works just fine, but I'm not trying to use that assignment on every process, 
just the current one.

I tried all sorts of hacks to get it to work including checking for NULL, 
&init_task, and a counter to prevent an infinite loop.  Nothing helps.  The 
kernel always stops just before INIT when the last line is "Freed xKB of 
kernel memory" (or something like that). If someone could help me figure 
out what I'm doing wrong I'd appreciate it greatly.

FYI: prealloc_pages is an unsigned char that I added to the struct 
mm_struct.

TIA.

Joseph D. Wagner

