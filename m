Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUJWU4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUJWU4h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbUJWU4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:56:36 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:62103 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261310AbUJWU4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:56:14 -0400
Date: Sat, 23 Oct 2004 23:56:06 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Willem Riede <wrlk@riede.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Should osst call cdev_alloc()
In-Reply-To: <1098551404l.3844l.1l@serve.riede.org>
Message-ID: <Pine.LNX.4.61.0410232336510.6707@kai.makisara.local>
References: <1098551404l.3844l.1l@serve.riede.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004, Willem Riede wrote:

> Currently, sg.c and st.c contain calls to cdev_alloc() and friends:
> 
> 
> [wriede@serve kernel]$ find linux-2.6.9 -name '*.c' | xargs grep cdev_alloc
> linux-2.6.9/drivers/s390/char/tape_class.c:     tcd->char_device =
> cdev_alloc();
> linux-2.6.9/drivers/scsi/sg.c:  cdev = cdev_alloc();
> linux-2.6.9/drivers/scsi/sg.c:          printk(KERN_WARNING "cdev_alloc
> failed\n");
> linux-2.6.9/drivers/scsi/st.c:                  cdev = cdev_alloc();
> linux-2.6.9/fs/char_dev.c:      cdev = cdev_alloc();
> linux-2.6.9/fs/char_dev.c:struct cdev *cdev_alloc(void)
> linux-2.6.9/fs/char_dev.c:EXPORT_SYMBOL(cdev_alloc);
> 
> 
> My question is: should osst do the same? It seems to work just fine without.
> 
The reason why st.c calls cdev_alloc() directly is that this allows it to 
use the large minor numbers (some people want to use more than 32 tapes).
This also used to give presence in sysfs but that is not the case any 
more. The devices can be shown in sysfs using device classes (st.c uses 
the class_simple_* functions).

Osst does call cdev_alloc() indirectly through register_chrdev(). This is 
the link between the "old style" character device allocation and the 
current method. As long as register_chrdev() exists, you don't have any 
pressing need to change osst unless you want to support more than 256 
minors.

-- 
Kai
