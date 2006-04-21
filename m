Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWDUEtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWDUEtj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWDUEoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:41857 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932234AbWDUEoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:01 -0400
Date: Thu, 20 Apr 2006 21:37:45 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Brian Hinz <bphinz@hotmail.com>, H Peter Anvin <hpa@zytor.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/22] efficeon-agp: Add missing memory mask
Message-ID: <20060421043745.GD12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="efficeon-agp-add-missing-memory-mask.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Original patch by Benjamin Herrenschmidt after debugging by Brian Hinz.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brian Hinz <bphinz@hotmail.com>
Signed-off-by: H Peter Anvin <hpa@zytor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/agp/efficeon-agp.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.16.9.orig/drivers/char/agp/efficeon-agp.c
+++ linux-2.6.16.9/drivers/char/agp/efficeon-agp.c
@@ -64,6 +64,12 @@ static struct gatt_mask efficeon_generic
 	{.mask = 0x00000001, .type = 0}
 };
 
+/* This function does the same thing as mask_memory() for this chipset... */
+static inline unsigned long efficeon_mask_memory(unsigned long addr)
+{
+	return addr | 0x00000001;
+}
+
 static struct aper_size_info_lvl2 efficeon_generic_sizes[4] =
 {
 	{256, 65536, 0},
@@ -251,7 +257,7 @@ static int efficeon_insert_memory(struct
 	last_page = NULL;
 	for (i = 0; i < count; i++) {
 		int index = pg_start + i;
-		unsigned long insert = mem->memory[i];
+		unsigned long insert = efficeon_mask_memory(mem->memory[i]);
 
 		page = (unsigned int *) efficeon_private.l1_table[index >> 10];
 

--
