Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbVLRNiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbVLRNiY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 08:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVLRNiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 08:38:24 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:20096 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932703AbVLRNiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 08:38:23 -0500
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
	 <dhowells1134774786@warthog.cambridge.redhat.com>
	 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
	 <1134791914.13138.167.camel@localhost.localdomain>
	 <14917.1134847311@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
	 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Dec 2005 13:38:13 +0000
Message-Id: <1134913093.26141.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-12-17 at 20:29 -0500, Nicolas Pitre wrote:
> out there.  The other 99% of actual ARM processors in the field only 
> have the atomic swap (swp) instruction which is insufficient for 
> implementing a counting semaphore (we therefore have to disable 
> interrupts, do the semaphore update and enable interrupts again which is 
> much slower than a swp-based mutex).

There are other approaches depending on how your CPU behaves and the
probability of splitting an "atomic operation" including checking the
return address range in the IRQ handler and ifs its in the 'atomic ops'
page jumping to a recovery function. If you are sneaky in how you lay
out your virtual address space it becomes a single unconditional or on
kernel->kernel interrupt returns.



