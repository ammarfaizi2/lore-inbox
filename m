Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbTILU0h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTILU0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:26:37 -0400
Received: from mail3.cc.huji.ac.il ([132.64.1.21]:492 "EHLO
	mail3.cc.huji.ac.il") by vger.kernel.org with ESMTP id S261913AbTILU0d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:26:33 -0400
Date: Sat, 13 Sep 2003 02:29:09 +0300
From: Voicu Liviu <pacman@mscc.huji.ac.il>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test5-mm1
Message-Id: <20030913022909.3a18f6fa.pacman@mscc.huji.ac.il>
In-Reply-To: <20030912112436.03ba9dd1.akpm@osdl.org>
References: <3F61C062.1080700@mscc.huji.ac.il>
	<20030912112436.03ba9dd1.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Ft1Ivv69rt_SQx"
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.14; VAE: 6.21.0.1; VDF: 6.21.0.41; host: mail3.cc.huji.ac.il)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Ft1Ivv69rt_SQx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thank you, I have found the problem, my sound card is Ensoniq ES1371 so the module should be snd_ens1371 but I used to load by mistake snd_ens1370 so I got the OOPS all the time, I fixed the alsa-config and now all works.
Liviu

On Fri, 12 Sep 2003 11:24:36 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Voicu Liviu <pacman@mscc.huji.ac.il> wrote:
> >
> > This happens after I load alsa modules on boot..............
> > 
> > <from_dmesg>
> > 
> > Freeing unused kernel memory: 308k freed
> > Adding 313228k swap on /dev/hda6.  Priority:-1 extents:1
> > PCI: Found IRQ 5 for device 0000:00:09.0
> > PCI: Sharing IRQ 5 with 0000:00:04.2
> > Unable to handle kernel paging request at virtual address ffffffef
> 
> 
> diff -puN fs/sysfs/dir.c~sysfs-create_dir-oops-fix fs/sysfs/dir.c
> --- 25/fs/sysfs/dir.c~sysfs-create_dir-oops-fix	Wed Sep 10 15:46:50 2003
> +++ 25-akpm/fs/sysfs/dir.c	Wed Sep 10 15:46:50 2003
> @@ -24,10 +24,11 @@ static int init_dir(struct inode * inode
>  static struct dentry * 
>  create_dir(struct kobject * k, struct dentry * p, const char * n)
>  {
> -	struct dentry * dentry;
> +	struct dentry *dentry, *ret;
>  
>  	down(&p->d_inode->i_sem);
>  	dentry = sysfs_get_dentry(p,n);
> +	ret = dentry;
>  	if (!IS_ERR(dentry)) {
>  		int error = sysfs_create(dentry,
>  					 S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO,
> @@ -36,11 +37,11 @@ create_dir(struct kobject * k, struct de
>  			dentry->d_fsdata = k;
>  			p->d_inode->i_nlink++;
>  		} else
> -			dentry = ERR_PTR(error);
> +			ret = ERR_PTR(error);
>  		dput(dentry);
>  	}
>  	up(&p->d_inode->i_sem);
> -	return dentry;
> +	return ret;
>  }
>  
>  
> 
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Liviu Voicu
Assistant Programmer and network support
Computation Center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: "Liviu Voicu"<pacman@mscc.huji.ac.il>

/**
 * cat /usr/src/linux/arch/i386/boot/bzImage > /dev/dsp
 * ( and the voice of God will be heard! )
 *
 */

Click here to see my GPG signature:
----------------------------------
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List

--=.Ft1Ivv69rt_SQx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/YlbJkj4I0Et8EMgRApK4AKCtJGHUj8mXqCPBq92jk5GRiWlYPwCgzJoB
4TGcrXIKBZ/VTFZc6inQwd0=
=Gs1a
-----END PGP SIGNATURE-----

--=.Ft1Ivv69rt_SQx--
