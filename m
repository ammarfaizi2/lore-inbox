Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVBAXVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVBAXVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVBAXVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:21:17 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:9139 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262168AbVBAXVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:21:08 -0500
Date: Tue, 1 Feb 2005 18:21:06 -0500
To: Ram <linuxram@us.ibm.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050201232106.GA22118@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <20050116160213.GB13624@fieldses.org> <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050116184209.GD13624@fieldses.org> <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk> <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106687232.3298.37.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 01:07:12PM -0800, Ram wrote:
> If there exists a private subtree in a larger shared subtree, what
> happens when the larger shared subtree is rbound to some other place? 
> Is a new private subtree created in the new larger shared subtree? or
> will that be pruned out in the new larger subtree?

"mount --rbind" will always do at least all the mounts that it did
before the introduction of shared subtrees--so certainly it will copy
private subtrees along with shared ones.  (Since subtrees are private by
default, anything else would make --rbind do nothing by default.) My
understanding of Viro's RFC is that the new subtree will have no
connection with the preexisting private subtree (we want private
subtrees to stay private), but that the new copy will end up with
whatever propagation the target of the "mount --rbind" had.  (So the
addition of the copy of the private subtree to the target vfsmount will
be replicated on any vfsmount that the target vfsmount propogates to,
and those copies will propagate among themselves in the same way that
the copies of the target vfsmount propagate to each other.)

--Bruce Fields
