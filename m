Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVJISTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVJISTe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 14:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJISTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 14:19:34 -0400
Received: from mx1.suse.de ([195.135.220.2]:654 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932171AbVJISTd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 14:19:33 -0400
Date: Sun, 9 Oct 2005 18:19:31 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/13] ppc64 boot: use in-kernel zlib, make zImage header relocateable, misc fixes
Message-ID: <20051009181931.0.IoWCk29070.29065.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The following series of patches improves the zImage header on ppc64.
Similar code is used in openSuSE since a while and works well, on 32bit
and 64bit systems.

Two patches touch generic code, they are required to simplify the copying
of lib/zlib_inflate. Since the bootheader is 32bit and include/asm points
to 64bit headers, the source files cant be used as is.

I have tested the resulting zImage on a 44p 270, with stock yaboot 1.3.13.


 arch/ppc64/boot/Makefile   |   67 -
 arch/ppc64/boot/crt0.S     |   52 -
 arch/ppc64/boot/main.c     |  264 ++---
 arch/ppc64/boot/string.S   |    4 
 arch/ppc64/boot/string.h   |    1 
 arch/ppc64/boot/zImage.lds |   64 -
 arch/ppc64/boot/zlib.c     | 2195 ---------------------------------------------
 arch/ppc64/boot/zlib.h     |  432 --------
 include/linux/zutil.h      |    1 
 lib/zlib_inflate/inflate.c |    1 
 10 files changed, 191 insertions(+), 2890 deletions(-)

