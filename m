Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVIBGwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVIBGwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 02:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbVIBGwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 02:52:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20633 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030426AbVIBGwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 02:52:21 -0400
Date: Thu, 1 Sep 2005 23:50:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miles Bader <miles@gnu.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v850: Round up length passed to slram driver to a
 multiple of SLRAM_BLK_SZ
Message-Id: <20050901235040.4ecc8bbf.akpm@osdl.org>
In-Reply-To: <20050902061330.BEF2B4DC@dhapc248.dev.necel.com>
References: <20050902061330.BEF2B4DC@dhapc248.dev.necel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@gnu.org> wrote:
>
>  +
>  +/* From drivers/mtd/devices/slram.c */
>  +#define SLRAM_BLK_SZ 0x4000
>  +
>   /* Set the root filesystem to be the given memory region.
>      Some parameter may be appended to CMD_LINE.  */
>   void set_mem_root (void *addr, size_t len, char *cmd_line)
>   {
>  +	/* Some sort of idiocy in MTD means we must supply a length that's
>  +	   a multiple of SLRAM_BLK_SZ.  We just round up the real length,
>  +	   as the file system shouldn't attempt to access anything beyond
>  +	   the end of the image anyway.  */
>  +	len = (((len - 1) + SLRAM_BLK_SZ) / SLRAM_BLK_SZ) * SLRAM_BLK_SZ;

If SLRAM_BLK_SZ will always be a power of two, there's kernel.h:ALIGN()..
