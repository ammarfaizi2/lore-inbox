Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272927AbTHPOTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272941AbTHPOTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:19:08 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:39810 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272927AbTHPOTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:19:06 -0400
Date: Sat, 16 Aug 2003 15:18:51 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030816141851.GD23646@mail.jlokier.co.uk>
References: <20030815235431.GT1027@matchmail.com> <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com> <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030816080614.01a0e418@pop.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> At 01:54 AM 8/16/2003 +0100, Jamie Lokier wrote:
> [...]
> 
> >None of these will work well if "wakee" tasks are able to run
> >immediately after being woken, before "waker" tasks get a chance to
> >either block or put the wakees back to sleep.
> 
> Sounds like another scheduler class (SCHED_NOPREEMPT) would be required.

If something special were to be added, it should be a way for a task
to say "If I call schedule() and block, don't do a schedule, just
continue my timeslice in task X".

The point of the mechanism is to submit system calls in an
asynchronous fashion, after all.  A proper task scheduling is
inappropriate when all we'd like to do is initiate the syscall and
continue processing, just as if it were an async I/O request.

The interesting part is what to do when the original task (the one
that went to sleep) wakes up.

-- Jamie

