Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUCZXUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbUCZXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:20:14 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:25353 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261422AbUCZXUK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:20:10 -0500
Date: Sat, 27 Mar 2004 10:19:58 +1100
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [EXT3/JBD] Periodic journal flush not enough?
Message-ID: <20040326231958.GA484@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I've encountered a problem with the journal flush timer.  The problem
is that when a filesystem is short on space, relying on a timer-based
flushing mechanism is no longer adequate.  For example, on my P4 2GHz
I can trigger an ENOSPC error by doing

while :; do echo test > a; [ -s a ] || break; rm a; done; echo Out of space

on an ext3 file system with 12Mb of free space using the usual 5s
journal flush timer.

Of course, when you extend the flushing period as you do with laptop-mode,
this problem becomes a lot worse.

So would it be possible to have the flushing activated on demand?

Thanks,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
