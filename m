Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270593AbRHTPfU>; Mon, 20 Aug 2001 11:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRHTPfJ>; Mon, 20 Aug 2001 11:35:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:55738 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S270593AbRHTPez>;
	Mon, 20 Aug 2001 11:34:55 -0400
Date: Mon, 20 Aug 2001 10:35:04 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Prevent reuse of active thread group id
Message-ID: <87110000.998321704@baldur>
X-Mailer: Mulberry/2.1.0b3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The thread group id of a task is initially assigned the value of that 
task's pid, then is inherited for each child task created with 
CLONE_THREAD.  This patch makes sure that the thread group id is never 
re-used as another task's pid as long as there's an active task with that 
tgid.

Patch is below.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

====================

--- linux-2.4.9/./kernel/fork.c	Tue Jul 17 20:23:28 2001
+++ linux-2.4.9-tgid/./kernel/fork.c	Mon Aug 20 10:28:22 2001
@@ -101,6 +101,7 @@
 		for_each_task(p) {
 			if(p->pid == last_pid	||
 			   p->pgrp == last_pid	||
+			   p->tgid == last_pid	||
 			   p->session == last_pid) {
 				if(++last_pid >= next_safe) {
 					if(last_pid & 0xffff8000)

