Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbUKEQxC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbUKEQxC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbUKEQxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:53:01 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262685AbUKEQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:52:58 -0500
Date: Fri, 5 Nov 2004 17:52:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>,
       Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: 2.6.10-rc1-mm3: drm_ati_pcigart_{init,cleanup} multiple definition
Message-ID: <20041105165220.GD1295@stusta.de>
References: <20041105001328.3ba97e08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105001328.3ba97e08.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 12:13:28AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc1-mm2:
>...
>  bk-drm.patch
>...

This causes the following compile error:

<--  snip  -->

...
  LD      drivers/char/drm/built-in.o
drivers/char/drm/radeon.o(.text+0x120): In function `drm_ati_pcigart_init':
: multiple definition of `drm_ati_pcigart_init'
drivers/char/drm/r128.o(.text+0x120): first defined here
drivers/char/drm/radeon.o(.text+0x350): In function `drm_ati_pcigart_cleanup':
: multiple definition of `drm_ati_pcigart_cleanup'
drivers/char/drm/r128.o(.text+0x350): first defined here
make[3]: *** [drivers/char/drm/built-in.o] Error 1

<--  snip  -->


The definition of non-inline functions in drivers/char/drm/ati_pcigart.h 
is not a good idea.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

