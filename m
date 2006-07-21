Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWGTWrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWGTWrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 18:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWGTWrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 18:47:25 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:52456 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030393AbWGTWrY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 18:47:24 -0400
Subject: Re: Bad ext3/nfs DoS bug
From: Marcel Holtmann <marcel@holtmann.org>
To: Neil Brown <neilb@suse.de>
Cc: Jan Kara <jack@suse.cz>, James <20@madingley.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sct@redhat.com
In-Reply-To: <17599.2754.962927.627515@cse.unsw.edu.au>
References: <20060717130128.GA12832@circe.esc.cam.ac.uk>
	 <1153209318.26690.1.camel@localhost>
	 <20060718145614.GA27788@circe.esc.cam.ac.uk>
	 <1153236136.10006.5.camel@localhost>
	 <20060718152341.GB27788@circe.esc.cam.ac.uk>
	 <1153253907.21024.25.camel@localhost>
	 <20060719092810.GA4347@circe.esc.cam.ac.uk>
	 <20060719155502.GD3270@atrey.karlin.mff.cuni.cz>
	 <17599.2754.962927.627515@cse.unsw.edu.au>
Content-Type: text/plain
Date: Fri, 21 Jul 2006 02:42:13 +0200
Message-Id: <1153442533.5050.1.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> > > So what happens next? Is the ext3 maintainer on sabatical,
> > > or am I expected to submit a patch to fix this?
> >   I guess people are mostly busy with OLS and such so maybe they missed
> > the discussion.. Giving CC to relevant people to catch their attention
> > :)
> >   Andrew, Stephen: James has come across a nasty bug (potentially remote
> > DoS). NFS extracts inode number from a filehandle and the inode number
> > eventually ends in ext3_read_inode(). Now if the inode number is bogus,
> > ext3_get_inode_block() calls ext3_error() and filesystem is remounted
> > RO or whatever else is configured. That is quite undesirable in this
> > case.
> >   Now the easy "fix" is to change ext3_error() to ext3_warning() but an
> > attacker flooding your logs with warnings is probably not good either
> > and in case the inode number comes from ext3 itself we should really do
> > ext3_error() as there is some corruption in the fs.
> >   Better fix would be to add a flag to read_inode() saying that the inode
> > number is from untrusted source (but that means changing a prototype of a
> > function every fs uses) and change export_iget() to pass this flag. Yet
> > another solution would be to make ext3 implement its own get_dentry() export
> > function and pass the flag internally...
> >   What do you think is the best solution?
> 
> I think that a good solution (hard to say if it is the best) is to
> remove that error message altogether, and put it where inode numbers
> are read out of directories.  Something like the following patch -
> compile tested only.

I tested your patch and it works for me. So can someone with ext3
knowledge review and then propose it for upstream inclusion.

Regards

Marcel


