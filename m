Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbUKIFdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUKIFdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 00:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUKIF0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 00:26:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:47774 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261369AbUKIFYw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 00:24:52 -0500
Subject: Re: [PATCH] I2C update for 2.6.10-rc1
In-Reply-To: <10999778572385@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 8 Nov 2004 21:24:17 -0800
Message-Id: <10999778574055@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2014.1.22, 2004/11/08 16:45:39-08:00, bunk@stusta.de

[PATCH] i2c/busses/ : make some code static

The patch below makes some needlessly global code under i2c/busses/
static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/i2c-ali1535.c |    4 ++--
 drivers/i2c/busses/i2c-amd8111.c |   12 ++++++------
 drivers/i2c/busses/scx200_acb.c  |    4 ++--
 drivers/i2c/busses/scx200_i2c.c  |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali1535.c b/drivers/i2c/busses/i2c-ali1535.c
--- a/drivers/i2c/busses/i2c-ali1535.c	2004-11-08 18:54:33 -08:00
+++ b/drivers/i2c/busses/i2c-ali1535.c	2004-11-08 18:54:33 -08:00
@@ -137,7 +137,7 @@
 
 
 static unsigned short ali1535_smba;
-DECLARE_MUTEX(i2c_ali1535_sem);
+static DECLARE_MUTEX(i2c_ali1535_sem);
 
 /* Detect whether a ALI1535 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
@@ -465,7 +465,7 @@
 }
 
 
-u32 ali1535_func(struct i2c_adapter *adapter)
+static u32 ali1535_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	2004-11-08 18:54:33 -08:00
+++ b/drivers/i2c/busses/i2c-amd8111.c	2004-11-08 18:54:33 -08:00
@@ -67,7 +67,7 @@
  * ACPI 2.0 chapter 13 access of registers of the EC
  */
 
-unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
+static unsigned int amd_ec_wait_write(struct amd_smbus *smbus)
 {
 	int timeout = 500;
 
@@ -82,7 +82,7 @@
 	return 0;
 }
 
-unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
+static unsigned int amd_ec_wait_read(struct amd_smbus *smbus)
 {
 	int timeout = 500;
 
@@ -97,7 +97,7 @@
 	return 0;
 }
 
-unsigned int amd_ec_read(struct amd_smbus *smbus, unsigned char address, unsigned char *data)
+static unsigned int amd_ec_read(struct amd_smbus *smbus, unsigned char address, unsigned char *data)
 {
 	if (amd_ec_wait_write(smbus))
 		return -1;
@@ -114,7 +114,7 @@
 	return 0;
 }
 
-unsigned int amd_ec_write(struct amd_smbus *smbus, unsigned char address, unsigned char data)
+static unsigned int amd_ec_write(struct amd_smbus *smbus, unsigned char address, unsigned char data)
 {
 	if (amd_ec_wait_write(smbus))
 		return -1;
@@ -174,7 +174,7 @@
 #define AMD_SMB_PRTCL_PEC		0x80
 
 
-s32 amd8111_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
+static s32 amd8111_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
 		char read_write, u8 command, int size, union i2c_smbus_data * data)
 {
 	struct amd_smbus *smbus = adap->algo_data;
@@ -315,7 +315,7 @@
 }
 
 
-u32 amd8111_func(struct i2c_adapter *adapter)
+static u32 amd8111_func(struct i2c_adapter *adapter)
 {
 	return	I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA |
diff -Nru a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
--- a/drivers/i2c/busses/scx200_acb.c	2004-11-08 18:54:33 -08:00
+++ b/drivers/i2c/busses/scx200_acb.c	2004-11-08 18:54:33 -08:00
@@ -402,9 +402,9 @@
 	.functionality	= scx200_acb_func,
 };
 
-struct scx200_acb_iface *scx200_acb_list;
+static struct scx200_acb_iface *scx200_acb_list;
 
-int scx200_acb_probe(struct scx200_acb_iface *iface)
+static int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
 
diff -Nru a/drivers/i2c/busses/scx200_i2c.c b/drivers/i2c/busses/scx200_i2c.c
--- a/drivers/i2c/busses/scx200_i2c.c	2004-11-08 18:54:33 -08:00
+++ b/drivers/i2c/busses/scx200_i2c.c	2004-11-08 18:54:33 -08:00
@@ -86,7 +86,7 @@
 	.name	= "NatSemi SCx200 I2C",
 };
 
-int scx200_i2c_init(void)
+static int scx200_i2c_init(void)
 {
 	pr_debug(NAME ": NatSemi SCx200 I2C Driver\n");
 
@@ -115,7 +115,7 @@
 	return 0;
 }
 
-void scx200_i2c_cleanup(void)
+static void scx200_i2c_cleanup(void)
 {
 	i2c_bit_del_bus(&scx200_i2c_ops);
 }

