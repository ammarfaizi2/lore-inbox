Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262860AbUKXVwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbUKXVwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUKXVwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:52:13 -0500
Received: from waste.org ([209.173.204.2]:6632 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262860AbUKXVvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:51:50 -0500
Date: Wed, 24 Nov 2004 13:35:21 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: george anzinger <george@mvista.com>
Subject: nanosleep interrupted by ignored signals
Message-ID: <20041124213521.GJ2460@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Take the following trivial program:

#include <unistd.h>

int main(void)
{
	sleep(10);
	return 0;
}

Run it in an xterm. Note that resizing the xterm has no effect on the
process. Now do the same with strace:

brk(0x80495bc)                          = 0x80495bc
brk(0x804a000)                          = 0x804a000
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
nanosleep({10, 0}, 0xbffff548)          = -1 EINTR (Interrupted system
call)
--- SIGWINCH (Window changed) ---
_exit(0)                                = ?

In short, nanosleep is getting interrupted by signals that are
supposedly ignored when a process is being praced. This appears to be
a long-standing bug.

It also appears to be a long-known bug. I found some old discussion of this
problem here but no sign of any resolution:

http://www.ussg.iu.edu/hypermail/linux/kernel/0108.1/1448.html

What's the current thinking on this?

-- 
Mathematics is the supreme nostalgia of our time.
