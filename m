Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbTEFQ0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTEFQZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:25:44 -0400
Received: from mail.convergence.de ([212.84.236.4]:9417 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263944AbTEFQOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:14:01 -0400
Message-ID: <3EB7E110.80500@convergence.de>
Date: Tue, 06 May 2003 18:21:36 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][9-11] correct the i2c address of the saa7111
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090303040309090109080109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090303040309090109080109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch corrects the i2c address from "34>>1" to 0x24 and 0x25. 
Believe me -- or look at the data sheet, for example from
http://www.gdv.uni-hannover.de/~hunold1/linux/saa7146/specs/saa7111a.pdf

Page 41 says: "Slave address read = 49H or 4BH; note 2 write = 48H or 4AH"

They use 8-bit addresses here, but i2c addresses are 7-bit, ie. 0x48>>1 
== 0x24 and 0x4a>>1 = 0x25

Please apply.

Thanks
Michael Hunold.











--------------090303040309090109080109
Content-Type: text/plain;
 name="09-saa7111-i2c-address-fixup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="09-saa7111-i2c-address-fixup.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/drivers/media/video/saa7111.c linux-2.5.69.patch/drivers/media/video/saa7111.c
--- linux-2.5.69/drivers/media/video/saa7111.c	2003-05-06 13:16:21.000000000 +0200
+++ linux-2.5.69.patch/drivers/media/video/saa7111.c	2003-05-06 17:18:27.000000000 +0200
@@ -57,7 +57,7 @@
 	int sat;
 };
 
-static unsigned short normal_i2c[] = { 34>>1, I2C_CLIENT_END };	
+static unsigned short normal_i2c[] = { 0x24, 0x25, I2C_CLIENT_END };    
 static unsigned short normal_i2c_range[] = { I2C_CLIENT_END };	
 
 I2C_CLIENT_INSMOD;

--------------090303040309090109080109--


