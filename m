Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030382AbVLWCcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030382AbVLWCcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030383AbVLWCcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:32:14 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:26894 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S1030382AbVLWCcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:32:14 -0500
From: Ron Peterson <rpeterso@MtHolyoke.edu>
Date: Thu, 22 Dec 2005 21:32:11 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs insecure_locks / Tru64 behaviour
Message-ID: <20051223023211.GD22949@mtholyoke.edu>
References: <20051222133623.GE7814@mtholyoke.edu> <1135293713.3685.9.camel@lade.trondhjem.org> <20051223013933.GB22949@mtholyoke.edu> <1135302325.3685.69.camel@lade.trondhjem.org> <20051223022126.GC22949@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223022126.GC22949@mtholyoke.edu>
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 09:21:26PM -0500, rpeterso wrote:
> On Fri, Dec 23, 2005 at 02:45:25AM +0100, Trond Myklebust wrote:
> > On Thu, 2005-12-22 at 20:39 -0500, Ron Peterson wrote:
> > > > As for your problem accessing files in the directory
> > > > 
> > > > drwxr-x---  2 root     system  4096 Dec 22 08:22 d/
> > > > 
> > > > as an unprivileged user on group 'kmw', the solution is obvious:
> > > > 
> > > > 'chgrp kmw d'
> > > > 
> > > > or
> > > > 
> > > > chmod a+x d
> > > 
> > > That's exactly the problem.  The first obvious solution doesn't work.
> > > Your second solution does.  The directory must have the execute bit set
> > > for other, or the the file cannot be edited, no matter who owns the
> > > directory (unless the owner/group is nobody/nogroup).
> > 
> > Why wouldn't the chgrp solution work? Isn't /etc/groups on the client
> > and server in sync?
> 
> Yep.
> 
> Why it doesn't work .. I dunno.  My current best guess is that the
> manner in which the insecure_locks option in /etc/exports is applied to
> directories isn't quite right.

BTW, the behaviour is that all files appear to be locked.  In vi, for
example, when I try to edit the file 'test' below, it says:

"test" [FILE BEING MODIFIED BY ANOTHER PROCESS] 1 line, 31 characters

on tru64 alpha:

% ls -al
total 12
drwxrwx---   2 root     kmw         4096 Dec 22 20:22 .
drwxr-xr-x   6 root     system      4096 Dec 22 08:22 ..
-rw-rw-r--   1 root     kmw           31 Dec 22 21:27 test

% groups
accntmgr kmw ...

Best.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://pks.mtholyoke.edu:11371/pks/lookup?search=0xB6D365A1&op=vindex
