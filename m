Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263738AbREYNCh>; Fri, 25 May 2001 09:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263740AbREYNC1>; Fri, 25 May 2001 09:02:27 -0400
Received: from www.wen-online.de ([212.223.88.39]:61714 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S263738AbREYNCQ>;
	Fri, 25 May 2001 09:02:16 -0400
Date: Fri, 25 May 2001 15:01:57 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.4-ac17
In-Reply-To: <014901c0e506$20be97e0$53a6b3d0@Toshiba>
Message-ID: <Pine.LNX.4.33.0105251401220.476-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Jaswinder Singh wrote:

> Dear Mike ,
>
> Are you using harddisk  ?

The OS resides on disk, yes.  I suppose I could plunk a minimal
system into ramfs, pivot_root and umount disk, but I don't see
any way that could matter for a memory leak.

(hmm.. locking up tho.  script makes dcache _grow_.  no swap and
ram is full.  page_launder... writepage needs a page?)

I'd try moving the call to shrink_dcache_memory() right to the
top of do_try_to_free_pages() and see what happens (WAG;) when
you run your script.

In any case, the fs itself doesn't seem to be leaking here.

	-Mike

