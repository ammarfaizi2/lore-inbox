Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVBHVUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVBHVUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 16:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVBHVUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 16:20:42 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:54246 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261565AbVBHVUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 16:20:35 -0500
Date: Tue, 8 Feb 2005 22:20:23 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Jeff Dike <jdike@addtoit.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and UML? 
In-Reply-To: <200502081855.j18ItFs0012685@ccure.user-mode-linux.org>
Message-Id: <Pine.OSF.4.05.10502082009360.23457-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2005, Jeff Dike wrote:

> mingo@elte.hu said:
> > Jeff, any objections against adding this change to UML at some point?
> 
> No, not at all.  I just need to understand what CONFIG_PREEMPT requires of
> UML.

Ingo can probably tell you in much more detail. My problem when I tried to
compile with CONFIG_PREEMPT_RT (not CONFIG_PREEMPT!) was that
__SEMAPHORE_INITIALIZER didn't exist since the architecture specific
semaphore.h is not included in that configuration. The reason again is
that locking (not completions) is changed a lot under CONFIG_PREEMPT_RT to
introduce muteces instead of raw spinlocks and priority inheritance to
make these lockings behave deterministicly.

> 
> >From a quick read of Documentation/preempt-locking.txt, this looks like it's
> implementing Rule #3 (unlock by the same task that locked), which looks fine.
>

Now I don't really know who I am responding to. But both up()s now changed
to complete()s are in something looking very much like an interrupt
handler. But again, as I said, I didn't analyze the code in detail, I just
made it compile and checked that it worked in bare 2.6.11-rc2 UML  - which
I am not too sure how to set up and use to begin with!
 
> 				Jeff
> 

Esben


