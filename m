Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVEXOJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVEXOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 10:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVEXOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 10:09:28 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:13418 "EHLO
	mailwasher.lanl.gov") by vger.kernel.org with ESMTP id S261338AbVEXOIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 10:08:55 -0400
Date: Tue, 24 May 2005 08:08:44 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: Pekka Enberg <penberg@gmail.com>
cc: "ericvh@gmail.com" <ericvh@gmail.com>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       penberg@cs.helsinki.fi
Subject: Re: [V9fs-developer] Re: [RFC][patch 3/7] v9fs: VFS inode operations
 (2.0-rc6)
In-Reply-To: <84144f0205052401432ffa1075@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0505240803410.9237@enigma.lanl.gov>
References: <200505232225.j4NMPmH9014347@ms-smtp-01-eri0.texas.rr.com>
 <84144f0205052401432ffa1075@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 May 2005, Pekka Enberg wrote:

> > +static int
> > +v9fs_vfs_create(struct inode *inode, struct dentry *dentry, int perm,
> > +		struct nameidata *nd)
> > +{
> > +	int retval = -EPERM;
> > +	int open_mode = O_RDWR;
> > +
> > +	retval = v9fs_create(inode, dentry, perm, open_mode);
> > +
> > +	return retval;

> 
> Both local variables are redundant. Please just do:
> 
> 	return v9fs_create(inode, dentry, perm, O_RDWR);
> 
well, here is my first point of disagreement with the many good 
suggestions I have seen. 

I prefer the style as it is, and dislike the return vfs_create(...) 
change. 

First, we're all agreed here that this is a style, not efficiency thing, 
right? Makes no difference, compiler will do what is right. 

The reason I prefer the 'retval = blah blah; return retval;' usage is that
I frequently have run v9fs in UML, and debugging is just easier. Set the
breakpoint in v9fs_vfs_create, step through, maybe skip over that
v9fs_create function, look at retval. Also, should we get to the point
later that we have a debug print of some sort in that function, adding it
is trivial.

I realize there is a preferred style here, but is there room for some 
flexibility?

thanks

ron
