Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936362AbWLFQO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936362AbWLFQO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936372AbWLFQO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:14:26 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:47972 "EHLO jdi.jdi-ict.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936362AbWLFQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:14:21 -0500
Date: Wed, 6 Dec 2006 17:14:08 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, npiggin@suse.de
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <20061206074008.2f308b2b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0612061655160.11560@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org> <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
 <Pine.LNX.4.58.0612061615550.24526@jdi.jdi-ict.nl> <20061206074008.2f308b2b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Wed, 06 Dec 2006 17:14:08 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Done some more digging : isn't http://lkml.org/lkml/2006/10/13/139 somehow 
> > related ? I do see pagefaults, and inode locks and mmap_locks. 
> > 
> 
> I thought it was, but from my look through yout 8-billion-task backtrace,
> no task was stuck in D-state with the appropriate call trace.
> 
> So I don't know what's causing this.  In the first trace you have at least
> four D-state kjournalds and a lot of processes stuck on an i_mutex.  I
> guess it's consistent with an IO system which is losing completion
> interrupts. 

Hmm.. Is there any way to make sure ? I've got a second machine (almost 
identical), which doesn't show this.

The main difference is the running kernel. I've had them at the same 
kernel, at which bad machine still crashes.

/proc/interrupts

Bad machine  : 18:   11160637   11235698   IO-APIC-fasteoi   arcmsr
Good machine : 18:   61658630   79352227   IO-APIC-level  arcmsr

Bad machine is running 2.6.19, good is running 2.6.14.7-grsec, which 
probably accounts for these changes.

> AFAICT in the second trace all you have is a lot of processes
> stuck on i_mutex for no obvious reason - I don't know why that would
> happen.

It's consequent, also the traces.
 
> How long does it take for this to happen?

Days to a week tops. It does happen less frequent with the 2.6.19, 
2.6.16.32 triggered it almost daily.

> Yes, lockdep might find something.

I've enabled most debug options. I'll boot the other kernel tomorrow.



Regards,


	Igmar
