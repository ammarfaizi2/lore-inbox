Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSGFUIP>; Sat, 6 Jul 2002 16:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSGFUIO>; Sat, 6 Jul 2002 16:08:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18696 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293203AbSGFUIO>; Sat, 6 Jul 2002 16:08:14 -0400
Date: Sat, 6 Jul 2002 13:11:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: [PATCH][RFT](2) minimal rmap for 2.5 - akpm tested
In-Reply-To: <3D274C6A.C6E23CAA@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207061301570.893-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jul 2002, Andrew Morton wrote:
>
> That is basically what do_munmap() does.  But I'm quite unfamiliar
> with the locking in there.

The only major user of i_shared is really vmtruncate, I think, and it's
quite ok to unmap the file before removing the mapping from the shared
list - if vmtruncate finds a unmapped area, it just won't be doing
anything (zap_page_range, but that won't do anything without any page
tables).

Together with the fact that unmap() already does it this way anyway, it
looks like the obvious fix..

		Linus

