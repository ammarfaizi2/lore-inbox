Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWF3RLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWF3RLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWF3RLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:11:01 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:14235 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932094AbWF3RK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:10:59 -0400
Subject: Re: Proposal and plan for ext2/3 future development work
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Jeff Garzik <jeff@garzik.org>, "Theodore Ts'o" <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060630015903.GE11640@ca-server1.us.oracle.com>
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org>
	 <44A47B0D.7020308@garzik.org>
	 <20060630015903.GE11640@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 10:13:06 -0700
Message-Id: <1151687586.339.5.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 18:59 -0700, Joel Becker wrote:
> On Thu, Jun 29, 2006 at 09:14:53PM -0400, Jeff Garzik wrote:
> > Agreed overall, though specifically for delayed allocation I think 
> > that's an ext4 thing:
> > 
> > * First off, I'm a big fan of delalloc, and (like extents) definitely 
> > want to see the feature implemented
> > * Delayed allocation, properly done, requires careful interaction with 
> > VM writeback (memory pressure or normal writeout), and may require some 
> > minor changes to generic code in fs/* and mm/*
> 
> 	To be honest, I'd like to see more delayed allocation
> infrastructure in the VFS itself.  XFS has to maintain an entire chunk
> of state for it, and I suspect ext4 will as well.  I'd love to get
> delayed allocation into OCFS2 someday.  Why not move to where we can
> share the in-memory accounting code?
> 	Now, we'd probably want to start by prototyping it in ext4
> directly.  Once it's stable as a filesystem feature, we can see where
> XFS and ext4 overlap, etc, etc.  But I'd like to keep a more generic
> direction in mind.

I tried adding "delayed allocation" for ext3 earlier. Yes. VFS level
infrastructure would be nice. But, I haven't found much that we can
do at VFS - which is common across all the filesystems (except
mpage_writepage(s) handling). Most of the stuff is specific to 
filesystem implementation (even though it could be common) - coming
out with VFS level interfaces to suite all the different filesystem
delalloc would be *interesting* exercise.

If you have ideas on what are the common/generic stuff we can do in
VFS - I can take a look at it again :)

Thanks,
Badari

