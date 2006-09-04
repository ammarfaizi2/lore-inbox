Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWIDIqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWIDIqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 04:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWIDIqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 04:46:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:4936 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751181AbWIDIqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:46:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TUzYoYtVDFtS94Uhn+1zVNt/goFlNkYVnUYt4ge3eizQ1cVPQm2mFBAsVXrRmzo07gdGSQb0T0DG9omboa6PWq32d4tGI6Oxuv6LOPbvYLDO0fK84lvW0X52noSyKcb9cY86lRQhYK7PsdOORXBcXHcx4lXESNP0/fn3fVEd3oc=
Message-ID: <6d6a94c50609040146k3538ef21x2a6d426f344f1e2e@mail.gmail.com>
Date: Mon, 4 Sep 2006 16:46:44 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fill more device IDS in the structure of m25p80 driver
Cc: linux-mtd@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the structure:
struct flash_info __devinitdata m25p_data [] = {
/* REVISIT: fill in JEDEC ids, for parts that have them */
...
};

has a bunch of missing fields (like the JEDEC ids indicated) ... this
causes problems when actually trying to use some ST parts as it gets
detected incorrectly

The following is the patch.
----------------------------------------------------------------------
Signed-off-by: Aubrey L1 <aubreylee@gmail.com>
---

 * Fill more device IDS in the structure of m25p80 driver.
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index a846614..ef4a731 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -406,13 +406,13 @@ struct flash_info {

 static struct flash_info __devinitdata m25p_data [] = {
        /* REVISIT: fill in JEDEC ids, for parts that have them */
-       { "m25p05", 0x05, 0x0000, 32 * 1024, 2 },
-       { "m25p10", 0x10, 0x0000, 32 * 1024, 4 },
-       { "m25p20", 0x11, 0x0000, 64 * 1024, 4 },
-       { "m25p40", 0x12, 0x0000, 64 * 1024, 8 },
+       { "m25p05", 0x05, 0x2010, 32 * 1024, 2 },
+       { "m25p10", 0x10, 0x2011, 32 * 1024, 4 },
+       { "m25p20", 0x11, 0x2012, 64 * 1024, 4 },
+       { "m25p40", 0x12, 0x2013, 64 * 1024, 8 },
        { "m25p80", 0x13, 0x0000, 64 * 1024, 16 },
-       { "m25p16", 0x14, 0x0000, 64 * 1024, 32 },
-       { "m25p32", 0x15, 0x0000, 64 * 1024, 64 },
+       { "m25p16", 0x14, 0x2015, 64 * 1024, 32 },
+       { "m25p32", 0x15, 0x2016, 64 * 1024, 64 },
        { "m25p64", 0x16, 0x2017, 64 * 1024, 128 },
 };

Regards,
-Aubrey

-- 
VGER BF report: H 0.283918
