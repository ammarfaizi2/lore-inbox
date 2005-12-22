Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbVLVVw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbVLVVw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVLVVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:52:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54867 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030327AbVLVVwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:52:55 -0500
Date: Thu, 22 Dec 2005 16:52:54 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/10] mutex subsystem, -V5
In-reply-to: <20051222213902.GA32433@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221647490.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222153717.GA6090@elte.hu>
 <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
 <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
 <20051222213902.GA32433@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Ingo Molnar wrote:

> i definitely do not say that _everything_ should be generalized. That 
> would be micromanaging things. But i definitely think there's an 
> unhealthy amount of _under_ generalization in current Linux 
> architectures, and i dont want the mutex subsystem to fall into that 
> trap.

BTW, I strongly believe the semaphore implementation could go with the 
same model the mutex model I hope is heading for.

I.e., the only thing each architecture really have to implement is 
__sem_fast_down and __sem_fast _up, and incidentally they would have the 
exact same definition as your atomic_*_call_if_* functions (while a bit 
too restrictive for mutex semantics, they really are the minimum 
required for semaphores).  Then all the current per architecture 
semaphore code could be consolidated.


Nicolas
