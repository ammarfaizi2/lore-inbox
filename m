Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWHISAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWHISAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWHISAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:00:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:60385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751261AbWHISAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:00:20 -0400
X-Authenticated: #271361
Date: Wed, 9 Aug 2006 20:00:10 +0200
From: Edgar Toernig <froese@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chase Venters <chase.venters@clientec.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
Message-Id: <20060809200010.2404895a.froese@gmx.de>
In-Reply-To: <1155119999.5729.141.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	<20060805122936.GC5417@ucw.cz>
	<20060807101745.61f21826.froese@gmx.de>
	<84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	<20060807224144.3bb64ac4.froese@gmx.de>
	<Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
	<1155039338.5729.21.camel@localhost.localdomain>
	<20060809104159.1f1737d3.froese@gmx.de>
	<1155119999.5729.141.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Ar Mer, 2006-08-09 am 10:41 +0200, ysgrifennodd Edgar Toernig:
> > 
> > But after revoke you get EBADF for any operation, even select or close.
> 
> Thats a detail of the proposed implementation that isn't hard to fix.

Fine.

> > And IMHO that's insane that a regular user may close fds in someone else's
> > processes (or munmap some of its memory).  I already see people trying
> > to exploit bugs in system services:
> 
> I can do this already today. In fact the index.html one can be used to
> crash certain products now depending on their configuration. Just do
> 
> 	while { true } do
> 		cp some.html index.html
> 		> index.html
> 	done
> 
> with a shell that truncates on > and you'll be able to bus error them if
> they mmap and are not well written.

I wasn't aware of that (and I would definitely prefer a different behaviour).

But anyway, correct me if I'm wrong, revoke (V2) not simply removes the
pages from the mmaped area as truncating does (the vma stays);  revoke
seems to completely remove the vma which is clearly a security bug.
Future mappings may silently get mapped into the area of the revoked
file without the app noticing it.  It may then hand out data of the new
file still thinking it's sending the old one.

Ciao, ET.
