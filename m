Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVL2BBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVL2BBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 20:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVL2BBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 20:01:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19416 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964950AbVL2BBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 20:01:09 -0500
Date: Wed, 28 Dec 2005 20:01:04 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: torvalds@osdl.org
Subject: fix ia64 compile failure with gcc4.1
Message-ID: <20051229010104.GA10929@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__get_unaligned creates a typeof the var its passed, and writes to it,
which on gcc4.1, spits out the following error:

drivers/char/vc_screen.c: In function 'vcs_write':
drivers/char/vc_screen.c:422: error: assignment of read-only variable 'val'

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/drivers/char/vc_screen.c~	2005-12-06 23:20:03.000000000 -0500
+++ linux-2.6.14/drivers/char/vc_screen.c	2005-12-06 23:21:35.000000000 -0500
@@ -419,7 +419,7 @@ vcs_write(struct file *file, const char 
 			while (this_round > 1) {
 				unsigned short w;
 
-				w = get_unaligned(((const unsigned short *)con_buf0));
+				w = get_unaligned(((unsigned short *)con_buf0));
 				vcs_scr_writew(vc, w, org++);
 				con_buf0 += 2;
 				this_round -= 2;


