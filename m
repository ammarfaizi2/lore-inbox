Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269058AbUIAAcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269058AbUIAAcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUIAA23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:28:29 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:8342 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S269291AbUIAA2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:28:04 -0400
Date: Tue, 31 Aug 2004 17:27:54 -0700
Message-Id: <200409010027.i810RsWT001980@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andi Kleen <ak@muc.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] cleanup ptrace stops and remove notify_parent
In-Reply-To: Andi Kleen's message of  Tuesday, 31 August 2004 12:00:02 +0200 <m3hdqjk4pp.fsf@averell.firstfloor.org>
X-Shopping-List: (1) Circular condiments
   (2) Diagnostic ardent geese
   (3) Independent enemas
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure such a user visible semantic change is a good idea? 

Not if it's not too hard to avoid.  I think I can make it not come up by
converting TASK_STOPPED into TASK_TRACED when you use ptrace.  It will just
take some synchronization for that case.

> I at least have written (not very important, but existing) user space
> code in the past that assumed it can stop and single step without
> SIGCONT. I wouldn't be surprised if other debuggers ran into 
> the same issue.

I assume you mean stop with SIGSTOP, then attach with PTRACE_ATTACH, then
step with PTRACE_SINGLESTEP.  If you are already attached, then any stop
will report to you first in TASK_TRACED and never end up TASK_STOPPED
unless you explicitly pass a stop signal through with ptrace.


Thanks,
Roland

