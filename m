Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUGMCTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUGMCTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUGMCTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:19:09 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:53900 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261184AbUGMCTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:19:05 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Mon, 12 Jul 2004 22:19:17 -0400
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lmb@suse.de, arjanv@redhat.com,
       sdake@mvista.com, teigland@redhat.com, linux-kernel@vger.kernel.org
References: <1089501890.19787.33.camel@persist.az.mvista.com> <40F294D2.3010203@yahoo.com.au> <20040712135432.57d0133c.akpm@osdl.org>
In-Reply-To: <20040712135432.57d0133c.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407122219.17582.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Monday 12 July 2004 16:54, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > I don't see why it would be a problem to implement a "this task
> > facilitates page reclaim" flag for userspace tasks that would take
> > care of this as well as the kernel does.
>
> Yes, that has been done before, and it works - userspace "block drivers"
> which permanently mark themselves as PF_MEMALLOC to avoid the obvious
> deadlocks.
>
> Note that you can achieve a similar thing in current 2.6 by acquiring
> realtime scheduling policy, but that's an artifact of some brainwave which
> a VM hacker happened to have and isn't a thing which should be relied upon.

Do you have a pointer to the brainwave?

> A privileged syscall which allows a task to mark itself as one which
> cleans memory would make sense.

For now we can do it with an ioctl, and we pretty much have to do it for 
pvmove.  But that's when user space drives the kernel by syscalls; there is 
also the nasty (and common) case where the kernel needs userspace to do 
something for it while it's in PF_MEMALLOC.  I'm playing with ideas there, 
but nothing I'm proud of yet.  For now I see the in-kernel approach as the 
conservative one, for anything that could possibly find itself on the VM 
writeout path.

Unfortunately, that may include some messy things like authentication.  I'd 
really like to solve this reliable-userspace problem.  We'd still have lots 
of arguments left to resolve about where things should be, but at least we'd 
have the choice.

Regards,

Daniel
