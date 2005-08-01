Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbVHAADL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVHAADL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 20:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVHAADK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 20:03:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43240 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262170AbVHAABf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 20:01:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: sigwait() breaks when straced
In-Reply-To: Andrew Morton's message of  Saturday, 30 July 2005 17:00:49 -0700 <20050730170049.6df9e39f.akpm@osdl.org>
X-Zippy-Says: Will it improve my CASH FLOW?
Message-Id: <20050801000120.1D00F180EC0@magilla.sf.frob.com>
Date: Sun, 31 Jul 2005 17:01:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is not really "when straced", but when strace attaches.  In
fact, it's not even "when PTRACE_ATTACH'd".  It's actually the implicit
SIGSTOP that PTRACE_ATTACH causes.  If you simply suspend and resume the
program (with SIGSTOP or C-z), you get the same result.  So this report is
more properly identified as "signal stop breaks sigwait".  

However, there is in fact no bug here.  The test program is just wrong.
sigwait returns zero or an error number, as POSIX specifies.  Conversely,
sigtimedwait and sigwaitinfo either return 0 or set errno and return -1.
It is odd that the interfaces of related functions differ in this way,
but they do.


Thanks,
Roland


