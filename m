Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWEAL7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWEAL7S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 07:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932073AbWEAL7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 07:59:18 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:54278 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S932071AbWEAL7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 07:59:17 -0400
Message-ID: <4455F825.2060802@gmail.com>
Date: Mon, 01 May 2006 13:59:10 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Daniel_Aragon=E9s?= <danarag@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Requested changelog for minix filesystem update to
 V3
References: <4455D3F1.7000102@gmail.com>
In-Reply-To: <4455D3F1.7000102@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel Aragonés napsal(a):
> Hi Andrew,
> 
> Thank you for your interest. The file attached now has been diffed
> against last week's 2.6.16.11.
> 
> Changelog:
> 
> In bitmap.c, the access to architecture dependent functions has been
> kept within the range of 1K blocksize. A loop inside a loop has been
> introduced to do so.
> In inode.c, 'sbi->s_ninodes = m3s->s_ninodes' was missing, and variable
> 'block' is now unsigned.
> In itree_common.c, function 'nblocks(loff_t size)' has been modified to
> fix the shift in 'blocks = (size + BLOCK_SIZE - 1) >> BLOCK_SIZE_BITS'.
> In minix.h, minor and cosmetic corrections.
> 
> Regards.
> 
> Signed-off-by: Daniel Aragones <danarag@gmail.com>
> 
> 
> ------------------------------------------------------------------------
> 
[snip]
> diff -ur orig.Linux-2.6.16.11/fs/minix/dir.c updated.Linux-2.6.16.11/fs/minix/dir.c
> --- orig.Linux-2.6.16.11/fs/minix/dir.c	2006-04-24 22:20:24.000000000 +0200
> +++ updated.Linux-2.6.16.11/fs/minix/dir.c	2006-03-28 18:04:28.000000000 +0200
> @@ -4,12 +4,15 @@
>   *  Copyright (C) 1991, 1992 Linus Torvalds
>   *
>   *  minix directory handling functions
> + *
> + *  Updated to filesystem version 3 by Daniel Aragones
>   */
>  
>  #include "minix.h"
>  #include <linux/highmem.h>
>  #include <linux/smp_lock.h>
>  
> +typedef struct minix3_dir_entry minix3_dirent;
>  typedef struct minix_dir_entry minix_dirent;
are typedefs _really_ needed? I think we want to kill them all.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEVfglMsxVwznUen4RAmKwAJ91Zj8O2Wz+EFp1GPcVe1ytwbgVCACfRIEQ
PRBY5/PEQKXbjQVJnSPmRnU=
=jBAY
-----END PGP SIGNATURE-----
