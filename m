Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263201AbTCLOqc>; Wed, 12 Mar 2003 09:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263202AbTCLOqc>; Wed, 12 Mar 2003 09:46:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:19020 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S263201AbTCLOqa> convert rfc822-to-8bit;
	Wed, 12 Mar 2003 09:46:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [2.4.19] How to get the path name of a struct dentry
Date: Wed, 12 Mar 2003 15:51:49 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200303121033.08560.torsten.foertsch@gmx.net> <200303121432.51329.torsten.foertsch@gmx.net> <20030312135954.A11564@infradead.org>
In-Reply-To: <20030312135954.A11564@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303121551.53736.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 12 March 2003 14:59, Christoph Hellwig wrote:
> >
> >   ns=current->namespace;
> > /*   get_namespace( ns ); */
>
> you want to keep this.

I commented it because I compile my code as a module and the inlined function 
put_namespace() calls umount_tree() that is not exported. So I have to copy 
it to my modules code.


>
> >   rootmnt=mntget( ns->root );
> > /*   put_namespace( ns ); */
>
> do the put once you're completly done with it
>
> >   root = dget(rootmnt->mnt_root);
> >
> >   spin_lock(&dcache_lock);
> >   res = __d_path(dentry, vfsmnt, root, rootmnt, buf, buflen);
> >   spin_unlock(&dcache_lock);
> >
> >   dput(root);
> >   mntput(rootmnt);

You mean put_namespace(ns) should go here?

> >   return res;
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+b0mJwicyCTir8T4RAnXHAJ9d3NVrT32iH3ct5ZZLCj3ZjU25vwCglvw5
A+nWzvgKOvjKc46J4jwmAPc=
=Hyot
-----END PGP SIGNATURE-----
