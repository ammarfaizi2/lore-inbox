Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267318AbUHDPyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267318AbUHDPyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUHDPyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:54:00 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62098 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267318AbUHDPxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:53:46 -0400
Date: Wed, 4 Aug 2004 17:53:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.4.27-rc5
In-Reply-To: <20040803234250.GB8083@logos.cnet>
Message-ID: <Pine.GSO.4.58.0408041752150.15861@waterleaf.sonytel.be>
References: <20040803234250.GB8083@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Marcelo Tosatti wrote:
> Most importantly this release fixes an exploitable race in file offset handling
> which allows unpriviledged users from potentially reading kernel memory.
> This touches several drivers and generic proc code. This issue is covered by
> CAN-2004-0415.
> Marcelo Tosatti:
>   o Al Viro and others: Fix file offset handling races in several drivers

Breaks the build with gcc 2.95. Trivial fix below:

--- linux-2.4.27-rc5/net/atm/br2684.c.orig	2004-08-04 15:33:22.000000000 +0200
+++ linux-2.4.27-rc5/net/atm/br2684.c	2004-08-04 17:21:16.000000000 +0200
@@ -736,8 +736,9 @@ static ssize_t br2684_proc_read(struct f
 {
 	unsigned long page;
 	int len = 0, x, left;
-	page = get_free_page(GFP_KERNEL);
 	loff_t n = *pos;
+
+	page = get_free_page(GFP_KERNEL);
 	if (!page)
 		return -ENOMEM;
 	left = PAGE_SIZE - 256;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
