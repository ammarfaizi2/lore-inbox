Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261575AbTCKUEd>; Tue, 11 Mar 2003 15:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbTCKUEd>; Tue, 11 Mar 2003 15:04:33 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:31417 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261575AbTCKUEa>; Tue, 11 Mar 2003 15:04:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [RFC] Improved inode number allocation for HTree
Date: Tue, 11 Mar 2003 21:19:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <11490000.1046367063@[10.10.2.4]> <20030311133705.2157A102100@mx12.arcor-online.net> <20030311193903.GA15327@hh.idb.hist.no>
In-Reply-To: <20030311193903.GA15327@hh.idb.hist.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030311201511.EEBE6F94A2@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11 Mar 03 20:39, Helge Hafting wrote:
> On Tue, Mar 11, 2003 at 02:41:06PM +0100, Daniel Phillips wrote:
> > <wishful thinking>
> > Now that you mention it, just locking out create and rename during
> > directory traversal would eliminate the pain.  Delete is easy enough to
> > handle during traversal.  For a B-Tree, coalescing could simply be
> > deferred until the traversal is finished, so reading the directory in
> > physical storage order would be fine.  Way, way cleaner than what we have
> > to do now.
> > </wishful thinking>
>
> Ok, so "rm" works.  Then you have things like "mv *.c /usr/src" to worry
> about.

That's equivalent to ls, the shell expands it before doing any moving.  You 
can construct something more interesting with ls | xargs <something nasty>
into the same directory.  Since the user is trying to shoot their foot off, 
let the lock be recursive, and let them do that.

> ...someone evil still
> could cause trouble by keeping a traversal going forever, creating one
> dummy file and deleting one whenever it makes progress.  The directory
> would get big, filled up with placeholders until some ulimit kicks in.
>
> Helge Hafting

It's not clear that's any more evil than things they can do already, eg,

   seq 1 1000000 | xargs -l1 cp -a /usr

Welllll, this is all idle speculation anyway.  Nobody's going to fix the 
flaw this week, if it's even possible (I suspect it is).

Regards,

Daniel
