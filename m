Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266091AbTA2Ore>; Wed, 29 Jan 2003 09:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbTA2Ore>; Wed, 29 Jan 2003 09:47:34 -0500
Received: from [217.167.51.129] ([217.167.51.129]:32210 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266091AbTA2Ord>;
	Wed, 29 Jan 2003 09:47:33 -0500
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid
	b_page.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043852266.1690.63.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 29 Jan 2003 15:57:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I just spotted this in the patch (but the code itself have been
there since 2.4.20-pre2).

> -			if (((unsigned long) bh->b_data) < PAGE_SIZE)
> +			if ((unsigned long) bh->b_data < PAGE_SIZE)

Didn't you meant PAGE_OFFSET and not PAGE_SIZE here ? I fail to see why
it would make any sense to compare a virtual address to PAGE_SIZE ;)

Ben.

