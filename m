Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318937AbSHMFpX>; Tue, 13 Aug 2002 01:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318938AbSHMFpX>; Tue, 13 Aug 2002 01:45:23 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:18074 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318937AbSHMFpX>; Tue, 13 Aug 2002 01:45:23 -0400
Message-ID: <3D589DD3.A8C16F2B@attbi.com>
Date: Tue, 13 Aug 2002 01:49:07 -0400
From: Albert Cranford <ac9410@attbi.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 1/4] 2.4.20-pre2 i2c updates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,
Please apply the following four tested patches that update
2.4.20-pre2 with these I2C changes:
o Support for SMBus 2.0 PEC Packet Error Checking
o New adapter-i2c-frodo for SA 1110 board
o New adapter-i2c-rpx for embeded MPC8XX
o Remove compat code for < 2.4
o Replace cli()&sti() with spin_{un}lock_irq()
o Updated documentation
Thanks,
Albert
--- linux/drivers/i2c/Config.in.orig    2002-07-23 01:47:14.000000000 -0400
+++ linux/drivers/i2c/Config.in 2002-07-23 01:47:14.000000000 -0400
@@ -32,10 +32,10 @@
          dep_tristate '  Embedded Planet RPX Lite/Classic suppoort' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
       fi
    fi
-   if [ "$CONFIG_405" = "y" ]; then
-      dep_tristate 'PPC 405 I2C Algorithm' CONFIG_I2C_PPC405_ALGO $CONFIG_I2C
-      if [ "$CONFIG_I2C_PPC405_ALGO" != "n" ]; then
-         dep_tristate '  PPC 405 I2C Adapter' CONFIG_I2C_PPC405_ADAP $CONFIG_I2C_PPC405_ALGO
+   if [ "$CONFIG_IBM_OCP" = "y" ]; then
+      dep_tristate 'IBM on-chip I2C Algorithm' CONFIG_I2C_IBM_OCP_ALGO $CONFIG_I2C
+      if [ "$CONFIG_I2C_IBM_OCP_ALGO" != "n" ]; then
+         dep_tristate '  IBM on-chip I2C Adapter' CONFIG_I2C_IBM_OCP_ADAP $CONFIG_I2C_IBM_OCP_ALGO
       fi
    fi
 
@@ -47,7 +47,7 @@
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 
 fi
 endmenu

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
