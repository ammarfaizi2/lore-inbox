Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292100AbSBAVwG>; Fri, 1 Feb 2002 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292095AbSBAVvq>; Fri, 1 Feb 2002 16:51:46 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48608 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292094AbSBAVvf>;
	Fri, 1 Feb 2002 16:51:35 -0500
Date: Sat, 2 Feb 2002 00:49:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Momchil Velikov <velco@fadata.bg>, Anton Blanchard <anton@samba.org>,
        Andrea Arcangeli <andrea@suse.de>,
        Rik van Riel <riel@conectiva.com.br>, John Stoffel <stoffel@casc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
In-Reply-To: <Pine.LNX.4.33.0202010903060.2634-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0202020045340.19093-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Feb 2002, Linus Torvalds wrote:

> In web-servers, 99% of the content is small files, and if the file is
> cached the expensive parts are all elsewhere. Don't make up "worst
> case schenarios" that simply do no exist.

in fact the locking structure of radix trees have a locking advantage in
the 'multiple small files' case: if one CPU does a sendfile() on one file,
then the lock will be likely CPU-local for the duration of the sendfile(),
while page buckets will access a new spinlock for every page accessed.

	Ingo

