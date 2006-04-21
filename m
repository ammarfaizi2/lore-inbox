Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWDUEuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWDUEuY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWDUEtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:49:49 -0400
Received: from mail.kroah.org ([69.55.234.183]:53633 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932232AbWDUEoG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:06 -0400
Date: Thu, 20 Apr 2006 21:39:33 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Barksdale <amatus@ocgnet.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/22] m41t00: fix bitmasks when writing to chip
Message-ID: <20060421043933.GQ12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="m41t00-fix-bitmasks-when-writing-to-chip.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Barksdale <amatus@ocgnet.org>

[PATCH] m41t00: fix bitmasks when writing to chip

Fix the bitmasks used when writing to the M41T00 registers.

The original code used a mask of 0x7f when writing to each register,
this is incorrect and probably the result of a copy-paste error.  As a
result years from 1980 to 1999 will be read back as 2000 to 2019.

Signed-off-by: David Barksdale <amatus@ocgnet.org>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/i2c/chips/m41t00.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.16.9.orig/drivers/i2c/chips/m41t00.c
+++ linux-2.6.16.9/drivers/i2c/chips/m41t00.c
@@ -129,13 +129,13 @@ m41t00_set_tlet(ulong arg)
 	if ((i2c_smbus_write_byte_data(save_client, 0, tm.tm_sec & 0x7f) < 0)
 		|| (i2c_smbus_write_byte_data(save_client, 1, tm.tm_min & 0x7f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 2, tm.tm_hour & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 2, tm.tm_hour & 0x3f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 4, tm.tm_mday & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 4, tm.tm_mday & 0x3f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 5, tm.tm_mon & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 5, tm.tm_mon & 0x1f)
 			< 0)
-		|| (i2c_smbus_write_byte_data(save_client, 6, tm.tm_year & 0x7f)
+		|| (i2c_smbus_write_byte_data(save_client, 6, tm.tm_year & 0xff)
 			< 0))
 
 		dev_warn(&save_client->dev,"m41t00: can't write to rtc chip\n");

--
