Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWC3RtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWC3RtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWC3RtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:49:15 -0500
Received: from orfeus.profiwh.com ([82.100.20.117]:7440 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S932256AbWC3RtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:49:14 -0500
Message-ID: <442C1A15.7040503@gmail.com>
Date: Thu, 30 Mar 2006 19:49:09 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: __get_free_pages problem, system then hangs
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SpamReason: {}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

I am trying to get pages as memory place with code like this one:

        mem = __get_free_pages(GFP_KERNEL | __GFP_ZERO, get_order(size));
        if (mem == 0ul)
                goto end;

        page = virt_to_page(mem);

        for (i = 0; i < (1 << get_order(size)); i++, page++) {
                get_page(page);
                SetPageReserved(page);
                SetPageLocked(page);
        }

What's wrong with `for' loop? When I am trying to mark them as reserved or
whatever you see there, the system hangs in few moments (some oopses with memory
allocation, obviously).

The problem disappears if:
a) get pages is called with __GFP_COMP flag and then it's sufficient to mark
only the first page (the rest is "bounded" to that one), but even if I mark all,
the problem doesn't appear,
b) I mark only the first page -- it's not what I want, I suppose

Size is 11k i. e. order is 2 (actually, 3 pages are needed) on my i386 system.

Could somebody tell me what am I still missing?

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFELBoVMsxVwznUen4RAoV+AJ0cPRrb7dLyIUPN0RkSpGVhD8LQmQCfelAJ
XDbNydUdRGHHJcN48A0Eib4=
=8vx7
-----END PGP SIGNATURE-----
