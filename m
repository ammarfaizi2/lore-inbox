Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSHMFFx>; Tue, 13 Aug 2002 01:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317365AbSHMFFx>; Tue, 13 Aug 2002 01:05:53 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:40878 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317363AbSHMFFx>;
	Tue, 13 Aug 2002 01:05:53 -0400
Date: Tue, 13 Aug 2002 15:09:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, matthew@wil.cx, michael.kerrisk@gmx.net
Subject: Re: [PATCH] [2.4.20-pre2] File lease fixes
Message-Id: <20020813150929.2770f9d4.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0208122346260.3620-100000@freak.distro.conectiva>
References: <20020813111012.2ea19232.sfr@canb.auug.org.au>
	<Pine.LNX.4.44.0208122346260.3620-100000@freak.distro.conectiva>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Mon, 12 Aug 2002 23:47:03 -0300 (BRT) Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> On Tue, 13 Aug 2002, Stephen Rothwell wrote:
> 
> >  static inline int get_lease(struct inode *inode, unsigned int mode)
> >  {
> > -	if (inode->i_flock && (inode->i_flock->fl_flags & FL_LEASE))
> > +	if (inode->i_flock)
> >  		return __get_lease(inode, mode);
> >  	return 0;
> >  }
> 
> Why do you remove the FL_LEASE check here?

Because there is a race between checking inode->i_flock and
inode->i_flock->fl_flags which a couple of people have actually
hit ... The check for FL_EASE is done again in __get_lease
but protected by the BKL.

This is just an optimisation and having the check here is only
faster in the case where there is a lock held that is NOT a lease.

This was the race fix provided by Willy.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
