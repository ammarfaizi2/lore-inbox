Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVAJW2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVAJW2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVAJWXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:23:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23717 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262738AbVAJWTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:19:23 -0500
Date: Mon, 10 Jan 2005 17:20:13 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-ID: <20050110192012.GA18531@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f250c71050110134337c08ef0@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 05:43:23PM -0400, Mauricio Lin wrote:
> Hi all,
> 
> We have done a comparison between the kernel version and user space
> version and apparently the behavior is similar. You can also get this
> patch and module to test it and compare with kernel OOM Killer. Here
> goes a patch and a module that moves the kernel space OOM Killer
> algorithm to user space. Let us know about your ideas.

No comments on the code itself - It is interesting to have certain pids "not selectable" by
the OOM killer. Patches which have similar funcionality have been floating around.

The userspace OOM killer is dangerous though. You have to guarantee that allocations 
will NOT happen until the OOM killer is executed and the killed process is dead and
has its pages freed - allocations under OOM can cause deadlocks. 

"OOM-killer-in-userspace" is unreliable, not sure if its worth the effort making
it reliable (mlock it, flagged as PF_MEMALLOC, etc). 
