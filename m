Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbSJJVtq>; Thu, 10 Oct 2002 17:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJJVtp>; Thu, 10 Oct 2002 17:49:45 -0400
Received: from packet.digeo.com ([12.110.80.53]:34492 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262283AbSJJVte>;
	Thu, 10 Oct 2002 17:49:34 -0400
Message-ID: <3DA5F740.3564A111@digeo.com>
Date: Thu, 10 Oct 2002 14:55:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sylvain Pasche <sylvain_pasche@yahoo.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.41 isofs patch to avoid "bad: scheduling while atomic!"
References: <15781.47072.335973.295982@yahoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 21:55:12.0549 (UTC) FILETIME=[B56D6550:01C270A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sylvain Pasche wrote:
> 
> --- linux-2.5.41/fs/isofs/dir.c_old     2002-10-10 19:12:19.000000000 +0200
> +++ linux-2.5.41/fs/isofs/dir.c 2002-10-10 19:13:26.000000000 +0200
> @@ -256,7 +256,7 @@
> 
>         lock_kernel();
> 
> -       tmpname = (char *) __get_free_page(GFP_KERNEL);
> +       tmpname = (char *) __get_free_page(GFP_KERNEL | GFP_ATOMIC);
>         if (!tmpname)
>                 return -ENOMEM;

Not sure about the scheduling while atomic thing, but it is returning
with the lock held.  I'll fix that up.
