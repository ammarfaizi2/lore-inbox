Return-Path: <linux-kernel-owner+w=401wt.eu-S1752042AbXAROQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbXAROQ4 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXAROQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:16:55 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:48493 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039AbXAROQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:16:54 -0500
Subject: Re: [PATCH: 2.6.20-rc4-mm1] JFS: Avoid deadlock introduced by
	explicit I/O plugging
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: Jens Axboe <jens.axboe@oracle.com>,
       JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20070118063019.GA31164@filer.fsl.cs.sunysb.edu>
References: <1169074549.10560.10.camel@kleikamp.austin.ibm.com>
	 <20070118063019.GA31164@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 08:15:30 -0600
Message-Id: <1169129730.7295.10.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 01:30 -0500, Josef Sipek wrote:
> On Wed, Jan 17, 2007 at 04:55:49PM -0600, Dave Kleikamp wrote:

> >  /*
> >   *	jfs_lock.h
> > @@ -42,6 +43,7 @@ do {							\
> >  		if (cond)				\
> >  			break;				\
> >  		unlock_cmd;				\
> > +		blk_replug_current_nested();		\
> >  		schedule();				\
> >  		lock_cmd;				\
> >  	}						\
> 
> Is {,un}lock_cmd a macro? ...

They are the commands passed into this macro (as arguments) to
release/take a lock.  This is a home-grown wait_on_event type macro
where the condition must be checked while holding a lock.  And the
commands passed in are themselves macros.  The jfs code could probably
be cleaned up a bit as far as excessive use of macros for locking, but
it's been working for a few years with few problems.

-- 
David Kleikamp
IBM Linux Technology Center

