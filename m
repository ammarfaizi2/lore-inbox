Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVFFAMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVFFAMC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 20:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVFFAMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 20:12:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5764 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261160AbVFFAL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 20:11:59 -0400
Date: Sun, 5 Jun 2005 15:51:51 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: hjl@lucon.org, arjan@redhat.com, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] save 4 bytes in "thread_struct" by changing fs/gs to "unsigned short"
Message-ID: <20050605185151.GA19232@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi HJLu, Linus, Arjan,

Now that all users of fs and gs fields of "thread_struct" have been switched
to use "mov" instead of "movl" (newer binutils requirement), why not save
4 bytes switching those fields to 16-bit data types. 

No big deal, but as we say around here, "grain by grain the chicken gets fat".  

--- a/include/asm-i386/processor.h.orig	2005-06-05 20:11:00.000000000 -0300
+++ b/include/asm-i386/processor.h	2005-06-05 20:11:44.000000000 -0300
@@ -439,8 +439,8 @@ struct thread_struct {
 	unsigned long	sysenter_cs;
 	unsigned long	eip;
 	unsigned long	esp;
-	unsigned long	fs;
-	unsigned long	gs;
+	unsigned short	fs;
+	unsigned short	gs;
 /* Hardware debugging registers */
 	unsigned long	debugreg[8];  /* %%db0-7 debug registers */
 /* fault info */
