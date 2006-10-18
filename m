Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbWJRRxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWJRRxb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWJRRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:53:31 -0400
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:22007 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1751506AbWJRRxa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:53:30 -0400
Subject: Re: [xfs-masters] Re: [PATCH] fs/xfs: Handcrafted MIN/MAX macro
	removal
From: Russell Cattelan <cattelan@thebarn.com>
To: Amol Lad <amol@verismonetworks.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com
In-Reply-To: <1161169068.20400.149.camel@amol.verismonetworks.com>
References: <1161169068.20400.149.camel@amol.verismonetworks.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KJIyv+dAKFYNNReoTdXg"
Date: Wed, 18 Oct 2006 12:51:25 -0500
Message-Id: <1161193885.5723.168.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KJIyv+dAKFYNNReoTdXg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This change doesn't seem to do anything?

The existing macros already handle the types correctly,
are named such that it's obvious as to their purpose, so
it doesn't seem to make the code clearer.

This is also putting linux defined macros into the common
code and thereby creating more frustrations for the other XFS ports.


On Wed, 2006-10-18 at 16:27 +0530, Amol Lad wrote:
> Incroporated comments from Christoph Hellwig
>=20
> Cleanups done to use min/max macros from kernel.h. Handcrafted MIN/MAX
> macros are changed to use macros in kernel.h
>=20
> Tested using allmodconfig
>=20
> Signed-off-by: Amol Lad <amol@verismonetworks.com>
> ---
> Christoph,=20
>=20
> I'm going on vacation. If you have more comments, I'll take them after I
> come back after 5 days..
>=20
> Thanks
> ---
>  xfs_alloc.c   |   24 +++++++++++-------------
>  xfs_bmap.c    |   32 ++++++++++++++------------------
>  xfs_btree.h   |   29 -----------------------------
>  xfs_inode.c   |    2 +-
>  xfs_iomap.c   |    2 +-
>  xfs_rtalloc.c |   16 ++++++++--------
>  xfs_rtalloc.h |    3 ---
>  7 files changed, 35 insertions(+), 73 deletions(-)
> ---
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_alloc.c linux-2.6.19-rc2/fs/xfs/xfs_alloc.c
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_alloc.c	2006-10-18 09:29:18.00000000=
0 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_alloc.c	2006-10-18 16:13:44.000000000 +05=
30
> @@ -151,11 +151,11 @@ xfs_alloc_compute_diff(
>  		if (newbno1 >=3D freeend)
>  			newbno1 =3D NULLAGBLOCK;
>  		else
> -			newlen1 =3D XFS_EXTLEN_MIN(wantlen, freeend - newbno1);
> +			newlen1 =3D min_t(xfs_extlen_t, wantlen, freeend - newbno1);
>  		if (newbno2 < freebno)
>  			newbno2 =3D NULLAGBLOCK;
>  		else
> -			newlen2 =3D XFS_EXTLEN_MIN(wantlen, freeend - newbno2);
> +			newlen2 =3D min_t(xfs_extlen_t, wantlen, freeend - newbno2);
>  		if (newbno1 !=3D NULLAGBLOCK && newbno2 !=3D NULLAGBLOCK) {
>  			if (newlen1 < newlen2 ||
>  			    (newlen1 =3D=3D newlen2 &&
> @@ -686,7 +686,7 @@ xfs_alloc_ag_vextent_exact(
>  	 * End of extent will be smaller of the freespace end and the
>  	 * maximal requested end.
>  	 */
> -	end =3D XFS_AGBLOCK_MIN(fend, maxend);
> +	end =3D min_t(xfs_agblock_t, fend, maxend);
>  	/*
>  	 * Fix the length according to mod and prod if given.
>  	 */
> @@ -850,7 +850,7 @@ xfs_alloc_ag_vextent_near(
>  					args->alignment, args->minlen,
>  					&ltbnoa, &ltlena))
>  				continue;
> -			args->len =3D XFS_EXTLEN_MIN(ltlena, args->maxlen);
> +			args->len =3D min_t(xfs_extlen_t, ltlena, args->maxlen);
>  			xfs_alloc_fix_len(args);
>  			ASSERT(args->len >=3D args->minlen);
>  			if (args->len < blen)
> @@ -1007,7 +1007,7 @@ xfs_alloc_ag_vextent_near(
>  			/*
>  			 * Fix up the length.
>  			 */
> -			args->len =3D XFS_EXTLEN_MIN(ltlena, args->maxlen);
> +			args->len =3D min_t(xfs_extlen_t, ltlena, args->maxlen);
>  			xfs_alloc_fix_len(args);
>  			rlen =3D args->len;
>  			ltdiff =3D xfs_alloc_compute_diff(args->agbno, rlen,
> @@ -1045,8 +1045,7 @@ xfs_alloc_ag_vextent_near(
>  					 */
>  					if (gtlena >=3D args->minlen) {
>  						args->len =3D
> -							XFS_EXTLEN_MIN(gtlena,
> -								args->maxlen);
> +							min_t(xfs_extlen_t, gtlena, args->maxlen);
>  						xfs_alloc_fix_len(args);
>  						rlen =3D args->len;
>  						gtdiff =3D xfs_alloc_compute_diff(
> @@ -1104,7 +1103,7 @@ xfs_alloc_ag_vextent_near(
>  			/*
>  			 * Fix up the length.
>  			 */
> -			args->len =3D XFS_EXTLEN_MIN(gtlena, args->maxlen);
> +			args->len =3D min_t(xfs_extlen_t, gtlena, args->maxlen);
>  			xfs_alloc_fix_len(args);
>  			rlen =3D args->len;
>  			gtdiff =3D xfs_alloc_compute_diff(args->agbno, rlen,
> @@ -1141,8 +1140,7 @@ xfs_alloc_ag_vextent_near(
>  					 * compare the two and pick the best.
>  					 */
>  					if (ltlena >=3D args->minlen) {
> -						args->len =3D XFS_EXTLEN_MIN(
> -							ltlena, args->maxlen);
> +						args->len =3D min_t(xfs_extlen_t, ltlena, args->maxlen);
>  						xfs_alloc_fix_len(args);
>  						rlen =3D args->len;
>  						ltdiff =3D xfs_alloc_compute_diff(
> @@ -1221,7 +1219,7 @@ xfs_alloc_ag_vextent_near(
>  	 * Fix up the length and compute the useful address.
>  	 */
>  	ltend =3D ltbno + ltlen;
> -	args->len =3D XFS_EXTLEN_MIN(ltlena, args->maxlen);
> +	args->len =3D min_t(xfs_extlen_t, ltlena, args->maxlen);
>  	xfs_alloc_fix_len(args);
>  	if (!xfs_alloc_fix_minleft(args)) {
>  		TRACE_ALLOC("nominleft", args);
> @@ -1320,7 +1318,7 @@ xfs_alloc_ag_vextent_size(
>  	 */
>  	xfs_alloc_compute_aligned(fbno, flen, args->alignment, args->minlen,
>  		&rbno, &rlen);
> -	rlen =3D XFS_EXTLEN_MIN(args->maxlen, rlen);
> +	rlen =3D min_t(xfs_extlen_t, args->maxlen, rlen);
>  	XFS_WANT_CORRUPTED_GOTO(rlen =3D=3D 0 ||
>  			(rlen <=3D flen && rbno + rlen <=3D fbno + flen), error0);
>  	if (rlen < args->maxlen) {
> @@ -1346,7 +1344,7 @@ xfs_alloc_ag_vextent_size(
>  				break;
>  			xfs_alloc_compute_aligned(fbno, flen, args->alignment,
>  				args->minlen, &rbno, &rlen);
> -			rlen =3D XFS_EXTLEN_MIN(args->maxlen, rlen);
> +			rlen =3D min_t(xfs_extlen_t, args->maxlen, rlen);
>  			XFS_WANT_CORRUPTED_GOTO(rlen =3D=3D 0 ||
>  				(rlen <=3D flen && rbno + rlen <=3D fbno + flen),
>  				error0);
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_bmap.c linux-2.6.19-rc2/fs/xfs/xfs_bmap.c
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_bmap.c	2006-10-18 09:29:18.000000000=
 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_bmap.c	2006-10-18 16:17:59.000000000 +053=
0
> @@ -1005,7 +1005,7 @@ xfs_bmap_add_extent_delay_real(
>  					LEFT.br_state)))
>  				goto done;
>  		}
> -		temp =3D XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
> +		temp =3D min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
>  			STARTBLOCKVAL(PREV.br_startblock));
>  		xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
>  		xfs_bmap_trace_post_update(fname, "LF|LC", ip, idx,
> @@ -1054,7 +1054,7 @@ xfs_bmap_add_extent_delay_real(
>  			if (error)
>  				goto done;
>  		}
> -		temp =3D XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
> +		temp =3D min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
>  			STARTBLOCKVAL(PREV.br_startblock) -
>  			(cur ? cur->bc_private.b.allocated : 0));
>  		ep =3D xfs_iext_get_ext(ifp, idx + 1);
> @@ -1101,7 +1101,7 @@ xfs_bmap_add_extent_delay_real(
>  					RIGHT.br_state)))
>  				goto done;
>  		}
> -		temp =3D XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
> +		temp =3D min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
>  			STARTBLOCKVAL(PREV.br_startblock));
>  		xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
>  		xfs_bmap_trace_post_update(fname, "RF|RC", ip, idx,
> @@ -1149,7 +1149,7 @@ xfs_bmap_add_extent_delay_real(
>  			if (error)
>  				goto done;
>  		}
> -		temp =3D XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
> +		temp =3D min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp),
>  			STARTBLOCKVAL(PREV.br_startblock) -
>  			(cur ? cur->bc_private.b.allocated : 0));
>  		ep =3D xfs_iext_get_ext(ifp, idx);
> @@ -3186,8 +3186,7 @@ xfs_bmap_del_extent(
>  		xfs_bmbt_set_blockcount(ep, temp);
>  		ifp->if_lastex =3D idx;
>  		if (delay) {
> -			temp =3D XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
> -				da_old);
> +			temp =3D min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp), da_old=
);
>  			xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
>  			xfs_bmap_trace_post_update(fname, "2", ip, idx,
>  				whichfork);
> @@ -3215,8 +3214,7 @@ xfs_bmap_del_extent(
>  		xfs_bmbt_set_blockcount(ep, temp);
>  		ifp->if_lastex =3D idx;
>  		if (delay) {
> -			temp =3D XFS_FILBLKS_MIN(xfs_bmap_worst_indlen(ip, temp),
> -				da_old);
> +			temp =3D min_t(xfs_filblks_t, xfs_bmap_worst_indlen(ip, temp), da_old=
);
>  			xfs_bmbt_set_startblock(ep, NULLSTARTBLOCK((int)temp));
>  			xfs_bmap_trace_post_update(fname, "1", ip, idx,
>  				whichfork);
> @@ -4346,7 +4344,7 @@ xfs_bmap_first_unused(
>  			return 0;
>  		}
>  		lastaddr =3D off + xfs_bmbt_get_blockcount(ep);
> -		max =3D XFS_FILEOFF_MAX(lastaddr, lowest);
> +		max =3D max_t(xfs_fileoff_t, lastaddr, lowest);
>  	}
>  	*first_unused =3D max;
>  	return 0;
> @@ -4861,17 +4859,15 @@ xfs_bmapi(
>  				}
>  			} else if (wasdelay) {
>  				alen =3D (xfs_extlen_t)
> -					XFS_FILBLKS_MIN(len,
> -						(got.br_startoff +
> -						 got.br_blockcount) - bno);
> +					min_t(xfs_filblks_t, len,
> +						(got.br_startoff + got.br_blockcount) - bno);
>  				aoff =3D bno;
>  			} else {
>  				alen =3D (xfs_extlen_t)
> -					XFS_FILBLKS_MIN(len, MAXEXTLEN);
> +					min_t(xfs_filblks_t, len, MAXEXTLEN);
>  				if (!eof)
>  					alen =3D (xfs_extlen_t)
> -						XFS_FILBLKS_MIN(alen,
> -							got.br_startoff - bno);
> +						min_t(xfs_filblks_t, alen, got.br_startoff - bno);
>  				aoff =3D bno;
>  			}
>  			minlen =3D (flags & XFS_BMAPI_CONTIG) ? alen : 1;
> @@ -5098,7 +5094,7 @@ xfs_bmapi(
>  			mval->br_startoff =3D bno;
>  			mval->br_startblock =3D HOLESTARTBLOCK;
>  			mval->br_blockcount =3D
> -				XFS_FILBLKS_MIN(len, got.br_startoff - bno);
> +				min_t(xfs_filblks_t, len, got.br_startoff - bno);
>  			mval->br_state =3D XFS_EXT_NORM;
>  			bno +=3D mval->br_blockcount;
>  			len -=3D mval->br_blockcount;
> @@ -5133,7 +5129,7 @@ xfs_bmapi(
>  			 * didn't overlap what was asked for.
>  			 */
>  			mval->br_blockcount =3D
> -				XFS_FILBLKS_MIN(end - bno, got.br_blockcount -
> +				min_t(xfs_filblks_t, end - bno, got.br_blockcount -
>  					(bno - got.br_startoff));
>  			mval->br_state =3D got.br_state;
>  			ASSERT(mval->br_blockcount <=3D len);
> @@ -5473,7 +5469,7 @@ xfs_bunmapi(
>  		 * Is the last block of this extent before the range
>  		 * we're supposed to delete?  If so, we're done.
>  		 */
> -		bno =3D XFS_FILEOFF_MIN(bno,
> +		bno =3D min_t(xfs_fileoff_t, bno,
>  			got.br_startoff + got.br_blockcount - 1);
>  		if (bno < start)
>  			break;
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_btree.h linux-2.6.19-rc2/fs/xfs/xfs_btree.h
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_btree.h	2006-10-18 09:29:18.00000000=
0 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_btree.h	2006-10-18 15:56:01.000000000 +05=
30
> @@ -440,35 +440,6 @@ xfs_btree_setbuf(
> =20
>  #endif	/* __KERNEL__ */
> =20
> -
> -/*
> - * Min and max functions for extlen, agblock, fileoff, and filblks types=
.
> - */
> -#define	XFS_EXTLEN_MIN(a,b)	\
> -	((xfs_extlen_t)(a) < (xfs_extlen_t)(b) ? \
> -		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
> -#define	XFS_EXTLEN_MAX(a,b)	\
> -	((xfs_extlen_t)(a) > (xfs_extlen_t)(b) ? \
> -		(xfs_extlen_t)(a) : (xfs_extlen_t)(b))
> -#define	XFS_AGBLOCK_MIN(a,b)	\
> -	((xfs_agblock_t)(a) < (xfs_agblock_t)(b) ? \
> -		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
> -#define	XFS_AGBLOCK_MAX(a,b)	\
> -	((xfs_agblock_t)(a) > (xfs_agblock_t)(b) ? \
> -		(xfs_agblock_t)(a) : (xfs_agblock_t)(b))
> -#define	XFS_FILEOFF_MIN(a,b)	\
> -	((xfs_fileoff_t)(a) < (xfs_fileoff_t)(b) ? \
> -		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
> -#define	XFS_FILEOFF_MAX(a,b)	\
> -	((xfs_fileoff_t)(a) > (xfs_fileoff_t)(b) ? \
> -		(xfs_fileoff_t)(a) : (xfs_fileoff_t)(b))
> -#define	XFS_FILBLKS_MIN(a,b)	\
> -	((xfs_filblks_t)(a) < (xfs_filblks_t)(b) ? \
> -		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
> -#define	XFS_FILBLKS_MAX(a,b)	\
> -	((xfs_filblks_t)(a) > (xfs_filblks_t)(b) ? \
> -		(xfs_filblks_t)(a) : (xfs_filblks_t)(b))
> -
>  #define	XFS_FSB_SANITY_CHECK(mp,fsb)	\
>  	(XFS_FSB_TO_AGNO(mp, fsb) < mp->m_sb.sb_agcount && \
>  		XFS_FSB_TO_AGBNO(mp, fsb) < mp->m_sb.sb_agblocks)
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_inode.c linux-2.6.19-rc2/fs/xfs/xfs_inode.c
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_inode.c	2006-10-18 09:29:18.00000000=
0 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_inode.c	2006-10-18 16:18:41.000000000 +05=
30
> @@ -1342,7 +1342,7 @@ xfs_file_last_byte(
>  		last_block =3D 0;
>  	}
>  	size_last_block =3D XFS_B_TO_FSB(mp, (xfs_ufsize_t)ip->i_d.di_size);
> -	last_block =3D XFS_FILEOFF_MAX(last_block, size_last_block);
> +	last_block =3D max_t(xfs_fileoff_t, last_block, size_last_block);
> =20
>  	last_byte =3D XFS_FSB_TO_B(mp, last_block);
>  	if (last_byte < 0) {
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_iomap.c linux-2.6.19-rc2/fs/xfs/xfs_iomap.c
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_iomap.c	2006-10-18 09:29:18.00000000=
0 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_iomap.c	2006-10-18 15:54:13.000000000 +05=
30
> @@ -822,7 +822,7 @@ xfs_iomap_write_allocate(
>  			end_fsb =3D XFS_B_TO_FSB(mp, ip->i_d.di_size);
>  			xfs_bmap_last_offset(NULL, ip, &last_block,
>  				XFS_DATA_FORK);
> -			last_block =3D XFS_FILEOFF_MAX(last_block, end_fsb);
> +			last_block =3D max_t(xfs_fileoff_t,last_block, end_fsb);
>  			if ((map_start_fsb + count_fsb) > last_block) {
>  				count_fsb =3D last_block - map_start_fsb;
>  				if (count_fsb =3D=3D 0) {
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_rtalloc.c linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.c
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.c	2006-10-18 09:29:18.000000=
000 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.c	2006-10-18 16:06:37.000000000 +=
0530
> @@ -699,8 +699,8 @@ xfs_rtallocate_extent_size(
>  			 * this summary level.
>  			 */
>  			error =3D xfs_rtallocate_extent_block(mp, tp, i,
> -					XFS_RTMAX(minlen, 1 << l),
> -					XFS_RTMIN(maxlen, (1 << (l + 1)) - 1),
> +					max_t(xfs_extlen_t, minlen, 1 << l),
> +					min_t(xfs_extlen_t, maxlen, (1 << (l + 1)) - 1),
>  					len, &n, rbpp, rsb, prod, &r);
>  			if (error) {
>  				return error;
> @@ -1020,7 +1020,7 @@ xfs_rtcheck_range(
>  		/*
>  		 * Compute first bit not examined.
>  		 */
> -		lastbit =3D XFS_RTMIN(bit + len, XFS_NBWORD);
> +		lastbit =3D min_t(xfs_extlen_t, bit + len, XFS_NBWORD);
>  		/*
>  		 * Mask of relevant bits.
>  		 */
> @@ -1238,7 +1238,7 @@ xfs_rtfind_back(
>  		 * Calculate first (leftmost) bit number to look at,
>  		 * and mask for all the relevant bits in this word.
>  		 */
> -		firstbit =3D XFS_RTMAX((xfs_srtblock_t)(bit - len + 1), 0);
> +		firstbit =3D max_t(xfs_srtblock_t, bit - len + 1, 0);
>  		mask =3D (((xfs_rtword_t)1 << (bit - firstbit + 1)) - 1) <<
>  			firstbit;
>  		/*
> @@ -1413,7 +1413,7 @@ xfs_rtfind_forw(
>  		 * Calculate last (rightmost) bit number to look at,
>  		 * and mask for all the relevant bits in this word.
>  		 */
> -		lastbit =3D XFS_RTMIN(bit + len, XFS_NBWORD);
> +		lastbit =3D min_t(xfs_rtblock_t, bit + len, XFS_NBWORD);
>  		mask =3D (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
>  		/*
>  		 * Calculate the difference between the value there
> @@ -1724,7 +1724,7 @@ xfs_rtmodify_range(
>  		/*
>  		 * Compute first bit not changed and mask of relevant bits.
>  		 */
> -		lastbit =3D XFS_RTMIN(bit + len, XFS_NBWORD);
> +		lastbit =3D min_t(xfs_extlen_t, bit + len, XFS_NBWORD);
>  		mask =3D (((xfs_rtword_t)1 << (lastbit - bit)) - 1) << bit;
>  		/*
>  		 * Set/clear the active bits.
> @@ -1998,7 +1998,7 @@ xfs_growfs_rt(
>  		nsbp->sb_rextsize =3D in->extsize;
>  		nsbp->sb_rbmblocks =3D bmbno + 1;
>  		nsbp->sb_rblocks =3D
> -			XFS_RTMIN(nrblocks,
> +			min_t(xfs_drfsbno_t, nrblocks,
>  				  nsbp->sb_rbmblocks * NBBY *
>  				  nsbp->sb_blocksize * nsbp->sb_rextsize);
>  		nsbp->sb_rextents =3D nsbp->sb_rblocks;
> @@ -2424,7 +2424,7 @@ xfs_rtprint_summary(
>  			if (c) {
>  				if (!p) {
>  					cmn_err(CE_DEBUG, "%Ld-%Ld:", 1LL << l,
> -						XFS_RTMIN((1LL << l) +
> +						min((1LL << l) +
>  							  ((1LL << l) - 1LL),
>  							 mp->m_sb.sb_rextents));
>  					p =3D 1;
> diff -uprN -X linux-2.6.19-rc2-orig/Documentation/dontdiff linux-2.6.19-r=
c2-orig/fs/xfs/xfs_rtalloc.h linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.h
> --- linux-2.6.19-rc2-orig/fs/xfs/xfs_rtalloc.h	2006-08-24 02:46:33.000000=
000 +0530
> +++ linux-2.6.19-rc2/fs/xfs/xfs_rtalloc.h	2006-10-18 15:46:53.000000000 +=
0530
> @@ -57,9 +57,6 @@ struct xfs_trans;
>  #define	XFS_BITTOWORD(mp,bi)	\
>  	((int)(((bi) >> XFS_NBWORDLOG) & XFS_BLOCKWMASK(mp)))
> =20
> -#define	XFS_RTMIN(a,b)	((a) < (b) ? (a) : (b))
> -#define	XFS_RTMAX(a,b)	((a) > (b) ? (a) : (b))
> -
>  #define	XFS_RTLOBIT(w)	xfs_lowbit32(w)
>  #define	XFS_RTHIBIT(w)	xfs_highbit32(w)
> =20
>=20

--=20
Russell Cattelan <cattelan@thebarn.com>

--=-KJIyv+dAKFYNNReoTdXg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFNmmdNRmM+OaGhBgRAvdSAJ9fMLgGBneq5ZJR3+dV9rYw1oNTygCdHFV2
YN8wd5iesE0xMwGbzczHTkc=
=4GrX
-----END PGP SIGNATURE-----

--=-KJIyv+dAKFYNNReoTdXg--

