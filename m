Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSFNJ0t>; Fri, 14 Jun 2002 05:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317899AbSFNJ0s>; Fri, 14 Jun 2002 05:26:48 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:58129 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317898AbSFNJ0r>; Fri, 14 Jun 2002 05:26:47 -0400
Date: Fri, 14 Jun 2002 06:22:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2/16] list_head debugging
In-Reply-To: <20020610163608.GA16138@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.LNX.4.44L.0206140621460.25228-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Jan Harkes wrote:
> On Mon, Jun 03, 2002 at 05:41:39PM -0300, Rik van Riel wrote:
> > > We've had this before, and it breaks some code that removes items from
> > > lists as follows,
> >
> > Such code is probably not SMP safe anyway.
>
> Where are you coming from with that comment?
>
>   down(&semaphore);
>
>   list_for_each(p, list)
>     if (condition)
> 	list_del(p);
>
>   up(&semaphore);
>
> Should be completely SMP safe,

Not if 'p' comes from the slab cache.

In that case 'p' can be re-allocated on another CPU
before we dereference ->next ...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

