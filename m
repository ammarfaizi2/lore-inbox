Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270347AbRH1HZW>; Tue, 28 Aug 2001 03:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270333AbRH1HZM>; Tue, 28 Aug 2001 03:25:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10259 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270347AbRH1HY5>; Tue, 28 Aug 2001 03:24:57 -0400
Date: Tue, 28 Aug 2001 02:57:19 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <oupofp0k6bw.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0108280257030.7746-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28 Aug 2001, Andi Kleen wrote:

> Marcelo Tosatti <marcelo@conectiva.com.br> writes:
> 
> > --- linux.orig/fs/buffer.c	Mon Aug 27 20:46:36 2001
> > +++ linux/fs/buffer.c	Mon Aug 27 21:43:35 2001
> > @@ -2448,6 +2448,10 @@
> >  	write_unlock(&hash_table_lock);
> >  	spin_unlock(&lru_list_lock);
> >  	if (gfp_mask & __GFP_IO) {
> > +#ifdef CONFIG_HIGHMEM
> > +		if (!(gfp_mask & __GFP_HIGHIO) & PageHighMem(page))
>                                               ^^
> Should clearly be &&
> Could be a problem if PageHighMem returns something other than 1 for true.

Right. 

Linus, please fix that on your tree. 

