Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUEYQsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUEYQsM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 12:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264969AbUEYQsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 12:48:12 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:50399 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264961AbUEYQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 12:48:10 -0400
Message-ID: <40B36A0E.5080509@kegel.com>
Date: Tue, 25 May 2004 08:45:18 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bringing back 'make symlinks'?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the 2.4 kernel, 'make symlinks' created the symlinks needed
to use the kernel tree's headers for building a gcc/glibc toolchain.

In the 2.6 kernel, you can do the same thing with 'include include/asm'.
Unless you're trying to build arm or cris, or maybe others, in which case you also need
'include/asm-$(ARCH)/.arch'.

That's fine, but it means that a script (like crosstool) or a book (like LFS)
that's trying to build a gcc/glibc toolchain for both 2.4 and 2.6 ends up
with a section like

case "$KERNEL_VERSION.$KERNEL_PATCHLEVEL.x" in
2.2.x|2.4.x) make ARCH=$ARCH symlinks    include/linux/version.h
              ;;
2.6.x)       make ARCH=$ARCH include/asm include/linux/version.h
              case $ARCH in
              arm*|cris*) make ARCH=$ARCH include/asm-$ARCH/.arch
                          ;;
              esac
              ;;
*)           abort "Unsupported kernel version $KERNEL_VERSION.$KERNEL_PATCHLEVEL"
esac

which is a bit ugly.  It'd be nice if 'make symlinks' did the neccesary
stuff in 2.6, too.  Think a patch to do that would be accepted?
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
