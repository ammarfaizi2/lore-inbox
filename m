Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbVEIS4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbVEIS4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 14:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVEIS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 14:56:21 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:3604 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261496AbVEIS4K convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 14:56:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NrtYS9nhSe3dfc6m7eeD6yDoUbQzEHmIjoIZJs3gfl0Zw/M2N6YSkCBpGP0l1HDPxk+I++WE9Tr7JLqxehdIXPJDOYwY+u2FY9s6DLTmYtH8j+ZjGLtlOeHr2UkZlNm3Czgvul94fr2Exm9ZuuKW1beOUYo+YBWqwvxm1h0ggq8=
Message-ID: <2cd57c9005050911561b9b987@mail.gmail.com>
Date: Tue, 10 May 2005 02:56:10 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@lovecn.org
To: Robert Love <rml@novell.com>
Subject: Re: [patch] updated inotify.
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       John McCutchan <ttb@tentacle.dhs.org>
In-Reply-To: <1115661400.6734.149.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115654707.6734.134.camel@betsy>
	 <2cd57c90050509104363efed0e@mail.gmail.com>
	 <1115661400.6734.149.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Robert Love <rml@novell.com> wrote:
> On Tue, 2005-05-10 at 01:43 +0800, Coywolf Qi Hunt wrote:
> 
> > Here's another compile warning, also in the current -mm tree.
> >
> > > diff -urN linux-2.6.12-rc4/fs/namei.c linux/fs/namei.c
> > > --- linux-2.6.12-rc4/fs/namei.c 2005-05-09 11:52:48.000000000 -0400
> > > +++ linux/fs/namei.c    2005-05-09 11:58:52.000000000 -0400
> >
> > ..
> >
> > > @@ -2172,18 +2174,18 @@
> > >         DQUOT_INIT(old_dir);
> > >         DQUOT_INIT(new_dir);
> > >
> > > +       old_name = fsnotify_oldname_init(old_dentry->d_name.name);
> > > +
> >
> > prodigy:/home/coywolf/2.6.12-rc3-mm3-cy# make fs/namei.o
> >   CC      fs/namei.o
> > /home/coywolf/2.6.12-rc3-mm3-cy/fs/namei.c: In function `vfs_rename':
> > /home/coywolf/2.6.12-rc3-mm3-cy/fs/namei.c:2177: warning: passing arg
> > 1 of `fsnotify_oldname_init' from incompatible pointer type

I didn't understand the warning correctly. unsighned char* and char*
are compatible.
gcc has no problem in casting char* to unsighned char*.

In 2.6.12-rc3-mm3, the placeholder version,
static inline char *fsnotify_oldname_init(struct dentry *old_dentry)
is incompatible to char*, thus the warning.

This warning is fixed in the previous patch.  It''s not necessary for
this update. Better change it back to keep the placeholder one and the
real.one of the same declaration.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
