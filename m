Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbVLRBaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbVLRBaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 20:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVLRBaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 20:30:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33621 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932660AbVLRBaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 20:30:01 -0500
Date: Sat, 17 Dec 2005 20:29:58 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-reply-to: <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Message-id: <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Dec 2005, Linus Torvalds wrote:

> Of the other architectures you list, only ARM is really important. And no, 
> arm doesn't do swap. It does LL/SC (except they call it "ldrex/strex", 
> which I assume stands for "load/store with reservation and X just because 
> X is cool. Yeah, we're cool" (*)).

Well, if you really want to be honest, you have to consider that the 
ldrex/strex instructions are available only on ARM architecture level 6 
and above, or in other words with only about 1% of all ARM deployments 
out there.  The other 99% of actual ARM processors in the field only 
have the atomic swap (swp) instruction which is insufficient for 
implementing a counting semaphore (we therefore have to disable 
interrupts, do the semaphore update and enable interrupts again which is 
much slower than a swp-based mutex).


Nicolas
