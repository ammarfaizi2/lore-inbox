Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbULOPTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbULOPTB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 10:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbULOPTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 10:19:01 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:22447 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262358AbULOPS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 10:18:59 -0500
Date: Wed, 15 Dec 2004 07:18:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041215151840.GA1265@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041213125046.GG3033@suse.de> <20041213130926.GH3033@suse.de> <20041213175721.GA2721@suse.de> <20041214133725.GG3157@suse.de> <20041214213155.GA2057@us.ibm.com> <20041215063628.GL3157@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215063628.GL3157@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 07:36:28AM +0100, Jens Axboe wrote:
> On Tue, Dec 14 2004, Paul E. McKenney wrote:
> > If only one task is referencing the list at all, no need for RCU or for
> > any other synchronization mechanism.  If multiple threads are referencing
> > the list, I cannot find any pure readers.  If multiple threads are updating
> > the list, I don't see how they are excluding each other.
> > 
> > Any enlightenment available?  I most definitely need a clue here...
> 
> No, you are about right :-)
> 
> The RCU stuff can go again, because I moved everything to happen under
> the same task. The section under rcu_read_lock() is the reader, it just
> later on moved the hot entry to the front as well which does indeed mean
> it's buggy if there were concurrent updaters. So that's why it's in a
> state of being a little messy right now.
> 
> A note on the list itself - a task has a cfq_io_context per queue it's
> doing io against and it needs to be looked up when we this process
> queues io. The task sets this up itself on first io and tears this down
> on exit. So only the task itself ever updates or searches this list.

Whew!!!  I feel much better!

							Thanx, Paul
