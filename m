Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288643AbSADOOw>; Fri, 4 Jan 2002 09:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288641AbSADOOo>; Fri, 4 Jan 2002 09:14:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:7280 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S288640AbSADOOe>; Fri, 4 Jan 2002 09:14:34 -0500
Date: Fri, 4 Jan 2002 15:14:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "M.H.VanLeeuwen" <vanl@megsinet.net>, andihartmann@freenet.de,
        riel@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020104151438.M1561@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0112292256490.24031-100000@imladris.surriel.com> <3C2F04F6.7030700@athlon.maya.org> <3C309CDC.DEA9960A@megsinet.net> <20011231185350.1ca25281.skraw@ithnet.com> <3C351012.9B4D4D6@megsinet.net> <20020104133321.39287b2d.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020104133321.39287b2d.skraw@ithnet.com>; from skraw@ithnet.com on Fri, Jan 04, 2002 at 01:33:21PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2002 at 01:33:21PM +0100, Stephan von Krawczynski wrote:
> On Thu, 03 Jan 2002 20:14:42 -0600
> "M.H.VanLeeuwen" <vanl@megsinet.net> wrote:
>  
> > Stephan,
> > 
> > Here is what I've run thus far.  I'll add nfs file copy into the mix also...
> 
> Ah, Martin, thanks for sending the patch. I think I saw the voodoo in your
> patch. When I did that last time I did _not_ do this:
> 
> +                       if (PageReferenced(page)) {
> +                               del_page_from_inactive_list(page);
> +                               add_page_to_active_list(page);
> +                       } 
> +                       continue;
> 
> This may shorten your inactive list through consecutive runs.
> 
> And there is another difference here:
> 
> +       if (max_mapped <= 0 && nr_pages > 0)
> +               swap_out(priority, gfp_mask, classzone);
> +
> 
> It sounds reasonable _not_ to swap in case of success (nr_pages == 0).
> To me this looks pretty interesting. Is something like this already in -aa?
> This patch may be worth applying in 2.4. It is small and looks like the right
> thing to do.

-aa swapout as soon as max_mapped hits zero. So it basically does it
internally (i.e. way more times) and so it will most certainly be able
to sustain an higher swap transfer rate. You can check with the mtest01
-w test from ltp.

Andrea
