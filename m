Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWJOJnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWJOJnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 05:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbWJOJnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 05:43:05 -0400
Received: from witte.sonytel.be ([80.88.33.193]:15786 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1750704AbWJOJnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 05:43:05 -0400
Date: Sun, 15 Oct 2006 11:43:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: undefined reference to highest_possible_node_id
In-Reply-To: <20061015080421.GA17399@aepfle.de>
Message-ID: <Pine.LNX.4.62.0610151139170.31351@pademelon.sonytel.be>
References: <20061015080421.GA17399@aepfle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2006, Olaf Hering wrote:
> A 2.6.19-rc2 pseries_defconfig build with SMP=n will not link,
> highest_possible_node_id is undefined because NODES_SHIFT == 4.
> How can this be fixed properly?

I noticed the same a few days ago, but only started looking into it a few
minutes ago.

If MAX_NUMNODES is larger than one, highest_possible_node_id() is no longer a
macro, but a real function, defined in lib/cpumask.c.
NEED_MULTIPLE_NODES depends on DISCONTIGMEM || NUMA.

But lib/cpumask.c is compiled only for SMP, causing a link failure if
CONFIG_SUNRPC is enabled, as net/sunrpc/svc.c:svc_pool_map_init_pernode() uses
highest_possible_node_id().

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
