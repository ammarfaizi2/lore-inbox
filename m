Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUKJMlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUKJMlu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbUKJMlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:41:50 -0500
Received: from navi.cs.colorado.edu ([128.138.207.240]:39627 "EHLO navi.cx")
	by vger.kernel.org with ESMTP id S261761AbUKJMlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:41:44 -0500
Date: Wed, 10 Nov 2004 05:51:48 -0700
From: Micah Dowty <micah@navi.cx>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix for hdlcdrv (ham radio) CRC calculation
Message-ID: <20041110125148.GA3557@navi.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a trivial patch against the hdlcdrv module that fixes its CRC
calculation. The finished CRC was overwriting the first two bytes of
each packet rather than being appended to the end.

I've tested this with 2.6.8 and 2.6.10-rc1, but hdlcdrv hasn't changed
much recently so it should work with many other kernel versions.

Signed-off-by: Micah Dowty <micah@navi.cx>

(Not subscribed, please CC: replies)

--- drivers/net/hamradio/hdlcdrv.c.orig 2004-11-10 12:33:00.365920000 -0700
+++ drivers/net/hamradio/hdlcdrv.c      2004-11-10 12:34:02.043543576 -0700
@@ -106,6 +106,7 @@ static char ax25_nocall[AX25_ADDR_LEN] =
 static inline void append_crc_ccitt(unsigned char *buffer, int len)
 {
        unsigned int crc = crc_ccitt(0xffff, buffer, len) ^ 0xffff;
+       buffer += len;
        *buffer++ = crc;
        *buffer++ = crc >> 8;
 }

--Micah

-- 
Only you can prevent creeping featurism!
