Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVLVMwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLVMwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 07:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLVMwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 07:52:49 -0500
Received: from murder.univie.ac.at ([131.130.1.183]:59614 "EHLO
	imap1u.univie.ac.at") by vger.kernel.org with ESMTP id S932419AbVLVMws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 07:52:48 -0500
From: Axel Kittenberger <axel.kernel@kittenberger.net>
Organization: =?iso-8859-1?q?Universit=E4t?= Wien
To: linux-kernel@vger.kernel.org
Subject: Possible Bootloader Optimization in inflate (get rid of unnecessary 32k Window)
Date: Thu, 22 Dec 2005 13:52:23 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512221352.23393.axel.kernel@kittenberger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Whom do I talk to about acceptance of Patches in the Bootloader?

I have seen, and coded once some time ago for priv. uses, do infalte the 
gziped linux kernel at boottime in "arch/i386/boot/compressed/misc.c" and " 
windowlib/inflate.c" the deflation algorthimn uses a 32k backtrack window. 
Whenever it is full, it copies it .... into the memory. 

While this window makes a lot of sense in an userspace application like 
gunzip, it does not make a lot sense in the bootloader. As userspace 
application the window is flushed to a file when full. The bootloader 
"flushes" it to memory (copies it in memory). That 1 time copy of the whole 
kernel can be optimized away, since we do not keep track of a window since 
the inflater can read what it has written right in the computer memory, while 
it unpacks the kernel.

What would the optimization be worth? 
* A faster uncompressing of the kernel, since a total 1-time memcopy of the 
whole kernel is been optimized away.
* I'm not sure about the size, the memory or disk footprint. If the 32k static 
(!) memory array in compressed/misc.c, I don't know if it safes 32k running 
memory, or 32k on-disk size. Since I don't know the indepth working of these.

Before I code this again (I know that this optimization has worked with a 2.4 
kernel), I want to ask, would such patch be accepted? now or once ever? who 
should I forward this?

Greetings,
Axel
