Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTDLJp5 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbTDLJp4 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:45:56 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:50448 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263220AbTDLJpz (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 05:45:55 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops: ptrace fix buggy
Date: Sat, 12 Apr 2003 11:54:32 +0200
User-Agent: KMail/1.5.1
References: <200304071222.OAA06275@boskoop.iwr.uni-heidelberg.de> <20030412021344.A8047@asooo.flowerfire.com>
In-Reply-To: <20030412021344.A8047@asooo.flowerfire.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YJ+l+B5NrJ5m/YQ"
Message-Id: <200304121154.32997.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_YJ+l+B5NrJ5m/YQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 12 April 2003 09:13, Ken Brownfield wrote:

Hi Ken,

> I'm reproducing this as well when using gdb.  Two oopses attached.
> This is with the ptrace patch applied to 2.4.20 (SMP/i386/P3).
Does the attached patch fixes the issue?

ciao, Marc
--Boundary-00=_YJ+l+B5NrJ5m/YQ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ptrace-oops-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ptrace-oops-fix.patch"

diff -Naurp linux-2.4.20/include/linux/sched.h linux-2.4.20-ptrace/include/linux/sched.h
--- linux-2.4.20/include/linux/sched.h	2003-03-20 14:35:49.000000000 +0100
+++ linux-2.4.20-ptrace/include/linux/sched.h	2003-04-07 18:20:45.000000000 +0200
@@ -478,7 +479,7 @@ struct task_struct {
 #define PT_TRACESYSGOOD	0x00000008
 #define PT_PTRACE_CAP	0x00000010	/* ptracer can follow suid-exec */
 
-#define is_dumpable(tsk)	((tsk)->task_dumpable && (tsk)->mm->dumpable)
+#define is_dumpable(tsk)	((tsk)->task_dumpable && (tsk)->mm && (tsk)->mm->dumpable)
 
 /*
  * Limit the stack by to some sane default: root can always

--Boundary-00=_YJ+l+B5NrJ5m/YQ--

