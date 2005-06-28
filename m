Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVF1H2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVF1H2s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 03:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbVF1H1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 03:27:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24258 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261899AbVF1H06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 03:26:58 -0400
Date: Tue, 28 Jun 2005 00:26:42 -0700
Message-Id: <200506280726.j5S7QgZU027472@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
X-Fcc: ~/Mail/linus
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: eliminate unneccessary sighand locking
In-Reply-To: Ingo Molnar's message of  Tuesday, 28 June 2005 09:16:24 +0200 <20050628071624.GA2302@elte.hu>
Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the amount of potentially affected code (assuming all the locking is 
> done in a single .[ch] file)

I'm not sure what that means.  I'm not confident that all relevant locking
code is always in one file.  If you mean that you did as I said, checked
every use of siglock and confirmed that tasklist_lock is held before
examining ->sighand, then we are good.

> this reminds me about the patch below: it gets rid of tasklist_lock use 
> in the POSIX timer signal delivery critical path.

I don't see how that works at all.  The thought that it would seems to
contradict what we've just been discussing.  Holding tasklist_lock is what
protects against ->sighand and ->signal changing and the old pointers
becoming stale, not task_lock.  What am I missing here?



Thanks,
Roland
