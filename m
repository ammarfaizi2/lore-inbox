Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265558AbUBBCU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 21:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265560AbUBBCU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 21:20:27 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:29963 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265558AbUBBCU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 21:20:26 -0500
Date: Mon, 2 Feb 2004 03:20:23 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Daniel Jacobowitz <dan@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040202032023.A28264@pclin040.win.tue.nl>
References: <200402012225.i11MPEN1009925@magilla.sf.frob.com> <Pine.LNX.4.58.0402011653230.2229@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0402011653230.2229@home.osdl.org>; from torvalds@osdl.org on Sun, Feb 01, 2004 at 04:55:11PM -0800
X-Spam-DCC: servers: mailhost.tue.nl 1049; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 04:55:11PM -0800, Linus Torvalds wrote:

> On Sun, 1 Feb 2004, Roland McGrath wrote:

> > I haven't really looked into the problem with Dan's test case yet (didn't
> > seem to reproduce, but I haven't tried a current and cruft-free kernel yet).  
> > But I don't see any problem with the implementation of PTRACE_KILL.
> 
> Hmm.. For me, Dan's program (with "-DBUG -DNOTHREAD") results in a 
> sleeping parent, and both children are likewise just sleeping. Despite the 
> fact that the parent just did the PTRACE_KILL on child2.
> 
> I didn't trace it through the kernel, it just looked like PTRACE_KILL 
> didn't do anything.

I agree with both of you.

So, I think what happens is that PTRACE_KILL immediately after the PTRACE_CONT
works because there is no schedule in between, so the effect of PTRACE_KILL
is still seen by the (grand)child.
Once the grandchild has returned it has become immune for PTRACE_KILL.
Maybe there is no bug.

Andries
