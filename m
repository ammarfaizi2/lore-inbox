Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUG0W5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUG0W5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266692AbUG0W5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:57:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23689 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266689AbUG0W5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:57:16 -0400
Date: Tue, 27 Jul 2004 18:56:33 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: fix bogus ioctl return in mtrr
Message-ID: <20040727225633.GA23921@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is fairly self explanatory - ENOIOCTLCMD is an internal code outside of
the -1 to -511 range. The correct return for an unknown ioctl is -ENOTTY
although some Linux devices return the incorrect -EINVAL result.

Patch-By: Alan Cox <alan@redhat.com>
OSDL Developer Certificate of Origin 1.0 included herein by reference

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/arch/i386/kernel/cpu/mtrr/if.c 2.6.7-ac/arch/i386/kernel/cpu/mtrr/if.c
--- linux-2.6.7/arch/i386/kernel/cpu/mtrr/if.c	2004-06-16 21:10:14.000000000 +0100
+++ 2.6.7-ac/arch/i386/kernel/cpu/mtrr/if.c	2004-06-26 19:01:54.000000000 +0100
@@ -160,7 +160,7 @@
 
 	switch (cmd) {
 	default:
-		return -ENOIOCTLCMD;
+		return -ENOTTY;
 	case MTRRIOC_ADD_ENTRY:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;



