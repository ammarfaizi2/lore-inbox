Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758545AbWK0UBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758545AbWK0UBY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 15:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758546AbWK0UBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 15:01:24 -0500
Received: from ns1.suse.de ([195.135.220.2]:41954 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758545AbWK0UBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 15:01:24 -0500
Date: Mon, 27 Nov 2006 13:20:52 +0100
From: Stefan Seyfried <seife@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061127122052.GA14752@suse.de>
References: <fa.U3NcOE+DHLOUMSq6HkaGglGl7hQ@ifi.uio.no> <fa.YMVQ6sabKF/IkEHUCoiQoxoHWZA@ifi.uio.no> <fa.c5fVj98hBgqoUumwbA9jymiSXr8@ifi.uio.no> <fa.zMBHTAXYfXNe2TVX89s3qsC2HRk@ifi.uio.no> <fa.yA6cvuiGulIRQfqY+E9joR2nWog@ifi.uio.no> <fa.bo0iOgKqELDD50VEZpxeUpzPsMg@ifi.uio.no> <45693E25.9010504@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45693E25.9010504@shaw.ca>
X-Operating-System: openSUSE 10.2 (i586), Kernel 2.6.18.2-23-default
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 01:11:33AM -0600, Robert Hancock wrote:
> options seem to work, and vbetool appears to helpfully segfault on any operation so that's out. 

Try this one:

From: Matthew Garrett
Subject: Fix failures on AMD64

This patch fixes at least some of the cases where vbetool segfaulted on x86_64
while the x86 emulator was executing BIOS code.

--- x86-common.c
+++ x86-common.c
@@ -33,8 +33,8 @@
 
 #include "include/lrmi.h"
 
-#define REAL_MEM_BASE 	((void *)0x10000)
-#define REAL_MEM_SIZE 	0x90000
+#define REAL_MEM_BASE 	((void *)0x1000)
+#define REAL_MEM_SIZE 	0xa0000
 #define REAL_MEM_BLOCKS 	0x100
 
 struct mem_block {


I have this in our vbetool-0.7 packages and have no reports about
segfaults since then.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
