Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135229AbRDLQy7>; Thu, 12 Apr 2001 12:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135230AbRDLQyo>; Thu, 12 Apr 2001 12:54:44 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:16132 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135229AbRDLQyC>;
	Thu, 12 Apr 2001 12:54:02 -0400
Date: Thu, 12 Apr 2001 13:53:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.21.0104121207130.2774-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0104121352580.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Marcelo Tosatti wrote:

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

Remember that we can ONLY do this if we have __GFP_IO ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

