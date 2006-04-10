Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWDJRmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWDJRmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWDJRmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:42:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38671 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751158AbWDJRmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:42:53 -0400
Date: Mon, 10 Apr 2006 19:42:52 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Aubrey <aubreylee@gmail.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org
Subject: Re: The assemble file under the driver folder can not be recognized when the driver is built as module
Message-ID: <20060410174252.GD2408@stusta.de>
References: <6d6a94c50604100316j43bcc32p6fa781c0ce47182d@mail.gmail.com> <20060410112817.GE12896@harddisk-recovery.com> <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6a94c50604100627q297b7335yb58288356aaa8edd@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 09:27:18PM +0800, Aubrey wrote:
>...
> Makefile is simple.
> ===============================
> ----snip----
> obj-$(CONFIG_FB_BFIN_7171)	  += bfin_ad7171fb.o rgb2ycbcr.o
> ----snip----
> ===============================
> There are two files, bfin_ad7171fb.c and rgb2ycbcr.S under the folder
> " ./drivers/video".
> It should be OK because the driver can pass the compilation when
> select it as built-in.
> It just failed when select it as module.
> 
> Thanks your any hints.

You can't build an object only built from an assembler file. 

But you don't want to get two modules, you want one module built from 
two source files.

IOW, you want:

  obj-$(CONFIG_FB_BFIN_7171)	+= bfin_ad7171fb.o
  bfin_ad7171fb-objs		:= bfin_ad7171fb_main.o rgb2ycbcr.o

Note that this requires renaming bfin_ad7171fb.c to bfin_ad7171fb_main.c.

> Regards,
> -Aubrey

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

