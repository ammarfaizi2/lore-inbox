Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSKUWWc>; Thu, 21 Nov 2002 17:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264978AbSKUWWc>; Thu, 21 Nov 2002 17:22:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:10880 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S264944AbSKUWWa>;
	Thu, 21 Nov 2002 17:22:30 -0500
Date: Thu, 21 Nov 2002 14:29:37 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Use min_t() instead of min() in fs/ntfs/attrib.c
Message-ID: <20021121222937.GB1431@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change removes a "duplicate 'const'" compiler warning.

diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	Thu Nov 21 13:51:26 2002
+++ b/fs/ntfs/attrib.c	Thu Nov 21 13:51:26 2002
@@ -1183,8 +1183,9 @@
 			register int rc;
 			
 			rc = memcmp(val, (u8*)a + le16_to_cpu(
-					a->_ARA(value_offset)), min(val_len,
-					le32_to_cpu(a->_ARA(value_length))));
+					a->_ARA(value_offset)),
+				    min_t(const u32, val_len,
+					  le32_to_cpu(a->_ARA(value_length))));
 			/*
 			 * If @val collates before the current attribute's
 			 * value, there is no matching attribute.
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
