Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135280AbRDLTiu>; Thu, 12 Apr 2001 15:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135279AbRDLTgf>; Thu, 12 Apr 2001 15:36:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3081 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135271AbRDLTfo>; Thu, 12 Apr 2001 15:35:44 -0400
Date: Thu, 12 Apr 2001 14:53:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode() broken?
In-Reply-To: <Pine.LNX.4.31.0104121228550.20191-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0104121451180.3059-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Apr 2001, Linus Torvalds wrote:

> On Thu, 12 Apr 2001, Marcelo Tosatti wrote:
> >
> > Comments?
> >
> > --- fs/inode.c~	Thu Mar 22 16:04:13 2001
> > +++ fs/inode.c	Thu Apr 12 15:18:22 2001
> > @@ -347,6 +347,11 @@
> >  #endif
> >
> >  	spin_lock(&inode_lock);
> > +	while (inode->i_state & I_LOCK) {
> > +		spin_unlock(&inode_lock);
> > +		__wait_on_inode(inode);
> > +		spin_lock(&inode_lock);
> > +	}
> >  	if (!(inode->i_state & I_DIRTY))
> >  		goto out;
> >  	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
> 
> Ehh.
> 
> Why not just lock the inode around the thing?
> 
> The above looks rather ugly.

You mean writing a function called "lock_inode()" or whatever to basically
do what I did ? 



