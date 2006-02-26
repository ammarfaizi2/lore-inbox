Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWBZLJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWBZLJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 06:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBZLJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 06:09:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:30735 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751321AbWBZLJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 06:09:27 -0500
Date: Sun, 26 Feb 2006 12:09:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>
Subject: block/floppy: fix section mismatch warnings
Message-ID: <20060226110920.GA25323@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In latest -mm a number of section mismatch warnings are generated for
floppy.o like the following:
WARNING: drivers/block/floppy.o - Section mismatch: reference to    \
.init.data: from .text between 'init_module' (at offset 0x6976) and \
'cleanup_module'

The warning are caused by a reference to floppy_init() which is __init
from init_module() which is not declared __init.
Declaring init_module() _init fixes this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 65dbc5b..bedb689 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4614,7 +4614,7 @@ static void __init parse_floppy_cfg_stri
 	}
 }
 
-int init_module(void)
+int __init init_module(void)
 {
 	if (floppy)
 		parse_floppy_cfg_string(floppy);
