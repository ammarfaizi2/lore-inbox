Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbWEYN3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbWEYN3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 09:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWEYN3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 09:29:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:22740 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965174AbWEYN3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 09:29:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:organization:user-agent;
        b=R1irlIg4QtSCTq/hfleHUjYxvKExtYv2JCv6XcO6o42X84fMp6Ai1njK14G2h8kpADgUp8T2V7MfcEmOeLEGwoQdZF+JRTh2/ht7adxIErde+r2ks1X6q491C5s6cUUIL51EvscSJBWZdJPmqFCzjR5bId0dAE5N6MZHa+MgaSk=
Date: Thu, 25 May 2006 21:29:15 +0800
From: Limin Wang <lance.lmwang@gmail.com>
To: sho@tnes.nec.co.jp
Cc: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [UPDATE][1/24]ext3 block allocation/reservation fixes to support 2^32 blocks
Message-ID: <20060525132914.GA9943@laptop.exavio.cn>
Mail-Followup-To: sho@tnes.nec.co.jp, adilger@clusterfs.com, cmm@us.ibm.com,
	jitendra@linsyssoft.com, ext2-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20060525214011sho@rifu.tnes.nec.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20060525214011sho@rifu.tnes.nec.co.jp>
Organization: Exavio.Inc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


See my comments in the lines.

Regards,
lmwang

* sho@tnes.nec.co.jp <sho@tnes.nec.co.jp> [2006-05-25 21:40:11 +0900]:

> Summary of this patch:
>   [1/24]  modify around the block allocation code(ext3)
>           - Modify around the ext3 block allocation code to replace
>             "int" type filesystem block number with "unsigned long".
>=20
> Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
> ---
> diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs=
/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
> --- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:18:35.848388909 +0900
> +++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:27:50.071038370 +=
0900
> @@ -223,7 +223,7 @@ void ext3_rsv_window_add(struct super_bl
>  {
>  	struct rb_root *root =3D &EXT3_SB(sb)->s_rsv_window_root;
>  	struct rb_node *node =3D &rsv->rsv_node;
> -	unsigned int start =3D rsv->rsv_start;
> +	unsigned long start =3D rsv->rsv_start;
> =20
>  	struct rb_node ** p =3D &root->rb_node;
>  	struct rb_node * parent =3D NULL;
> @@ -656,7 +656,8 @@ ext3_try_to_allocate(struct super_block=20
>  			struct buffer_head *bitmap_bh, int goal,
>  			unsigned long *count, struct ext3_reserve_window *my_rsv)
>  {
> -	int group_first_block, start, end;
> +	unsigned long group_first_block;
> +	int start, end;=20
unsigned long start, end;

start and end will get data from my_rcv, so it need use u32 also.

>  	unsigned long num =3D 0;
> =20
>  	/* we do allocation within the reservation window if we have a window */
> @@ -766,12 +767,13 @@ fail_access:
>  static int find_next_reservable_window(
>  				struct ext3_reserve_window_node *search_head,
>  				struct ext3_reserve_window_node *my_rsv,
> -				struct super_block * sb, int start_block,
> -				int last_block)
> +				struct super_block * sb,
> +				unsigned long start_block,
> +				unsigned long last_block)
>  {
>  	struct rb_node *next;
>  	struct ext3_reserve_window_node *rsv, *prev;
> -	int cur;
> +	unsigned long cur;
>  	int size =3D my_rsv->rsv_goal_size;
unsigned long size =3D my_rsv->rsv_goal_size;
=20


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iQEVAwUBRHWxKjS5KN/wlg3IAQLX+Qf+IHbg+QfhOXRIucmkMc7BLZLA2j1MxYVU
U9dAJ+UxLo2FbsXmvvffC/ahDQeHdsLQVMyj5kcrejcD0pUYXK93h2opuPbod52m
ShK/NNQbqfSApUET+z5cgFkl38soySfGeVseRqw0FVWfwaLFSeiQlLu5OC6hTpTW
gHiNfCz2gJevz/5+1yexkiRikowhIa4BTtpH2OBXzz0fjklnQPQpei+j2QlLQB7S
1qV+ywfq8U2l93QnyyDf7DpFDGeKSg1+r1h73FQuwnFGxc4F1sY+miIVJDfGr04h
3M7WF+1P98yBKaf6XCxoF/pyP3DBC2WqJg9JGneOEzX2UCLLYgYBgw==
=v+OH
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
