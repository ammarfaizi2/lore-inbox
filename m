Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWGVM0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWGVM0N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 08:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWGVM0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 08:26:13 -0400
Received: from thunk.org ([69.25.196.29]:43912 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751315AbWGVM0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 08:26:12 -0400
Date: Sat, 22 Jul 2006 08:25:56 -0400
From: Theodore Tso <tytso@mit.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bill Davidsen <davidsen@tmr.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060722122555.GA7321@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Bill Davidsen <davidsen@tmr.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <44AC2D9A.7020401@tmr.com> <1152135740.22345.42.camel@lade.trondhjem.org> <44B01DEF.9070607@tmr.com> <1152562135.6220.7.camel@lade.trondhjem.org> <44B2D6AA.3090707@tmr.com> <1152585383.10156.9.camel@lade.trondhjem.org> <44C045B4.3040609@tmr.com> <1153483570.21909.8.camel@localhost> <20060721143619.GB2290@thunk.org> <1153508555.7534.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153508555.7534.5.camel@localhost>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2006 at 03:02:35PM -0400, Trond Myklebust wrote:
> > Nope, it doesn't violate POSIX/SuSv3.  The specifications only control
> > what happens if the system is cleanly shutdown.  What happens on an
> > unclean shutdown is explicitly undefined.  Hence, lazy atime update
> > where there is a "dirty" and "mostly clean" (i.e., atime-dirty) bit,
> > and where "mostly clean" inodes are only flushed out to disk when they
> > become fully dirty and then written out to disk, or when the
> > filesystem is unmounted, or when the filesystem feels like it (i.e.,
> > when we need to clear out in-core inodes in response to memory
> > pressure), would in fact be completely POSIX/SuSv3 compliant.
> 
> I agree that POSIX does not place any requirements on caching, but what
> you propose is impossible to implement on NFS: you may be able to get
> the atime 'right' (assuming that you are using something like ntp to
> ensure that client and server are in sync) but the NFS SETATTR
> primitives do not permit you to set the ctime, so that will be set to
> the time on the server it processed your SETATTR call (i.e. the close
> time). That violates POSIX semantics.

Sure, this is something that could only be done on local disk
filesystems.  But those are the ones most likely to be running on
battery power on notebook computers.  :-)

						- Ted
