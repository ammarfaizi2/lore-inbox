Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWBPPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWBPPEZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWBPPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 10:04:25 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44423 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932536AbWBPPEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 10:04:24 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/1] swsusp: fix breakage with swap on LVM
Date: Thu, 16 Feb 2006 16:03:48 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@redhat.com>,
       LKML <linux-kernel@vger.kernel.org>
References: <200602161558.57702.rjw@sisk.pl>
In-Reply-To: <200602161558.57702.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602161603.49329.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the compatibility with the older code and make it possible to
suspend if the kernel command line doesn't contain the "resume="
argument


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/swsusp.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.16-rc3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.16-rc3.orig/kernel/power/swsusp.c
+++ linux-2.6.16-rc3/kernel/power/swsusp.c
@@ -153,13 +153,11 @@ static int swsusp_swap_check(void) /* Th
 {
 	int i;
 
-	if (!swsusp_resume_device)
-		return -ENODEV;
 	spin_lock(&swap_lock);
 	for (i = 0; i < MAX_SWAPFILES; i++) {
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
-		if (is_resume_device(swap_info + i)) {
+		if (!swsusp_resume_device || is_resume_device(swap_info + i)) {
 			spin_unlock(&swap_lock);
 			root_swap = i;
 			return 0;

