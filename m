Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVLRETY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVLRETY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 23:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVLRETY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 23:19:24 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:62105 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965076AbVLRETX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 23:19:23 -0500
Date: Sat, 17 Dec 2005 23:18:54 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Nicolas Pitre <nico@cam.org>
cc: Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0512172313210.7817@gandalf.stny.rr.com>
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
> handler, or another thread if kernel preemption is allowed, to come
> along right between (2) and (4) to call up() or down() which will
> make the sem count inconsistent as soon as the interrupted down() or
> up() is resumed.
>

Well, the one thing that is preventing this is the fact that interrupts
don't call up and down, since down can schedule.  Now they might do a
down_trylock, but then if it would succeed, it would most likely call the
up. So the semaphore would be back to what it was before the interrupt
took place.

But you do have a case about preemption.

-- Steve

