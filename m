Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267400AbUHDTxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267400AbUHDTxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUHDTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:53:52 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:33473 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S267400AbUHDTxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:53:50 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [2.6.8-rc2-mm2] oops report (crashes on booting)
Date: Wed, 4 Aug 2004 21:53:36 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank.Otto@tc.pci.uni-heidelberg.de
References: <Pine.LNX.4.44.0408041808050.30401-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0408041808050.30401-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408042153.38404.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> tmpfs must use __copy_from_user_inatomic now, to avoid might_sleep
> warning, when knowingly using __copy_from_user with an atomic kmap.
>
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
>
> --- 2.6.8-rc2-mm2/mm/shmem.c	2004-08-02 13:03:33.000000000 +0100
> +++ linux/mm/shmem.c	2004-08-04 18:05:07.917110256 +0100
> @@ -1323,7 +1323,8 @@ shmem_file_write(struct file *file, cons
>  			__get_user(dummy, buf + bytes - 1);
>
>  			kaddr = kmap_atomic(page, KM_USER0);
> -			left = __copy_from_user(kaddr + offset, buf, bytes);
> +			left = __copy_from_user_inatomic(kaddr + offset,
> +							buf, bytes);
>  			kunmap_atomic(kaddr, KM_USER0);
>  		}
>  		if (left) {

Thanks a lot,  that fixed it.

Bernd
