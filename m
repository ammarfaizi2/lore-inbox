Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVCaRm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVCaRm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 12:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVCaRm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 12:42:28 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29660 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261586AbVCaRmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 12:42:23 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050331141040.GA2544@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk>
	 <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 31 Mar 2005 12:41:56 -0500
Message-Id: <1112290916.12543.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 16:10 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > One more thing. Was this on SMP or UP.  I haven't tested this on SMP 
> > yet. When my laptop (HT) gets done with its work, I'll give it a try 
> > there. Of course I need to disable NVidia on it first.
> 
> i've booted the latest tree on a 4-way testbox and everything seems ok.

Thanks Ingo.

Oh, and did your really want to assign debug = .1?

-- Steve

Here you go:


--- ./include/linux/rt_lock.h.orig	2005-03-31 12:38:31.583913080 -0500
+++ ./include/linux/rt_lock.h	2005-03-31 12:38:35.499061576 -0500
@@ -125,7 +125,7 @@
 # ifdef CONFIG_RT_DEADLOCK_DETECT
 #  define __RW_LOCK_UNLOCKED \
 	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED, .save_state = 1, \
-	.debug = .1, .file = __FILE__, .line = __LINE__
+	.debug = 1, .file = __FILE__, .line = __LINE__
 #  define _RW_LOCK_UNLOCKED(lock) \
 	(rwlock_t) { { { __RW_LOCK_UNLOCKED, .name = #lock } } }
 #  define RW_LOCK_UNLOCKED \


