Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135835AbRDTJdi>; Fri, 20 Apr 2001 05:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135836AbRDTJd3>; Fri, 20 Apr 2001 05:33:29 -0400
Received: from quechua.inka.de ([212.227.14.2]:21550 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S135835AbRDTJdN>;
	Fri, 20 Apr 2001 05:33:13 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com>
Organization: private Linux site, southern Germany
Date: Fri, 20 Apr 2001 11:29:31 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14qXEU-0005xo-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ehh.. I will bet you $10 USD that if libc allocates the next file
> descriptor on the first "malloc()" in user space (in order to use the
> semaphores for mm protection), programs _will_ break.

Of course, but this is a result from sloppy coding. In general, open()
can just return anything and about the only case where you can even
think of ignoring its result is this:
 close(0); close(1); close(2);
 open("/dev/null", O_RDWR); dup(0); dup(0);
(which is even not clean for other reasons).

I can't imagine depending on the "fact" that the first fd I open is 3,
the next is 4, etc. And what if the routine in question is not
malloc() but e.g. getpwuid()? Both are just arbitrary library
functions, and one of them clearly does open file descriptors,
depending on their implementation.

What would the reason[1] be for wanting contiguous fd space anyway?

Olaf

[1] apart from not having understood how poll() works of course.
