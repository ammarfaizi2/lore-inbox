Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTBFNkK>; Thu, 6 Feb 2003 08:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTBFNkK>; Thu, 6 Feb 2003 08:40:10 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:18185 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267158AbTBFNkJ>; Thu, 6 Feb 2003 08:40:09 -0500
Date: Thu, 6 Feb 2003 13:49:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] Update of the input subsystem - 37 csets
Message-ID: <20030206134939.A9732@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vojtech Pavlik <vojtech@suse.cz>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030206141352.A10182@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030206141352.A10182@ucw.cz>; from vojtech@suse.cz on Thu, Feb 06, 2003 at 02:13:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  * Some laptops take the 789uiojklm,. keys as number pad when NumLock is on.
  * This seems a good reason to start with NumLock off.
  */
+#ifndef CONFIG_X86_PC9800
 #define KBD_DEFLEDS 0
+#else
+#define KBD_DEFLEDS (1 << VC_NUMLOCK)
+#endif
 #endif

This ifdef is the wrong way around.
But having something like

#ifndef KBD_DEFLEDS
#define KBD_DEFLEDS 0
#endif

and the PC98-specific stuff in a asm header sounds like a much better plan.
 
 
--- bk/include/linux/serio.h	Thu Feb  6 13:10:36 2003
+++ bk+input/include/linux/serio.h	Thu Feb  6 13:21:56 2003
@@ -10,10 +10,13 @@
  */
 
 #include <linux/ioctl.h>
-#include <linux/list.h>
 
 #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
 
+#ifdef __KERNEL__
+
+#include <linux/list.h>


Don't add more #ifdef __KERNEL__ - the kernel headers aren't supposed
to be included from userspace.

