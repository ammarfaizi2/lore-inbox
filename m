Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262839AbUKYFrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbUKYFrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 00:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbUKYFrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 00:47:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17641 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262839AbUKYFrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 00:47:52 -0500
Message-ID: <41A54731.2040607@mvista.com>
Date: Wed, 24 Nov 2004 18:45:05 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nanosleep interrupted by ignored signals
References: <20041124213521.GJ2460@waste.org>
In-Reply-To: <20041124213521.GJ2460@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> Take the following trivial program:
> 
> #include <unistd.h>
> 
> int main(void)
> {
> 	sleep(10);
> 	return 0;
> }
> 
> Run it in an xterm. Note that resizing the xterm has no effect on the
> process. Now do the same with strace:
> 
> brk(0x80495bc)                          = 0x80495bc
> brk(0x804a000)                          = 0x804a000
> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
> rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
> nanosleep({10, 0}, 0xbffff548)          = -1 EINTR (Interrupted system
> call)
> --- SIGWINCH (Window changed) ---
> _exit(0)                                = ?
> 
> In short, nanosleep is getting interrupted by signals that are
> supposedly ignored when a process is being praced. This appears to be
> a long-standing bug.
> 
> It also appears to be a long-known bug. I found some old discussion of this
> problem here but no sign of any resolution:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0108.1/1448.html
> 
> What's the current thinking on this?

This should have been resolved with the 2.6 changes, in particular, the restart 
code.  What kernel are you using?
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

