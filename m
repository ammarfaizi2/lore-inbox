Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWEDPMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWEDPMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWEDPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:12:40 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16350 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751499AbWEDPMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:12:39 -0400
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Thompson <michael.craig.thompson@gmail.com>
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
In-Reply-To: <afcef88a0605040800t42a24f5h539a117b54a9740@mail.gmail.com>
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
	 <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>
	 <afcef88a0605040800t42a24f5h539a117b54a9740@mail.gmail.com>
Date: Thu, 04 May 2006 18:12:37 +0300
Message-Id: <1146755557.11422.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > > +kmem_cache_t *ecryptfs_inode_info_cache;
> >
> > Please use struct kmem_cache instead of the typedef.

On Thu, 2006-05-04 at 10:00 -0500, Michael Thompson wrote:
> Please explain why. Looking at the source shows that kmem_cache_t is
> more widely used, and therefore seems to be the prefered way.

That's because the typedef is deprecated. See commit
2109a2d1b175dfcffbfdac693bdbe4c4ab62f11f "[PATCH] mm: rename
kmem_cache_s to kmem_cache".

> > > +/**
> > > + * Set up the ecryptfs inode.
> > > + */
> > > +static void ecryptfs_read_inode(struct inode *inode)
> > > +{
> > > +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
> > > +       /* This is where we setup the self-reference in the vfs_inode's
> > > +        * u.generic_ip. That way we don't have to walk the list again. */
> > > +       ECRYPTFS_INODE_TO_PRIVATE_SM(inode) =
> > > +               list_entry(inode, struct ecryptfs_inode_info, vfs_inode);
> > > +       ECRYPTFS_INODE_TO_LOWER(inode) = NULL;
> >
> > Hmm, ugly, please make the setters explicit instead.
> 
> Curious, what exactly do you mean by this? I'm not sure what you mean
> by "setters".

That

 +       ECRYPTFS_INODE_TO_LOWER(inode) = NULL;

should be either

         ecryptfs_set_lower_inode(inode, NULL);

or

         inode->lower = NULL;

