Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267659AbTBEBte>; Tue, 4 Feb 2003 20:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267662AbTBEBte>; Tue, 4 Feb 2003 20:49:34 -0500
Received: from 4-088.ctame701-1.telepar.net.br ([200.193.162.88]:6320 "EHLO
	4-088.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267659AbTBEBtd>; Tue, 4 Feb 2003 20:49:33 -0500
Date: Tue, 4 Feb 2003 23:58:52 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: torvalds@transmeta.com, "" <linux-kernel@vger.kernel.org>,
       "" <tytso@thunk.org>, "" <rddunlap@osdl.org>
Subject: Re: [PATCH][RESEND 3] disassociate_ctty SMP fix
In-Reply-To: <20030204175109.57bbfc51.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50L.0302042356580.32328-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com>
 <Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com>
 <20030204175109.57bbfc51.akpm@digeo.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Andrew Morton wrote:
> Rik van Riel <riel@conectiva.com.br> wrote:
> >
> > ===== drivers/char/tty_io.c 1.55 vs edited =====
> > --- 1.55/drivers/char/tty_io.c	Tue Jan 14 23:37:20 2003
> > +++ edited/drivers/char/tty_io.c	Tue Feb  4 23:02:52 2003
> > @@ -425,19 +425,21 @@
> >   */
> >  void do_tty_hangup(void *data)
> >  {
> > -	struct tty_struct *tty = (struct tty_struct *) data;

> > -	if (!tty)
> > -		return;
> > -
> >  	/* inuse_filps is protected by the single kernel lock */
> >  	lock_kernel();

   [ move stuff to after the lock_kernel() ]

> This part is a no-op...

Mmmm Doh, local variable indeed ;/

I guess it's time to fix the caller of this function then,
since something strange is going on here:

http://bugme.osdl.org/show_bug.cgi?id=54

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
