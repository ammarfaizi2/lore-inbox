Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbUKGCeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbUKGCeU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUKGCeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:34:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15878 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261517AbUKGCeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:34:08 -0500
Date: Sun, 7 Nov 2004 03:33:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com, phil@netroedge.com
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] i2c/busses/ : make some code static
Message-ID: <20041107023333.GB14308@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code under i2c/busses/ 
static.


diffstat output:
 drivers/i2c/busses/i2c-ali1535.c |    4 ++--
 drivers/i2c/busses/i2c-amd8111.c |   12 ++++++------
 drivers/i2c/busses/scx200_acb.c  |    4 ++--
 drivers/i2c/busses/scx200_i2c.c  |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/i2c-ali1535.c.old	2004-11-07 02:46:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/i2c-ali1535.c	2004-11-07 02:47:15.000000000 +0100
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
--- linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/i2c-amd8111.c.old	2004-11-07 02:47:44.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/i2c-amd8111.c	2004-11-07 02:48:34.000000000 +0100
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
--- linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/scx200_acb.c.old	2004-11-07 02:48:54.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/scx200_acb.c	2004-11-07 02:49:53.000000000 +0100
@@ -402,9 +402,9 @@
 	.functionality	= scx200_acb_func,
 };
 
-struct scx200_acb_iface *scx200_acb_list;
+static struct scx200_acb_iface *scx200_acb_list;
 
-int scx200_acb_probe(struct scx200_acb_iface *iface)
+static int scx200_acb_probe(struct scx200_acb_iface *iface)
 {
 	u8 val;
 
--- linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/scx200_i2c.c.old	2004-11-07 02:52:05.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/i2c/busses/scx200_i2c.c	2004-11-07 02:50:30.000000000 +0100
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

