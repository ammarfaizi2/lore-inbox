Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934488AbWLFPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934488AbWLFPkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935778AbWLFPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:40:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34467 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934488AbWLFPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:40:15 -0500
Date: Wed, 6 Dec 2006 07:40:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
Message-Id: <20061206074008.2f308b2b.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
	<20061130212248.1b49bd32.akpm@osdl.org>
	<Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
	<Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 16:17:10 +0100 (CET)
Igmar Palsenberg <i.palsenberg@jdi-ict.nl> wrote:

> 
> > > It's rather large, but for those who want to look at it : 
> > > http://www.jdi-ict.nl/plain/serial-28112006.txt
> > 
> > The same problem, this time with 2.6.19. I've done a show tasks, a show 
> > locks, a show regs, and after that, a sync + reboot :)
> > 
> > Log is at http://www.jdi-ict.nl/plain/serial-04122006.txt .
> > 
> > If anyone needs more info : please tell me.
> 
> Done some more digging : isn't http://lkml.org/lkml/2006/10/13/139 somehow 
> related ? I do see pagefaults, and inode locks and mmap_locks. 
> 

I thought it was, but from my look through yout 8-billion-task backtrace,
no task was stuck in D-state with the appropriate call trace.

So I don't know what's causing this.  In the first trace you have at least
four D-state kjournalds and a lot of processes stuck on an i_mutex.  I
guess it's consistent with an IO system which is losing completion
interrupts.  AFAICT in the second trace all you have is a lot of processes
stuck on i_mutex for no obvious reason - I don't know why that would
happen.

How long does it take for this to happen?

Yes, lockdep might find something.
