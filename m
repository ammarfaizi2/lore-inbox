Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317986AbSGLGRx>; Fri, 12 Jul 2002 02:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSGLGRw>; Fri, 12 Jul 2002 02:17:52 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:61658 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317986AbSGLGRu>;
	Fri, 12 Jul 2002 02:17:50 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: per-cpu data...
Date: Fri, 12 Jul 2002 16:01:52 +1000
Message-Id: <20020712062058.25F21415D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IIUC, __per_cpu_data is insufficient for Alpha as stands, to use
thread-specific gcc tricks (__thread prepended to the decl, even
though they had a perfectly good __attribute__ extension already).

So, I guess we're stuck with something like:

DECLARE_PER_CPU(int x);

If we're going to do this, we can also mangle the name as well to
avoid accidental "direct" accesses:

eg:
	#define DECLARE_PER_CPU(var) 
		var##__percpu __attribute__((section(".percpu")))

	/* If not SMP: */
	#define per_cpu(var) var##__percpu

(From my reading, ## on "int x" and "__per_cpu" is well-defined).

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
