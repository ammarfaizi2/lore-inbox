Return-Path: <linux-kernel-owner+w=401wt.eu-S1030244AbXADXCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbXADXCT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXADXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:02:19 -0500
Received: from mail.macqel.be ([194.78.208.39]:6579 "EHLO mail.macqel.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030244AbXADXCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:02:18 -0500
X-Greylist: delayed 1712 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 18:02:18 EST
Date: Thu, 4 Jan 2007 23:33:45 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linux-kernel@vger.kernel.org
Subject: PATCH i2c/m41t00 do not forget to write year
Message-ID: <20070104223345.GA786@ingate.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m41t00.c forgets to set the year field in set_rtc_time; fix that.

Signed-off-by: Philippe De Muyter <phdm@macqel.be>

--- drivers/i2c/chips/m41t00.c	2007-01-02 20:57:59.000000000 +0100
+++ drivers/i2c/chips/m41t00.c	2007-01-04 22:11:35.000000000 +0100
@@ -209,6 +209,7 @@ m41t00_set(void *arg)
 	buf[m41t00_chip->hour] = (buf[m41t00_chip->hour] & ~0x3f) | (hour& 0x3f);
 	buf[m41t00_chip->day] = (buf[m41t00_chip->day] & ~0x3f) | (day & 0x3f);
 	buf[m41t00_chip->mon] = (buf[m41t00_chip->mon] & ~0x1f) | (mon & 0x1f);
+	buf[m41t00_chip->year] = year;
 
 	if (i2c_master_send(save_client, wbuf, 9) < 0)
 		dev_err(&save_client->dev, "m41t00_set: Write error\n");
