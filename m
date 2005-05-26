Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbVEZVTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbVEZVTZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 17:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEZVTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 17:19:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35814 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261796AbVEZVRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 17:17:11 -0400
Date: Thu, 26 May 2005 14:17:05 -0700
Message-Id: <200505262117.j4QLH5BD010823@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
In-Reply-To: Michael Kerrisk's message of  Wednesday, 18 May 2005 10:20:47 +0200 <24601.1116404447@www71.gmx.net>
X-Windows: the first fully modular software disaster.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your test works fine on FC4 kernels (which are pretty current),
but it does hit the problem on my vanilla build.  strace output suggests
something is clobbering two registers:

waitid(P_PID, 1740, Sending signal to parent
0xbfc8b198, WEXITED|WSTOPPED|WCONTINUED, NULL) = ? ERESTARTSYS (To be restarted)
--- SIGUSR1 (User defined signal 1) @ 0 (0) ---
--- SIGCHLD (Child exited) @ 0 (0) ---
write(1, "Caught signal", 13Caught signal)           = 13
write(1, "\n", 1
)                       = 1
sigreturn()                             = ? (mask now [])
waitid(0x6cc /* P_??? */, 14, 0xbfc8b198, 0, NULL) = -1 EINVAL (Invalid argument)


I will look into it further.


Thanks,
Roland
