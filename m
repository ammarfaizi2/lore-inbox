Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWDQO5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWDQO5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 10:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWDQO5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 10:57:51 -0400
Received: from canuck.infradead.org ([205.233.218.70]:59803 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751073AbWDQO5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 10:57:50 -0400
Subject: Re: [RFC: 2.6 patch] let arm use drivers/Kconfig
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060417144823.GC7429@stusta.de>
References: <20060417144823.GC7429@stusta.de>
Content-Type: text/plain
Date: Mon, 17 Apr 2006 15:55:54 +0100
Message-Id: <1145285754.13200.15.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-17 at 16:48 +0200, Adrian Bunk wrote:
> --- linux-2.6.17-rc1-mm2-arm/drivers/mtd/Kconfig.old    2006-04-17 14:32:35.000000000 +0200
> +++ linux-2.6.17-rc1-mm2-arm/drivers/mtd/Kconfig        2006-04-17 15:00:57.000000000 +0200
> @@ -1,6 +1,7 @@
>  # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
>  
>  menu "Memory Technology Devices (MTD)"
> +       depends on (ALIGNMENT_TRAP || !ARM)
>  
>  config MTD
>         tristate "Memory Technology Device (MTD) support"

This dependency is incorrect. It's only one or two chip-specific drivers
which require that the architecture correctly handle alignment traps,
and even then it's only actually apparent when used with JFFS2 which
actually _gives_ it an unaligned buffer occasionally. Everything else
works fine.

Also, I don't want to see this dependency expressed in the MTD Kconfig
file unless it's not arch-specific. Please make a generic
BROKEN_UNALIGNED config option, and set it on all architectures which
need it. Then propose a saner place to put the restriction instead of on
CONFIG_MTD.

-- 
dwmw2

