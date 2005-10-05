Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVJEQaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVJEQaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVJEQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:30:19 -0400
Received: from over.co.us.ibm.com ([32.97.110.157]:59040 "EHLO
	bldfb.esmtp.ibm.com") by vger.kernel.org with ESMTP
	id S1030227AbVJEQaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:30:16 -0400
Date: Wed, 5 Oct 2005 09:29:48 -0700
To: David Leimbach <leimy2k@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: /etc/mtab and per-process namespaces
Message-ID: <20051005162948.GA25162@RAM>
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com> <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1162e60510041214t3afd803re27b742705d27900@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 12:14:47PM -0700, David Leimbach wrote:
> Hmm no responses on this thread a couple days now.  I guess:
> 
> 1) No one cares about private namespaces or the fact that they make
> /etc/mtab totally inconsistent.
> 2) Private Namespaces aren't important to anyone and will never be
> robust unless someone who cares, like me, takes it over somehow.
> 3) Everyone is busy with their own shit and doesn't want to deal with
> me or mine right now.
> 
> I'm seriously hoping it's 3 :).  2 Is acceptable too of course.  I
> think this is important and I want to know more about the innards
> anyway.  1 would make me sad as I think Linux can really show other
> Unix's what-for here when it comes to showing off how good the VFS can
> be.

This becomes even more intresting when sharedsubtree gets added to 
the equation. One would like to know all the mounts in its namesapace
and than all the mounts it propagates to which could include mounts in 
other namespaces too..

I guess some interface that meets the following needs would eventually
be needed:

1. what are all the mounts in  my namespace ?
	A. what are the attributes of each of the mounts?
		a. where is it mounted
		b. who is its parent  
		c. what is it mounted from
		d. what are the attributes of its mount
		e. what are its peer mounts (I suspect some kind 
					of identifier has
					to be associated with each mount)
		f. if it has a master mount where is it
		g. what are its slave mounts.at
		(note: e, f, g can point to mounts in other namespaces)
2. what are the attributes of my namespace?
	a. what is the parent namespace? ( I suspect some kind 
			of identifier has to associated 
			with each namespace, pid of the cloned
			process?)
	b. what are my children namespace?

3. which processes can access my namespace?


And I don't think /etc/mtab can do a decent job with this, because it
would not know where all the mounts propagate, when it attempts a mount.
Only the kernel would know, and hence all the commands who depend on
/etc/mtab may have to depend on some /proc or maybe /sysfs interface to
do a descent job.

RP

> 
> Linux has always been a bit of DIY, so I guess I just need to accept
> that.  It's not unlike the KDE development model.  People who want
> certain things done either motivate others to help or make a run for
> it on their own, even in the face of adversity.  Kind of more noble
> that way I guess.
> 
> Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
