Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUGLUwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUGLUwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 16:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGLUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 16:52:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:13493 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262730AbUGLUwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 16:52:31 -0400
Date: Mon, 12 Jul 2004 13:54:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lmb@suse.de, arjanv@redhat.com, phillips@istop.com, sdake@mvista.com,
       teigland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-Id: <20040712135432.57d0133c.akpm@osdl.org>
In-Reply-To: <40F294D2.3010203@yahoo.com.au>
References: <1089501890.19787.33.camel@persist.az.mvista.com>
	<200407111544.25590.phillips@istop.com>
	<20040711210624.GC3933@marowsky-bree.de>
	<1089615523.2806.5.camel@laptop.fenrus.com>
	<20040712100547.GF3933@marowsky-bree.de>
	<20040712101107.GA31013@devserv.devel.redhat.com>
	<20040712102124.GH3933@marowsky-bree.de>
	<20040712102818.GB31013@devserv.devel.redhat.com>
	<20040712115003.GV3933@marowsky-bree.de>
	<20040712120127.GB16604@devserv.devel.redhat.com>
	<20040712131312.GY3933@marowsky-bree.de>
	<40F294D2.3010203@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> I don't see why it would be a problem to implement a "this task
> facilitates page reclaim" flag for userspace tasks that would take
> care of this as well as the kernel does.

Yes, that has been done before, and it works - userspace "block drivers"
which permanently mark themselves as PF_MEMALLOC to avoid the obvious
deadlocks.

Note that you can achieve a similar thing in current 2.6 by acquiring
realtime scheduling policy, but that's an artifact of some brainwave which
a VM hacker happened to have and isn't a thing which should be relied upon.

A privileged syscall which allows a task to mark itself as one which
cleans memory would make sense.
