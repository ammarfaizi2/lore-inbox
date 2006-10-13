Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWJMIC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWJMIC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 04:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJMIC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 04:02:29 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:50633 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750741AbWJMIC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 04:02:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VAdbhZSMyOPUp64IgoABhh7FPfg3OA7gVzj5OWztM/iE8raaAbOjXssabnfrs5V7WuYseJhZDCsN7F2dXtsYNtncyYgMHAuDG8Dzxk064JCFVpoBrdLvMfxM7lZl+Uw5LT8STFlBE5qWDDBof3D2V1xrvmxVxtMOF2tZlFgsG2Q=
Message-ID: <84144f020610130102p4414f91fv9e2e4bee64690a16@mail.gmail.com>
Date: Fri, 13 Oct 2006 11:02:26 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 20 of 23] Unionfs: Internal include file
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com,
       phillip@hellewell.homeip.net
In-Reply-To: <4a0655b52aef552fe558.1160197659@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
	 <4a0655b52aef552fe558.1160197659@thor.fsl.cs.sunysb.edu>
X-Google-Sender-Auth: 7ef6e563b50779c6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/06, Josef Jeff Sipek <jsipek@cs.sunysb.edu> wrote:
> +static inline void fist_copy_attr_atime(struct inode *dest,
> +                                       const struct inode *src)
> +{
> +       dest->i_atime = src->i_atime;
> +}
> +
> +static inline void fist_copy_attr_times(struct inode *dest,
> +                                       const struct inode *src)
> +{
> +       dest->i_atime = src->i_atime;
> +       dest->i_mtime = src->i_mtime;
> +       dest->i_ctime = src->i_ctime;
> +}
> +
> +static inline void fist_copy_attr_timesizes(struct inode *dest,
> +                                           const struct inode *src)
> +{
> +       dest->i_atime = src->i_atime;
> +       dest->i_mtime = src->i_mtime;
> +       dest->i_ctime = src->i_ctime;
> +       dest->i_size = src->i_size;
> +       dest->i_blocks = src->i_blocks;
> +}
> +
> +static inline void fist_copy_attr_all(struct inode *dest,
> +                                     const struct inode *src)
> +{
> +       dest->i_mode = src->i_mode;
> +       /* we do not need to copy if the file is a deleted file */
> +       if (dest->i_nlink > 0)
> +               dest->i_nlink = get_nlinks(dest);
> +       dest->i_uid = src->i_uid;
> +       dest->i_gid = src->i_gid;
> +       dest->i_rdev = src->i_rdev;
> +       dest->i_atime = src->i_atime;
> +       dest->i_mtime = src->i_mtime;
> +       dest->i_ctime = src->i_ctime;
> +       dest->i_blkbits = src->i_blkbits;
> +       dest->i_size = src->i_size;
> +       dest->i_blocks = src->i_blocks;
> +       dest->i_flags = src->i_flags;
> +}

Ecryptfs has the exact same bits. Please consolidate to common code.
