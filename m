Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSGARcd>; Mon, 1 Jul 2002 13:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315928AbSGARcd>; Mon, 1 Jul 2002 13:32:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315925AbSGARcc>;
	Mon, 1 Jul 2002 13:32:32 -0400
Message-ID: <3D209401.C89C6EE4@zip.com.au>
Date: Mon, 01 Jul 2002 10:40:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lightweight patch manager <patch@luckynet.dynu.com>
CC: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(x) instead of if (x) BUG() in mm/page_alloc,swap_state.c
References: <200207011231.g61CVJLX026313@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lightweight patch manager wrote:
> 
> This replaces if(x) BUG() with BUG_ON(x) where necessarry, at least in
> mm/page_alloc.c and mm/swap_state.c

Thanks - I'll add to my pile.

> ...
> -                       if (!nr_pages--)
> -                               BUG();
> +                       BUG_ON(!nr_pages--)

Except for this chunk.  It's best to avoid putting statements
with side-effects inside BUG_ON().  If someone wants to build
a super-small kernel with a no-op BUG_ON() then code such as the
above will cause it to fail.

It'll probably fail anyway, but hey - may as well try.

-
