Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWGUOga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWGUOga (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 10:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWGUOg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 10:36:29 -0400
Received: from thunk.org ([69.25.196.29]:63136 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1750744AbWGUOg3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 10:36:29 -0400
Date: Fri, 21 Jul 2006 10:36:19 -0400
From: Theodore Tso <tytso@mit.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bill Davidsen <davidsen@tmr.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060721143619.GB2290@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Bill Davidsen <davidsen@tmr.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <20060705125956.GA529@fieldses.org> <1152128033.22345.17.camel@lade.trondhjem.org> <44AC2D9A.7020401@tmr.com> <1152135740.22345.42.camel@lade.trondhjem.org> <44B01DEF.9070607@tmr.com> <1152562135.6220.7.camel@lade.trondhjem.org> <44B2D6AA.3090707@tmr.com> <1152585383.10156.9.camel@lade.trondhjem.org> <44C045B4.3040609@tmr.com> <1153483570.21909.8.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153483570.21909.8.camel@localhost>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 08:06:10AM -0400, Trond Myklebust wrote:
> > By keeping lazy track of access time it's possible to still have that 
> > data, with minimal disk access cost. And to some people that can be 
> > really useful, such as those of us who have to justify expenditures.
> 
> What you propose violates both POSIX and SuSv3. close() does not update
> the atime on a file. I can't see anyone accepting that there is a need
> for this.

Nope, it doesn't violate POSIX/SuSv3.  The specifications only control
what happens if the system is cleanly shutdown.  What happens on an
unclean shutdown is explicitly undefined.  Hence, lazy atime update
where there is a "dirty" and "mostly clean" (i.e., atime-dirty) bit,
and where "mostly clean" inodes are only flushed out to disk when they
become fully dirty and then written out to disk, or when the
filesystem is unmounted, or when the filesystem feels like it (i.e.,
when we need to clear out in-core inodes in response to memory
pressure), would in fact be completely POSIX/SuSv3 compliant.

						- Ted
