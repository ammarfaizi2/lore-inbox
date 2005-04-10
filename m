Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVDJKQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVDJKQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 06:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVDJKQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 06:16:03 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:17024 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261462AbVDJKP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 06:15:56 -0400
Date: Sun, 10 Apr 2005 03:06:46 -0400
From: Christopher Li <lkml@chrisli.org>
To: Junio C Hamano <junkio@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050410070646.GD13853@64m.dyndns.org>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <20050410055340.GB13853@64m.dyndns.org> <7v7jjbc755.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v7jjbc755.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 02:28:54AM -0700, Junio C Hamano wrote:
> >>>>> "CL" == Christopher Li <lkml@chrisli.org> writes:
> 
> CL> On Sun, Apr 10, 2005 at 12:51:59AM -0700, Junio C Hamano wrote:
> >> 
> >> But I am wondering what your plans are to handle renames---or
> >> does git already represent them?
> >> 
> 
> CL> Rename should just work.  It will create a new tree object and you
> CL> will notice that in the entry that changed, the hash for the blob
> CL> object is the same.
> 
> Sorry, I was unclear.  But doesn't that imply that a SCM built
> on top of git storage needs to read all the commit and tree
> records up to the common ancestor to show tree diffs between two
> forked tree?
> 
> I suspect that another problem is that noticing the move of the
> same SHA1 hash from one pathname to another and recognizing that
> as a rename would not always work in the real world, because
> sometimes people move files *and* make small changes at the same
> time.  If git is meant to be an intermediate format to suck
> existing kernel history out of BK so that the history can be
> converted for the next SCM chosen for the kernel work, I would
> imagine that there needs to be a way to represent such a case.
> Maybe convert a file rename as two git trees (one tree for pure
> move which immediately followed by another tree for edit) if it
> is not a pure move?
> 

Git is not a SCM yet.  For the rename + change set it should internally
handle by pure rename only plus the extra delta. The current git don't
have per file change history. From git's point of view some file deleted
and the other file appeared with same content.

It is the top level SCM to handle that correctly.
Rename a directory will be even more fun.

Chris
