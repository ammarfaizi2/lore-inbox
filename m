Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBNMCp>; Wed, 14 Feb 2001 07:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132013AbRBNMCZ>; Wed, 14 Feb 2001 07:02:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:25614 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129055AbRBNMCT>; Wed, 14 Feb 2001 07:02:19 -0500
Date: Wed, 14 Feb 2001 08:12:47 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: NIIBE Yutaka <gniibe@m17n.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swapin flush cache bug
In-Reply-To: <200102140208.LAA18226@mule.m17n.org>
Message-ID: <Pine.LNX.4.21.0102140510240.30964-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Feb 2001, NIIBE Yutaka wrote:

> Alan Cox wrote:
>  > Ok we need to handle that case a bit more intelligently so those flushes dont
>  > get into other ports code paths. 
> 
> Possibly at fs/buffer.c:end_buffer_io_async?
> 
> We need to flush the cache when I/O was READ or READA.

Yet another thing (1) on end_buffer_io_async() to handle a case which is
only true for a specific user of it. Since the other special case handling
is for swap IO too, I think a separate IO end operation for swap would be
interesting.

(1) The current one is SetPageDecrAfter handling.

> Is there any way for end_buffer_io_async to distinguish which I/O (READ or WRITE)
> has been done?

Yes. If the buffer_head is uptodated (BH_Uptodate) then its a WRITE,
otherwise its a READ (this is only true before mark_buffer_uptodate() call
inside end_buffer_io_async(), of course). 

