Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVE0BF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVE0BF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVE0BFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:05:22 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:19854 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261364AbVE0BFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:07 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Roland McGrath <roland@redhat.com>
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
Date: Thu, 26 May 2005 21:05:08 -0400
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       mtk-lkml@gmx.net, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
References: <200505270011.j4R0BuwN011311@magilla.sf.frob.com> <200505262037.57204.kernel-stuff@comcast.net>
In-Reply-To: <200505262037.57204.kernel-stuff@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505262105.09258.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2005 20:37, Parag Warudkar wrote:

With WCONTINUED - there is no waitid in the strace output -

> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x2aaaaade7b70) = 7683
> child (PID = 7683) started
> rt_sigaction(SIGUSR1, {0x400aa0, [], SA_RESTORER|SA_RESTART,
> 0x2aaaaabefca0}, NULL, 8) = 0
> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> child_tidptr=0x2aaaaade7b70) = 7684
> write(1, "Error Code from waitid - -1\n", 28Error Code from waitid - -1
> ) = 28

Without WCONTINUED -

>clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x2aaaaade7b70) = 7898
>child (PID = 7898) started
>rt_sigaction(SIGUSR1, {0x400aa0, [], SA_RESTORER|SA_RESTART, 0x2aaaaabefca0}, 
>NULL, 8) = 0
>clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, 
child_tidptr=0x2aaaaade7b70) = 7899
>wait4(7898, Sending signal to parent
>0x7fffffffeecc, WSTOPPED, NULL) = ? ERESTARTSYS (To be restarted)
>--- SIGUSR1 (User defined signal 1) @ 0 (0) ---
>--- SIGCHLD (Child exited) @ 0 (0) ---
>write(1, "Caught signal", 13Caught signal)           = 13
>write(1, "\n", 1
>)                       = 1
>rt_sigreturn(0x1)                       = 61

It's of course beyond me why this difference - strace output should have had 
mention of wait4(...) = ENOTSUP (or whatever) when WCONTINUED is used. 
WCONTINUED is declared in include files and mentioned as supported in the man 
pages.

Parag
