Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274969AbTHRUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275010AbTHRUrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:47:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:16553 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274969AbTHRUrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:47:04 -0400
Date: Mon, 18 Aug 2003 13:32:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Fix up riscom8 driver to use work queues instead of task
 queueing.
Message-Id: <20030818133226.66986354.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308181234500.5929-100000@home.osdl.org>
References: <20030818192529.GC19067@gtf.org>
	<Pine.LNX.4.44.0308181234500.5929-100000@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> On Mon, 18 Aug 2003, Jeff Garzik wrote:
> > 
> > There was talk in another thread about fixing up workqueue to create
> > a new kernel thread, if one isn't available within five seconds.
> 
> That's probably reasonable. Together with some upper limit to active
> threads, along with timeouting old queues when idle it would be fairly
> flexible. It's how basically all servers end up working, after all. It 
> shouldn't be that hard to do.
> 

Note that pdflush is already doing this.  It doesn't seem to work very well
though:

a) new threads seem to start up too late

b) they probably don't hang around for long enough

c) now that pdflush avoids blocking on queues it's all rather overkill
   anyway.

pdflush could kinda-sorta be converted to use workqueues, but it doesn't
want a thread per cpu.

