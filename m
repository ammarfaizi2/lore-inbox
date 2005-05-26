Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVEZHEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVEZHEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVEZHEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:04:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32155 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261230AbVEZHED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:04:03 -0400
Date: Thu, 26 May 2005 08:04:38 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-ntfs-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: ntfs: remove redundant assignments
Message-ID: <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
References: <1117044875.9510.2.camel@localhost> <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk> <courier.42956AFA.00002502@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42956AFA.00002502@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 09:21:46AM +0300, Pekka J Enberg wrote:
> On Wed, 2005-05-25 at 22:10 +0100, Anton Altaparmakov wrote:
> >This is not.  memset(0) is not the same as = NULL IMO.  I don't care if 
> >the compiler thinks it is the same.  NULL does not have to be 0 so I 
> >prefer to initialize pointers explicitly to NULL.  Even more so since this 
> >code is not performance critical at all so I prefer clarity here.
> 
> I kind of figured out you were doing it on purpose. The fact is, NULL is 
> zero on _all_ Linux architectures. If it weren't, we'd have a lot of broken 
> code. Let me play the devils advocate here: why do you memset() (now 
> kcalloc()) in the first place? 

Oh, come on...

	ictx = kmalloc(sizeof(ntfs_index_context), GFP_NOFS);
	if (ictx)
		*ictx = (ntfs_index_context){.idx_ni = idx_ni};
	return ictx;

and be done with that.  Let compiler do its job.  And yes, that *will*
give properly initialized pointers even for weird platforms.  Not that
we had the slightest chance of porting to any of them...

> There's a simple reason why I don't like explicit assignments: it's way too 
> easy to forget to initialize something. 

So use the proper constructs.  Variant above is guaranteed to do the right
thing on any C99 compiler, provided that kmalloc() returns NULL or pointer
to object sufficiently large and properly aligned for ntfs_index_context.
All missing fields will be initialized the same way they would for initializer
of a static object.
