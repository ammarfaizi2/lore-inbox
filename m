Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUGZUDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUGZUDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUGZUDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:03:55 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:9660 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S265489AbUGZTMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:12:52 -0400
Message-ID: <41055722.2070104@us.ibm.com>
Date: Mon, 26 Jul 2004 14:10:26 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: wenxiong@us.ibm.com, linux-serial@vger.kernel.org
Subject: new device driver to enable the IBM Multiport Serial Adapter in Linux
Content-Type: multipart/mixed;
 boundary="------------030502080108000505030809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030502080108000505030809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The patch below enables the IBM Multiport Serial Adapter for the Linux 
OS.  This driver is for a family of multiport serial adapters including 
2 port RVX, 2 port internal modem, 4 port internal modem and a split 1 
port RVX and 1 port internal modem.  We have applied & tested this patch 
against our iSeries and pSeries machines (there are no known existing 
defects following this testing).

We would like this code accepted into the kernel.  It was previosly 
submitted to the linux-serial mailing list, and we believe we have 
addressed any coding issues raised.   Are there any additional concerns? 
 How do you suggest we proceed to have this code accepted?

Thanks for you time and help!

Wendy
wenxiong@us.ibm.com

(p.s  this email is coming from girouard@us.ibm.com due to formatting 
issues when using Wendy's email)


--------------030502080108000505030809
Content-Type: text/plain;
 name="icom-2.6.5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="icom-2.6.5.patch"

diff -Nur orig/Documentation/serial/icom.txt devel/Documentation/serial/icom.txt
--- orig/Documentation/serial/icom.txt	1969-12-31 16:00:00.000000000 -0800
+++ devel/Documentation/serial/icom.txt	2004-04-02 15:31:30.000000000 -0800
@@ -0,0 +1,118 @@
+Internal modem country code setting for icom serial device driver adapters.
+
+If the icom serial device driver adapter you are using contains an internal
+modem you may need to configure your modem for your country.  You can use
+the proc file data provided by the icom driver to determine whether an
+internal modem is present.  Simply "cat /proc/tty/driver/icom" and analyze
+its output.  If the cable field in the icom proc file output indicates an
+"InternalModem" type (1) then that port contains an internal modem and may
+need to have its country code set.  Using a serial console, you will need
+to issue an AT commands to determine the current country code setting.  The
+major and minor number of the port containing the internal modem can also
+be obtained from icom proc file data.  Using this information you can
+determine which tty device to open with your serial console.  Once the
+serial console is opened against the proper device, issue the command
+"ATI9" to the modem.  The first set of digits returned are the encoded
+country code setting for the modem (in decimal), eg.
+
+>ATI9
+>52
+>
+>(.$MTS0314\\MODEM\TIA0602,TIA0578\MultiTech Systems MT5656SMI-L38)
+>
+>OK
+
+In this example, the country code setting of the modem is set to "52".  By
+referencing the table below you can determine if the current country code
+is set correctly.  If you find that the country code is not set correctly,
+you will need to issue another command to the modem to set the country
+code.  The command to set a new country code is "AT%T19,0,x", where x is
+the new country code (in hex), eg. to set a new country code for Japan,
+issue the command "AT%T19,0,10".  Use "ATI9" to verify the country code was
+set correctly.
+
+         Country        Country     Country
+          Code           Code
+          (hex)        (decimal)
+           34             52     * AR Argentina *
+           34             52     * AW Aruba *
+            1              1     * AU Australia *
+           34             52     * AT Austria *
+           34             52     * BH Bahrain *
+           34             52     * BE Belgium *
+           34             52     * BR Brazil *
+           34             52     * BN Brunei Darussalam *
+           34             52     * CA Canada *
+           34             52     * KY Cayman Islands *
+           34             52     * CL Chile *
+           34             52     * CN China *
+           34             52     * CO Colombia *
+           34             52     * CR Costa Rica *
+           34             52     * HR Croatia *
+           34             52     * CY Cyprus *
+           25             37     * CZ Czech Republic *
+           34             52     * DK Denmark *
+           34             52     * EC Ecuador *
+           34             52     * EG Egypt *
+           34             52     * FI Finland *
+           34             52     * FR France *
+           34             52     * DE Germany *
+           34             52     * GR Greece *
+           34             52     * GT Guatemala *
+           30             48     * HK China (Hong Kong S.A.R.) *
+           30             48     * HU Hungary *
+           34             52     * IS Iceland *
+           30             48     * IN India *
+           30             48     * ID Indonesia *
+           34             52     * IE Ireland *
+           30             48     * IL Israel *
+           34             52     * IT Italy *
+           34             52     * JM Jamaica *
+           10             16     * JP Japan *
+           34             52     * KR Korea, Republic of *
+           34             52     * LU Luxembourg *
+           34             52     * MO China (Macau S.A.R.) *
+           30             48     * MY Malaysia *
+           34             52     * MX Mexico *
+           34             52     * MA Morocco *
+           34             52     * NL Netherlands *
+           34             52     * AN Netherlands Antilles *
+            9              9     * NZ New Zealand *
+           34             52     * NO Norway *
+           34             52     * PK Pakistan *
+           34             52     * PA Panama *
+           34             52     * PE Peru *
+           30             48     * PH Philippines *
+           30             48     * PL Poland *
+           34             52     * PT Portugal *
+           34             52     * QA Qatar *
+           34             52     * RO Romania *
+           34             52     * RU Russia *
+           34             52     * SA Saudi Arabia *
+           30             48     * SG Singapore *
+           34             52     * SK Slovakia *
+           30             48     * SI Slovenia *
+           35             53     * ZA South Africa *
+           34             52     * ES Spain *
+           34             52     * LK Sri Lanka *
+           34             52     * SE Sweden *
+           34             52     * CH Switzerland *
+           34             52     * TW Taiwan *
+           34             52     * TH Thailand *
+           34             52     * TT Trinidad and Tobago *
+           34             52     * TR Turkey *
+           34             52     * UA Ukraine *
+           34             52     * AE United Arab Emirates *
+           34             52     * GB United Kingdom *
+           34             52     * US United States of America*
+           34             52     * UY Uruguay *
+           34             52     * VE Venezuela *
+           30             48     * VN Vietnam *
+
+
+(1) The older serial adapters supported by this device driver do not
+indicate when an Internal modem is present.  If the serial adapter
+installed in your system is a model 2771 then Port 0 is the internal modem
+which may require country code configuration.  If the serial adapter
+installed in your system is a model 2772 (0609/0610), then both Port 0 and
+Port 1 are internal modems which may require country code configuration.
diff -Nur orig/drivers/serial/Kconfig devel/drivers/serial/Kconfig
--- orig/drivers/serial/Kconfig	2004-04-02 15:19:36.000000000 -0800
+++ devel/drivers/serial/Kconfig	2004-04-02 15:31:30.000000000 -0800
@@ -562,5 +562,16 @@
 	  on your PowerMac as the console, you can do so by answering
 	  Y to this option.
 
+config SERIAL_ICOM
+	tristate "IBM Multiport Serial Adapter"
+	select SERIAL_CORE
+	help
+	  This driver is for a family of multiport serial adapters
+	  including 2 port RVX, 2 port internal modem, 4 port internal
+	  modem and a split 1 port RVX and 1 port internal modem.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called icom.
+
 endmenu
 
diff -Nur orig/drivers/serial/Makefile devel/drivers/serial/Makefile
--- orig/drivers/serial/Makefile	2004-04-02 15:19:40.000000000 -0800
+++ devel/drivers/serial/Makefile	2004-04-02 15:30:01.000000000 -0800
@@ -36,3 +36,4 @@
 obj-$(CONFIG_SERIAL_AU1X00) += au1x00_uart.o
 obj-$(CONFIG_SERIAL_DZ) += dz.o
 obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
+obj-$(CONFIG_SERIAL_ICOM) += icom.o
diff -Nur orig/drivers/serial/icom.c devel/drivers/serial/icom.c
--- orig/drivers/serial/icom.c	1969-12-31 16:00:00.000000000 -0800
+++ devel/drivers/serial/icom.c	2004-03-26 13:29:25.000000000 -0800
@@ -0,0 +1,1752 @@
+/*
+  * icom.c
+  *
+  * Copyright (C) 2001 Michael Anderson, IBM Corporation
+  *
+  * Serial device driver.
+  *
+  * Based on code from serial.c
+  *
+  * This program is free software; you can redistribute it and/or modify
+  * it under the terms of the GNU General Public License as published by
+  * the Free Software Foundation; either version 2 of the License, or
+  * (at your option) any later version.
+  *
+  * This program is distributed in the hope that it will be useful,
+  * but WITHOUT ANY WARRANTY; without even the implied warranty of
+  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  * GNU General Public License for more details.
+  *
+  * You should have received a copy of the GNU General Public License
+  * along with this program; if not, write to the Free Software
+  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+  *
+  */
+#define SERIAL_DO_RESTART
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/tty.h>
+#include <linux/termios.h>
+#include <linux/fs.h>
+#include <linux/tty_flip.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+#include <linux/major.h>
+#include <linux/string.h>
+#include <linux/fcntl.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/kobject.h>
+#include <linux/firmware.h>
+
+#include <asm/system.h>
+#include <asm/segment.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/bitops.h>
+#include <asm/serial.h>
+
+#include "icom.h"
+
+/*#define ICOM_TRACE		 enable port trace capabilities */
+
+#define ICOM_DRIVER_NAME "icom"
+#define ICOM_VERSION_STR "1.3.1"
+#define ICOM_DEV_ID_1    0x0031
+#define ICOM_DEV_ID_2    0x0219
+#define NR_PORTS	       128
+#define ICOM_PORT ((struct icom_port *)port)
+#define to_icom_adapter(d) container_of(d, struct icom_adapter, kobj)
+
+static const struct pci_device_id icom_pci_table[] = {
+	{
+	      .vendor = PCI_VENDOR_ID_IBM,
+	      .device = ICOM_DEV_ID_1,
+	      .subvendor = PCI_ANY_ID,
+	      .subdevice = PCI_ANY_ID,
+	      .driver_data = ADAPTER_V1,
+	 },
+	{
+	      .vendor = PCI_VENDOR_ID_IBM,
+	      .device = ICOM_DEV_ID_2,
+	      .subvendor = PCI_VENDOR_ID_IBM,
+	      .subdevice = V2_TWO_PORTS_RVX,
+	      .driver_data = ADAPTER_V2,
+	 },
+	{
+	      .vendor = PCI_VENDOR_ID_IBM,
+	      .device = ICOM_DEV_ID_2,
+	      .subvendor = PCI_VENDOR_ID_IBM,
+	      .subdevice = V2_ONE_PORT_RVX_ONE_PORT_IMBED_MDM,
+	      .driver_data = ADAPTER_V2,
+	 },
+	{
+	      .vendor = PCI_VENDOR_ID_IBM,
+	      .device = ICOM_DEV_ID_2,
+	      .subvendor = PCI_VENDOR_ID_IBM,
+	      .subdevice = FOUR_PORT_MODEL,
+	      .driver_data = ADAPTER_V2,
+	 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(pci, icom_pci_table);
+
+static LIST_HEAD(icom_adapter_head);
+
+/* spinlock for adapter initialization and changing adapter operations */
+static spinlock_t icom_lock;
+
+#ifdef ICOM_TRACE
+static void trace(struct icom_port *, char *, unsigned long);
+#else
+static void trace(struct icom_port *port, char *trace_pt, unsigned long data)
+{
+};
+#endif
+
+static void return_port_memory(struct icom_port *icom_port)
+{
+	struct pci_dev *dev = icom_port->adapter->pci_dev;
+
+	trace(icom_port, "RET_PORT_MEM", 0);
+	if (icom_port->recv_buf) {
+		pci_free_consistent(dev, 4096, icom_port->recv_buf,
+				    icom_port->recv_buf_pci);
+		icom_port->recv_buf = 0;
+	}
+	if (icom_port->xmit_buf) {
+		pci_free_consistent(dev, 4096, icom_port->xmit_buf,
+				    icom_port->xmit_buf_pci);
+		icom_port->xmit_buf = 0;
+	}
+	if (icom_port->statStg) {
+		pci_free_consistent(dev, 4096, icom_port->statStg,
+				    icom_port->statStg_pci);
+		icom_port->statStg = 0;
+	}
+
+	if (icom_port->xmitRestart) {
+		pci_free_consistent(dev, 4096, icom_port->xmitRestart,
+				    icom_port->xmitRestart_pci);
+		icom_port->xmitRestart = 0;
+	}
+}
+
+static int __init get_port_memory(struct icom_port *icom_port)
+{
+	int index;
+	int number_of_buffs;
+	unsigned long stgAddr;
+	unsigned long startStgAddr;
+	unsigned long offset;
+	struct pci_dev *dev = icom_port->adapter->pci_dev;
+
+	icom_port->xmit_buf =
+	    pci_alloc_consistent(dev, 4096, &icom_port->xmit_buf_pci);
+	if (!icom_port->xmit_buf) {
+		dev_err(&dev->dev, "Can not allocate Transmit buffer\n");
+		return -ENOMEM;
+	}
+
+	trace(icom_port, "GET_PORT_MEM",
+	      (unsigned long) icom_port->xmit_buf);
+
+	icom_port->recv_buf =
+	    pci_alloc_consistent(dev, 4096, &icom_port->recv_buf_pci);
+	if (!icom_port->recv_buf) {
+		dev_err(&dev->dev, "Can not allocate Receive buffer\n");
+		return_port_memory(icom_port);
+		return -ENOMEM;
+	}
+	trace(icom_port, "GET_PORT_MEM",
+	      (unsigned long) icom_port->recv_buf);
+
+	icom_port->statStg =
+	    pci_alloc_consistent(dev, 4096, &icom_port->statStg_pci);
+	if (!icom_port->statStg) {
+		dev_err(&dev->dev, "Can not allocate Status buffer\n");
+		return_port_memory(icom_port);
+		return -ENOMEM;
+	}
+	trace(icom_port, "GET_PORT_MEM",
+	      (unsigned long) icom_port->statStg);
+
+	icom_port->xmitRestart =
+	    pci_alloc_consistent(dev, 4096, &icom_port->xmitRestart_pci);
+	if (!icom_port->xmitRestart) {
+		dev_err(&dev->dev,
+			"Can not allocate xmit Restart buffer\n");
+		return_port_memory(icom_port);
+		return -ENOMEM;
+	}
+
+	memset(icom_port->statStg, 0, 4096);
+
+	/* FODs */
+	number_of_buffs = NUM_XBUFFS;
+	stgAddr = (unsigned long) icom_port->statStg;
+	startStgAddr = stgAddr;
+	for (index = 0; index < number_of_buffs; index++) {
+		trace(icom_port, "FOD_ADDR", stgAddr);
+		stgAddr = stgAddr + sizeof(icom_port->statStg->xmit[0]);
+		if (index < (number_of_buffs - 1)) {
+			icom_port->statStg->xmit[index].flags = 0;
+			icom_port->statStg->xmit[index].leNext = 0;
+			icom_port->statStg->xmit[index].leNextASD = 0;
+			icom_port->statStg->xmit[index].leLengthASD =
+			    (unsigned short int) cpu_to_le16(XMIT_BUFF_SZ);
+			icom_port->statStg->xmit[index].leOffsetASD = 0;
+			trace(icom_port, "FOD_ADDR", stgAddr);
+			trace(icom_port, "FOD_XBUFF",
+			      (unsigned long) icom_port->xmit_buf);
+			icom_port->statStg->xmit[index].leBuffer =
+			    cpu_to_le32(icom_port->xmit_buf_pci);
+		} else if (index == (number_of_buffs - 1)) {
+			icom_port->statStg->xmit[index].flags = 0;
+			icom_port->statStg->xmit[index].leNext = 0;
+			icom_port->statStg->xmit[index].leNextASD = 0;
+			icom_port->statStg->xmit[index].leLengthASD =
+			    (unsigned short int) cpu_to_le16(XMIT_BUFF_SZ);
+			icom_port->statStg->xmit[index].leOffsetASD = 0;
+			trace(icom_port, "FOD_XBUFF",
+			      (unsigned long) icom_port->xmit_buf);
+			icom_port->statStg->xmit[index].leBuffer =
+			    cpu_to_le32(icom_port->xmit_buf_pci);
+		} else {
+			icom_port->statStg->xmit[index].flags = 0;
+			icom_port->statStg->xmit[index].leNext = 0;
+			icom_port->statStg->xmit[index].leNextASD = 0;
+			icom_port->statStg->xmit[index].leLengthASD = 0;
+			icom_port->statStg->xmit[index].leOffsetASD = 0;
+			icom_port->statStg->xmit[index].leBuffer = 0;
+		}
+	}
+	/* FIDs */
+	startStgAddr = stgAddr;
+
+	/* fill in every entry, even if no buffer */
+	number_of_buffs = NUM_RBUFFS;
+	for (index = 0; index < number_of_buffs; index++) {
+		trace(icom_port, "FID_ADDR", stgAddr);
+		stgAddr = stgAddr + sizeof(icom_port->statStg->rcv[0]);
+		icom_port->statStg->rcv[index].leLength = 0;
+		icom_port->statStg->rcv[index].WorkingLength =
+		    (unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
+		if (index < (number_of_buffs - 1)) {
+			offset =
+			    stgAddr - (unsigned long) icom_port->statStg;
+			icom_port->statStg->rcv[index].leNext =
+			    (unsigned long) cpu_to_le32(icom_port->
+							statStg_pci +
+							offset);
+			trace(icom_port, "FID_RBUFF",
+			      (unsigned long) icom_port->recv_buf);
+			icom_port->statStg->rcv[index].leBuffer =
+			    cpu_to_le32(icom_port->recv_buf_pci);
+		} else if (index == (number_of_buffs - 1)) {
+			offset =
+			    startStgAddr -
+			    (unsigned long) icom_port->statStg;
+			icom_port->statStg->rcv[index].leNext =
+			    (unsigned long) cpu_to_le32(icom_port->
+							statStg_pci +
+							offset);
+			trace(icom_port, "FID_RBUFF",
+			      (unsigned long) icom_port->recv_buf + 2048);
+			icom_port->statStg->rcv[index].leBuffer =
+			    cpu_to_le32(icom_port->recv_buf_pci + 2048);
+		} else {
+			icom_port->statStg->rcv[index].leNext = 0;
+			icom_port->statStg->rcv[index].leBuffer = 0;
+		}
+	}
+
+	return 0;
+}
+
+static void stop_processor(struct icom_port *icom_port)
+{
+	unsigned long temp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&icom_lock, flags);
+
+	switch (icom_port->port) {
+	case 0:
+		temp = readl(&icom_port->global_reg->control);
+		temp =
+		    (temp & ~ICOM_CONTROL_START_A) | ICOM_CONTROL_STOP_A;
+		writel(temp, &icom_port->global_reg->control);
+		trace(icom_port, "STOP_PROC_A", 0);
+		break;
+	case 1:
+		temp = readl(&icom_port->global_reg->control);
+		temp =
+		    (temp & ~ICOM_CONTROL_START_B) | ICOM_CONTROL_STOP_B;
+		writel(temp, &icom_port->global_reg->control);
+		trace(icom_port, "STOP_PROC_B", 0);
+		break;
+	case 2:
+		temp = readl(&icom_port->global_reg->control_2);
+		temp =
+		    (temp & ~ICOM_CONTROL_START_C) | ICOM_CONTROL_STOP_C;
+		writel(temp, &icom_port->global_reg->control_2);
+		trace(icom_port, "STOP_PROC_C", 0);
+		break;
+	case 3:
+		temp = readl(&icom_port->global_reg->control_2);
+		temp =
+		    (temp & ~ICOM_CONTROL_START_D) | ICOM_CONTROL_STOP_D;
+		writel(temp, &icom_port->global_reg->control_2);
+		trace(icom_port, "STOP_PROC_D", 0);
+		break;
+	default:
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+	}
+	spin_unlock_irqrestore(&icom_lock, flags);
+}
+
+static void start_processor(struct icom_port *icom_port)
+{
+	unsigned long temp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&icom_lock, flags);
+
+	switch (icom_port->port) {
+	case 0:
+		temp = readl(&icom_port->global_reg->control);
+		temp =
+		    (temp & ~ICOM_CONTROL_STOP_A) | ICOM_CONTROL_START_A;
+		writel(temp, &icom_port->global_reg->control);
+		trace(icom_port, "START_PROC_A", 0);
+		break;
+	case 1:
+		temp = readl(&icom_port->global_reg->control);
+		temp =
+		    (temp & ~ICOM_CONTROL_STOP_B) | ICOM_CONTROL_START_B;
+		writel(temp, &icom_port->global_reg->control);
+		trace(icom_port, "START_PROC_B", 0);
+		break;
+	case 2:
+		temp = readl(&icom_port->global_reg->control_2);
+		temp =
+		    (temp & ~ICOM_CONTROL_STOP_C) | ICOM_CONTROL_START_C;
+		writel(temp, &icom_port->global_reg->control_2);
+		trace(icom_port, "START_PROC_C", 0);
+		break;
+	case 3:
+		temp = readl(&icom_port->global_reg->control_2);
+		temp =
+		    (temp & ~ICOM_CONTROL_STOP_D) | ICOM_CONTROL_START_D;
+		writel(temp, &icom_port->global_reg->control_2);
+		trace(icom_port, "START_PROC_D", 0);
+		break;
+	default:
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+	}
+	spin_unlock_irqrestore(&icom_lock, flags);
+}
+
+static void load_code(struct icom_port *icom_port)
+{
+	const struct firmware *fw;
+	char *iram_ptr;
+	int index;
+	int status = 0;
+	char *dram_ptr = (char *) icom_port->dram;
+	dma_addr_t temp_pci;
+	unsigned char *new_page = NULL;
+	unsigned char cable_id = NO_CABLE;
+	struct pci_dev *dev = icom_port->adapter->pci_dev;
+
+	/* Clear out any pending interrupts */
+	writew(0x3FFF, (void *) icom_port->int_reg);
+
+	trace(icom_port, "CLEAR_INTERRUPTS", 0);
+
+	/* Stop processor */
+	stop_processor(icom_port);
+
+	/* Zero out DRAM */
+	for (index = 0; index < 512; index++)
+		writeb(0x00, &dram_ptr[index]);
+
+	/* Load Call Setup into Adapter */
+	if (request_firmware(&fw, "icom_call_setup.bin", &dev->dev) < 0) {
+		dev_err(&dev->dev,"Unable to load icom_call_setup.bin firmware image\n");
+		status = -1;
+		goto load_code_exit;
+	}
+
+	if (fw->size > ICOM_DCE_IRAM_OFFSET) {
+		dev_err(&dev->dev, "Invalid firmware image for icom_call_setup.bin found.\n");
+		release_firmware(fw);
+		status = -1;
+		goto load_code_exit;
+	}
+
+	iram_ptr = (char *) icom_port->dram + ICOM_IRAM_OFFSET;
+	for (index = 0; index < fw->size; index++)
+		writeb(fw->data[index], &iram_ptr[index]);
+
+	release_firmware(fw);
+
+	/* Load Resident DCE portion of Adapter */
+	if (request_firmware(&fw, "icom_res_dce.bin", &dev->dev) < 0) {
+		dev_err(&dev->dev,"Unable to load icom_res_dce.bin firmware image\n");
+		status = -1;
+		goto load_code_exit;
+	}
+
+	if (fw->size > ICOM_IRAM_SIZE) {
+		dev_err(&dev->dev, "Invalid firmware image for icom_res_dce.bin found.\n");
+		release_firmware(fw);
+		status = -1;
+		goto load_code_exit;
+	}
+
+	iram_ptr = (char *) icom_port->dram + ICOM_IRAM_OFFSET;
+	for (index = ICOM_DCE_IRAM_OFFSET; index < fw->size; index++)
+		writeb(fw->data[index], &iram_ptr[index]);
+
+	release_firmware(fw);
+	
+	/* Set Hardware level */
+	if ((icom_port->adapter->version | ADAPTER_V2) == ADAPTER_V2)
+		writeb(V2_HARDWARE, &(icom_port->dram->misc_flags));
+
+	/* Start the processor in Adapter */
+	start_processor(icom_port);
+
+	writeb((HDLC_PPP_PURE_ASYNC | HDLC_FF_FILL),
+	       &(icom_port->dram->HDLCConfigReg));
+	writeb(0x04, &(icom_port->dram->FlagFillIdleTimer));	/* 0.5 seconds */
+	writeb(0x00, &(icom_port->dram->CmdReg));
+	writeb(0x10, &(icom_port->dram->async_config3));
+	writeb((ICOM_ACFG_DRIVE1 | ICOM_ACFG_NO_PARITY | ICOM_ACFG_8BPC |
+		ICOM_ACFG_1STOP_BIT), &(icom_port->dram->async_config2));
+
+	/*Set up data in icom DRAM to indicate where personality
+	 *code is located and its length.
+	 */
+	new_page = pci_alloc_consistent(dev, 4096, &temp_pci);
+
+	if (!new_page) {
+		dev_err(&dev->dev, "Can not allocate DMA buffer\n");
+		status = -1;
+		goto load_code_exit;
+	}
+
+	if (request_firmware(&fw, "icom_asc.bin", &dev->dev) < 0) {
+		dev_err(&dev->dev,"Unable to load icom_asc.bin firmware image\n");
+		status = -1;
+		goto load_code_exit;
+	}
+
+	if (fw->size > ICOM_DCE_IRAM_OFFSET) {
+		dev_err(&dev->dev, "Invalid firmware image for icom_asc.bin found.\n");
+		release_firmware(fw);
+		status = -1;
+		goto load_code_exit;
+	}
+
+	for (index = 0; index < fw->size; index++)
+		new_page[index] = fw->data[index];
+
+	release_firmware(fw);
+
+	writeb((char) ((fw->size + 16)/16), &icom_port->dram->mac_length);
+	writel(temp_pci, &icom_port->dram->mac_load_addr);
+
+	/*Setting the syncReg to 0x80 causes adapter to start downloading
+	   the personality code into adapter instruction RAM.
+	   Once code is loaded, it will begin executing and, based on
+	   information provided above, will start DMAing data from
+	   shared memory to adapter DRAM.
+	 */
+	writeb(START_DOWNLOAD, &icom_port->dram->sync);
+
+	/* Wait max 1 Sec for data download and processor to start */
+	for (index = 0; index < 10; index++) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ / 10);
+		if (readb(&icom_port->dram->misc_flags) & ICOM_HDW_ACTIVE)
+			break;
+	}
+
+	if (index == 10)
+		status = -1;
+
+	/*
+	 * check Cable ID
+	 */
+	cable_id = readb(&icom_port->dram->cable_id);
+
+	if (cable_id & ICOM_CABLE_ID_VALID) {
+		/* Get cable ID into the lower 4 bits (standard form) */
+		cable_id = (cable_id & ICOM_CABLE_ID_MASK) >> 4;
+		icom_port->cable_id = cable_id;
+	} else {
+		dev_err(&dev->dev,"Invalid or no cable attached\n");
+		icom_port->cable_id = NO_CABLE;
+	}
+
+      load_code_exit:
+
+	if (status != 0) {
+		/* Clear out any pending interrupts */
+		writew(0x3FFF, (void *) icom_port->int_reg);
+
+		/* Turn off port */
+		writeb(ICOM_DISABLE, &(icom_port->dram->disable));
+
+		/* Stop processor */
+		stop_processor(icom_port);
+
+		dev_err(&icom_port->adapter->pci_dev->dev,"Port not opertional\n");
+	}
+
+      if (new_page != NULL)
+	      pci_free_consistent(dev, 4096, new_page, temp_pci);
+}
+
+static int startup(struct icom_port *icom_port)
+{
+	unsigned long temp;
+	unsigned char cable_id, raw_cable_id;
+	unsigned long flags;
+
+	trace(icom_port, "STARTUP", 0);
+
+	if (icom_port->dram == 0x00000000) {
+		/* should NEVER be zero */
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Unusable Port, port configuration missing\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * check Cable ID
+	 */
+	raw_cable_id = readb(&icom_port->dram->cable_id);
+	trace(icom_port, "CABLE_ID", raw_cable_id);
+
+	/* Get cable ID into the lower 4 bits (standard form) */
+	cable_id = (raw_cable_id & ICOM_CABLE_ID_MASK) >> 4;
+
+	/* Check for valid Cable ID */
+	if (!(raw_cable_id & ICOM_CABLE_ID_VALID) ||
+	    (cable_id != icom_port->cable_id)) {
+
+		/* reload adapter code, pick up any potential changes in cable id */
+		load_code(icom_port);
+
+		/* still no sign of cable, error out */
+		raw_cable_id = readb(&icom_port->dram->cable_id);
+		cable_id = (raw_cable_id & ICOM_CABLE_ID_MASK) >> 4;
+		if (!(raw_cable_id & ICOM_CABLE_ID_VALID) ||
+		    (icom_port->cable_id == NO_CABLE))
+			return -EIO;
+	}
+
+	/*
+	 * Finally, clear and  enable interrupts
+	 */
+	spin_lock_irqsave(&icom_lock, flags);
+	switch (icom_port->port) {
+	case 0:
+		/* Clear out any pending interrupts */
+		writew(0x00FF, (void *) icom_port->int_reg);
+
+		/* Enable interrupts for first port */
+		trace(icom_port, "ENABLE_INTERRUPTS_PA", 0);
+		temp = readl(&icom_port->global_reg->int_mask);
+		writel((temp & ~ICOM_INT_MASK_PRC_A),
+		       &icom_port->global_reg->int_mask);
+		break;
+	case 1:
+		/* Clear out any pending interrupts */
+		writew(0x3F00, (void *) icom_port->int_reg);
+
+		/* Enable interrupts for second port */
+		trace(icom_port, "ENABLE_INTERRUPTS_PB", 0);
+		temp = readl(&icom_port->global_reg->int_mask);
+		writel((temp & ~ICOM_INT_MASK_PRC_B),
+		       &icom_port->global_reg->int_mask);
+		break;
+	case 2:
+		/* Clear out any pending interrupts */
+		writew(0x00FF, (void *) icom_port->int_reg);
+
+		/* Enable interrupts for first port */
+		trace(icom_port, "ENABLE_INTERRUPTS_PC", 0);
+		temp = readl(&icom_port->global_reg->int_mask_2);
+		writel((temp & ~ICOM_INT_MASK_PRC_C),
+		       &icom_port->global_reg->int_mask_2);
+		break;
+	case 3:
+		/* Clear out any pending interrupts */
+		writew(0x3F00, (void *) icom_port->int_reg);
+
+		/* Enable interrupts for second port */
+		trace(icom_port, "ENABLE_INTERRUPTS_PD", 0);
+		temp = readl(&icom_port->global_reg->int_mask_2);
+		writel((temp & ~ICOM_INT_MASK_PRC_D),
+		       &icom_port->global_reg->int_mask_2);
+		break;
+	default:
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port defined\n");
+	}
+
+	spin_unlock_irqrestore(&icom_lock, flags);
+	return 0;
+}
+
+static void shutdown(struct icom_port *icom_port)
+{
+	unsigned long temp;
+	unsigned char cmdReg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&icom_lock, flags);
+	trace(icom_port, "SHUTDOWN", 0);
+
+	/*
+	 * disable all interrupts
+	 */
+	switch (icom_port->port) {
+	case 0:
+		trace(icom_port, "DIS_INTERRUPTS_PA", 0);
+		temp = readl(&icom_port->global_reg->int_mask);
+		writel((temp | ICOM_INT_MASK_PRC_A),
+		       &icom_port->global_reg->int_mask);
+		break;
+	case 1:
+		trace(icom_port, "DIS_INTERRUPTS_PB", 0);
+		temp = readl(&icom_port->global_reg->int_mask);
+		writel((temp | ICOM_INT_MASK_PRC_B),
+		       &icom_port->global_reg->int_mask);
+		break;
+	case 2:
+		trace(icom_port, "DIS_INTERRUPTS_PC", 0);
+		temp = readl(&icom_port->global_reg->int_mask_2);
+		writel((temp | ICOM_INT_MASK_PRC_C),
+		       &icom_port->global_reg->int_mask_2);
+		break;
+	case 3:
+		trace(icom_port, "DIS_INTERRUPTS_PD", 0);
+		temp = readl(&icom_port->global_reg->int_mask_2);
+		writel((temp | ICOM_INT_MASK_PRC_D),
+		       &icom_port->global_reg->int_mask_2);
+		break;
+	default:
+		dev_err(&icom_port->adapter->pci_dev->dev,
+			"Invalid port assignment\n");
+	}
+
+	spin_unlock_irqrestore(&icom_lock, flags);
+
+	/*
+	 * disable break condition
+	 */
+	cmdReg = readb(&icom_port->dram->CmdReg);
+	if ((cmdReg | CMD_SND_BREAK) == CMD_SND_BREAK) {
+		writeb(cmdReg & ~CMD_SND_BREAK, &icom_port->dram->CmdReg);
+	}
+}
+
+static int icom_write(struct uart_port *port)
+{
+	unsigned long data_count;
+	unsigned char cmdReg;
+	unsigned long offset;
+	int temp_tail = port->info->xmit.tail;
+
+	trace(ICOM_PORT, "WRITE", 0);
+
+	if (cpu_to_le16(ICOM_PORT->statStg->xmit[0].flags) &
+	    SA_FLAGS_READY_TO_XMIT) {
+		trace(ICOM_PORT, "WRITE_FULL", 0);
+		return 0;
+	}
+
+	data_count = 0;
+	while ((port->info->xmit.head != temp_tail) &&
+	       (data_count <= XMIT_BUFF_SZ)) {
+
+		ICOM_PORT->xmit_buf[data_count++] =
+		    port->info->xmit.buf[temp_tail];
+
+		temp_tail++;
+		temp_tail &= (UART_XMIT_SIZE - 1);
+	}
+
+	if (data_count) {
+		ICOM_PORT->statStg->xmit[0].flags = (unsigned short int)
+		    cpu_to_le16(SA_FLAGS_READY_TO_XMIT);
+		ICOM_PORT->statStg->xmit[0].leLength =
+		    (unsigned short int) cpu_to_le16(data_count);
+		offset =
+		    (unsigned long) &ICOM_PORT->statStg->xmit[0] -
+		    (unsigned long) ICOM_PORT->statStg;
+		*ICOM_PORT->xmitRestart =
+		    cpu_to_le32(ICOM_PORT->statStg_pci + offset);
+		cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+		writeb(cmdReg | CMD_XMIT_RCV_ENABLE,
+		       &ICOM_PORT->dram->CmdReg);
+		writeb(START_XMIT, &ICOM_PORT->dram->StartXmitCmd);
+		trace(ICOM_PORT, "WRITE_START", data_count);
+	}
+
+	return data_count;
+}
+
+static inline void check_modem_status(struct icom_port *icom_port)
+{
+	static char old_status = 0;
+	char delta_status;
+	unsigned char status;
+	unsigned long flags;
+
+	spin_lock_irqsave(&icom_port->uart_port.lock, flags);
+
+	/*modem input register */
+	status = readb(&icom_port->dram->isr);
+	trace(icom_port, "CHECK_MODEM", status);
+	delta_status = status ^ old_status;
+	if (delta_status) {
+		if (delta_status & ICOM_RI)
+			icom_port->uart_port.icount.rng++;
+		if (delta_status & ICOM_DSR)
+			icom_port->uart_port.icount.dsr++;
+		if (delta_status & ICOM_DCD)
+			uart_handle_dcd_change(&icom_port->uart_port,
+					       delta_status & ICOM_DCD);
+		if (delta_status & ICOM_CTS)
+			uart_handle_cts_change(&icom_port->uart_port,
+					       delta_status & ICOM_CTS);
+
+		wake_up_interruptible(&icom_port->uart_port.info->
+				      delta_msr_wait);
+		old_status = status;
+	}
+	spin_unlock_irqrestore(&icom_port->uart_port.lock, flags);
+}
+
+static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
+{
+	unsigned short int count;
+	int i;
+
+	if (port_int_reg & (INT_XMIT_COMPLETED)) {
+		trace(icom_port, "XMIT_COMPLETE", 0);
+
+		/* clear buffer in use bit */
+		icom_port->statStg->xmit[0].flags &=
+			cpu_to_le16(~SA_FLAGS_READY_TO_XMIT);
+
+		count = (unsigned short int)
+			cpu_to_le16(icom_port->statStg->xmit[0].leLength);
+		icom_port->uart_port.icount.tx += count;
+
+		for (i=0; i<count &&
+			!uart_circ_empty(&icom_port->uart_port.info->xmit); i++) {
+
+			icom_port->uart_port.info->xmit.tail++;
+			icom_port->uart_port.info->xmit.tail &=
+				(UART_XMIT_SIZE - 1);
+		}
+
+		if (!icom_write(&icom_port->uart_port))
+			/* activate write queue */
+			uart_write_wakeup(&icom_port->uart_port);
+	} else
+		trace(icom_port, "XMIT_DISABLED", 0);
+}
+
+static void recv_interrupt(u16 port_int_reg, struct icom_port *icom_port)
+{
+	short int count, rcv_buff;
+	struct tty_struct *tty = icom_port->uart_port.info->tty;
+	unsigned short int status;
+	struct uart_icount *icount;
+	unsigned long offset;
+
+	trace(icom_port, "RCV_COMPLETE", 0);
+	rcv_buff = icom_port->next_rcv;
+
+	status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
+	while (status & SA_FL_RCV_DONE) {
+
+		trace(icom_port, "FID_STATUS", status);
+		count = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].leLength);
+
+		trace(icom_port, "RCV_COUNT", count);
+		if (count > (TTY_FLIPBUF_SIZE - tty->flip.count))
+			count = TTY_FLIPBUF_SIZE - tty->flip.count;
+
+		trace(icom_port, "REAL_COUNT", count);
+
+		offset =
+			cpu_to_le32(icom_port->statStg->rcv[rcv_buff].leBuffer) -
+			icom_port->recv_buf_pci;
+
+		memcpy(tty->flip.char_buf_ptr,(unsigned char *)
+		       ((unsigned long)icom_port->recv_buf + offset), count);
+
+		if (count > 0) {
+			tty->flip.count += count - 1;
+			tty->flip.char_buf_ptr += count - 1;
+
+			memset(tty->flip.flag_buf_ptr, 0, count);
+			tty->flip.flag_buf_ptr += count - 1;
+		}
+
+		icount = &icom_port->uart_port.icount;
+		icount->rx += count;
+
+		/* Break detect logic */
+		if ((status & SA_FLAGS_FRAME_ERROR)
+		    && (tty->flip.char_buf_ptr[0] == 0x00)) {
+			status &= ~SA_FLAGS_FRAME_ERROR;
+			status |= SA_FLAGS_BREAK_DET;
+			trace(icom_port, "BREAK_DET", 0);
+		}
+
+		if (status &
+		    (SA_FLAGS_BREAK_DET | SA_FLAGS_PARITY_ERROR |
+		     SA_FLAGS_FRAME_ERROR | SA_FLAGS_OVERRUN)) {
+
+			if (status & SA_FLAGS_BREAK_DET)
+				icount->brk++;
+			if (status & SA_FLAGS_PARITY_ERROR)
+				icount->parity++;
+			if (status & SA_FLAGS_FRAME_ERROR)
+				icount->frame++;
+			if (status & SA_FLAGS_OVERRUN)
+				icount->overrun++;
+
+			/*
+			 * Now check to see if character should be
+			 * ignored, and mask off conditions which
+			 * should be ignored.
+			 */
+			if (status & icom_port->ignore_status_mask) {
+				trace(icom_port, "IGNORE_CHAR", 0);
+				goto ignore_char;
+			}
+
+			status &= icom_port->read_status_mask;
+
+			if (status & SA_FLAGS_BREAK_DET) {
+				*tty->flip.flag_buf_ptr = TTY_BREAK;
+			} else if (status & SA_FLAGS_PARITY_ERROR) {
+				trace(icom_port, "PARITY_ERROR", 0);
+				*tty->flip.flag_buf_ptr = TTY_PARITY;
+			} else if (status & SA_FLAGS_FRAME_ERROR)
+				*tty->flip.flag_buf_ptr = TTY_FRAME;
+
+			if (status & SA_FLAGS_OVERRUN) {
+				/*
+				 * Overrun is special, since it's
+				 * reported immediately, and doesn't
+				 * affect the current character
+				 */
+				if (tty->flip.count < TTY_FLIPBUF_SIZE) {
+					tty->flip.count++;
+					tty->flip.flag_buf_ptr++;
+					tty->flip.char_buf_ptr++;
+					*tty->flip.flag_buf_ptr = TTY_OVERRUN;
+				}
+			}
+		}
+
+		tty->flip.flag_buf_ptr++;
+		tty->flip.char_buf_ptr++;
+		tty->flip.count++;
+		ignore_char:
+			icom_port->statStg->rcv[rcv_buff].flags = 0;
+		icom_port->statStg->rcv[rcv_buff].leLength = 0;
+		icom_port->statStg->rcv[rcv_buff].WorkingLength =
+			(unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
+
+		rcv_buff++;
+		if (rcv_buff == NUM_RBUFFS)
+			rcv_buff = 0;
+
+		status = cpu_to_le16(icom_port->statStg->rcv[rcv_buff].flags);
+	}
+	icom_port->next_rcv = rcv_buff;
+	tty_flip_buffer_push(tty);
+}
+
+static void process_interrupt(u16 port_int_reg,
+			      struct icom_port *icom_port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&icom_port->uart_port.lock, flags);
+	trace(icom_port, "INTERRUPT", port_int_reg);
+
+	if (port_int_reg & (INT_XMIT_COMPLETED | INT_XMIT_DISABLED))
+		xmit_interrupt(port_int_reg, icom_port);
+
+	if (port_int_reg & INT_RCV_COMPLETED)
+		recv_interrupt(port_int_reg, icom_port);
+
+	spin_unlock_irqrestore(&icom_port->uart_port.lock, flags);
+}
+
+static irqreturn_t icom_interrupt(int irq, void *dev_id,
+				  struct pt_regs *regs)
+{
+	unsigned long int_reg;
+	u32 adapter_interrupts;
+	u16 port_int_reg;
+	struct icom_adapter *icom_adapter;
+	struct icom_port *icom_port;
+
+	/* find icom_port for this interrupt */
+	icom_adapter = (struct icom_adapter *) dev_id;
+
+	if ((icom_adapter->version | ADAPTER_V2) == ADAPTER_V2) {
+		int_reg = icom_adapter->base_addr + 0x8024;
+
+		adapter_interrupts = readl((void *) int_reg);
+
+		if (adapter_interrupts & 0x00003FFF) {
+			/* port 2 interrupt,  NOTE:  for all ADAPTER_V2, port 2 will be active */
+			icom_port = &icom_adapter->port_info[2];
+			port_int_reg = (u16) adapter_interrupts;
+			process_interrupt(port_int_reg, icom_port);
+			check_modem_status(icom_port);
+		}
+		if (adapter_interrupts & 0x3FFF0000) {
+			/* port 3 interrupt */
+			icom_port = &icom_adapter->port_info[3];
+			if (icom_port->status == ICOM_PORT_ACTIVE) {
+				port_int_reg =
+				    (u16) (adapter_interrupts >> 16);
+				process_interrupt(port_int_reg, icom_port);
+				check_modem_status(icom_port);
+			}
+		}
+
+		/* Clear out any pending interrupts */
+		writel(adapter_interrupts, (void *) int_reg);
+
+		int_reg = icom_adapter->base_addr + 0x8004;
+	} else {
+		int_reg = icom_adapter->base_addr + 0x4004;
+	}
+
+	adapter_interrupts = readl((void *) int_reg);
+
+	if (adapter_interrupts & 0x00003FFF) {
+		/* port 0 interrupt, NOTE:  for all adapters, port 0 will be active */
+		icom_port = &icom_adapter->port_info[0];
+		port_int_reg = (u16) adapter_interrupts;
+		process_interrupt(port_int_reg, icom_port);
+		check_modem_status(icom_port);
+	}
+	if (adapter_interrupts & 0x3FFF0000) {
+		/* port 1 interrupt */
+		icom_port = &icom_adapter->port_info[1];
+		if (icom_port->status == ICOM_PORT_ACTIVE) {
+			port_int_reg = (u16) (adapter_interrupts >> 16);
+			process_interrupt(port_int_reg, icom_port);
+			check_modem_status(icom_port);
+		}
+	}
+
+	/* Clear out any pending interrupts */
+	writel(adapter_interrupts, (void *) int_reg);
+
+	/* flush the write */
+	adapter_interrupts = readl((void *) int_reg);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * ------------------------------------------------------------------
+ * Begin serial-core API
+ * ------------------------------------------------------------------
+ */
+static unsigned int icom_tx_empty(struct uart_port *port)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	if (cpu_to_le16(ICOM_PORT->statStg->xmit[0].flags) &
+	    SA_FLAGS_READY_TO_XMIT)
+		ret = TIOCSER_TEMT;
+	else
+		ret = 0;
+
+	spin_unlock_irqrestore(&port->lock, flags);
+	return ret;
+}
+
+static void icom_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	unsigned char local_osr;
+
+	trace(ICOM_PORT, "SET_MODEM", 0);
+	local_osr = readb(&ICOM_PORT->dram->osr);
+
+	if (mctrl & TIOCM_RTS) {
+		trace(ICOM_PORT, "RAISE_RTS", 0);
+		local_osr |= ICOM_RTS;
+	} else {
+		trace(ICOM_PORT, "LOWER_RTS", 0);
+		local_osr &= ~ICOM_RTS;
+	}
+
+	if (mctrl & TIOCM_DTR) {
+		trace(ICOM_PORT, "RAISE_DTR", 0);
+		local_osr |= ICOM_DTR;
+	} else {
+		trace(ICOM_PORT, "LOWER_DTR", 0);
+		local_osr &= ~ICOM_DTR;
+	}
+
+	writeb(local_osr, &ICOM_PORT->dram->osr);
+}
+
+static unsigned int icom_get_mctrl(struct uart_port *port)
+{
+	unsigned char status;
+	unsigned int result;
+
+	trace(ICOM_PORT, "GET_MODEM", 0);
+
+	status = readb(&ICOM_PORT->dram->isr);
+
+	result = ((status & ICOM_DCD) ? TIOCM_CAR : 0)
+	    | ((status & ICOM_RI) ? TIOCM_RNG : 0)
+	    | ((status & ICOM_DSR) ? TIOCM_DSR : 0)
+	    | ((status & ICOM_CTS) ? TIOCM_CTS : 0);
+	return result;
+}
+
+static void icom_stop_tx(struct uart_port *port, unsigned int tty_stop)
+{
+	unsigned char cmdReg;
+
+	if (tty_stop) {
+		trace(ICOM_PORT, "STOP", 0);
+		cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+		writeb(cmdReg | CMD_HOLD_XMIT, &ICOM_PORT->dram->CmdReg);
+	}
+}
+
+static void icom_start_tx(struct uart_port *port, unsigned int tty_start)
+{
+	unsigned char cmdReg;
+
+	trace(ICOM_PORT, "START", 0);
+	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+	if ((cmdReg & CMD_HOLD_XMIT) == CMD_HOLD_XMIT)
+		writeb(cmdReg & ~CMD_HOLD_XMIT,
+		       &ICOM_PORT->dram->CmdReg);
+
+	icom_write(port);
+}
+
+static void icom_send_xchar(struct uart_port *port, char ch)
+{
+	unsigned char xdata;
+	int index;
+	unsigned long flags;
+
+	trace(ICOM_PORT, "SEND_XCHAR", ch);
+
+	/* wait .1 sec to send char */
+	for (index = 0; index < 10; index++) {
+		spin_lock_irqsave(&port->lock, flags);
+		xdata = readb(&ICOM_PORT->dram->xchar);
+		if (xdata == 0x00) {
+			trace(ICOM_PORT, "QUICK_WRITE", 0);
+			writeb(ch, &ICOM_PORT->dram->xchar);
+
+			/* flush write operation */
+			xdata = readb(&ICOM_PORT->dram->xchar);
+			spin_unlock_irqrestore(&port->lock, flags);
+			break;
+		}
+		spin_unlock_irqrestore(&port->lock, flags);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ / 100);
+	}
+}
+
+static void icom_stop_rx(struct uart_port *port)
+{
+	unsigned char cmdReg;
+
+	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+	writeb(cmdReg & ~CMD_RCV_ENABLE, &ICOM_PORT->dram->CmdReg);
+}
+
+static void icom_enable_ms(struct uart_port *port)
+{
+	/* no-op */
+}
+
+static void icom_break(struct uart_port *port, int break_state)
+{
+	unsigned char cmdReg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	trace(ICOM_PORT, "BREAK", 0);
+	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+	if (break_state == -1) {
+		writeb(cmdReg | CMD_SND_BREAK, &ICOM_PORT->dram->CmdReg);
+	} else {
+		writeb(cmdReg & ~CMD_SND_BREAK, &ICOM_PORT->dram->CmdReg);
+	}
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static int icom_open(struct uart_port *port)
+{
+	int retval;
+
+	kobject_get(&ICOM_PORT->adapter->kobj);
+
+	retval = startup(ICOM_PORT);
+
+	if (retval) {
+		kobject_put(&ICOM_PORT->adapter->kobj);
+		trace(ICOM_PORT, "STARTUP_ERROR", 0);
+		return retval;
+	}
+
+	return 0;
+}
+
+static void icom_close(struct uart_port *port)
+{
+	unsigned char cmdReg;
+
+	trace(ICOM_PORT, "CLOSE", 0);
+
+	/* stop receiver */
+	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
+	writeb(cmdReg & (unsigned char) ~CMD_RCV_ENABLE,
+	       &ICOM_PORT->dram->CmdReg);
+
+	shutdown(ICOM_PORT);
+
+	kobject_put(&ICOM_PORT->adapter->kobj);
+}
+
+static void icom_set_termios(struct uart_port *port,
+			     struct termios *termios,
+			     struct termios *old_termios)
+{
+	int baud;
+	unsigned cflag, iflag;
+	int bits;
+	char new_config2;
+	char new_config3 = 0;
+	char tmp_byte;
+	int index;
+	int rcv_buff, xmit_buff;
+	unsigned long offset;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	trace(ICOM_PORT, "CHANGE_SPEED", 0);
+
+	cflag = termios->c_cflag;
+	iflag = termios->c_iflag;
+
+	new_config2 = ICOM_ACFG_DRIVE1;
+
+	/* byte size and parity */
+	switch (cflag & CSIZE) {
+	case CS5:		/* 5 bits/char */
+		new_config2 |= ICOM_ACFG_5BPC;
+		bits = 7;
+		break;
+	case CS6:		/* 6 bits/char */
+		new_config2 |= ICOM_ACFG_6BPC;
+		bits = 8;
+		break;
+	case CS7:		/* 7 bits/char */
+		new_config2 |= ICOM_ACFG_7BPC;
+		bits = 9;
+		break;
+	case CS8:		/* 8 bits/char */
+		new_config2 |= ICOM_ACFG_8BPC;
+		bits = 10;
+		break;
+	default:
+		bits = 10;
+		break;
+	}
+	if (cflag & CSTOPB) {
+		/* 2 stop bits */
+		new_config2 |= ICOM_ACFG_2STOP_BIT;
+		bits++;
+	}
+	if (cflag & PARENB) {
+		/* parity bit enabled */
+		new_config2 |= ICOM_ACFG_PARITY_ENAB;
+		trace(ICOM_PORT, "PARENB", 0);
+		bits++;
+	}
+	if (cflag & PARODD) {
+		/* odd parity */
+		new_config2 |= ICOM_ACFG_PARITY_ODD;
+		trace(ICOM_PORT, "PARODD", 0);
+	}
+
+	/* Determine divisor based on baud rate */
+	baud = uart_get_baud_rate(port, termios, old_termios,
+				  icom_acfg_baud[0],
+				  icom_acfg_baud[BAUD_TABLE_LIMIT]);
+	if (!baud)
+		baud = 9600;	/* B0 transition handled in rs_set_termios */
+
+	for (index = 0; index < BAUD_TABLE_LIMIT; index++) {
+		if (icom_acfg_baud[index] == baud) {
+			new_config3 = index;
+			break;
+		}
+	}
+
+	uart_update_timeout(port, cflag, baud);
+
+	/* CTS flow control flag and modem status interrupts */
+	tmp_byte = readb(&(ICOM_PORT->dram->HDLCConfigReg));
+	if (cflag & CRTSCTS)
+		tmp_byte |= HDLC_HDW_FLOW;
+	else
+		tmp_byte &= ~HDLC_HDW_FLOW;
+	writeb(tmp_byte, &(ICOM_PORT->dram->HDLCConfigReg));
+
+	/*
+	 * Set up parity check flag
+	 */
+	ICOM_PORT->read_status_mask = SA_FLAGS_OVERRUN | SA_FL_RCV_DONE;
+	if (iflag & INPCK)
+		ICOM_PORT->read_status_mask |=
+		    SA_FLAGS_FRAME_ERROR | SA_FLAGS_PARITY_ERROR;
+
+	if ((iflag & BRKINT) || (iflag & PARMRK))
+		ICOM_PORT->read_status_mask |= SA_FLAGS_BREAK_DET;
+
+	/*
+	 * Characters to ignore
+	 */
+	ICOM_PORT->ignore_status_mask = 0;
+	if (iflag & IGNPAR)
+		ICOM_PORT->ignore_status_mask |=
+		    SA_FLAGS_PARITY_ERROR | SA_FLAGS_FRAME_ERROR;
+	if (iflag & IGNBRK) {
+		ICOM_PORT->ignore_status_mask |= SA_FLAGS_BREAK_DET;
+		/*
+		 * If we're ignore parity and break indicators, ignore 
+		 * overruns too.  (For real raw support).
+		 */
+		if (iflag & IGNPAR)
+			ICOM_PORT->ignore_status_mask |= SA_FLAGS_OVERRUN;
+	}
+
+	/*
+	 * !!! ignore all characters if CREAD is not set
+	 */
+	if ((cflag & CREAD) == 0)
+		ICOM_PORT->ignore_status_mask |= SA_FL_RCV_DONE;
+
+	/* Turn off Receiver to prepare for reset */
+	writeb(CMD_RCV_DISABLE, &ICOM_PORT->dram->CmdReg);
+
+	for (index = 0; index < 10; index++) {
+		if (readb(&ICOM_PORT->dram->PrevCmdReg) == 0x00) {
+			break;
+		}
+	}
+
+	/* clear all current buffers of data */
+	for (rcv_buff = 0; rcv_buff < NUM_RBUFFS; rcv_buff++) {
+		ICOM_PORT->statStg->rcv[rcv_buff].flags = 0;
+		ICOM_PORT->statStg->rcv[rcv_buff].leLength = 0;
+		ICOM_PORT->statStg->rcv[rcv_buff].WorkingLength =
+		    (unsigned short int) cpu_to_le16(RCV_BUFF_SZ);
+	}
+
+	for (xmit_buff = 0; xmit_buff < NUM_XBUFFS; xmit_buff++) {
+		ICOM_PORT->statStg->xmit[xmit_buff].flags = 0;
+	}
+
+	/* activate changes and start xmit and receiver here */
+	/* Enable the receiver */
+	writeb(new_config3, &(ICOM_PORT->dram->async_config3));
+	writeb(new_config2, &(ICOM_PORT->dram->async_config2));
+	tmp_byte = readb(&(ICOM_PORT->dram->HDLCConfigReg));
+	tmp_byte |= HDLC_PPP_PURE_ASYNC | HDLC_FF_FILL;
+	writeb(tmp_byte, &(ICOM_PORT->dram->HDLCConfigReg));
+	writeb(0x04, &(ICOM_PORT->dram->FlagFillIdleTimer));	/* 0.5 seconds */
+	writeb(0xFF, &(ICOM_PORT->dram->ier));	/* enable modem signal interrupts */
+
+	/* reset processor */
+	writeb(CMD_RESTART, &ICOM_PORT->dram->CmdReg);
+
+	for (index = 0; index < 10; index++) {
+		if (readb(&ICOM_PORT->dram->CmdReg) == 0x00) {
+			break;
+		}
+	}
+
+	/* Enable Transmitter and Reciever */
+	offset =
+	    (unsigned long) &ICOM_PORT->statStg->rcv[0] -
+	    (unsigned long) ICOM_PORT->statStg;
+	writel(ICOM_PORT->statStg_pci + offset,
+	       &ICOM_PORT->dram->RcvStatusAddr);
+	ICOM_PORT->next_rcv = 0;
+	ICOM_PORT->put_length = 0;
+	*ICOM_PORT->xmitRestart = 0;
+	writel(ICOM_PORT->xmitRestart_pci,
+	       &ICOM_PORT->dram->XmitStatusAddr);
+	trace(ICOM_PORT, "XR_ENAB", 0);
+	writeb(CMD_XMIT_RCV_ENABLE, &ICOM_PORT->dram->CmdReg);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *icom_type(struct uart_port *port)
+{
+	return "icom";
+}
+
+static void icom_release_port(struct uart_port *port)
+{
+}
+
+static int icom_request_port(struct uart_port *port)
+{
+	return 0;
+}
+
+static void icom_config_port(struct uart_port *port, int flags)
+{
+	port->type = PORT_ICOM;
+}
+
+static struct uart_ops icom_ops = {
+	.tx_empty = icom_tx_empty,
+	.set_mctrl = icom_set_mctrl,
+	.get_mctrl = icom_get_mctrl,
+	.stop_tx = icom_stop_tx,
+	.start_tx = icom_start_tx,
+	.send_xchar = icom_send_xchar,
+	.stop_rx = icom_stop_rx,
+	.enable_ms = icom_enable_ms,
+	.break_ctl = icom_break,
+	.startup = icom_open,
+	.shutdown = icom_close,
+	.set_termios = icom_set_termios,
+	.type = icom_type,
+	.release_port = icom_release_port,
+	.request_port = icom_request_port,
+	.config_port = icom_config_port,
+};
+
+#define ICOM_CONSOLE NULL
+
+static struct uart_driver icom_uart_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = ICOM_DRIVER_NAME,
+	.dev_name = "ttyA",
+	.major = ICOM_MAJOR,
+	.minor = ICOM_MINOR_START,
+	.nr = NR_PORTS,
+	.cons = ICOM_CONSOLE,
+};
+
+static int __devinit icom_init_ports(struct icom_adapter *icom_adapter)
+{
+	u32 subsystem_id = icom_adapter->subsystem_id;
+	int retval = 0;
+	int i;
+	struct icom_port *icom_port;
+
+	if (icom_adapter->version == ADAPTER_V1) {
+		icom_adapter->numb_ports = 2;
+
+		for (i = 0; i < 2; i++) {
+			icom_port = &icom_adapter->port_info[i];
+			icom_port->port = i;
+			icom_port->status = ICOM_PORT_ACTIVE;
+			icom_port->imbed_modem = ICOM_UNKNOWN;
+		}
+	} else {
+		if (subsystem_id == FOUR_PORT_MODEL) {
+			icom_adapter->numb_ports = 4;
+
+			for (i = 0; i < 4; i++) {
+				icom_port = &icom_adapter->port_info[i];
+
+				icom_port->port = i;
+				icom_port->status = ICOM_PORT_ACTIVE;
+				icom_port->imbed_modem = ICOM_IMBED_MODEM;
+			}
+		} else {
+			icom_adapter->numb_ports = 4;
+
+			icom_adapter->port_info[0].port = 0;
+			icom_adapter->port_info[0].status = ICOM_PORT_ACTIVE;
+
+			if (subsystem_id ==
+			    V2_ONE_PORT_RVX_ONE_PORT_IMBED_MDM) {
+				icom_adapter->port_info[0].imbed_modem = ICOM_IMBED_MODEM;
+			} else {
+				icom_adapter->port_info[0].imbed_modem = ICOM_RVX;
+			}
+
+			icom_adapter->port_info[1].status = ICOM_PORT_OFF;
+
+			icom_adapter->port_info[2].port = 2;
+			icom_adapter->port_info[2].status = ICOM_PORT_ACTIVE;
+			icom_adapter->port_info[2].imbed_modem = ICOM_RVX;
+			icom_adapter->port_info[3].status = ICOM_PORT_OFF;
+		}
+	}
+
+	return retval;
+}
+
+static int __init icom_load_ports(struct icom_adapter *icom_adapter)
+{
+	struct icom_port *icom_port;
+	int port_num;
+	int retval;
+
+	for (port_num = 0; port_num < icom_adapter->numb_ports; port_num++) {
+
+		icom_port = &icom_adapter->port_info[port_num];
+
+		if (icom_port->status == ICOM_PORT_ACTIVE) {
+
+			if (icom_adapter->version == ADAPTER_V1) {
+				icom_port->global_reg =
+				    (struct icom_regs *) ((char *)
+					icom_adapter->base_addr + 0x4000);
+				icom_port->int_reg = (unsigned long)
+				    icom_adapter->base_addr +
+				    0x4004 + 2 - 2 * port_num;
+			} else {
+				icom_port->global_reg =
+				    (struct icom_regs *) ((char *)
+					icom_adapter->base_addr + 0x8000);
+				if (icom_port->port < 2)
+					icom_port->int_reg = (unsigned long)
+					    icom_adapter->base_addr +
+					    0x8004 + 2 -
+					    2 * icom_port->port;
+				else
+					icom_port->int_reg = (unsigned long)
+					    icom_adapter->base_addr +
+					    0x8024 + 2 -
+					    2 * (icom_port->port - 2);
+			}
+			icom_port->dram = (struct func_dram *) ((char *)
+					icom_adapter->base_addr +
+					0x2000 * icom_port->port);
+
+			icom_port->adapter = icom_adapter;
+
+			/* get port memory */
+			if ((retval = get_port_memory(icom_port)) != 0) {
+				dev_err(&icom_port->adapter->pci_dev->dev,
+					"Memory allocation for port FAILED\n");
+			}
+		}
+	}
+	return 0;
+}
+
+static int __devinit icom_alloc_adapter(struct icom_adapter
+					**icom_adapter_ref)
+{
+	int adapter_count = 0;
+	struct icom_adapter *icom_adapter;
+	struct icom_adapter *cur_adapter_entry;
+	struct list_head *tmp;
+
+	icom_adapter = (struct icom_adapter *)
+	    kmalloc(sizeof(struct icom_adapter), GFP_KERNEL);
+
+	if (!icom_adapter) {
+		return -ENOMEM;
+	}
+
+	memset(icom_adapter, 0, sizeof(struct icom_adapter));
+
+	list_for_each(tmp, &icom_adapter_head) {
+		cur_adapter_entry =
+		    list_entry(tmp, struct icom_adapter,
+			       icom_adapter_entry);
+		if (cur_adapter_entry->index != adapter_count) {
+			break;
+		}
+		adapter_count++;
+	}
+
+	icom_adapter->index = adapter_count;
+	list_add_tail(&icom_adapter->icom_adapter_entry, tmp);
+
+	*icom_adapter_ref = icom_adapter;
+	return 0;
+}
+
+static void icom_free_adapter(struct icom_adapter *icom_adapter)
+{
+	list_del(&icom_adapter->icom_adapter_entry);
+	kfree(icom_adapter);
+}
+
+static void icom_remove_adapter(struct icom_adapter *icom_adapter)
+{
+	struct icom_port *icom_port;
+	int index;
+
+	for (index = 0; index < icom_adapter->numb_ports; index++) {
+		icom_port = &icom_adapter->port_info[index];
+
+		if (icom_port->status == ICOM_PORT_ACTIVE) {
+			dev_info(&icom_adapter->pci_dev->dev,
+				 "Device removed\n");
+
+			uart_remove_one_port(&icom_uart_driver,
+					     &icom_port->uart_port);
+
+			/* be sure that DTR and RTS are dropped */
+			writeb(0x00, &icom_port->dram->osr);
+
+			/* Wait 0.1 Sec for simple Init to complete */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout(HZ / 10);
+
+			/* Stop proccessor */
+			stop_processor(icom_port);
+
+			return_port_memory(icom_port);
+		}
+	}
+
+	free_irq(icom_adapter->irq_number, (void *) icom_adapter);
+	iounmap((void *) icom_adapter->base_addr);
+	release_mem_region(icom_adapter->base_addr_pci,
+			   pci_resource_len(icom_adapter->pci_dev, 0));
+	icom_free_adapter(icom_adapter);
+}
+
+static void icom_kobj_release(struct kobject *kobj)
+{
+	struct icom_adapter *icom_adapter;
+
+	icom_adapter = to_icom_adapter(kobj);
+	icom_remove_adapter(icom_adapter);
+}
+
+static struct kobj_type icom_kobj_type = {
+	.release = icom_kobj_release,
+};
+
+static int __devinit icom_probe(struct pci_dev *dev,
+				const struct pci_device_id *ent)
+{
+	int index;
+	unsigned int command_reg;
+	int retval;
+	struct icom_adapter *icom_adapter;
+	struct icom_port *icom_port;
+
+	if (pci_enable_device(dev)) {
+		dev_err(&dev->dev, "Device enable FAILED\n");
+		return -EIO;
+	}
+
+	if (pci_read_config_dword(dev, PCI_COMMAND, &command_reg)) {
+		dev_err(&dev->dev, "PCI Config read FAILED\n");
+		return -EIO;
+	}
+
+	pci_write_config_dword(dev, PCI_COMMAND, command_reg | 0x00000146);
+	if (ent->driver_data == ADAPTER_V1) {
+		pci_write_config_dword(dev, 0x44, 0x8300830A);
+	} else {
+		pci_write_config_dword(dev, 0x44, 0x42004200);
+		pci_write_config_dword(dev, 0x48, 0x42004200);
+	}
+
+	retval = icom_alloc_adapter(&icom_adapter);
+	if (retval)
+		return retval;
+
+	icom_adapter->base_addr_pci = pci_resource_start(dev, 0);
+	icom_adapter->irq_number = dev->irq;
+	icom_adapter->pci_dev = dev;
+	icom_adapter->version = ent->driver_data;
+	icom_adapter->subsystem_id = ent->subdevice;
+
+	retval = icom_init_ports(icom_adapter);
+	if (retval) {
+		dev_err(&dev->dev, "Port configuration failed\n");
+		goto probe_exit0;
+	}
+
+	if (!request_mem_region(icom_adapter->base_addr_pci,
+				pci_resource_len(dev, 0), "icom")) {
+		dev_err(&dev->dev, "request_mem_region FAILED\n");
+		retval = -EIO;
+		goto probe_exit0;
+	}
+
+	icom_adapter->base_addr =
+	    (unsigned long) ioremap(icom_adapter->base_addr_pci,
+				    pci_resource_len(dev, 0));
+
+	/* save off irq and request irq line */
+	if (request_irq(dev->irq, icom_interrupt,
+			SA_INTERRUPT | SA_SHIRQ, ICOM_DRIVER_NAME,
+			(void *) icom_adapter)) {
+		retval = -EIO;
+		goto probe_exit1;
+	}
+
+	retval = icom_load_ports(icom_adapter);
+
+	for (index = 0; index < icom_adapter->numb_ports; index++) {
+		icom_port = &icom_adapter->port_info[index];
+
+		if (icom_port->status == ICOM_PORT_ACTIVE) {
+			icom_port->uart_port.irq =
+			    icom_port->adapter->irq_number;
+			icom_port->uart_port.type = PORT_ICOM;
+			icom_port->uart_port.iotype = UPIO_MEM;
+			icom_port->uart_port.membase =
+			    (char *) icom_adapter->base_addr_pci;
+			icom_port->uart_port.fifosize = 16;
+			icom_port->uart_port.ops = &icom_ops;
+			icom_port->uart_port.line =
+			    icom_port->port + icom_adapter->index * 4;
+			if (uart_add_one_port
+			    (&icom_uart_driver, &icom_port->uart_port)) {
+				icom_port->status = ICOM_PORT_OFF;
+				dev_err(&dev->dev, "Device add failed\n");
+			} else
+				dev_info(&dev->dev, "Device added\n");
+		}
+	}
+
+	kobject_init(&icom_adapter->kobj);
+	icom_adapter->kobj.ktype = &icom_kobj_type;
+	return 0;
+
+      probe_exit1:
+	iounmap((void *) icom_adapter->base_addr);
+	release_mem_region(icom_adapter->base_addr_pci,
+			   pci_resource_len(dev, 0));
+
+      probe_exit0:
+	icom_free_adapter(icom_adapter);
+	return retval;
+
+}
+
+static void __devexit icom_remove(struct pci_dev *dev)
+{
+	struct icom_adapter *icom_adapter;
+	struct list_head *tmp;
+
+	list_for_each(tmp, &icom_adapter_head) {
+		icom_adapter = list_entry(tmp, struct icom_adapter,
+					  icom_adapter_entry);
+		if (icom_adapter->pci_dev == dev) {
+			kobject_put(&icom_adapter->kobj);
+			return;
+		}
+	}
+
+	dev_err(&dev->dev, "Unable to find device to remove\n");
+}
+
+static struct pci_driver icom_pci_driver = {
+	.name = ICOM_DRIVER_NAME,
+	.id_table = icom_pci_table,
+	.probe = icom_probe,
+	.remove = __devexit_p(icom_remove),
+};
+
+static int __init icom_init(void)
+{
+	int ret;
+
+	spin_lock_init(&icom_lock);
+
+	ret = uart_register_driver(&icom_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = pci_register_driver(&icom_pci_driver);
+
+	if (ret < 0)
+		uart_unregister_driver(&icom_uart_driver);
+
+	return ret;
+}
+
+static void __exit icom_exit(void)
+{
+	pci_unregister_driver(&icom_pci_driver);
+	uart_unregister_driver(&icom_uart_driver);
+}
+
+module_init(icom_init);
+module_exit(icom_exit);
+
+#ifdef ICOM_TRACE
+static void trace(struct icom_port *icom_port, char *trace_pt,
+		  unsigned long trace_data)
+{
+	dev_info(&icom_port->adapter->pci_dev->dev, ":%d:%s - %lx\n",
+		 icom_port->port, trace_pt, trace_data);
+}
+#endif
+
+MODULE_AUTHOR("Michael Anderson <mjanders@us.ibm.com>");
+MODULE_DESCRIPTION("IBM iSeries Serial IOA driver");
+MODULE_SUPPORTED_DEVICE
+    ("IBM iSeries 2745, 2771, 2772, 2742, 2793 and 2805 Communications adapters");
+MODULE_LICENSE("GPL");
diff -Nur orig/drivers/serial/icom.h devel/drivers/serial/icom.h
--- orig/drivers/serial/icom.h	1969-12-31 16:00:00.000000000 -0800
+++ devel/drivers/serial/icom.h	2004-03-26 06:19:25.000000000 -0800
@@ -0,0 +1,278 @@
+/*
+ * icom.h
+ *
+ * Copyright (C) 2001 Michael Anderson, IBM Corporation
+ *
+ * Serial device driver include file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include<linux/serial_core.h>
+
+#define BAUD_TABLE_LIMIT	((sizeof(icom_acfg_baud)/sizeof(int)) - 1)
+static int icom_acfg_baud[] = {
+	300,
+	600,
+	900,
+	1200,
+	1800,
+	2400,
+	3600,
+	4800,
+	7200,
+	9600,
+	14400,
+	19200,
+	28800,
+	38400,
+	57600,
+	76800,
+	115200,
+	153600,
+	230400,
+	307200,
+	460800,
+};
+
+struct icom_regs {
+	u32 control;		/* Adapter Control Register     */
+	u32 interrupt;		/* Adapter Interrupt Register   */
+	u32 int_mask;		/* Adapter Interrupt Mask Reg   */
+	u32 int_pri;		/* Adapter Interrupt Priority r */
+	u32 int_reg_b;		/* Adapter non-masked Interrupt */
+	u32 resvd01;
+	u32 resvd02;
+	u32 resvd03;
+	u32 control_2;		/* Adapter Control Register 2   */
+	u32 interrupt_2;	/* Adapter Interrupt Register 2 */
+	u32 int_mask_2;		/* Adapter Interrupt Mask 2     */
+	u32 int_pri_2;		/* Adapter Interrupt Prior 2    */
+	u32 int_reg_2b;		/* Adapter non-masked 2         */
+};
+
+struct func_dram {
+	u32 reserved[108];	/* 0-1B0   reserved by personality code */
+	u32 RcvStatusAddr;	/* 1B0-1B3 Status Address for Next rcv */
+	u8 RcvStnAddr;		/* 1B4     Receive Station Addr */
+	u8 IdleState;		/* 1B5     Idle State */
+	u8 IdleMonitor;		/* 1B6     Idle Monitor */
+	u8 FlagFillIdleTimer;	/* 1B7     Flag Fill Idle Timer */
+	u32 XmitStatusAddr;	/* 1B8-1BB Transmit Status Address */
+	u8 StartXmitCmd;	/* 1BC     Start Xmit Command */
+	u8 HDLCConfigReg;	/* 1BD     Reserved */
+	u8 CauseCode;		/* 1BE     Cause code for fatal error */
+	u8 xchar;		/* 1BF     High priority send */
+	u32 reserved3;		/* 1C0-1C3 Reserved */
+	u8 PrevCmdReg;		/* 1C4     Reserved */
+	u8 CmdReg;		/* 1C5     Command Register */
+	u8 async_config2;	/* 1C6     Async Config Byte 2 */
+	u8 async_config3;	/* 1C7     Async Config Byte 3 */
+	u8 dce_resvd[20];	/* 1C8-1DB DCE Rsvd           */
+	u8 dce_resvd21;		/* 1DC     DCE Rsvd (21st byte */
+	u8 misc_flags;		/* 1DD     misc flags         */
+#define V2_HARDWARE     0x40
+#define ICOM_HDW_ACTIVE 0x01
+	u8 call_length;		/* 1DE     Phone #/CFI buff ln */
+	u8 call_length2;	/* 1DF     Upper byte (unused) */
+	u32 call_addr;		/* 1E0-1E3 Phn #/CFI buff addr */
+	u16 timer_value;	/* 1E4-1E5 general timer value */
+	u8 timer_command;	/* 1E6     general timer cmd  */
+	u8 dce_command;		/* 1E7     dce command reg    */
+	u8 dce_cmd_status;	/* 1E8     dce command stat   */
+	u8 x21_r1_ioff;		/* 1E9     dce ready counter  */
+	u8 x21_r0_ioff;		/* 1EA     dce not ready ctr  */
+	u8 x21_ralt_ioff;	/* 1EB     dce CNR counter    */
+	u8 x21_r1_ion;		/* 1EC     dce ready I on ctr */
+	u8 rsvd_ier;		/* 1ED     Rsvd for IER (if ne */
+	u8 ier;			/* 1EE     Interrupt Enable   */
+	u8 isr;			/* 1EF     Input Signal Reg   */
+	u8 osr;			/* 1F0     Output Signal Reg  */
+	u8 reset;		/* 1F1     Reset/Reload Reg   */
+	u8 disable;		/* 1F2     Disable Reg        */
+	u8 sync;		/* 1F3     Sync Reg           */
+	u8 error_stat;		/* 1F4     Error Status       */
+	u8 cable_id;		/* 1F5     Cable ID           */
+	u8 cs_length;		/* 1F6     CS Load Length     */
+	u8 mac_length;		/* 1F7     Mac Load Length    */
+	u32 cs_load_addr;	/* 1F8-1FB Call Load PCI Addr */
+	u32 mac_load_addr;	/* 1FC-1FF Mac Load PCI Addr  */
+};
+
+/*
+ * adapter defines and structures
+ */
+#define ICOM_CONTROL_START_A         0x00000008
+#define ICOM_CONTROL_STOP_A          0x00000004
+#define ICOM_CONTROL_START_B         0x00000002
+#define ICOM_CONTROL_STOP_B          0x00000001
+#define ICOM_CONTROL_START_C         0x00000008
+#define ICOM_CONTROL_STOP_C          0x00000004
+#define ICOM_CONTROL_START_D         0x00000002
+#define ICOM_CONTROL_STOP_D          0x00000001
+#define ICOM_IRAM_OFFSET             0x1000
+#define ICOM_IRAM_SIZE               0x0C00
+#define ICOM_DCE_IRAM_OFFSET         0x0A00
+#define ICOM_CABLE_ID_VALID          0x01
+#define ICOM_CABLE_ID_MASK           0xF0
+#define ICOM_DISABLE                 0x80
+#define CMD_XMIT_RCV_ENABLE          0xC0
+#define CMD_XMIT_ENABLE              0x40
+#define CMD_RCV_DISABLE              0x00
+#define CMD_RCV_ENABLE               0x80
+#define CMD_RESTART                  0x01
+#define CMD_HOLD_XMIT                0x02
+#define CMD_SND_BREAK                0x04
+#define RS232_CABLE                  0x06
+#define V24_CABLE                    0x0E
+#define V35_CABLE                    0x0C
+#define V36_CABLE                    0x02
+#define NO_CABLE                     0x00
+#define START_DOWNLOAD               0x80
+#define ICOM_INT_MASK_PRC_A          0x00003FFF
+#define ICOM_INT_MASK_PRC_B          0x3FFF0000
+#define ICOM_INT_MASK_PRC_C          0x00003FFF
+#define ICOM_INT_MASK_PRC_D          0x3FFF0000
+#define INT_RCV_COMPLETED            0x1000
+#define INT_XMIT_COMPLETED           0x2000
+#define INT_IDLE_DETECT              0x0800
+#define INT_RCV_DISABLED             0x0400
+#define INT_XMIT_DISABLED            0x0200
+#define INT_RCV_XMIT_SHUTDOWN        0x0100
+#define INT_FATAL_ERROR              0x0080
+#define INT_CABLE_PULL               0x0020
+#define INT_SIGNAL_CHANGE            0x0010
+#define HDLC_PPP_PURE_ASYNC          0x02
+#define HDLC_FF_FILL                 0x00
+#define HDLC_HDW_FLOW                0x01
+#define START_XMIT                   0x80
+#define ICOM_ACFG_DRIVE1             0x20
+#define ICOM_ACFG_NO_PARITY          0x00
+#define ICOM_ACFG_PARITY_ENAB        0x02
+#define ICOM_ACFG_PARITY_ODD         0x01
+#define ICOM_ACFG_8BPC               0x00
+#define ICOM_ACFG_7BPC               0x04
+#define ICOM_ACFG_6BPC               0x08
+#define ICOM_ACFG_5BPC               0x0C
+#define ICOM_ACFG_1STOP_BIT          0x00
+#define ICOM_ACFG_2STOP_BIT          0x10
+#define ICOM_DTR                     0x80
+#define ICOM_RTS                     0x40
+#define ICOM_RI                      0x08
+#define ICOM_DSR                     0x80
+#define ICOM_DCD                     0x20
+#define ICOM_CTS                     0x40
+
+#define NUM_XBUFFS 1
+#define NUM_RBUFFS 2
+#define RCV_BUFF_SZ 0x0200
+#define XMIT_BUFF_SZ 0x1000
+struct statusArea {
+    /**********************************************/
+	/* Transmit Status Area                       */
+    /**********************************************/
+	struct {
+		u32 leNext;	/* Next entry in Little Endian on Adapter */
+		u32 leNextASD;
+		u32 leBuffer;	/* Buffer for entry in LE for Adapter */
+		u16 leLengthASD;
+		u16 leOffsetASD;
+		u16 leLength;	/* Length of data in segment */
+		u16 flags;
+#define SA_FLAGS_DONE           0x0080	/* Done with Segment */
+#define SA_FLAGS_CONTINUED      0x8000	/* More Segments */
+#define SA_FLAGS_IDLE           0x4000	/* Mark IDLE after frm */
+#define SA_FLAGS_READY_TO_XMIT  0x0800
+#define SA_FLAGS_STAT_MASK      0x007F
+	} xmit[NUM_XBUFFS];
+
+    /**********************************************/
+	/* Receive Status Area                        */
+    /**********************************************/
+	struct {
+		u32 leNext;	/* Next entry in Little Endian on Adapter */
+		u32 leNextASD;
+		u32 leBuffer;	/* Buffer for entry in LE for Adapter */
+		u16 WorkingLength;	/* size of segment */
+		u16 reserv01;
+		u16 leLength;	/* Length of data in segment */
+		u16 flags;
+#define SA_FL_RCV_DONE           0x0010	/* Data ready */
+#define SA_FLAGS_OVERRUN         0x0040
+#define SA_FLAGS_PARITY_ERROR    0x0080
+#define SA_FLAGS_FRAME_ERROR     0x0001
+#define SA_FLAGS_FRAME_TRUNC     0x0002
+#define SA_FLAGS_BREAK_DET       0x0004	/* set conditionally by device driver, not hardware */
+#define SA_FLAGS_RCV_MASK        0xFFE6
+	} rcv[NUM_RBUFFS];
+};
+
+struct icom_adapter;
+
+
+#define ICOM_MAJOR       243
+#define ICOM_MINOR_START 0
+
+struct icom_port {
+	struct uart_port uart_port;
+	u8 imbed_modem;
+#define ICOM_UNKNOWN		1
+#define ICOM_RVX		2
+#define ICOM_IMBED_MODEM	3
+	unsigned char cable_id;
+	unsigned char read_status_mask;
+	unsigned char ignore_status_mask;
+	unsigned long int_reg;
+	struct icom_regs *global_reg;
+	struct func_dram *dram;
+	int port;
+	struct statusArea *statStg;
+	dma_addr_t statStg_pci;
+	u32 *xmitRestart;
+	dma_addr_t xmitRestart_pci;
+	unsigned char *xmit_buf;
+	dma_addr_t xmit_buf_pci;
+	unsigned char *recv_buf;
+	dma_addr_t recv_buf_pci;
+	int next_rcv;
+	int put_length;
+	int status;
+#define ICOM_PORT_ACTIVE	1	/* Port exists. */
+#define ICOM_PORT_OFF		0	/* Port does not exist. */
+	int load_in_progress;
+	struct icom_adapter *adapter;
+};
+
+struct icom_adapter {
+	unsigned long base_addr;
+	unsigned long base_addr_pci;
+	unsigned char irq_number;
+	struct pci_dev *pci_dev;
+	struct icom_port port_info[4];
+	int index;
+	int version;
+#define ADAPTER_V1	0x0001
+#define ADAPTER_V2	0x0002
+	u32 subsystem_id;
+#define FOUR_PORT_MODEL				0x0252
+#define V2_TWO_PORTS_RVX			0x021A
+#define V2_ONE_PORT_RVX_ONE_PORT_IMBED_MDM	0x0251
+	int numb_ports;
+	struct list_head icom_adapter_entry;
+	struct kobject kobj;
+};
+
+/* prototype */
+extern void iCom_sercons_init(void);
diff -Nur orig/include/linux/serial_core.h devel/include/linux/serial_core.h
--- orig/include/linux/serial_core.h	2004-04-02 15:20:02.000000000 -0800
+++ devel/include/linux/serial_core.h	2004-04-02 15:28:17.000000000 -0800
@@ -83,6 +83,9 @@
 #define PORT_SCIF	53
 #define PORT_IRDA	54
 
+/* IBM icom */
+#define PORT_ICOM	55
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>

--------------030502080108000505030809--

