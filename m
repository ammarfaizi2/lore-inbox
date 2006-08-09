Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030642AbWHIKUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbWHIKUj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 06:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWHIKUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 06:20:39 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63636 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030642AbWHIKUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 06:20:37 -0400
Subject: Re: [RFC/PATCH] revoke/frevoke system calls V2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Edgar Toernig <froese@gmx.de>
Cc: Chase Venters <chase.venters@clientec.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@zeniv.linux.org.uk, tytso@mit.edu,
       tigran@veritas.com
In-Reply-To: <20060809104159.1f1737d3.froese@gmx.de>
References: <Pine.LNX.4.58.0607271722430.4663@sbz-30.cs.Helsinki.FI>
	 <20060805122936.GC5417@ucw.cz> <20060807101745.61f21826.froese@gmx.de>
	 <84144f020608070251j2e14e909v8a18f62db85ff3d4@mail.gmail.com>
	 <20060807224144.3bb64ac4.froese@gmx.de>
	 <Pine.LNX.4.64.0608071720510.29055@turbotaz.ourhouse>
	 <1155039338.5729.21.camel@localhost.localdomain>
	 <20060809104159.1f1737d3.froese@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Aug 2006 11:39:59 +0100
Message-Id: <1155119999.5729.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-09 am 10:41 +0200, ysgrifennodd Edgar Toernig:
> If I read the code correctly, the behaviour for hung up ttys is completely
> different: read returns EOF, write returns EIO, select/poll/epoll return
> ready, close works.  As rather boring but totally sane behaviour for an fd.
> 
> But after revoke you get EBADF for any operation, even select or close.

Thats a detail of the proposed implementation that isn't hard to fix.

> And IMHO that's insane that a regular user may close fds in someone else's
> processes (or munmap some of its memory).  I already see people trying
> to exploit bugs in system services:

I can do this already today. In fact the index.html one can be used to
crash certain products now depending on their configuration. Just do

	while { true } do
		cp some.html index.html
		> index.html
	done

with a shell that truncates on > and you'll be able to bus error them if
they mmap and are not well written.

These are not actually changes in behaviour. At any point I can shrink a
file I own and you get read -> 0, mmap access -> bus error. Write
behaviour is new but thats no different to filling the disk up or other
real write errors.


