Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWEMXgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWEMXgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 19:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWEMXgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 19:36:21 -0400
Received: from www.tglx.de ([213.239.205.147]:13485 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S964803AbWEMXgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 19:36:20 -0400
Subject: Re: [PATCH -mm] update comment in rtmutex.c and friends
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@osdl.org, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0605131846250.2208@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605131846250.2208@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Sun, 14 May 2006 01:39:36 +0200
Message-Id: <1147563576.2667.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 19:34 -0400, Steven Rostedt wrote:
> The documented state in both the code and the rt-mutex.txt has a slight
> incorrect statement.  They state that if the owner of the mutex is NULL,
> and the "mutex has waiters" bit is set that it is an invalid state.
> 
> This is not true. To synchronize with an owner releasing the mutex, the
> owner field must have the "mutex has waiters" bit set before trying to
> grab the lock.  This prevents the owner from releasing the lock without going
> into the slow unlock path.  But if the mutex doesn't have an owner, then
> before the current process grabs the lock, it sets the "mutex has waiters"
> bit.  But in this case it will grab the lock and clear the bit. So the
> "mutex has waiters" bit and owner == NULL is a transitional state.
> 
> This patch comments this case.
> 
> -- Steve
> 
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


