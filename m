Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbVCVXKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVCVXKj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCVXKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:10:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:51909 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262347AbVCVXKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:10:31 -0500
Date: Tue, 22 Mar 2005 15:10:08 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, mort@sgi.com, linux-mm@kvack.org, emery@sgi.com, bron@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets policy kill no swap
Message-Id: <20050322151008.4a259486.pj@engr.sgi.com>
In-Reply-To: <20050319225855.475e4167.akpm@osdl.org>
References: <20050320014847.16310.53697.sendpatchset@sam.engr.sgi.com>
	<20050319225855.475e4167.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew - you're right.  Drop this patch in /dev/null.

 * I will look around for some way that user code can
   detect that a task has provoked swapping, or propose
   a small patch, perhaps to /proc, for that, if need be.

 * I agree that the action, killing a task or whatever, can
   and should be instigated by user level code.  The kernel
   provides the essential mechanisms; user code decides the
   policy, and elaborates the mechanisms.

 * I'm concerned that polling some /proc state will either be too
   wasteful of cycles (if we poll fast) or have too much delay to
   trigger (if we poll slow).  Though I need some real numbers,
   to see if this is a real problem.  It was definitely a problem
   in a past life, but that may not apply here.  The Linux 2.6
   swapper is much more NUMA friendly.

   Note, however, that something like rlimit, used to impose
   other limits on task resource consumption, depends on specific
   kernel hooks to catch the violation (using too much memory,
   say) rather than insisting that user space code scan /proc
   information looking for violators.  The former is just way
   too efficient compared to the latter.

 * I'm still casting about for appropriate mechanisms (if polling
   some /proc data is not adequate) to:
    1) enable user space code to control some kernel trigger
       that fires when a task causes more swapping than the
       setting allows (something like rlimit?), and
    2) an economical mechanism for the kernel to deliver such
       events back to user space (call_usermodehelper or
       satisfying a read on a special file?).

If you, or any lurker, has further thoughts, they would be
welcome.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
