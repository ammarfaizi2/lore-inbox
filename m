Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbVLRRVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbVLRRVl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbVLRRVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:21:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62018 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965229AbVLRRVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:21:39 -0500
Date: Sun, 18 Dec 2005 12:21:38 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <1134913093.26141.30.camel@localhost.localdomain>
X-X-Sender: nico@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512181217340.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <1134913093.26141.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Dec 2005, Alan Cox wrote:

> On Sad, 2005-12-17 at 20:29 -0500, Nicolas Pitre wrote:
> > out there.  The other 99% of actual ARM processors in the field only 
> > have the atomic swap (swp) instruction which is insufficient for 
> > implementing a counting semaphore (we therefore have to disable 
> > interrupts, do the semaphore update and enable interrupts again which is 
> > much slower than a swp-based mutex).
> 
> There are other approaches depending on how your CPU behaves and the
> probability of splitting an "atomic operation" including checking the
> return address range in the IRQ handler and ifs its in the 'atomic ops'
> page jumping to a recovery function. If you are sneaky in how you lay
> out your virtual address space it becomes a single unconditional or on
> kernel->kernel interrupt returns.

Well we sort of do something similar to implement cmpxchg for NPTL usage 
from user space (forcing the abortion of the operation if an interrupt 
happens in the middle of it).  But it's more hassle to do in kernel 
space.


Nicolas
