Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030197AbVLVPTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVLVPTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLVPTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:19:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47833 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751107AbVLVPTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:19:48 -0500
Date: Thu, 22 Dec 2005 10:19:46 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-reply-to: <20051222050701.41b308f9.akpm@osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       alan@lxorguk.ukuu.org.uk, bcrl@kvack.org, rostedt@goodmis.org,
       hch@infradead.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Message-id: <Pine.LNX.4.64.0512221012020.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222114147.GA18878@elte.hu>
 <20051222035443.19a4b24e.akpm@osdl.org> <20051222122011.GA20789@elte.hu>
 <20051222050701.41b308f9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Andrew Morton wrote:

> I'd prefer to see mutexes compared with semaphores after you've put as much
> work into improving semaphores as you have into developing mutexes.

There is a fundamental difference between semaphores and mutexes.  The 
semaphore semantics _require_ atomic increments/decrements where mutexes 
do not.  This makes a huge difference on ARM where 99% of all ARM 
processors out there can only perform atomic swaps which is sufficient 
for mutexes but insufficient for semaphores.  Therefore on ARM 
performing an atomic increment/decrement (the semaphore fast 
path) requires extra costly locking 
and .text space (23 cycles over 8 instructions) while the mutex fast 
path is about 2-3 instructions and 
needs 7-8 cycles.  I bet many other architectures are in the same camp.


Nicolas
