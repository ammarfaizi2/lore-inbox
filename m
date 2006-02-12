Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWBLNJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBLNJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWBLNJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:09:07 -0500
Received: from cantor.suse.de ([195.135.220.2]:58502 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750722AbWBLNJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:09:06 -0500
Date: Sun, 12 Feb 2006 14:09:03 +0100
From: Olaf Hering <olh@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] updated fstatat64 support
Message-ID: <20060212130903.GA20732@suse.de>
References: <200602101528.k1AFSFIg011658@devserv.devel.redhat.com> <20060211112157.GA9371@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060211112157.GA9371@osiris.boeblingen.de.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


s390 doesnt compile because sys_newfstatat() is not defined.
__ARCH_WANT_STAT64 is defined for 32bit build in
include/asm-s390/unistd.h. This change fixes compilation, but its likely
not correct to do it that way:

Index: linux-2.6.15/fs/stat.c
===================================================================
--- linux-2.6.15.orig/fs/stat.c
+++ linux-2.6.15/fs/stat.c
@@ -261,7 +261,7 @@ asmlinkage long sys_newlstat(char __user
        return error;
 }
 
-#ifndef __ARCH_WANT_STAT64
+#ifdef __ARCH_WANT_STAT64
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
                                struct stat __user *statbuf, int flag)
 {



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
