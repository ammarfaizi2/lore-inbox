Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbTDAHKz>; Tue, 1 Apr 2003 02:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262096AbTDAHKz>; Tue, 1 Apr 2003 02:10:55 -0500
Received: from [12.47.58.55] ([12.47.58.55]:39675 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S262085AbTDAHKy>;
	Tue, 1 Apr 2003 02:10:54 -0500
Date: Mon, 31 Mar 2003 23:22:27 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, gibbs@scsiguy.com
Subject: Re: aic7(censored) use after free in 2.5.66
Message-Id: <20030331232227.3f9c9c5f.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0304010155470.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
	<Pine.LNX.4.50.0304010155470.8773-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 07:22:11.0009 (UTC) FILETIME=[690F7310:01C2F81F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> > Slab corruption: start=f7d66248, expend=f7d662c7, problemat=f7d662ac
> > Last user: [<c024f0b7>](ahc_linux_free_device+0x27/0x60)
> > Data: 
> 
> This probably wants; Or if we can sleep in all the paths, a  
> synchronize_kernel after del_timer should suffice.

Yes, but no.

The corruption was at offset 52 decimal into struct ahc_linux_device. 
Without knowing your config it is hard for me to work out what you have at
that offset.   Rebuild your kernel with -g and do:

(gdb) p/d &(((struct ahc_linux_device *)0)->maxtags)

until you find which member is at offset 52.

Something incremented that field by one after it was freed.

