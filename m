Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUKYDcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUKYDcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 22:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbUKYDcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 22:32:52 -0500
Received: from waste.org ([209.173.204.2]:64428 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262954AbUKYDct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 22:32:49 -0500
Date: Wed, 24 Nov 2004 19:06:27 -0800
From: Matt Mackall <mpm@selenic.com>
To: George Anzinger <george@mvista.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep interrupted by ignored signals
Message-ID: <20041125030627.GK2460@waste.org>
References: <20041124213521.GJ2460@waste.org> <41A54731.2040607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A54731.2040607@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 06:45:05PM -0800, George Anzinger wrote:
> Matt Mackall wrote:
> >Take the following trivial program:
> >
> >#include <unistd.h>
> >
> >int main(void)
> >{
> >	sleep(10);
> >	return 0;
> >}
> >
> >Run it in an xterm. Note that resizing the xterm has no effect on the
> >process. Now do the same with strace:
> >
> >brk(0x80495bc)                          = 0x80495bc
> >brk(0x804a000)                          = 0x804a000
> >rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> >rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> >rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> >nanosleep({10, 0}, 0xbffff548)          = -1 EINTR (Interrupted system
> >call)
> >--- SIGWINCH (Window changed) ---
> >_exit(0)                                = ?
> >
> >In short, nanosleep is getting interrupted by signals that are
> >supposedly ignored when a process is being praced. This appears to be
> >a long-standing bug.
> >
> >It also appears to be a long-known bug. I found some old discussion of this
> >problem here but no sign of any resolution:
> >
> >http://www.ussg.iu.edu/hypermail/linux/kernel/0108.1/1448.html
> >
> >What's the current thinking on this?
> 
> This should have been resolved with the 2.6 changes, in particular, the 
> restart code.  What kernel are you using?

Indeed it is. Forgot I still had 2.4 on the box in question, didn't
notice the restart bit when comparing the 2.6 code against the thread
above. Mea culpa.

-- 
Mathematics is the supreme nostalgia of our time.
