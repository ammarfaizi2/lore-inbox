Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290677AbSA3W2u>; Wed, 30 Jan 2002 17:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290675AbSA3W2k>; Wed, 30 Jan 2002 17:28:40 -0500
Received: from mx.fluke.com ([129.196.128.53]:48143 "EHLO
	evtvir03.tc.fluke.com") by vger.kernel.org with ESMTP
	id <S290676AbSA3W23>; Wed, 30 Jan 2002 17:28:29 -0500
Date: Wed, 30 Jan 2002 14:28:28 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: <linux-kernel@vger.kernel.org>
cc: <R.E.Wolff@BitWizard.nl>
Subject: 2.5.3 missing <linux/malloc.h>
Message-ID: <Pine.LNX.4.33.0201301239370.19671-100000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Haven't seen this posted yet, so I'm surprised to report that
several 2.5.3 source files

    arch/arm/mach-clps711x/dma.c
    drivers/base/core.c
    drivers/base/fs.c
    drivers/video/neofb.c


try to include linux/malloc.h
but there is no file in the include directory by that name.

I worked around the problem by copying an older linux/malloc.h:

#ifndef _LINUX_MALLOC_H
#define _LINUX_MALLOC_H

#include <linux/slab.h>
#endif /* _LINUX_MALLOC_H */


and I've noticed that many source files have
  #include <linux/slab.h>     /* kmalloc(), kfree() */
instead of trying to include linux/malloc.h

What's the story/direction the code is taking?


