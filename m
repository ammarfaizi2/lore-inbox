Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTATHlF>; Mon, 20 Jan 2003 02:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTATHlF>; Mon, 20 Jan 2003 02:41:05 -0500
Received: from news.ti.com ([192.94.94.33]:53746 "EHLO dragon.ti.com")
	by vger.kernel.org with ESMTP id <S261368AbTATHlE>;
	Mon, 20 Jan 2003 02:41:04 -0500
From: "Balbir" <balbir@ti.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Disabling file system caching
Date: Mon, 20 Jan 2003 13:17:42 +0530
Message-ID: <006f01c2c058$3748ad00$6353579d@india.ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if posting to the newsgroup linux.kernel sends
it to the mailing list too.

"Balbir Singh" <balbir_soni@yahoo.com> wrote in message
news:b0g6q2$lfq$1@tilde.itg.ti.com...
> "Rik van Riel" <riel@conectiva.com.br> wrote in message
> news:20030120011009$2d98@gated-at.bofh.it...
> > On Sun, 19 Jan 2003, Jean-Eric Cuendet wrote:
> >
> > > Is it possible to disable file caching for a given partition or mount?
> >
> > No, if you do that mmap(), read(), write() etc. would be impossible.
> >
> > > Or at least to limit it at a certain quantity of memory?
> >
> > Not yet.  I'm thinking of implementing something like this
> > for the next version of -rmap (reclaim only from the cache
> > if the cache occupies more than a certain fraction of ram).
>

I think that this feature is very important. In an embedded system
using an NFS root filesystem, we found that the file cache
would take a lot of memory and all insmods would fail. This is
especially true when the system boots up and looks for /lib/modules.

I think it should be possible to modify the slab allocator to
implement a memory pool. We could add a flag which would prevent
the slab from growing beyond its initial size.

This approach would work only if the cache is allocated by
using the slab allocator.

Balbir



