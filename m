Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261331AbSIWTcH>; Mon, 23 Sep 2002 15:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbSIWTax>; Mon, 23 Sep 2002 15:30:53 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261306AbSIWSlg>;
	Mon, 23 Sep 2002 14:41:36 -0400
Date: Mon, 23 Sep 2002 10:27:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Matthew Wilcox <willy@debian.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Configure/compile error with 2.5.38
In-Reply-To: <20020923164144.B27458@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.10.10209231026330.390-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct, that is why I had it scheduled to be moved into legacy.
However until many issuse are settle down minor fixes like this are on
hold.

On Mon, 23 Sep 2002, Matthew Wilcox wrote:

> 
> Got an interesting one here; this combination fails to link:
> 
> CONFIG_BLK_DEV_CMD640=y
> # CONFIG_BLK_DEV_IDEPCI is not set
> 
> Why not?  Well.. cmd640.c is in drivers/ide/pci/ which is only
> entered if CONFIG_BLK_DEV_IDEPCI, and if CONFIG_BLK_DEV_CMD640 is set,
> drivers/ide/ide.c contains a reference to cmd640_vlb which is defined
> in cmd640.c.
> 
> The "obvious" solution to make CMD640 depend on IDEPCI is not correct
> because of the aforementioned VLB controllers.  Maybe we could just add
> the line:
> obj-$(CONFIG_BLK_DEV_CMD640)            += pci/
> to drivers/ide/Makefile which is a bit of a kludge..
> 
> -- 
> Revolutions do not require corporate support.
> 

Andre Hedrick
LAD Storage Consulting Group

