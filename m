Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965254AbVLRTm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965254AbVLRTm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 14:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbVLRTm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 14:42:29 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:52390 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965252AbVLRTm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 14:42:28 -0500
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>,
       David Howells <dhowells@redhat.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>, mingo@redhat.com,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
	 <dhowells1134774786@warthog.cambridge.redhat.com>
	 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
	 <1134791914.13138.167.camel@localhost.localdomain>
	 <14917.1134847311@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
	 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
	 <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
	 <Pine.LNX.4.64.0512172150260.26663@localhost.localdomain>
	 <Pine.LNX.4.64.0512172227280.3698@g5.osdl.org>
	 <20051218092616.GA17308@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0512181027220.4827@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 13:41:26 -0600
Message-Id: <1134934887.3517.15.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 10:42 -0800, Linus Torvalds wrote:
> It's easy enough to add a "might_sleep()" to the up(). Not strictly true, 
> but conceptually it would make sense to make up/down match in that sense. 
> We'd have to mark the (few) places that do down_trylock() + up() in 
> interrupt context with a special "up_in_interrupt()", but that would be ok 
> even from a documentation standpoint.

Actually, I don't think you want might_sleep(): there are a few cases
where we do an up() from under a spinlock, which will spuriously trigger
this.  I'd suggest WARN_ON(in_interrupt()) instead.

James


