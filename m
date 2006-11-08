Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWKHTzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWKHTzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422718AbWKHTzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:55:19 -0500
Received: from rune.pobox.com ([208.210.124.79]:31366 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1422717AbWKHTzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:55:16 -0500
Date: Wed, 8 Nov 2006 13:55:11 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] nvidiafb: fix unreachable code in nv10GetConfig
Message-ID: <20061108195511.GK17028@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix binary/logical operator typo which leads to unreachable code.
Noticed while looking at other issues; I don't have the relevant
hardware to test this.


Signed-off-by: Nathan Lynch <ntl@pobox.com>

--- linux-2.6-powerpc.git.orig/drivers/video/nvidia/nv_setup.c
+++ linux-2.6-powerpc.git/drivers/video/nvidia/nv_setup.c
@@ -262,7 +262,7 @@ static void nv10GetConfig(struct nvidia_
 #endif
 
 	dev = pci_find_slot(0, 1);
-	if ((par->Chipset && 0xffff) == 0x01a0) {
+	if ((par->Chipset & 0xffff) == 0x01a0) {
 		int amt = 0;
 
 		pci_read_config_dword(dev, 0x7c, &amt);
