Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbUJ3SEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbUJ3SEv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbUJ3SEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:04:50 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:25004 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261252AbUJ3SDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:03:48 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] floppy: change MODULE_PARM to module_param =?iso-8859-1?q?in=09drivers/block/floppy=2Ec?=
Date: Sat, 30 Oct 2004 13:03:45 -0500
User-Agent: KMail/1.6.2
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, james4765@verizon.net,
       kernel-janitors@lists.osdl.org
References: <20041030134246.23710.45693.84191@localhost.localdomain> <4183BF5B.5000303@osdl.org>
In-Reply-To: <4183BF5B.5000303@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410301303.45161.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 11:20 am, Randy.Dunlap wrote:
> james4765@verizon.net wrote:
> > Replace MODULE_PARM with module_param in drivers/block/floppy.c.  Compile tested.
> > 
> > Signed-off-by: James Nelson <james4765@gmail.com>
> > 
> > diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
> > --- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
> > +++ linux-2.6.9/drivers/block/floppy.c	2004-10-30 09:16:04.856720081 -0400
> > @@ -180,6 +180,7 @@
> >  #include <linux/devfs_fs_kernel.h>
> >  #include <linux/device.h>
> >  #include <linux/buffer_head.h>	/* for invalidate_buffers() */
> > +#include <linux/moduleparam.h>
> >  
> >  /*
> >   * PS/2 floppies have much slower step rates than regular floppies.
> > @@ -4623,9 +4624,9 @@
> >  	wait_for_completion(&device_release);
> >  }
> >  
> > -MODULE_PARM(floppy, "s");
> > -MODULE_PARM(FLOPPY_IRQ, "i");
> > -MODULE_PARM(FLOPPY_DMA, "i");
> > +module_param(floppy, charp, 0);
> > +module_param(FLOPPY_IRQ, int, 0);
> > +module_param(FLOPPY_DMA, int, 0);
> >  MODULE_AUTHOR("Alain L. Knaff");
> >  MODULE_SUPPORTED_DEVICE("fd");
> >  MODULE_LICENSE("GPL");
> 
> Please check Andrew's 2.6.10-rc1-mm2 for a large MODULE_PARAM
> patch, and then convert drivers that are not yet converted...
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/convert-module_parm-to-module_param-family.patch
> 

Actually it would be nice if drivers were converted "intelligently"
instead of basic find-and-replace - I really find parameter names
like floppy.floppy= or floppy.floppy_dma= ugly.

-- 
Dmitry
