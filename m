Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbTCLNte>; Wed, 12 Mar 2003 08:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbTCLNte>; Wed, 12 Mar 2003 08:49:34 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:19719 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261651AbTCLNtd>; Wed, 12 Mar 2003 08:49:33 -0500
Date: Wed, 12 Mar 2003 13:59:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Message-ID: <20030312135954.A11564@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Torsten Foertsch <torsten.foertsch@gmx.net>,
	linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <20030312104741.A9625@infradead.org> <200303121404.04979.torsten.foertsch@gmx.net> <200303121432.51329.torsten.foertsch@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303121432.51329.torsten.foertsch@gmx.net>; from torsten.foertsch@gmx.net on Wed, Mar 12, 2003 at 02:32:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 02:32:47PM +0100, Torsten Foertsch wrote:
> 
> char*
> full_d_path( struct dentry *dentry,
> 	     struct vfsmount *vfsmnt,
> 	     char *buf, int buflen ) {
>   char *res;
>   struct vfsmount *rootmnt;
>   struct dentry *root;
>   struct namespace *ns;
> 
>   ns=current->namespace;
> /*   get_namespace( ns ); */

you want to keep this.

>   rootmnt=mntget( ns->root );
> /*   put_namespace( ns ); */

do the put once you're completly done with it

> 
>   root = dget(rootmnt->mnt_root);
> 
>   spin_lock(&dcache_lock);
>   res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
>   spin_unlock(&dcache_lock);
> 
>   dput(root);
>   mntput(rootmnt);
>   return res;

looks okay to me otherwise.

