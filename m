Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266769AbUHWT5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266769AbUHWT5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbUHWTzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:55:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:42691 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266768AbUHWSgN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:13 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860883996@kroah.com>
Date: Mon, 23 Aug 2004 11:34:48 -0700
Message-Id: <10932860884059@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.36, 2004/08/09 10:47:35-07:00, greg@kroah.com

[PATCH] W1: fix some improper '{' style code.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/ds_w1_bridge.c |    6 ++----
 drivers/w1/dscore.c       |   15 +++++----------
 drivers/w1/w1.c           |    6 ++----
 drivers/w1/w1_io.c        |    6 ++----
 drivers/w1/w1_therm.c     |    6 ++----
 5 files changed, 13 insertions(+), 26 deletions(-)


diff -Nru a/drivers/w1/ds_w1_bridge.c b/drivers/w1/ds_w1_bridge.c
--- a/drivers/w1/ds_w1_bridge.c	2004-08-23 11:03:12 -07:00
+++ b/drivers/w1/ds_w1_bridge.c	2004-08-23 11:03:12 -07:00
@@ -122,15 +122,13 @@
 	int err;
 	
 	ds_bus_master = kmalloc(sizeof(*ds_bus_master), GFP_KERNEL);
-	if (!ds_bus_master)
-	{
+	if (!ds_bus_master) {
 		printk(KERN_ERR "Failed to allocate DS9490R USB<->W1 bus_master structure.\n");
 		return -ENOMEM;
 	}
 
 	ds_dev = ds_get_device();
-	if (!ds_dev)
-	{
+	if (!ds_dev) {
 		printk(KERN_ERR "DS9490R is not registered.\n");
 		err =  -ENODEV;
 		goto err_out_free_bus_master;
diff -Nru a/drivers/w1/dscore.c b/drivers/w1/dscore.c
--- a/drivers/w1/dscore.c	2004-08-23 11:03:12 -07:00
+++ b/drivers/w1/dscore.c	2004-08-23 11:03:12 -07:00
@@ -164,8 +164,7 @@
 		printk("%02x ", buf[i]);
 	printk("\n");
 
-	if (count >= 16)
-	{
+	if (count >= 16) {
 		ds_dump_status(buf, "enable flag", 0);
 		ds_dump_status(buf, "1-wire speed", 1);
 		ds_dump_status(buf, "strong pullup duration", 2);
@@ -186,8 +185,7 @@
 
 	memcpy(st, buf, sizeof(*st));
 
-	if (st->status & ST_EPOF)
-	{
+	if (st->status & ST_EPOF) {
 		printk(KERN_INFO "Resetting device after ST_EPOF.\n");
 		err = ds_send_control_cmd(dev, CTL_RESET_DEVICE, 0);
 		if (err)
@@ -197,8 +195,7 @@
 			return err;
 	}
 #if 0
-	if (st->status & ST_IDLE)
-	{
+	if (st->status & ST_IDLE) {
 		printk(KERN_INFO "Resetting pulse after ST_IDLE.\n");
 		err = ds_start_pulse(dev, PULLUP_PULSE_DURATION);
 		if (err)
@@ -311,8 +308,7 @@
 	do {
 		err = ds_recv_status_nodump(dev, st, buf, sizeof(buf));
 #if 0
-		if (err >= 0)
-		{	
+		if (err >= 0) {	
 			int i;
 			printk("0x%x: count=%d, status: ", dev->ep[EP_STATUS], err);
 			for (i=0; i<err; ++i)
@@ -343,8 +339,7 @@
 
 	ds_wait_status(dev, st);
 #if 0
-	if (st->command_buffer_status)
-	{
+	if (st->command_buffer_status) {
 		printk(KERN_INFO "Short circuit.\n");
 		return -EIO;
 	}
diff -Nru a/drivers/w1/w1.c b/drivers/w1/w1.c
--- a/drivers/w1/w1.c	2004-08-23 11:03:12 -07:00
+++ b/drivers/w1/w1.c	2004-08-23 11:03:12 -07:00
@@ -556,8 +556,7 @@
 
 			if (sl->reg_num.family == tmp->family &&
 			    sl->reg_num.id == tmp->id &&
-			    sl->reg_num.crc == tmp->crc)
-			{
+			    sl->reg_num.crc == tmp->crc) {
 				set_bit(W1_SLAVE_ACTIVE, (long *)&sl->flags);
 				break;
 			}
@@ -719,8 +718,7 @@
 		list_for_each_safe(ent, n, &dev->slist) {
 			sl = list_entry(ent, struct w1_slave, w1_slave_entry);
 
-			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags))
-			{
+			if (sl && !test_bit(W1_SLAVE_ACTIVE, (unsigned long *)&sl->flags)) {
 				list_del (&sl->w1_slave_entry);
 
 				w1_slave_detach (sl);
diff -Nru a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c	2004-08-23 11:03:12 -07:00
+++ b/drivers/w1/w1_io.c	2004-08-23 11:03:12 -07:00
@@ -136,8 +136,7 @@
 
 	if (dev->bus_master->read_block)
 		ret = dev->bus_master->read_block(dev->bus_master->data, buf, len);
-	else
-	{
+	else {
 		for (i = 0; i < len; ++i)
 			buf[i] = w1_read_8(dev);
 		ret = len;
@@ -152,8 +151,7 @@
 
 	if (dev->bus_master->reset_bus)
 		result = dev->bus_master->reset_bus(dev->bus_master->data) & 0x1;
-	else
-	{
+	else {
 		dev->bus_master->write_bit(dev->bus_master->data, 0);
 		w1_delay(480);
 		dev->bus_master->write_bit(dev->bus_master->data, 1);
diff -Nru a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c	2004-08-23 11:03:12 -07:00
+++ b/drivers/w1/w1_therm.c	2004-08-23 11:03:12 -07:00
@@ -116,8 +116,7 @@
 	verdict = 0;
 	crc = 0;
 
-	while (max_trying--)	
-	{
+	while (max_trying--) {
 		if (!w1_reset_bus (dev)) {
 			int count = 0;
 			u8 match[9] = {W1_MATCH_ROM, };
@@ -133,8 +132,7 @@
 					w1_write_block(dev, match, 9);
 
 					w1_write_8(dev, W1_READ_SCRATCHPAD);
-					if ((count = w1_read_block(dev, rom, 9)) != 9)
-					{
+					if ((count = w1_read_block(dev, rom, 9)) != 9) {
 						dev_warn(&dev->dev, "w1_read_block() returned %d instead of 9.\n", count);
 					}
 

