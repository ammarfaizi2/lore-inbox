Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbSLaCpQ>; Mon, 30 Dec 2002 21:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbSLaCpQ>; Mon, 30 Dec 2002 21:45:16 -0500
Received: from alb-24-29-45-178.nycap.rr.com ([24.29.45.178]:3076 "EHLO
	ender.tmmz.net") by vger.kernel.org with ESMTP id <S267126AbSLaCpP>;
	Mon, 30 Dec 2002 21:45:15 -0500
Date: Mon, 30 Dec 2002 21:58:20 -0500 (EST)
From: Matthew Zahorik <matt@albany.net>
X-X-Sender: matt@ender.tmmz.net
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How does the disk buffer cache work?
In-Reply-To: <3E10F1C7.258629F6@digeo.com>
Message-ID: <Pine.BSF.4.43.0212302153400.370-100000@ender.tmmz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2002, Andrew Morton wrote:

> > [.. the next function call in read_cache_page() is lock_page(), which we
> > hang forever on ..]
>
> lock_page() will sleep until the page is unlocked.  The page is unlocked
> from end_buffer_io_sync(), which is called from within the context of
> the disk device driver's interrupt handler.

Okay, I'll track it down there.  Probably the driver not calling
end_buffer_io_sync() when timed out.  When the bad drive is detached,
things work fine - leading me to believe that hardware and interrupt
routing wise things are okay.

Thanks!

- Matt

