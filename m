Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbVLRGbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbVLRGbI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 01:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVLRGbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 01:31:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030191AbVLRGbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 01:31:06 -0500
Date: Sat, 17 Dec 2005 22:30:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Dec 2005, Nicolas Pitre wrote:
> 
> Now if you don't disable interrupts then nothing prevents an interrupt 
> handler, or another thread if kernel preemption is allowed

Preemption, yes. Interrupts no.

>							 to come 
> along right between (2) and (4) to call up() or down() which will 
> make the sem count inconsistent as soon as the interrupted down() or 
> up() is resumed.

An interrupt can never change the value without changing it back, except 
for the old-fashioned use of "up()" as a completion (which I don't think 
we do any more - we used to do it for IO completion a looong time ago).

So I think the interrupt disable could be removed for UP, at least for
non-preemption.

(Of course, maybe it's not worth it. It might not be a big performance 
issue).

		Linus
