Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317855AbSG1Xt3>; Sun, 28 Jul 2002 19:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSG1Xt3>; Sun, 28 Jul 2002 19:49:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317855AbSG1Xt1>; Sun, 28 Jul 2002 19:49:27 -0400
Date: Sun, 28 Jul 2002 16:54:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D439E10.67A839A5@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207281649560.9427-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> There are some situations where a page's final release is performed by
> put_page().  Such as in access_process_vm().  This tends to go BUG()
> because the page is on the LRU.

This is wrong.

If that happens, then you should just make access_process_vm() use
"page_cache_release()". That's what you basically make "__free_pages_ok()"
do, but since you still have to add the BUG_ON() check to make clear that
it is illegal to do this from an interrupt context, it's much better to
just do this check statically.

		Linus

