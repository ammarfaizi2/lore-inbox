Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318926AbSHMDdR>; Mon, 12 Aug 2002 23:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318927AbSHMDdR>; Mon, 12 Aug 2002 23:33:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23049 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318926AbSHMDdQ>; Mon, 12 Aug 2002 23:33:16 -0400
Date: Mon, 12 Aug 2002 23:47:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
       Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: [PATCH] [2.4.20-pre2] File lease fixes
In-Reply-To: <20020813111012.2ea19232.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0208122346260.3620-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Aug 2002, Stephen Rothwell wrote:

> Hi Marcelo,
>
> Here it is again against pre2.  Do you have something against this
> patch or do I just slip between the boards?
>
> There are several current problems with the file leases code in 2.4
> including at least one race condition.  This is a back port of the
> 2.5 file lease code which solves all the reported problems.  It also
> includes a fix for an SMP race condition from Matthew Wilcox.
>
> Thanks to Michael Kerrisk for pushing and testing.

>  static inline int get_lease(struct inode *inode, unsigned int mode)
>  {
> -	if (inode->i_flock && (inode->i_flock->fl_flags & FL_LEASE))
> +	if (inode->i_flock)
>  		return __get_lease(inode, mode);
>  	return 0;
>  }

Why do you remove the FL_LEASE check here?

I see no point doing that.

