Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRACXIT>; Wed, 3 Jan 2001 18:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRACXIL>; Wed, 3 Jan 2001 18:08:11 -0500
Received: from inje.iskon.hr ([213.191.128.16]:35343 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S129267AbRACXIB>;
	Wed, 3 Jan 2001 18:08:01 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Mike Galbraith <mikeg@wen-online.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] add PF_MEMALLOC to __alloc_pages()
In-Reply-To: <Pine.LNX.4.21.0101031258070.1403-100000@duckman.distro.conectiva>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 04 Jan 2001 00:03:13 +0100
In-Reply-To: Rik van Riel's message of "Wed, 3 Jan 2001 13:03:27 -0200 (BRDT)"
Message-ID: <87g0j0qlvy.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> Hi Linus, Alan, Mike,
> 
> the following patch sets PF_MEMALLOC for the current task
> in __alloc_pages() to avoid infinite recursion when we try
> to free memory from __alloc_pages().
> 
> Please apply the patch below, which fixes this (embarrasing)
> bug...
> 
[snip]
>  		 * free ourselves...
>  		 */
>  		} else if (gfp_mask & __GFP_WAIT) {
> +			current->flags |= PF_MEMALLOC;
>  			try_to_free_pages(gfp_mask);
> +			current->flags &= ~PF_MEMALLOC;
>  			memory_pressure++;
>  			if (!order)
>  				goto try_again;
> 

Hm, try_to_free_pages already sets the PF_MEMALLOC flag!
-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
