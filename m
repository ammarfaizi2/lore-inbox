Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVCKTef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVCKTef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVCKTaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:30:15 -0500
Received: from news.suse.de ([195.135.220.2]:28309 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261320AbVCKT3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:29:12 -0500
Date: Fri, 11 Mar 2005 20:28:58 +0100
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] be more verbose in gen-devlist
Message-ID: <20050311192858.GA11077@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gen-devlist should print how many bytes will be cut off and pci.ids
entry. Also print the removed '[more blah]' part.

Signed-off-by: Olaf Hering <olh@suse.de>

--- ../linux-2.6.10/drivers/pci/gen-devlist.c	2004-12-24 22:34:45.000000000 +0100
+++ ./drivers/pci/gen-devlist.c	2005-03-11 20:10:11.542098265 +0100
@@ -72,9 +72,19 @@ main(void)
 						/* Too long, try cutting off long description */
 						bra = strchr(c, '[');
 						if (bra && bra > c && bra[-1] == ' ')
+#if 0
+						{
+							fprintf(stderr, "Line %d: cut off '%s' from line:\n", lino, bra);
+							fprintf(stderr, " '%s'\n", c);
 							bra[-1] = 0;
+							fprintf(stderr, " '%s'\n", c);
+						}
+#else
+							bra[-1] = 0;
+#endif
 						if (vendor_len + strlen(c) + 1 > MAX_NAME_SIZE) {
-							fprintf(stderr, "Line %d: Device name too long. Name truncated.\n", lino);
+							fprintf(stderr, "Line %d: Device name %d chars too long. Name truncated.\n",
+									lino, (vendor_len + strlen(c) + 1) - MAX_NAME_SIZE);
 							fprintf(stderr, "%s\n", c);
 							/*return 1;*/
 						}
