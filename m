Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVBBBhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVBBBhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVBBBhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:37:40 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:61619 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262194AbVBBBh0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:37:26 -0500
Date: Tue, 1 Feb 2005 20:37:19 -0500
To: Ram <linuxram@us.ibm.com>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050202013719.GB23662@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org> <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk> <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost> <41F6BE58.50208@sun.com> <1106690563.3298.43.camel@localhost> <20050201233753.GB22118@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201233753.GB22118@fieldses.org>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 06:37:54PM -0500, J. Bruce Fields wrote:
> I think the question you meant to ask was what would happen if you
> mounted something on /tmp/mnt2/a/b (the slave copy) and then mounted
> something else on /tmp/mnt1/a/b.  In that case there's two places where
> the propagated mount might go:
> 	1. On top of the dentry a/b in /tmp/mnt2, underneath the
> 	   preexisting mount.
> 	2. On top of the root dentry of the thing mounted in
> 	   /tmp/mnt2/a/b, thus covering the preexisting mount.
> 
> Wouldn't option 1 require changing the mnt_parent of the preexisting
> mount on /tmp/mnt2/a/b?  That seems like an odd thing to do, so I assume
> option 2 is the only possible solution, but perhaps I'm missing
> something.

Yes, I'm confused: --move, for example, changes the mnt_parent, and it's
only ever used under vfsmount_lock.

So #1, which adheres to the rule that all the clones are mounted at the
same dentry, probably makes more sense.--b.
