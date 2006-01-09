Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWAIVIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWAIVIs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWAIVIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:08:48 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10208 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750764AbWAIVIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:08:47 -0500
Subject: Re: robust futex deadlock detection patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org, dino@in.ibm.com,
       David Singleton <dsingleton@mvista.com>
In-Reply-To: <Pine.LNX.4.44L0.0601092109520.18240-100000@lifa01.phys.au.dk>
References: <Pine.LNX.4.44L0.0601092109520.18240-100000@lifa01.phys.au.dk>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 16:08:06 -0500
Message-Id: <1136840886.6197.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 21:16 +0100, Esben Nielsen wrote:

> You only take the spinlocks corresponding to the current lock. What about
> the next locks in the chain? Remember those locks might not be
> futexes but a lock inside the kernel, taken in system calls. I.e. the
> robust_sem might not protect you.
> If there are n locks you need to lock n lock->wait_lock and n
> owner->task->pi_lock as you traverse the locks. That is what I tried to
> sketch in the examble below.

The thing about this is that you can't (if the kernel is not buggy)
deadlock on the kernel spin locks.  As long as you protect the locks in
the futex from deadlocking you are fine.  This is because you don't grab
a futex after grabbing a kernel spin lock.  All kernel spin locks
__must__ be released before going back to user land, and that's where
you grab the futexes.

-- Steve


