Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWGCJhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWGCJhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 05:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWGCJhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 05:37:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:61839 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750921AbWGCJhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 05:37:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=FHmYzrlRp3ihWHP0HbOSYUNiHaZQDF69h1RzEhiq9K4y7csXfZTU7FnaiWwSWd45ODYWI63c6YCDd+3IBdSjn4dvcTyp02s0OnYDy/TbJUITvW3JM+jmgpfnACuUaoTI8Ha2zyMQs3CEZSuO6aj4T0n5GFwHrM5wm5N9HuTDimQ=
Date: Mon, 3 Jul 2006 13:37:54 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] cris: switch to iminor/imajor
Message-ID: <20060703093754.GB7581@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/cris/arch-v10/drivers/eeprom.c      |    4 ++--
 arch/cris/arch-v10/drivers/gpio.c        |    2 +-
 arch/cris/arch-v32/drivers/cryptocop.c   |    2 +-
 arch/cris/arch-v32/drivers/gpio.c        |    2 +-
 arch/cris/arch-v32/drivers/sync_serial.c |   12 ++++++------
 5 files changed, 11 insertions(+), 11 deletions(-)

--- a/arch/cris/arch-v10/drivers/eeprom.c
+++ b/arch/cris/arch-v10/drivers/eeprom.c
@@ -450,9 +450,9 @@ int __init eeprom_init(void)
 static int eeprom_open(struct inode * inode, struct file * file)
 {
 
-  if(MINOR(inode->i_rdev) != EEPROM_MINOR_NR)
+  if(iminor(inode) != EEPROM_MINOR_NR)
      return -ENXIO;
-  if(MAJOR(inode->i_rdev) != EEPROM_MAJOR_NR)
+  if(imajor(inode) != EEPROM_MAJOR_NR)
      return -ENXIO;
 
   if( eeprom.size > 0 )
--- a/arch/cris/arch-v10/drivers/gpio.c
+++ b/arch/cris/arch-v10/drivers/gpio.c
@@ -435,7 +435,7 @@ static int
 gpio_open(struct inode *inode, struct file *filp)
 {
 	struct gpio_private *priv;
-	int p = MINOR(inode->i_rdev);
+	int p = iminor(inode);
 
 	if (p > GPIO_MINOR_LAST)
 		return -EINVAL;
--- a/arch/cris/arch-v32/drivers/cryptocop.c
+++ b/arch/cris/arch-v32/drivers/cryptocop.c
@@ -2302,7 +2302,7 @@ static int cryptocop_job_setup(struct cr
 
 static int cryptocop_open(struct inode *inode, struct file *filp)
 {
-	int p = MINOR(inode->i_rdev);
+	int p = iminor(inode);
 
 	if (p != CRYPTOCOP_MINOR) return -EINVAL;
 
--- a/arch/cris/arch-v32/drivers/gpio.c
+++ b/arch/cris/arch-v32/drivers/gpio.c
@@ -418,7 +418,7 @@ static int
 gpio_open(struct inode *inode, struct file *filp)
 {
 	struct gpio_private *priv;
-	int p = MINOR(inode->i_rdev);
+	int p = iminor(inode);
 
 	if (p > GPIO_MINOR_LAST)
 		return -EINVAL;
--- a/arch/cris/arch-v32/drivers/sync_serial.c
+++ b/arch/cris/arch-v32/drivers/sync_serial.c
@@ -340,7 +340,7 @@ static inline int sync_data_avail_to_end
 
 static int sync_serial_open(struct inode *inode, struct file *file)
 {
-	int dev = MINOR(inode->i_rdev);
+	int dev = iminor(inode);
 	sync_port* port;
 	reg_dma_rw_cfg cfg = {.en = regk_dma_yes};
 	reg_dma_rw_intr_mask intr_mask = {.data = regk_dma_yes};
@@ -486,7 +486,7 @@ static int sync_serial_open(struct inode
 
 static int sync_serial_release(struct inode *inode, struct file *file)
 {
-	int dev = MINOR(inode->i_rdev);
+	int dev = iminor(inode);
 	sync_port* port;
 
 	if (dev < 0 || dev >= NUMBER_OF_PORTS || !ports[dev].enabled)
@@ -504,7 +504,7 @@ static int sync_serial_release(struct in
 
 static unsigned int sync_serial_poll(struct file *file, poll_table *wait)
 {
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = iminor(file->f_dentry->d_inode);
 	unsigned int mask = 0;
 	sync_port* port;
 	DEBUGPOLL( static unsigned int prev_mask = 0; );
@@ -531,7 +531,7 @@ static int sync_serial_ioctl(struct inod
 		  unsigned int cmd, unsigned long arg)
 {
 	int return_val = 0;
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = iminor(file->f_dentry->d_inode);
 	sync_port* port;
 	reg_sser_rw_tr_cfg tr_cfg;
 	reg_sser_rw_rec_cfg rec_cfg;
@@ -789,7 +789,7 @@ static int sync_serial_ioctl(struct inod
 static ssize_t sync_serial_write(struct file * file, const char * buf,
                                  size_t count, loff_t *ppos)
 {
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = iminor(file->f_dentry->d_inode);
 	DECLARE_WAITQUEUE(wait, current);
 	sync_port *port;
 	unsigned long c, c1;
@@ -919,7 +919,7 @@ static ssize_t sync_serial_write(struct 
 static ssize_t sync_serial_read(struct file * file, char * buf,
 				size_t count, loff_t *ppos)
 {
-	int dev = MINOR(file->f_dentry->d_inode->i_rdev);
+	int dev = iminor(file->f_dentry->d_inode);
 	int avail;
 	sync_port *port;
 	unsigned char* start;

