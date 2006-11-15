Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966860AbWKONpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966860AbWKONpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 08:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966861AbWKONpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 08:45:21 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:36120 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S966860AbWKONpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 08:45:20 -0500
Date: Wed, 15 Nov 2006 16:50:55 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: akpm@osdl.org
Cc: Deepak Saxena <dsaxena@mvista.com>, linux-kernel@vger.kernel.org,
       devel@openvz.org
Subject: [PATCH] i2c-ixp4xx: fix ") != 0))" typo
Message-ID: <20061115135055.GA8990@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i2c_bit_add_bus() returns -E;
-E != 0		=>	err = 1
probe fails with positive error code

Signed-off-by: Alexey Dobriyan <adobriyan@openvz.org>
---

 drivers/i2c/busses/i2c-ixp4xx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-ixp4xx.c
+++ b/drivers/i2c/busses/i2c-ixp4xx.c
@@ -137,7 +137,8 @@ static int ixp4xx_i2c_probe(struct platf
 	gpio_line_set(gpio->scl_pin, 0);
 	gpio_line_set(gpio->sda_pin, 0);
 
-	if ((err = i2c_bit_add_bus(&drv_data->adapter) != 0)) {
+	err = i2c_bit_add_bus(&drv_data->adapter);
+	if (err != 0)
 		printk(KERN_ERR "ERROR: Could not install %s\n", plat_dev->dev.bus_id);
 
 		kfree(drv_data);

