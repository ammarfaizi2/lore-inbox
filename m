Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUDNW3C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 18:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUDNW15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 18:27:57 -0400
Received: from mail.kroah.org ([65.200.24.183]:39071 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261951AbUDNWY6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 18:24:58 -0400
Subject: Re: [PATCH] I2C update for 2.6.5
In-Reply-To: <10819814502077@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 14 Apr 2004 15:24:10 -0700
Message-Id: <10819814502943@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.10, 2004/03/30 14:27:06-08:00, khali@linux-fr.org

[PATCH] I2C: Incorrect memset in eeprom.c

Quoting Ralf Roesch:

> currently I'm only working with Linux MIPS 2.4 kernel,
> so it would be nice if you could forward the patch for 2.6.

OK, so here we are. Greg, this is the port to 2.6 of Ralf patch that
fixes an incorrect memset while initializing the eeprom driver. Please
apply.


 drivers/i2c/chips/eeprom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Wed Apr 14 15:14:11 2004
+++ b/drivers/i2c/chips/eeprom.c	Wed Apr 14 15:14:11 2004
@@ -197,7 +197,7 @@
 				 sizeof(struct eeprom_data));
 
 	data = (struct eeprom_data *) (new_client + 1);
-	memset(data, 0xff, EEPROM_SIZE);
+	memset(data->data, 0xff, EEPROM_SIZE);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;

