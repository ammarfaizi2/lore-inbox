Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031660AbWLASPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031660AbWLASPq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 13:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759327AbWLASPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 13:15:45 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:34022 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1759325AbWLASPo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 13:15:44 -0500
Subject: Re: [GFS2] Shrink gfs2_inode (6) - di_atime/di_mtime/di_ctime
	[26/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <1164888987.3752.356.camel@quoit.chygwyn.com>
References: <1164888987.3752.356.camel@quoit.chygwyn.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5V6GlAOY79H0HA+Gfu+Y"
Date: Fri, 01 Dec 2006 12:15:34 -0600
Message-Id: <1164996934.1194.50.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5V6GlAOY79H0HA+Gfu+Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-30 at 12:16 +0000, Steven Whitehouse wrote:
> >From 1a7b1eed5802502fd649e04784becd58557fdcf1 Mon Sep 17 00:00:00 2001
> From: Steven Whitehouse <swhiteho@redhat.com>
> Date: Wed, 1 Nov 2006 14:35:17 -0500
> Subject: [PATCH] [GFS2] Shrink gfs2_inode (6) - di_atime/di_mtime/di_ctim=
e
>=20
> Remove the di_[amc]time fields and use inode->i_[amc]time
> fields instead. This saves 24 bytes from the gfs2_inode.

More of the data structure clean up work? That is=20
incomplete?


>=20
> Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
> ---
>  fs/gfs2/bmap.c              |   10 +++++-----
>  fs/gfs2/dir.c               |   10 +++++-----
>  fs/gfs2/eattr.c             |    9 ++++-----
>  fs/gfs2/inode.c             |   44 +++++++++++--------------------------=
------
>  fs/gfs2/inode.h             |    1 -
>  fs/gfs2/ondisk.c            |   10 +++-------
>  fs/gfs2/ops_address.c       |    4 ----
>  fs/gfs2/ops_inode.c         |    3 +--
>  include/linux/gfs2_ondisk.h |    3 ---
>  9 files changed, 29 insertions(+), 65 deletions(-)
>=20
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index 0c913ee..692d4a3 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -778,7 +778,7 @@ static int do_strip(struct gfs2_inode *i
>  			gfs2_free_data(ip, bstart, blen);
>  	}
> =20
> -	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_secon=
ds();
> =20
>  	gfs2_dinode_out(ip, dibh->b_data);
> =20
> @@ -853,7 +853,7 @@ static int do_grow(struct gfs2_inode *ip
>  	}
> =20
>  	ip->i_di.di_size =3D size;
> -	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_secon=
ds();
> =20
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  	if (error)
> @@ -968,7 +968,7 @@ static int trunc_start(struct gfs2_inode
> =20
>  	if (gfs2_is_stuffed(ip)) {
>  		ip->i_di.di_size =3D size;
> -		ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +		ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_seco=
nds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode) + size);
> @@ -980,7 +980,7 @@ static int trunc_start(struct gfs2_inode
> =20
>  		if (!error) {
>  			ip->i_di.di_size =3D size;
> -			ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +			ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_sec=
onds();
>  			ip->i_di.di_flags |=3D GFS2_DIF_TRUNC_IN_PROG;
>  			gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  			gfs2_dinode_out(ip, dibh->b_data);
> @@ -1053,7 +1053,7 @@ static int trunc_end(struct gfs2_inode *
>  			ip->i_num.no_addr;
>  		gfs2_buffer_clear_tail(dibh, sizeof(struct gfs2_dinode));
>  	}
> -	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_secon=
ds();
>  	ip->i_di.di_flags &=3D ~GFS2_DIF_TRUNC_IN_PROG;
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 0742761..ca23c8b 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -131,7 +131,7 @@ static int gfs2_dir_write_stuffed(struct
>  	memcpy(dibh->b_data + offset + sizeof(struct gfs2_dinode), buf, size);
>  	if (ip->i_di.di_size < offset + size)
>  		ip->i_di.di_size =3D offset + size;
> -	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_secon=
ds();
>  	gfs2_dinode_out(ip, dibh->b_data);
> =20
>  	brelse(dibh);
> @@ -229,7 +229,7 @@ out:
> =20
>  	if (ip->i_di.di_size < offset + copied)
>  		ip->i_di.di_size =3D offset + copied;
> -	ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_secon=
ds();
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(ip, dibh->b_data);
> @@ -1560,7 +1560,7 @@ int gfs2_dir_add(struct inode *inode, co
>  				break;
>  			gfs2_trans_add_bh(ip->i_gl, bh, 1);
>  			ip->i_di.di_entries++;
> -			ip->i_di.di_mtime =3D ip->i_di.di_ctime =3D get_seconds();
> +			ip->i_inode.i_mtime.tv_sec =3D ip->i_inode.i_ctime.tv_sec =3D get_sec=
onds();
>  			gfs2_dinode_out(ip, bh->b_data);
>  			brelse(bh);
>  			error =3D 0;
> @@ -1646,7 +1646,7 @@ int gfs2_dir_del(struct gfs2_inode *dip,
>  		gfs2_consist_inode(dip);
>  	gfs2_trans_add_bh(dip->i_gl, bh, 1);
>  	dip->i_di.di_entries--;
> -	dip->i_di.di_mtime =3D dip->i_di.di_ctime =3D get_seconds();
> +	dip->i_inode.i_mtime.tv_sec =3D dip->i_inode.i_ctime.tv_sec =3D get_sec=
onds();
>  	gfs2_dinode_out(dip, bh->b_data);
>  	brelse(bh);
>  	mark_inode_dirty(&dip->i_inode);
> @@ -1694,7 +1694,7 @@ int gfs2_dir_mvino(struct gfs2_inode *di
>  		gfs2_trans_add_bh(dip->i_gl, bh, 1);
>  	}
> =20
> -	dip->i_di.di_mtime =3D dip->i_di.di_ctime =3D get_seconds();
> +	dip->i_inode.i_mtime.tv_sec =3D dip->i_inode.i_ctime.tv_sec =3D get_sec=
onds();
>  	gfs2_dinode_out(dip, bh->b_data);
>  	brelse(bh);
>  	return 0;
> diff --git a/fs/gfs2/eattr.c b/fs/gfs2/eattr.c
> index 935cc9a..7dde847 100644
> --- a/fs/gfs2/eattr.c
> +++ b/fs/gfs2/eattr.c
> @@ -300,7 +300,7 @@ static int ea_dealloc_unstuffed(struct g
> =20
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  	if (!error) {
> -		ip->i_di.di_ctime =3D get_seconds();
> +		ip->i_inode.i_ctime.tv_sec =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
> @@ -715,7 +715,7 @@ static int ea_alloc_skeleton(struct gfs2
>  					    (er->er_mode & S_IFMT));
>  			ip->i_inode.i_mode =3D er->er_mode;
>  		}
> -		ip->i_di.di_ctime =3D get_seconds();
> +		ip->i_inode.i_ctime.tv_sec =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
> @@ -850,7 +850,7 @@ static int ea_set_simple_noalloc(struct=20
>  			(ip->i_inode.i_mode & S_IFMT) =3D=3D (er->er_mode & S_IFMT));
>  		ip->i_inode.i_mode =3D er->er_mode;
>  	}
> -	ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_ctime.tv_sec =3D get_seconds();
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(ip, dibh->b_data);
>  	brelse(dibh);
> @@ -1130,7 +1130,7 @@ static int ea_remove_stuffed(struct gfs2
> =20
>  	error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  	if (!error) {
> -		ip->i_di.di_ctime =3D get_seconds();
> +		ip->i_inode.i_ctime.tv_sec =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
> @@ -1285,7 +1285,6 @@ int gfs2_ea_acl_chmod(struct gfs2_inode=20
>  	if (!error) {
>  		error =3D inode_setattr(&ip->i_inode, attr);
>  		gfs2_assert_warn(GFS2_SB(&ip->i_inode), !error);
> -		gfs2_inode_attr_out(ip);
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 7112039..c22ae3c 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -52,12 +52,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
> =20
>  	inode->i_ino =3D ip->i_num.no_addr;
>  	i_size_write(inode, di->di_size);
> -	inode->i_atime.tv_sec =3D di->di_atime;
> -	inode->i_mtime.tv_sec =3D di->di_mtime;
> -	inode->i_ctime.tv_sec =3D di->di_ctime;
> -	inode->i_atime.tv_nsec =3D 0;
> -	inode->i_mtime.tv_nsec =3D 0;
> -	inode->i_ctime.tv_nsec =3D 0;
>  	inode->i_blocks =3D di->di_blocks <<
>  		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
> =20
> @@ -72,23 +66,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
>  		inode->i_flags &=3D ~S_APPEND;
>  }
> =20
> -/**
> - * gfs2_inode_attr_out - Copy attributes from VFS inode into the dinode
> - * @ip: The GFS2 inode
> - *
> - * Only copy out the attributes that we want the VFS layer
> - * to be able to modify.
> - */
> -
> -void gfs2_inode_attr_out(struct gfs2_inode *ip)
> -{
> -	struct inode *inode =3D &ip->i_inode;
> -	struct gfs2_dinode_host *di =3D &ip->i_di;
> -	di->di_atime =3D inode->i_atime.tv_sec;
> -	di->di_mtime =3D inode->i_mtime.tv_sec;
> -	di->di_ctime =3D inode->i_ctime.tv_sec;
> -}
> -
>  static int iget_test(struct inode *inode, void *opaque)
>  {
>  	struct gfs2_inode *ip =3D GFS2_I(inode);
> @@ -221,9 +198,12 @@ static int gfs2_dinode_in(struct gfs2_in
>  	ip->i_inode.i_nlink =3D be32_to_cpu(str->di_nlink);
>  	di->di_size =3D be64_to_cpu(str->di_size);
>  	di->di_blocks =3D be64_to_cpu(str->di_blocks);
> -	di->di_atime =3D be64_to_cpu(str->di_atime);
> -	di->di_mtime =3D be64_to_cpu(str->di_mtime);
> -	di->di_ctime =3D be64_to_cpu(str->di_ctime);
> +	ip->i_inode.i_atime.tv_sec =3D be64_to_cpu(str->di_atime);
> +	ip->i_inode.i_atime.tv_nsec =3D 0;
> +	ip->i_inode.i_mtime.tv_sec =3D be64_to_cpu(str->di_mtime);
> +	ip->i_inode.i_mtime.tv_nsec =3D 0;
> +	ip->i_inode.i_ctime.tv_sec =3D be64_to_cpu(str->di_ctime);
> +	ip->i_inode.i_ctime.tv_nsec =3D 0;
> =20
>  	di->di_goal_meta =3D be64_to_cpu(str->di_goal_meta);
>  	di->di_goal_data =3D be64_to_cpu(str->di_goal_data);
> @@ -360,7 +340,7 @@ int gfs2_change_nlink(struct gfs2_inode=20
>  	else
>  		drop_nlink(&ip->i_inode);
> =20
> -	ip->i_di.di_ctime =3D get_seconds();
> +	ip->i_inode.i_ctime.tv_sec =3D get_seconds();
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(ip, dibh->b_data);
> @@ -1224,7 +1204,7 @@ int gfs2_glock_nq_atime(struct gfs2_hold
>  		return 0;
> =20
>  	curtime =3D get_seconds();
> -	if (curtime - ip->i_di.di_atime >=3D quantum) {
> +	if (curtime - ip->i_inode.i_atime.tv_sec >=3D quantum) {
>  		gfs2_glock_dq(gh);
>  		gfs2_holder_reinit(LM_ST_EXCLUSIVE, gh->gh_flags & ~LM_FLAG_ANY,
>  				   gh);
> @@ -1236,7 +1216,7 @@ int gfs2_glock_nq_atime(struct gfs2_hold
>  		   trying to get exclusive lock. */
> =20
>  		curtime =3D get_seconds();
> -		if (curtime - ip->i_di.di_atime >=3D quantum) {
> +		if (curtime - ip->i_inode.i_atime.tv_sec >=3D quantum) {
>  			struct buffer_head *dibh;
>  			struct gfs2_dinode *di;
> =20
> @@ -1250,11 +1230,11 @@ int gfs2_glock_nq_atime(struct gfs2_hold
>  			if (error)
>  				goto fail_end_trans;
> =20
> -			ip->i_di.di_atime =3D curtime;
> +			ip->i_inode.i_atime.tv_sec =3D curtime;
> =20
>  			gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  			di =3D (struct gfs2_dinode *)dibh->b_data;
> -			di->di_atime =3D cpu_to_be64(ip->i_di.di_atime);
> +			di->di_atime =3D cpu_to_be64(ip->i_inode.i_atime.tv_sec);
>  			brelse(dibh);
> =20
>  			gfs2_trans_end(sdp);
> @@ -1375,8 +1355,6 @@ __gfs2_setattr_simple(struct gfs2_inode=20
>  	if (!error) {
>  		error =3D inode_setattr(&ip->i_inode, attr);
>  		gfs2_assert_warn(GFS2_SB(&ip->i_inode), !error);
> -		gfs2_inode_attr_out(ip);
> -
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
> diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
> index 69cbf98..54d584e 100644
> --- a/fs/gfs2/inode.h
> +++ b/fs/gfs2/inode.h
> @@ -26,7 +26,6 @@ static inline int gfs2_is_dir(struct gfs
>  }
> =20
>  void gfs2_inode_attr_in(struct gfs2_inode *ip);
> -void gfs2_inode_attr_out(struct gfs2_inode *ip);
>  struct inode *gfs2_inode_lookup(struct super_block *sb, struct gfs2_inum=
_host *inum, unsigned type);
>  struct inode *gfs2_ilookup(struct super_block *sb, struct gfs2_inum_host=
 *inum);
> =20
> diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
> index b4e354b..82003e8 100644
> --- a/fs/gfs2/ondisk.c
> +++ b/fs/gfs2/ondisk.c
> @@ -167,9 +167,9 @@ void gfs2_dinode_out(const struct gfs2_i
>  	str->di_nlink =3D cpu_to_be32(ip->i_inode.i_nlink);
>  	str->di_size =3D cpu_to_be64(di->di_size);
>  	str->di_blocks =3D cpu_to_be64(di->di_blocks);
> -	str->di_atime =3D cpu_to_be64(di->di_atime);
> -	str->di_mtime =3D cpu_to_be64(di->di_mtime);
> -	str->di_ctime =3D cpu_to_be64(di->di_ctime);
> +	str->di_atime =3D cpu_to_be64(ip->i_inode.i_atime.tv_sec);
> +	str->di_mtime =3D cpu_to_be64(ip->i_inode.i_mtime.tv_sec);
> +	str->di_ctime =3D cpu_to_be64(ip->i_inode.i_ctime.tv_sec);
> =20
>  	str->di_goal_meta =3D cpu_to_be64(di->di_goal_meta);
>  	str->di_goal_data =3D cpu_to_be64(di->di_goal_data);
> @@ -193,10 +193,6 @@ void gfs2_dinode_print(const struct gfs2
> =20
>  	printk(KERN_INFO "  di_size =3D %llu\n", (unsigned long long)di->di_siz=
e);
>  	printk(KERN_INFO "  di_blocks =3D %llu\n", (unsigned long long)di->di_b=
locks);
> -	printk(KERN_INFO "  di_atime =3D %lld\n", (long long)di->di_atime);
> -	printk(KERN_INFO "  di_mtime =3D %lld\n", (long long)di->di_mtime);
> -	printk(KERN_INFO "  di_ctime =3D %lld\n", (long long)di->di_ctime);
> -
>  	printk(KERN_INFO "  di_goal_meta =3D %llu\n", (unsigned long long)di->d=
i_goal_meta);
>  	printk(KERN_INFO "  di_goal_data =3D %llu\n", (unsigned long long)di->d=
i_goal_data);
> =20
> diff --git a/fs/gfs2/ops_address.c b/fs/gfs2/ops_address.c
> index 38b702a..5c3962c 100644
> --- a/fs/gfs2/ops_address.c
> +++ b/fs/gfs2/ops_address.c
> @@ -498,10 +498,6 @@ static int gfs2_commit_write(struct file
>  		di->di_size =3D cpu_to_be64(inode->i_size);
>  	}
> =20
> -	di->di_atime =3D cpu_to_be64(inode->i_atime.tv_sec);
> -	di->di_mtime =3D cpu_to_be64(inode->i_mtime.tv_sec);
> -	di->di_ctime =3D cpu_to_be64(inode->i_ctime.tv_sec);
> -
>  	brelse(dibh);
>  	gfs2_trans_end(sdp);
>  	if (al->al_requested) {
> diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
> index 06176de..585b43a 100644
> --- a/fs/gfs2/ops_inode.c
> +++ b/fs/gfs2/ops_inode.c
> @@ -729,7 +729,7 @@ static int gfs2_rename(struct inode *odi
>  		error =3D gfs2_meta_inode_buffer(ip, &dibh);
>  		if (error)
>  			goto out_end_trans;
> -		ip->i_di.di_ctime =3D get_seconds();
> +		ip->i_inode.i_ctime.tv_sec =3D get_seconds();
>  		gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  		gfs2_dinode_out(ip, dibh->b_data);
>  		brelse(dibh);
> @@ -915,7 +915,6 @@ static int setattr_chown(struct inode *i
> =20
>  	error =3D inode_setattr(inode, attr);
>  	gfs2_assert_warn(sdp, !error);
> -	gfs2_inode_attr_out(ip);
> =20
>  	gfs2_trans_add_bh(ip->i_gl, dibh, 1);
>  	gfs2_dinode_out(ip, dibh->b_data);
> diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
> index c61517b..7f5a4a1 100644
> --- a/include/linux/gfs2_ondisk.h
> +++ b/include/linux/gfs2_ondisk.h
> @@ -324,9 +324,6 @@ struct gfs2_dinode {
>  struct gfs2_dinode_host {
>  	__u64 di_size;	/* number of bytes in file */
>  	__u64 di_blocks;	/* number of blocks in file */
> -	__u64 di_atime;	/* time last accessed */
> -	__u64 di_mtime;	/* time last modified */
> -	__u64 di_ctime;	/* time last changed */
> =20
>  	/* This section varies from gfs1. Padding added to align with
>           * remainder of dinode
--=20
Russell Cattelan <cattelan@thebarn.com>

--=-5V6GlAOY79H0HA+Gfu+Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcHFGNRmM+OaGhBgRAnUlAJoCjpRW/3je3wms+P84/SOg80zMsQCbBbr7
HsQwI3zyjqkAUHjLfwHUzX8=
=clfY
-----END PGP SIGNATURE-----

--=-5V6GlAOY79H0HA+Gfu+Y--

