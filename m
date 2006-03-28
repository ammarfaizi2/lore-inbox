Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWC1W7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWC1W7e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWC1W7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:15 -0500
Received: from [198.99.130.12] ([198.99.130.12]:24003 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964790AbWC1W7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:04 -0500
Message-Id: <200603282300.k2SN0JaP023007@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 10/10] UML - Fix min usage
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
type-safe min() in arch/um/drivers/mconsole_kern.c

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/drivers/mconsole_kern.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Index: linux-2.6.16-mm/arch/um/drivers/mconsole_kern.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/drivers/mconsole_kern.c	2006-03-28 09:30:36.000000000 -0500
+++ linux-2.6.16-mm/arch/um/drivers/mconsole_kern.c	2006-03-28 09:40:36.000000000 -0500
@@ -616,7 +616,7 @@ static void console_write(struct console
 		return;
 
 	while(1){
-		n = min(len, ARRAY_SIZE(console_buf) - console_index);
+		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
 		strncpy(&console_buf[console_index], string, n);
 		console_index += n;
 		string += n;

