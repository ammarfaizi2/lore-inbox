Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315806AbSETJda>; Mon, 20 May 2002 05:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315808AbSETJda>; Mon, 20 May 2002 05:33:30 -0400
Received: from 213-98-127-214.uc.nombres.ttd.es ([213.98.127.214]:56511 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S315806AbSETJd3>;
	Mon, 20 May 2002 05:33:29 -0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Frank Krauss <fmfkrauss@mindspring.com>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Possible EXT2 File System Corruption in Kernel 2.4
In-Reply-To: <E16vKwg-00056q-00@barry.mail.mindspring.net>
	<02041112492500.01786@sevencardstud.cable.nu>
	<20020417075637.GJ20464@turbolinux.com>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: 20 May 2002 11:38:52 +0200
Message-ID: <m2661jxioj.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "andreas" == Andreas Dilger <adilger@clusterfs.com> writes:

Hi

Sorry for reading so late that mail.

andreas> diff -ru linux-2.4.18.orig/fs/ext2/balloc.c linux-2.4.18-aed/fs/ext2/balloc.c
andreas> --- linux-2.4.18.orig/fs/ext2/balloc.c	Wed Feb 27 10:31:58 2002
andreas> +++ linux-2.4.18-aed/fs/ext2/balloc.c	Mon Mar 18 17:07:55 2002
andreas> @@ -269,7 +269,8 @@
andreas> }
andreas> lock_super (sb);
andreas> es = sb->u.ext2_sb.s_es;
andreas> -	if (block < le32_to_cpu(es->s_first_data_block) || 
andreas> +	if (block < le32_to_cpu(es->s_first_data_block) ||
andreas> +	    block + count < block ||

It is just me, or this will allways be false?  A fast grep shows that
count is always bigger than 1. Same for the ext3 part.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
