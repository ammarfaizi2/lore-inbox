Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135220AbRDLQ3g>; Thu, 12 Apr 2001 12:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135221AbRDLQ30>; Thu, 12 Apr 2001 12:29:26 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:26130 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135220AbRDLQ3R>;
	Thu, 12 Apr 2001 12:29:17 -0400
Date: Thu, 12 Apr 2001 13:29:02 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hugh Dickins <hugh@veritas.com>, Valdis.Kletnieks@vt.edu,
        linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <E14njYc-0000vA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0104121327450.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Alan Cox wrote:

> > 2.4.3-pre6 quietly made a very significant change there:
> > it used to say "if (!order) goto try_again;" and now just
> > says "goto try_again;".  Which seems very sensible since
> > __GFP_WAIT is set, but I do wonder if it was a safe change.
> > We have mechanisms for freeing pages (order 0), but whether
> > any higher orders come out of that is a matter of chance.
> 
> The fundamental problem is that it should say
> 
> 	wait_for_mm_progress();
> 	goto try_again;
> 
> and we dont have that facility right now.

>From mm/page_alloc.c, around line 453:

                if (gfp_mask & __GFP_WAIT) {
                        memory_pressure++;
                        try_to_free_pages(gfp_mask);
                        wakeup_bdflush(0);
                        goto try_again;
                }

I guess we should remove the wakeup_bdflush(0) ... who put it
there anyway ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

