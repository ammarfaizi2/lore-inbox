Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277826AbRJLTiD>; Fri, 12 Oct 2001 15:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277829AbRJLThp>; Fri, 12 Oct 2001 15:37:45 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:30797 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277826AbRJLTha>; Fri, 12 Oct 2001 15:37:30 -0400
Date: Fri, 12 Oct 2001 14:37:52 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Matt Domsch <Matt_Domsch@dell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups
In-Reply-To: <Pine.LNX.4.33.0110121340140.17295-100000@lists.us.dell.com>
Message-ID: <Pine.LNX.3.96.1011012143222.6594D-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More comments:
* if ether_crc is always == ether_crc_be, then create a #define instead
  of patching driver code
* no need to inline ether_crc_be, stick it in lib/crc32.c also
* using a ref-counting init_crc32 and cleanup_crc32, you do not need
  CONFIG_xxx tests, per driver, in the code itself.  Either make
  lib/crc32 a permanent part of the kernel, or make it a separate module
  which is enabled by makefile rules.  Example:

(linux/lib/Makefile)
obj-$(CONFIG_TULIP) += crc32.o
obj-$(CONFIG_NATSEMI) += crc32.o
obj-$(CONFIG_DMFE) += crc32.o
obj-$(CONFIG_ANOTHERDRIVER) += crc32.o

makefile rules eliminate the duplicates...

