Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135227AbRDLQwj>; Thu, 12 Apr 2001 12:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135228AbRDLQwb>; Thu, 12 Apr 2001 12:52:31 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26640 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135227AbRDLQwB>; Thu, 12 Apr 2001 12:52:01 -0400
Date: Thu, 12 Apr 2001 12:10:36 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.21.0104121207130.2774-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104121209000.2774-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Thu, 12 Apr 2001, Marcelo Tosatti wrote:
> 
> I did :)
> 
> This should fix it 
> 
> --- mm/page_alloc.c.orig   Thu Apr 12 13:47:53 2001
> +++ mm/page_alloc.c        Thu Apr 12 13:48:06 2001
> @@ -454,7 +454,7 @@
>                 if (gfp_mask & __GFP_WAIT) {
>                         memory_pressure++;
>                         try_to_free_pages(gfp_mask);
> -                       wakeup_bdflush(0);
> +                       balance_dirty(NODEV);
>                         goto try_again;
>                 }

This patch is broken, ignore it. 

Just removing wakeup_bdflush() is indeed correct. 

We already wakeup bdflush at try_to_free_buffers() anyway.

