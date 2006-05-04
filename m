Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWEDPAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWEDPAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWEDPAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:00:47 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:13636 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751491AbWEDPAq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:00:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QtzMjLoahmxxW/bEbq8giToy0RBZ1WicFeUOjLte5d668Eyns4UuLoZLrSW81gK+XrZGp/d8U9Xqif4gF0E2D/7TTZ1k4cvKvtwDWehJ30ASdDobus+aX3Tdf5zQHutTeDJbgi2JnttnU3cWyJwjLjQ6677Yz+0u6elHrYMTTW8=
Message-ID: <afcef88a0605040800t42a24f5h539a117b54a9740@mail.gmail.com>
Date: Thu, 4 May 2006 10:00:45 -0500
From: "Michael Thompson" <michael.craig.thompson@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033829.GE28613@hellewell.homeip.net>
	 <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi Phillip,
>
> Some comments below.
>
> On 5/4/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> > +kmem_cache_t *ecryptfs_inode_info_cache;
>
> Please use struct kmem_cache instead of the typedef.

Please explain why. Looking at the source shows that kmem_cache_t is
more widely used, and therefore seems to be the prefered way.

> > +       ecryptfs_printk(KERN_DEBUG, "Exit\n");
> > +}
> > +
> > +/**
> > + * Set up the ecryptfs inode.
> > + */
> > +static void ecryptfs_read_inode(struct inode *inode)
> > +{
> > +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
> > +       /* This is where we setup the self-reference in the vfs_inode's
> > +        * u.generic_ip. That way we don't have to walk the list again. */
> > +       ECRYPTFS_INODE_TO_PRIVATE_SM(inode) =
> > +               list_entry(inode, struct ecryptfs_inode_info, vfs_inode);
> > +       ECRYPTFS_INODE_TO_LOWER(inode) = NULL;
>
> Hmm, ugly, please make the setters explicit instead.

Curious, what exactly do you mean by this? I'm not sure what you mean
by "setters".

--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security
