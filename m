Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315216AbSEHVbX>; Wed, 8 May 2002 17:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSEHVbW>; Wed, 8 May 2002 17:31:22 -0400
Received: from moist227.drizzle.com ([216.162.216.227]:3321 "EHLO
	cac.seattle.wa.us") by vger.kernel.org with ESMTP
	id <S315216AbSEHVaR>; Wed, 8 May 2002 17:30:17 -0400
Date: Wed, 8 May 2002 14:30:10 -0700 (PDT)
From: "Charles A. Clinton" <cac@cac.seattle.wa.us>
To: Johnny Mnemonic <johnny@themnemonic.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: bug in tmpfs
In-Reply-To: <20020508170024.RTDY6993.fep23-svc.tin.it@there>
Message-ID: <Pine.LNX.4.33.0205081425240.13323-100000@cac.seattle.wa.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, Johnny Mnemonic wrote:

> > I've noticed the following wrong behaviour on tmpfs:
> >
> > (running kernel 2.4.18)
> >
> > [johnny@revenge johnny]$ cd /mnt/shm
> > [johnny@revenge shm]$ rm -rf W
> > [johnny@revenge shm]$ mkdir W
> > [johnny@revenge shm]$ cd W
> > [johnny@revenge W]$ touch MYFILE
> > [johnny@revenge W]$ ln -s X Y
> > [johnny@revenge W]$ ls -l
> > total 0
> > -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> > -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> > lrwxrwxrwx    1 johnny   johnny          1 May  7 19:37 Y -> X
> > [johnny@revenge W]$ ls -l
> > total 0
> > -rw-rw-r--    1 johnny   johnny          0 May  7 19:37 MYFILE
> > lrwxrwxrwx    1 johnny   johnny          1 May  7 19:37 Y -> X
> > [johnny@revenge W]$
> >
> > This bug is reproducible in most ways, when you create a
> > non-existent symlink, the first ls will always show up two "MYFILE",
> > while the second and further one won't.
>
> This is probably a misbehaviour of the general cfs layer on which the
> tmpfs directory handling relies. Further on my time nowaday is totally
> sucked up by my job. So I can't look into this myself.
>
> Please report this bug to the Linux Kernel Mailing list.
>
> Greetings
>                 Christoph
>
> -------------------------------------------------------
>
> Anyone would like to track this bug before 2.4.19 release?

If you substitute "\ls" for "ls" the problem goes away. If you use "\ls
--color=tty -l" the problem reappears.

-- Charles

