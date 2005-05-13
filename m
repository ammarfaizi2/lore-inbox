Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVEMRP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVEMRP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 13:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262441AbVEMRP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 13:15:26 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:30982 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262442AbVEMROx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 13:14:53 -0400
To: linuxram@us.ibm.com
CC: jamie@shareable.org, ericvh@gmail.com, 7eggert@gmx.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <1116003238.6248.367.camel@localhost> (message from Ram on Fri,
	13 May 2005 09:53:58 -0700)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <20050511170700.GC2141@mail.shareable.org>
	 <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
	 <1115840139.6248.181.camel@localhost>
	 <20050511212810.GD5093@mail.shareable.org>
	 <1115851333.6248.225.camel@localhost>
	 <a4e6962a0505111558337dd903@mail.gmail.com>
	 <20050512010215.GB8457@mail.shareable.org>
	 <a4e6962a05051119181e53634e@mail.gmail.com>
	 <20050512064514.GA12315@mail.shareable.org>
	 <a4e6962a0505120623645c0947@mail.gmail.com>
	 <20050512151631.GA16310@mail.shareable.org>
	 <E1DWIms-0005nC-00@dorka.pomaz.szeredi.hu>
	 <1115946620.6248.299.camel@localhost> <1115969123.6248.336.camel@localhost>
	 <1115974780.6248.346.camel@localhost>
	 <E1DWWBo-00013Z-00@dorka.pomaz.szeredi.hu> <1116003238.6248.367.camel@localhost>
Message-Id: <E1DWdje-0004NL-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 May 2005 19:14:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  	dentry = file->f_dentry;
> > >  	mnt = file->f_vfsmnt;
> > >  	inode = dentry->d_inode;
> > > +	if(mnt->mnt_namespace != current->namespace)
> > > +		goto out_putf;
> > >  
> > >  	error = -ENOTDIR;
> > >  	if (!S_ISDIR(inode->i_mode))
> > > 
> > 
> > Does this actually fix the problem?  The open is done in the right
> > namespace, and mount() doesn't call open().
> 
> Right but this fix disallows fchdir into a directory belonging to
> a different namespace.  And hence would disallow the ability to
> cross mount across namespaces.

Ahh, sorry.  I thought that check was in open(), but I see now it's in
fchdir().  Next time please use '-p' option of diff, to avoid
confusing thoughtless readers like me :)

Though your patch does fix the bug, I still think it's wrong, since
mounting from a different namespace has legitimate uses, and is not a
security problem.

Miklos
