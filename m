Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWBYVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWBYVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWBYVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:48:27 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:9425 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750973AbWBYVs0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:48:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pD0wEBdR95w7OLnDi3yqBSTbuvAr5WcCXUdZSAdz9XrIi/AouAZHtHzKEHvIi8+KJ20Ay20S5lBpr11ycTuxwGY7RZfQl9ZgqD3K8hI65p1MNyssW94YG7pKNHyemb0v60oDXcx9vToF3B0B43+46auxtrBCJLVsZDJvs0GXMus=
Message-ID: <84144f020602251348t3ea1420du4e84ac012e9d7909@mail.gmail.com>
Date: Sat, 25 Feb 2006 23:48:24 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Steven Whitehouse" <swhiteho@redhat.com>
Subject: Re: GFS2 Filesystem [1/16]
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1140792745.6400.710.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140792745.6400.710.camel@quoit.chygwyn.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Steven Whitehouse <swhiteho@redhat.com> wrote:
> +/*  Divide num by den.  Round up if there is a remainder.  */
> +#define DIV_RU(num, den) (((num) + (den) - 1) / (den))

Seems generally useful. Consider putting this to <linux/kernel.h> and
giving it a better name e.g. DIV_ROUND_UP.

> +#define get_v2sdp(sb) ((struct gfs2_sbd *)(sb)->s_fs_info)
> +#define set_v2sdp(sb, sdp) (sb)->s_fs_info = (sdp)
> +#define get_v2ip(inode) ((struct gfs2_inode *)(inode)->u.generic_ip)
> +#define set_v2ip(inode, ip) (inode)->u.generic_ip = (ip)
> +#define get_v2fp(file) ((struct gfs2_file *)(file)->private_data)
> +#define set_v2fp(file, fp) (file)->private_data = (fp)
> +#define get_v2bd(bh) ((struct gfs2_bufdata *)(bh)->b_private)
> +#define set_v2bd(bh, bd) (bh)->b_private = (bd)
> +
> +#define get_transaction ((struct gfs2_trans *)(current->journal_info))
> +#define set_transaction(tr) (current->journal_info) = (tr)
> +
> +#define get_gl2ip(gl) ((struct gfs2_inode *)(gl)->gl_object)
> +#define set_gl2ip(gl, ip) (gl)->gl_object = (ip)
> +#define get_gl2rgd(gl) ((struct gfs2_rgrpd *)(gl)->gl_object)
> +#define set_gl2rgd(gl, rgd) (gl)->gl_object = (rgd)
> +#define get_gl2gl(gl) ((struct gfs2_glock *)(gl)->gl_object)
> +#define set_gl2gl(gl, gl2) (gl)->gl_object = (gl2)

Consider dropping these macros. Please note redundant casting.

> +#define gfs2_inum_equal(ino1, ino2) \
> +       (((ino1)->no_formal_ino == (ino2)->no_formal_ino) && \
> +       ((ino1)->no_addr == (ino2)->no_addr))

Consider using static inline function instead.

> +#define DT2IF(dt) (((dt) << 12) & S_IFMT)
> +#define IF2DT(sif) (((sif) & S_IFMT) >> 12)

Ditto.

                                              Pekka
