Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317570AbSGJRdM>; Wed, 10 Jul 2002 13:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSGJRdL>; Wed, 10 Jul 2002 13:33:11 -0400
Received: from pop.gmx.net ([213.165.64.20]:28032 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317570AbSGJRdJ>;
	Wed, 10 Jul 2002 13:33:09 -0400
Date: Wed, 10 Jul 2002 19:35:45 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, linux-mm@kvack.org
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
Message-Id: <20020710193545.272bedab.sebastian.droege@gmx.de>
In-Reply-To: <Pine.LNX.4.44L.0207060228460.8346-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207060228460.8346-100000@imladris.surriel.com>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.fQxYHH?+b_SyGa"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.fQxYHH?+b_SyGa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jul 2002 02:31:38 -0300 (BRT)
Rik van Riel <riel@conectiva.com.br> wrote:

> Hi,
> 
> Almost the same patch as before, except this one has had
> a few hours of testing by Andrew Morton and two bugs have
> been ironed out, most notably the truncate_complete_page()
> race.  This patch is probably safe since Andrew got bored
> when no new bugs showed up ...
> 
> If you have some time left this weekend and feel brave,
> please test the patch which can be found at:
> 
> 	http://surriel.com/patches/2.5/2.5.25-rmap-akpmtested
> 
> This patch is based on Craig Kulesa's minimal rmap patch
> for 2.5.24, with a few changes:
> - removed a few unrelated changes
> - updated armv/rmap.h for new pagetable layout of linux/arm
> - dropped per-zone pte_chain freelists, we want to make per-cpu
>   ones for SMP scalability
> - ported to 2.5.25 (PF_NOWARN instead of PF_RADIX_TREE)
> - drop spelling and whitespace fixes (should be merged separately)
> - fix truncate_complete_page race condition (akpm)
> 
> It should be mostly ready for being integrated into the 2.5 tree,
> with the note that pte-highmem support still needs to be implemented
> (some IBMers have been volunteered for this task, this functionality
> can easily be added afterwards).
> 
> Right now this patch needs testing and careful scrutiny. If you can
> find anything wrong with it, please let me know.
> 
> kind regards,
> 
> Rik
Hi,
after running your patch some time I have to say that the old VM implementation and the full rmap patch (by Craig Kulesa) was better.
The system becomes very slow and has to swap in too much after some uptime (4 hours - 2 days) and memory intensive tasks...
Maybe this happens only to me but it's fully reproducable
If you need some more informations just ask

Bye
--=.fQxYHH?+b_SyGa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9LHB1e9FFpVVDScsRAqYQAKDD5esAvWHe7O6iLlFLkicwO8tmhwCg3xIu
tp8vedDfBrmW+ZfWguZRwYo=
=HQ7s
-----END PGP SIGNATURE-----

--=.fQxYHH?+b_SyGa--

