Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263210AbTDCANH>; Wed, 2 Apr 2003 19:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263237AbTDCAHu>; Wed, 2 Apr 2003 19:07:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:11142 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263214AbTDCACN> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10493289583083@kroah.com>
Subject: Re: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <1049328958830@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:58 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.9, 2003/04/02 11:48:13-08:00, greg@kroah.com

i2c: remove unused paramater in found_proc callback function.

(the users of this function have already been changed in previous patches)


 drivers/i2c/i2c-proc.c   |    4 ++--
 include/linux/i2c-proc.h |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/i2c-proc.c b/drivers/i2c/i2c-proc.c
--- a/drivers/i2c/i2c-proc.c	Wed Apr  2 16:00:55 2003
+++ b/drivers/i2c/i2c-proc.c	Wed Apr  2 16:00:55 2003
@@ -69,7 +69,7 @@
 				      ((this_force->force[j] == SENSORS_ANY_I2C_BUS) && !is_isa)) &&
 				      (addr == this_force->force[j + 1]) ) {
 					dev_dbg(&adapter->dev, "found force parameter for adapter %d, addr %04x\n", adapter_id, addr);
-					if ((err = found_proc(adapter, addr, 0, this_force->kind)))
+					if ((err = found_proc(adapter, addr, this_force->kind)))
 						return err;
 					found = 1;
 				}
@@ -162,7 +162,7 @@
 		   whether there is some client here at all! */
 		if (is_isa ||
 		    (i2c_smbus_xfer (adapter, addr, 0, 0, 0, I2C_SMBUS_QUICK, NULL) >= 0))
-			if ((err = found_proc(adapter, addr, 0, -1)))
+			if ((err = found_proc(adapter, addr, -1)))
 				return err;
 	}
 	return 0;
diff -Nru a/include/linux/i2c-proc.h b/include/linux/i2c-proc.h
--- a/include/linux/i2c-proc.h	Wed Apr  2 16:00:55 2003
+++ b/include/linux/i2c-proc.h	Wed Apr  2 16:00:55 2003
@@ -328,8 +328,7 @@
   SENSORS_INSMOD
 
 typedef int i2c_found_addr_proc(struct i2c_adapter *adapter,
-				    int addr, unsigned short flags,
-				    int kind);
+				    int addr, int kind);
 
 /* Detect function. It iterates over all possible addresses itself. For
    SMBus addresses, it will only call found_proc if some client is connected

