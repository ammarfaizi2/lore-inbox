Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265573AbSJSJZC>; Sat, 19 Oct 2002 05:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265577AbSJSJZC>; Sat, 19 Oct 2002 05:25:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7626 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265573AbSJSJZB>; Sat, 19 Oct 2002 05:25:01 -0400
Date: Sat, 19 Oct 2002 11:31:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ivan Gyurdiev <ivg2@cornell.edu>, Adam Belay <ambx1@neo.rr.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch] Re: 2.5.44 - scripts/kconfig.tk error (xconfig fails)
In-Reply-To: <200210190517.53089.ivg2@cornell.edu>
Message-ID: <Pine.NEB.4.44.0210191128140.28761-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Oct 2002, Ivan Gyurdiev wrote:

> drivers/pnp/Config.in: 7: can't handle dep_bool/dep_mbool/dep_tristate
> condition
> wish -f scripts/kconfig.tk
> Error in startup script: invalid command name "clear_choices"
>...


A dep_bool without a dependency is wrong. The following patch fixes it:


--- linux-2.5.44-full/drivers/pnp/Config.in.old	2002-10-19 11:26:11.000000000 +0200
+++ linux-2.5.44-full/drivers/pnp/Config.in	2002-10-19 11:27:12.000000000 +0200
@@ -4,7 +4,7 @@
 mainmenu_option next_comment
 comment 'Plug and Play configuration'

-dep_bool 'Plug and Play support' CONFIG_PNP
+bool 'Plug and Play support' CONFIG_PNP

    dep_bool '  Plug and Play device name database' CONFIG_PNP_NAMES $CONFIG_PNP
    dep_bool '  PnP Debug Messages' CONFIG_PNP_DEBUG $CONFIG_PNP

cu
Adrian

-- 

"Is there not promise of rain?" Ling Tan asked suddenly out
of the darkness. There had been need of rain for many days.
"Only a promise," Lao Er said.
                                Pearl S. Buck - Dragon Seed



