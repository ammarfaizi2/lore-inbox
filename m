Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSGWLxg>; Tue, 23 Jul 2002 07:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318039AbSGWLxg>; Tue, 23 Jul 2002 07:53:36 -0400
Received: from matrix.rvs.uni-bielefeld.de ([129.70.123.40]:37009 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S318036AbSGWLw7>; Tue, 23 Jul 2002 07:52:59 -0400
Subject: Re: [PATCH] Bluetooth Subsystem PC Card drivers for 2.5.27
From: Marcel Holtmann <marcel@holtmann.org>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0207212139150.3309-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0207212139150.3309-100000@hawkeye.luckynet.adm>
Content-Type: multipart/mixed; boundary="=-RRiqe/RAo9JWj9zQYmyY"
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2002 13:57:51 +0200
Message-Id: <1027425484.26701.2.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RRiqe/RAo9JWj9zQYmyY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

> Please don't use EXPORT_NO_SYMBOLS where it's avoidable.

attached is the same patch without EXPORT_NO_SYMBOLS. Please apply.

Regards

Marcel


--=-RRiqe/RAo9JWj9zQYmyY
Content-Disposition: attachment; filename=patch-2.5.27-bluetooth-pccard-drivers
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=patch-2.5.27-bluetooth-pccard-drivers;
	charset=ISO-8859-1

diff -urN linux-2.5.27/CREDITS linux-2.5.27-mh/CREDITS
--- linux-2.5.27/CREDITS	Sat Jul 20 21:11:09 2002
+++ linux-2.5.27-mh/CREDITS	Tue Jul 23 13:50:22 2002
@@ -1337,6 +1337,12 @@
 S: Provo, Utah 84606-5607
 S: USA
=20
+N: Marcel Holtmann
+E: marcel@holtmann.org
+W: http://www.holtmann.org
+D: Author of the Linux Bluetooth Subsystem PC Card drivers
+S: Germany
+
 N: Rob W. W. Hooft
 E: hooft@EMBL-Heidelberg.DE
 D: Shared libs for graphics-tools and for the f2c compiler
diff -urN linux-2.5.27/MAINTAINERS linux-2.5.27-mh/MAINTAINERS
--- linux-2.5.27/MAINTAINERS	Sat Jul 20 21:11:24 2002
+++ linux-2.5.27-mh/MAINTAINERS	Tue Jul 23 13:50:22 2002
@@ -270,6 +270,12 @@
 W:	http://bluez.sf.net
 S:	Maintained
=20
+BLUETOOTH SUBSYSTEM (PC Card Drivers)
+P:	Marcel Holtmann
+M:	marcel@holtmann.org
+W:	http://www.holtmann.org/linux/bluetooth/
+S:	Maintained
+
 BTTV VIDEO4LINUX DRIVER
 P:	Gerd Knorr
 M:	kraxel@bytesex.org
diff -urN linux-2.5.27/drivers/bluetooth/Config.help linux-2.5.27-mh/driver=
s/bluetooth/Config.help
--- linux-2.5.27/drivers/bluetooth/Config.help	Sat Jul 20 21:11:14 2002
+++ linux-2.5.27-mh/drivers/bluetooth/Config.help	Tue Jul 23 13:50:22 2002
@@ -62,6 +62,20 @@
   Say Y here to compile support for HCI DTL1 devices into the
   kernel or say M to compile it as module (dtl1_cs.o).
=20
+HCI BT3C (PC Card) device driver
+CONFIG_BLUEZ_HCIBT3C
+  Bluetooth HCI BT3C (PC Card) driver.
+  This driver provides support for Bluetooth PCMCIA devices with
+  3Com BT3C interface:
+     3Com Bluetooth Card (3CRWB6096)
+     HP Bluetooth Card
+
+  The HCI BT3C driver uses external firmware loader program provided in
+  the BlueFW package. For more information, see <http://bluez.sf.net>.
+
+  Say Y here to compile support for HCI BT3C devices into the
+  kernel or say M to compile it as module (bt3c_cs.o).
+
 HCI BlueCard (PC Card) device driver
 CONFIG_BLUEZ_HCIBLUECARD
   Bluetooth HCI BlueCard (PC Card) driver.
diff -urN linux-2.5.27/drivers/bluetooth/Config.in linux-2.5.27-mh/drivers/=
bluetooth/Config.in
--- linux-2.5.27/drivers/bluetooth/Config.in	Sat Jul 20 21:11:23 2002
+++ linux-2.5.27-mh/drivers/bluetooth/Config.in	Tue Jul 23 13:50:22 2002
@@ -14,6 +14,8 @@
=20
 dep_tristate 'HCI DTL1 (PC Card) driver' CONFIG_BLUEZ_HCIDTL1 $CONFIG_PCMC=
IA $CONFIG_BLUEZ
=20
+dep_tristate 'HCI BT3C (PC Card) driver' CONFIG_BLUEZ_HCIBT3C $CONFIG_PCMC=
IA $CONFIG_BLUEZ
+
 dep_tristate 'HCI BlueCard (PC Card) driver' CONFIG_BLUEZ_HCIBLUECARD $CON=
FIG_PCMCIA $CONFIG_BLUEZ
=20
 dep_tristate 'HCI VHCI (Virtual HCI device) driver' CONFIG_BLUEZ_HCIVHCI $=
CONFIG_BLUEZ
diff -urN linux-2.5.27/drivers/bluetooth/Makefile linux-2.5.27-mh/drivers/b=
luetooth/Makefile
--- linux-2.5.27/drivers/bluetooth/Makefile	Sat Jul 20 21:12:26 2002
+++ linux-2.5.27-mh/drivers/bluetooth/Makefile	Tue Jul 23 13:50:22 2002
@@ -6,6 +6,7 @@
 obj-$(CONFIG_BLUEZ_HCIVHCI)	+=3D hci_vhci.o
 obj-$(CONFIG_BLUEZ_HCIUART)	+=3D hci_uart.o
 obj-$(CONFIG_BLUEZ_HCIDTL1)	+=3D dtl1_cs.o
+obj-$(CONFIG_BLUEZ_HCIBT3C)	+=3D bt3c_cs.o
 obj-$(CONFIG_BLUEZ_HCIBLUECARD)	+=3D bluecard_cs.o
=20
 hci_uart-y				:=3D hci_ldisc.o
diff -urN linux-2.5.27/drivers/bluetooth/bluecard_cs.c linux-2.5.27-mh/driv=
ers/bluetooth/bluecard_cs.c
--- linux-2.5.27/drivers/bluetooth/bluecard_cs.c	Sat Jul 20 21:11:18 2002
+++ linux-2.5.27-mh/drivers/bluetooth/bluecard_cs.c	Tue Jul 23 13:50:36 200=
2
@@ -89,16 +89,16 @@
 } bluecard_info_t;
=20
=20
-void bluecard_config(dev_link_t * link);
+void bluecard_config(dev_link_t *link);
 void bluecard_release(u_long arg);
-int bluecard_event(event_t event, int priority, event_callback_args_t * ar=
gs);
+int bluecard_event(event_t event, int priority, event_callback_args_t *arg=
s);
=20
 static dev_info_t dev_info =3D "bluecard_cs";
=20
 dev_link_t *bluecard_attach(void);
 void bluecard_detach(dev_link_t *);
=20
-dev_link_t *dev_list =3D NULL;
+static dev_link_t *dev_list =3D NULL;
=20
=20
 /* Default baud rate: 57600, 115200, 230400 or 460800 */
@@ -171,7 +171,7 @@
=20
 void bluecard_activity_led_timeout(u_long arg)
 {
-	bluecard_info_t *info =3D (bluecard_info_t *) arg;
+	bluecard_info_t *info =3D (bluecard_info_t *)arg;
 	unsigned int iobase =3D info->link.io.BasePort1;
=20
 	if (test_bit(CARD_HAS_ACTIVITY_LED, &(info->hw_state))) {
@@ -184,7 +184,7 @@
 }
=20
=20
-static void bluecard_enable_activity_led(bluecard_info_t * info)
+static void bluecard_enable_activity_led(bluecard_info_t *info)
 {
 	unsigned int iobase =3D info->link.io.BasePort1;
=20
@@ -208,8 +208,7 @@
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Interrupt handling =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D */
=20
=20
-static int bluecard_write(unsigned int iobase, unsigned int offset,
-			  __u8 * buf, int len)
+static int bluecard_write(unsigned int iobase, unsigned int offset, __u8 *=
buf, int len)
 {
 	int i, actual;
=20
@@ -224,7 +223,7 @@
 }
=20
=20
-static void bluecard_write_wakeup(bluecard_info_t * info)
+static void bluecard_write_wakeup(bluecard_info_t *info)
 {
 	if (!info) {
 		printk(KERN_WARNING "bluecard_cs: Call of write_wakeup for unknown devic=
e.\n");
@@ -253,15 +252,13 @@
 			return;
=20
 		if (test_bit(XMIT_BUFFER_NUMBER, &(info->tx_state))) {
-			if (!test_bit
-			    (XMIT_BUF_TWO_READY, &(info->tx_state)))
+			if (!test_bit(XMIT_BUF_TWO_READY, &(info->tx_state)))
 				break;
 			offset =3D 0x10;
 			command =3D REG_COMMAND_TX_BUF_TWO;
 			ready_bit =3D XMIT_BUF_TWO_READY;
 		} else {
-			if (!test_bit
-			    (XMIT_BUF_ONE_READY, &(info->tx_state)))
+			if (!test_bit(XMIT_BUF_ONE_READY, &(info->tx_state)))
 				break;
 			offset =3D 0x00;
 			command =3D REG_COMMAND_TX_BUF_ONE;
@@ -272,11 +269,9 @@
 			break;
=20
 		if (skb->pkt_type & 0x80) {
-
 			/* Disable RTS */
 			info->ctrl_reg |=3D REG_CONTROL_RTS;
 			outb(info->ctrl_reg, iobase + REG_CONTROL);
-
 		}
=20
 		/* Activate LED */
@@ -349,8 +344,7 @@
 }
=20
=20
-static int bluecard_read(unsigned int iobase, unsigned int offset,
-			 __u8 * buf, int size)
+static int bluecard_read(unsigned int iobase, unsigned int offset, __u8 *b=
uf, int size)
 {
 	int i, n, len;
=20
@@ -378,7 +372,7 @@
 }
=20
=20
-static void bluecard_receive(bluecard_info_t * info, unsigned int offset)
+static void bluecard_receive(bluecard_info_t *info, unsigned int offset)
 {
 	unsigned int iobase;
 	unsigned char buf[31];
@@ -410,7 +404,7 @@
=20
 		if (info->rx_state =3D=3D RECV_WAIT_PACKET_TYPE) {
=20
-			info->rx_skb->dev =3D (void *) &(info->hdev);
+			info->rx_skb->dev =3D (void *)&(info->hdev);
 			info->rx_skb->pkt_type =3D buf[i];
=20
 			switch (info->rx_skb->pkt_type) {
@@ -469,20 +463,20 @@
 				switch (info->rx_state) {
=20
 				case RECV_WAIT_EVENT_HEADER:
-					eh =3D (hci_event_hdr *) (info->rx_skb->data);
+					eh =3D (hci_event_hdr *)(info->rx_skb->data);
 					info->rx_state =3D RECV_WAIT_DATA;
 					info->rx_count =3D eh->plen;
 					break;
=20
 				case RECV_WAIT_ACL_HEADER:
-					ah =3D (hci_acl_hdr *) (info->rx_skb->data);
+					ah =3D (hci_acl_hdr *)(info->rx_skb->data);
 					dlen =3D __le16_to_cpu(ah->dlen);
 					info->rx_state =3D RECV_WAIT_DATA;
 					info->rx_count =3D dlen;
 					break;
=20
 				case RECV_WAIT_SCO_HEADER:
-					sh =3D (hci_sco_hdr *) (info->rx_skb->data);
+					sh =3D (hci_sco_hdr *)(info->rx_skb->data);
 					info->rx_state =3D RECV_WAIT_DATA;
 					info->rx_count =3D sh->dlen;
 					break;
@@ -571,9 +565,8 @@
=20
 static int bluecard_hci_set_baud_rate(struct hci_dev *hdev, int baud)
 {
-	bluecard_info_t *info =3D (bluecard_info_t *) (hdev->driver_data);
+	bluecard_info_t *info =3D (bluecard_info_t *)(hdev->driver_data);
 	struct sk_buff *skb;
-	int i;
=20
 	/* Ericsson baud rate command */
 	unsigned char cmd[] =3D { HCI_COMMAND_PKT, 0x09, 0xfc, 0x01, 0x03 };
@@ -604,8 +597,7 @@
 		break;
 	}
=20
-	for (i =3D 0; i < sizeof(cmd); i++)
-		*skb_put(skb, 1) =3D cmd[i];
+	memcpy(skb_put(skb, sizeof(cmd)), cmd, sizeof(cmd));
=20
 	skb_queue_tail(&(info->txq), skb);
=20
@@ -621,7 +613,7 @@
=20
 static int bluecard_hci_flush(struct hci_dev *hdev)
 {
-	bluecard_info_t *info =3D (bluecard_info_t *) (hdev->driver_data);
+	bluecard_info_t *info =3D (bluecard_info_t *)(hdev->driver_data);
=20
 	/* Drop TX queue */
 	skb_queue_purge(&(info->txq));
@@ -632,7 +624,7 @@
=20
 static int bluecard_hci_open(struct hci_dev *hdev)
 {
-	bluecard_info_t *info =3D (bluecard_info_t *) (hdev->driver_data);
+	bluecard_info_t *info =3D (bluecard_info_t *)(hdev->driver_data);
 	unsigned int iobase =3D info->link.io.BasePort1;
=20
 	bluecard_hci_set_baud_rate(hdev, DEFAULT_BAUD_RATE);
@@ -649,7 +641,7 @@
=20
 static int bluecard_hci_close(struct hci_dev *hdev)
 {
-	bluecard_info_t *info =3D (bluecard_info_t *) (hdev->driver_data);
+	bluecard_info_t *info =3D (bluecard_info_t *)(hdev->driver_data);
 	unsigned int iobase =3D info->link.io.BasePort1;
=20
 	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
@@ -667,14 +659,14 @@
 static int bluecard_hci_send_frame(struct sk_buff *skb)
 {
 	bluecard_info_t *info;
-	struct hci_dev *hdev =3D (struct hci_dev *) (skb->dev);
+	struct hci_dev *hdev =3D (struct hci_dev *)(skb->dev);
=20
 	if (!hdev) {
 		printk(KERN_WARNING "bluecard_cs: Frame for unknown HCI device (hdev=3DN=
ULL).");
 		return -ENODEV;
 	}
=20
-	info =3D (bluecard_info_t *) (hdev->driver_data);
+	info =3D (bluecard_info_t *)(hdev->driver_data);
=20
 	switch (skb->pkt_type) {
 	case HCI_COMMAND_PKT:
@@ -703,8 +695,7 @@
 }
=20
=20
-static int bluecard_hci_ioctl(struct hci_dev *hdev, unsigned int cmd,
-			      unsigned long arg)
+static int bluecard_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsi=
gned long arg)
 {
 	return -ENOIOCTLCMD;
 }
@@ -714,7 +705,7 @@
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Card services HCI interaction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
=20
=20
-int bluecard_open(bluecard_info_t * info)
+int bluecard_open(bluecard_info_t *info)
 {
 	unsigned int iobase =3D info->link.io.BasePort1;
 	struct hci_dev *hdev;
@@ -724,7 +715,7 @@
=20
 	init_timer(&(info->timer));
 	info->timer.function =3D &bluecard_activity_led_timeout;
-	info->timer.data =3D (u_long) info;
+	info->timer.data =3D (u_long)info;
=20
 	skb_queue_head_init(&(info->txq));
=20
@@ -781,7 +772,8 @@
=20
 	/* Timeout before it is safe to send the first HCI packet */
 	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout((HZ * 5) / 4);	// or set it to 3/2
+	schedule_timeout((HZ * 5) / 4);		// or set it to 3/2
+
=20
 	/* Initialize and register HCI device */
=20
@@ -806,7 +798,7 @@
 }
=20
=20
-int bluecard_close(bluecard_info_t * info)
+int bluecard_close(bluecard_info_t *info)
 {
 	unsigned int iobase =3D info->link.io.BasePort1;
 	struct hci_dev *hdev =3D &(info->hdev);
@@ -858,7 +850,7 @@
 	link->priv =3D info;
=20
 	link->release.function =3D &bluecard_release;
-	link->release.data =3D (u_long) link;
+	link->release.data =3D (u_long)link;
 	link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
 	link->io.NumPorts1 =3D 8;
 	link->irq.Attributes =3D IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
@@ -883,9 +875,9 @@
 	client_reg.dev_info =3D &dev_info;
 	client_reg.Attributes =3D INFO_IO_CLIENT | INFO_CARD_SHARE;
 	client_reg.EventMask =3D
-	    CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
-	    CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
-	    CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+		CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
 	client_reg.event_handler =3D &bluecard_event;
 	client_reg.Version =3D 0x0210;
 	client_reg.event_callback_args.client_data =3D link;
@@ -901,7 +893,7 @@
 }
=20
=20
-void bluecard_detach(dev_link_t * link)
+void bluecard_detach(dev_link_t *link)
 {
 	bluecard_info_t *info =3D link->priv;
 	dev_link_t **linkp;
@@ -917,7 +909,7 @@
=20
 	del_timer(&link->release);
 	if (link->state & DEV_CONFIG)
-		bluecard_release((u_long) link);
+		bluecard_release((u_long)link);
=20
 	if (link->handle) {
 		ret =3D CardServices(DeregisterClient, link->handle);
@@ -932,8 +924,7 @@
 }
=20
=20
-static int get_tuple(int fn, client_handle_t handle, tuple_t * tuple,
-		     cisparse_t * parse)
+static int get_tuple(int fn, client_handle_t handle, tuple_t *tuple, cispa=
rse_t *parse)
 {
 	int i;
=20
@@ -952,7 +943,7 @@
 #define first_tuple(a, b, c) get_tuple(GetFirstTuple, a, b, c)
 #define next_tuple(a, b, c) get_tuple(GetNextTuple, a, b, c)
=20
-void bluecard_config(dev_link_t * link)
+void bluecard_config(dev_link_t *link)
 {
 	client_handle_t handle =3D link->handle;
 	bluecard_info_t *info =3D link->priv;
@@ -962,7 +953,7 @@
 	config_info_t config;
 	int i, n, last_ret, last_fn;
=20
-	tuple.TupleData =3D (cisdata_t *) buf;
+	tuple.TupleData =3D (cisdata_t *)buf;
 	tuple.TupleOffset =3D 0;
 	tuple.TupleDataMax =3D 255;
 	tuple.Attributes =3D 0;
@@ -1010,12 +1001,12 @@
 		goto failed;
 	}
=20
-
 	MOD_INC_USE_COUNT;
=20
 	if (bluecard_open(info) !=3D 0)
 		goto failed;
=20
+	strcpy(info->node.dev_name, info->hdev.name);
 	link->dev =3D &info->node;
 	link->state &=3D ~DEV_CONFIG_PENDING;
=20
@@ -1025,13 +1016,13 @@
 	cs_error(link->handle, last_fn, last_ret);
=20
 failed:
-	bluecard_release((u_long) link);
+	bluecard_release((u_long)link);
 }
=20
=20
 void bluecard_release(u_long arg)
 {
-	dev_link_t *link =3D (dev_link_t *) arg;
+	dev_link_t *link =3D (dev_link_t *)arg;
 	bluecard_info_t *info =3D link->priv;
=20
 	if (link->state & DEV_PRESENT)
@@ -1049,8 +1040,7 @@
 }
=20
=20
-int bluecard_event(event_t event, int priority,
-		   event_callback_args_t * args)
+int bluecard_event(event_t event, int priority, event_callback_args_t *arg=
s)
 {
 	dev_link_t *link =3D args->client_data;
 	bluecard_info_t *info =3D link->priv;
@@ -1079,8 +1069,7 @@
 		/* Fall through... */
 	case CS_EVENT_CARD_RESET:
 		if (DEV_OK(link))
-			CardServices(RequestConfiguration, link->handle,
-				     &link->conf);
+			CardServices(RequestConfiguration, link->handle, &link->conf);
 		break;
 	}
=20
diff -urN linux-2.5.27/drivers/bluetooth/bt3c_cs.c linux-2.5.27-mh/drivers/=
bluetooth/bt3c_cs.c
--- linux-2.5.27/drivers/bluetooth/bt3c_cs.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.27-mh/drivers/bluetooth/bt3c_cs.c	Tue Jul 23 13:50:53 2002
@@ -0,0 +1,944 @@
+/*
+ *
+ *  Driver for the 3Com Bluetooth PCMCIA card
+ *
+ *  Copyright (C) 2001-2002  Marcel Holtmann <marcel@holtmann.org>
+ *                           Jose Orlando Pereira <jop@di.uminho.pt>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation;
+ *
+ *  Software distributed under the License is distributed on an "AS
+ *  IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
+ *  implied. See the License for the specific language governing
+ *  rights and limitations under the License.
+ *
+ *  The initial developer of the original code is David A. Hinds
+ *  <dahinds@users.sourceforge.net>.  Portions created by David A. Hinds
+ *  are Copyright (C) 1999 David A. Hinds.  All Rights Reserved.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+
+#define __KERNEL_SYSCALLS__
+
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/ioport.h>
+#include <linux/spinlock.h>
+
+#include <linux/skbuff.h>
+#include <linux/string.h>
+#include <linux/serial.h>
+#include <linux/serial_reg.h>
+#include <asm/system.h>
+#include <asm/bitops.h>
+#include <asm/io.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/cistpl.h>
+#include <pcmcia/ciscode.h>
+#include <pcmcia/ds.h>
+#include <pcmcia/cisreg.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Module parameters =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D */
+
+
+/* Bit map of interrupts to choose from */
+static u_int irq_mask =3D 0xffff;
+static int irq_list[4] =3D { -1 };
+
+MODULE_PARM(irq_mask, "i");
+MODULE_PARM(irq_list, "1-4i");
+
+MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>, Jose Orlando Pereira=
 <jop@di.uminho.pt>");
+MODULE_DESCRIPTION("BlueZ driver for the 3Com Bluetooth PCMCIA card");
+MODULE_LICENSE("GPL");
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Local structures =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D */
+
+
+typedef struct bt3c_info_t {
+	dev_link_t link;
+	dev_node_t node;
+
+	struct hci_dev hdev;
+
+	spinlock_t lock;		/* For serializing operations */
+
+	struct sk_buff_head txq;
+	unsigned long tx_state;
+
+	unsigned long rx_state;
+	unsigned long rx_count;
+	struct sk_buff *rx_skb;
+} bt3c_info_t;
+
+
+void bt3c_config(dev_link_t *link);
+void bt3c_release(u_long arg);
+int bt3c_event(event_t event, int priority, event_callback_args_t *args);
+
+static dev_info_t dev_info =3D "bt3c_cs";
+
+dev_link_t *bt3c_attach(void);
+void bt3c_detach(dev_link_t *);
+
+static dev_link_t *dev_list =3D NULL;
+
+
+/* Transmit states  */
+#define XMIT_SENDING  1
+#define XMIT_WAKEUP   2
+#define XMIT_WAITING  8
+
+/* Receiver states */
+#define RECV_WAIT_PACKET_TYPE   0
+#define RECV_WAIT_EVENT_HEADER  1
+#define RECV_WAIT_ACL_HEADER    2
+#define RECV_WAIT_SCO_HEADER    3
+#define RECV_WAIT_DATA          4
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Special I/O functions =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D */
+
+
+#define DATA_L   0
+#define DATA_H   1
+#define ADDR_L   2
+#define ADDR_H   3
+#define CONTROL  4
+
+
+inline void bt3c_address(unsigned int iobase, unsigned short addr)
+{
+	outb(addr & 0xff, iobase + ADDR_L);
+	outb((addr >> 8) & 0xff, iobase + ADDR_H);
+}
+
+
+inline void bt3c_put(unsigned int iobase, unsigned short value)
+{
+	outb(value & 0xff, iobase + DATA_L);
+	outb((value >> 8) & 0xff, iobase + DATA_H);
+}
+
+
+inline void bt3c_io_write(unsigned int iobase, unsigned short addr, unsign=
ed short value)
+{
+	bt3c_address(iobase, addr);
+	bt3c_put(iobase, value);
+}
+
+
+inline unsigned short bt3c_get(unsigned int iobase)
+{
+	unsigned short value =3D inb(iobase + DATA_L);
+
+	value |=3D inb(iobase + DATA_H) << 8;
+
+	return value;
+}
+
+
+inline unsigned short bt3c_read(unsigned int iobase, unsigned short addr)
+{
+	bt3c_address(iobase, addr);
+
+	return bt3c_get(iobase);
+}
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Interrupt handling =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D */
+
+
+static int bt3c_write(unsigned int iobase, int fifo_size, __u8 *buf, int l=
en)
+{
+	int actual =3D 0;
+
+	bt3c_address(iobase, 0x7080);
+
+	/* Fill FIFO with current frame */
+	while (actual < len) {
+		/* Transmit next byte */
+		bt3c_put(iobase, buf[actual]);
+		actual++;
+	}
+
+	bt3c_io_write(iobase, 0x7005, actual);
+
+	return actual;
+}
+
+
+static void bt3c_write_wakeup(bt3c_info_t *info, int from)
+{
+	unsigned long flags;
+
+	if (!info) {
+		printk(KERN_WARNING "bt3c_cs: Call of write_wakeup for unknown device.\n=
");
+		return;
+	}
+
+	if (test_and_set_bit(XMIT_SENDING, &(info->tx_state)))
+		return;
+
+	spin_lock_irqsave(&(info->lock), flags);
+
+	do {
+		register unsigned int iobase =3D info->link.io.BasePort1;
+		register struct sk_buff *skb;
+		register int len;
+
+		if (!(info->link.state & DEV_PRESENT))
+			break;
+
+
+		if (!(skb =3D skb_dequeue(&(info->txq)))) {
+			clear_bit(XMIT_SENDING, &(info->tx_state));
+			break;
+		}
+
+		/* Send frame */
+		len =3D bt3c_write(iobase, 256, skb->data, skb->len);
+
+		if (len !=3D skb->len) {
+			printk(KERN_WARNING "bt3c_cs: very strange\n");
+		}
+
+		kfree_skb(skb);
+
+		info->hdev.stat.byte_tx +=3D len;
+
+	} while (0);
+
+	spin_unlock_irqrestore(&(info->lock), flags);
+}
+
+
+static void bt3c_receive(bt3c_info_t *info)
+{
+	unsigned int iobase;
+	int size =3D 0, avail;
+
+	if (!info) {
+		printk(KERN_WARNING "bt3c_cs: Call of receive for unknown device.\n");
+		return;
+	}
+
+	iobase =3D info->link.io.BasePort1;
+
+	avail =3D bt3c_read(iobase, 0x7006);
+	//printk("bt3c_cs: receiving %d bytes\n", avail);
+
+	bt3c_address(iobase, 0x7480);
+	while (size < avail) {
+		size++;
+		info->hdev.stat.byte_rx++;
+
+		/* Allocate packet */
+		if (info->rx_skb =3D=3D NULL) {
+			info->rx_state =3D RECV_WAIT_PACKET_TYPE;
+			info->rx_count =3D 0;
+			if (!(info->rx_skb =3D bluez_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))=
) {
+				printk(KERN_WARNING "bt3c_cs: Can't allocate mem for new packet.\n");
+				return;
+			}
+		}
+
+
+		if (info->rx_state =3D=3D RECV_WAIT_PACKET_TYPE) {
+
+			info->rx_skb->dev =3D (void *)&(info->hdev);
+			info->rx_skb->pkt_type =3D inb(iobase + DATA_L);
+			inb(iobase + DATA_H);
+			//printk("bt3c: PACKET_TYPE=3D%02x\n", info->rx_skb->pkt_type);
+
+			switch (info->rx_skb->pkt_type) {
+
+			case HCI_EVENT_PKT:
+				info->rx_state =3D RECV_WAIT_EVENT_HEADER;
+				info->rx_count =3D HCI_EVENT_HDR_SIZE;
+				break;
+
+			case HCI_ACLDATA_PKT:
+				info->rx_state =3D RECV_WAIT_ACL_HEADER;
+				info->rx_count =3D HCI_ACL_HDR_SIZE;
+				break;
+
+			case HCI_SCODATA_PKT:
+				info->rx_state =3D RECV_WAIT_SCO_HEADER;
+				info->rx_count =3D HCI_SCO_HDR_SIZE;
+				break;
+
+			default:
+				/* Unknown packet */
+				printk(KERN_WARNING "bt3c_cs: Unknown HCI packet with type 0x%02x rece=
ived.\n", info->rx_skb->pkt_type);
+				info->hdev.stat.err_rx++;
+				clear_bit(HCI_RUNNING, &(info->hdev.flags));
+
+				kfree_skb(info->rx_skb);
+				info->rx_skb =3D NULL;
+				break;
+
+			}
+
+		} else {
+
+			__u8 x =3D inb(iobase + DATA_L);
+
+			*skb_put(info->rx_skb, 1) =3D x;
+			inb(iobase + DATA_H);
+			info->rx_count--;
+
+			if (info->rx_count =3D=3D 0) {
+
+				int dlen;
+				hci_event_hdr *eh;
+				hci_acl_hdr *ah;
+				hci_sco_hdr *sh;
+
+				switch (info->rx_state) {
+
+				case RECV_WAIT_EVENT_HEADER:
+					eh =3D (hci_event_hdr *)(info->rx_skb->data);
+					info->rx_state =3D RECV_WAIT_DATA;
+					info->rx_count =3D eh->plen;
+					break;
+
+				case RECV_WAIT_ACL_HEADER:
+					ah =3D (hci_acl_hdr *)(info->rx_skb->data);
+					dlen =3D __le16_to_cpu(ah->dlen);
+					info->rx_state =3D RECV_WAIT_DATA;
+					info->rx_count =3D dlen;
+					break;
+
+				case RECV_WAIT_SCO_HEADER:
+					sh =3D (hci_sco_hdr *)(info->rx_skb->data);
+					info->rx_state =3D RECV_WAIT_DATA;
+					info->rx_count =3D sh->dlen;
+					break;
+
+				case RECV_WAIT_DATA:
+					hci_recv_frame(info->rx_skb);
+					info->rx_skb =3D NULL;
+					break;
+
+				}
+
+			}
+
+		}
+
+	}
+
+	bt3c_io_write(iobase, 0x7006, 0x0000);
+}
+
+
+void bt3c_interrupt(int irq, void *dev_inst, struct pt_regs *regs)
+{
+	bt3c_info_t *info =3D dev_inst;
+	unsigned int iobase;
+	int iir;
+
+	if (!info) {
+		printk(KERN_WARNING "bt3c_cs: Call of irq %d for unknown device.\n", irq=
);
+		return;
+	}
+
+	iobase =3D info->link.io.BasePort1;
+
+	spin_lock(&(info->lock));
+
+	iir =3D inb(iobase + CONTROL);
+	if (iir & 0x80) {
+		int stat =3D bt3c_read(iobase, 0x7001);
+
+		if ((stat & 0xff) =3D=3D 0x7f) {
+			printk(KERN_WARNING "bt3c_cs: STRANGE stat=3D%04x\n", stat);
+		} else if ((stat & 0xff) !=3D 0xff) {
+			if (stat & 0x0020) {
+				int stat =3D bt3c_read(iobase, 0x7002) & 0x10;
+				printk(KERN_WARNING "bt3c_cs: antena %s\n", stat ? "OUT" : "IN");
+			}
+			if (stat & 0x0001)
+				bt3c_receive(info);
+			if (stat & 0x0002) {
+				//printk("bt3c_cs: ACK %04x\n", stat);
+				clear_bit(XMIT_SENDING, &(info->tx_state));
+				bt3c_write_wakeup(info, 1);
+			}
+
+			bt3c_io_write(iobase, 0x7001, 0x0000);
+
+			outb(iir, iobase + CONTROL);
+		}
+	}
+
+	spin_unlock(&(info->lock));
+}
+
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D HCI interface =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
+
+
+static int bt3c_hci_flush(struct hci_dev *hdev)
+{
+	bt3c_info_t *info =3D (bt3c_info_t *)(hdev->driver_data);
+
+	/* Drop TX queue */
+	skb_queue_purge(&(info->txq));
+
+	return 0;
+}
+
+
+static int bt3c_hci_open(struct hci_dev *hdev)
+{
+	set_bit(HCI_RUNNING, &(hdev->flags));
+
+	return 0;
+}
+
+
+static int bt3c_hci_close(struct hci_dev *hdev)
+{
+	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
+		return 0;
+
+	bt3c_hci_flush(hdev);
+
+	return 0;
+}
+
+
+static int bt3c_hci_send_frame(struct sk_buff *skb)
+{
+	bt3c_info_t *info;
+	struct hci_dev *hdev =3D (struct hci_dev *)(skb->dev);
+
+	if (!hdev) {
+		printk(KERN_WARNING "bt3c_cs: Frame for unknown HCI device (hdev=3DNULL)=
.");
+		return -ENODEV;
+	}
+
+	info =3D (bt3c_info_t *) (hdev->driver_data);
+
+	switch (skb->pkt_type) {
+	case HCI_COMMAND_PKT:
+		hdev->stat.cmd_tx++;
+		break;
+	case HCI_ACLDATA_PKT:
+		hdev->stat.acl_tx++;
+		break;
+	case HCI_SCODATA_PKT:
+		hdev->stat.sco_tx++;
+		break;
+	};
+
+	/* Prepend skb with frame type */
+	memcpy(skb_push(skb, 1), &(skb->pkt_type), 1);
+	skb_queue_tail(&(info->txq), skb);
+
+	bt3c_write_wakeup(info, 0);
+
+	return 0;
+}
+
+
+static void bt3c_hci_destruct(struct hci_dev *hdev)
+{
+}
+
+
+static int bt3c_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned=
 long arg)
+{
+	return -ENOIOCTLCMD;
+}
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D User mode firmware loader =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+
+#define FW_LOADER  "/sbin/bluefw"
+static int errno;
+
+
+static int bt3c_fw_loader_exec(void *dev)
+{
+	char *argv[] =3D { FW_LOADER, "pccard", dev, NULL };
+	char *envp[] =3D { "HOME=3D/", "TERM=3Dlinux", "PATH=3D/sbin:/usr/sbin:/b=
in:/usr/bin", NULL };
+	int err;
+
+	err =3D exec_usermodehelper(FW_LOADER, argv, envp);
+	if (err)
+		printk(KERN_WARNING "bt3c_cs: Failed to exec \"%s pccard %s\".\n", FW_LO=
ADER, (char *)dev);
+
+	return err;
+}
+
+
+static int bt3c_firmware_load(bt3c_info_t *info)
+{
+	sigset_t tmpsig;
+	char dev[16];
+	pid_t pid;
+	int result;
+
+	/* Check if root fs is mounted */
+	if (!current->fs->root) {
+		printk(KERN_WARNING "bt3c_cs: Root filesystem is not mounted.\n");
+		return -EPERM;
+	}
+
+	sprintf(dev, "%04x", info->link.io.BasePort1);
+
+	pid =3D kernel_thread(bt3c_fw_loader_exec, (void *)dev, 0);
+	if (pid < 0) {
+		printk(KERN_WARNING "bt3c_cs: Forking of kernel thread failed (errno=3D%=
d).\n", -pid);
+		return pid;
+	}
+
+	/* Block signals, everything but SIGKILL/SIGSTOP */
+	spin_lock_irq(&current->sigmask_lock);
+	tmpsig =3D current->blocked;
+	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	recalc_sigpending();
+	spin_unlock_irq(&current->sigmask_lock);
+
+	result =3D waitpid(pid, NULL, __WCLONE);
+
+	/* Allow signals again */
+	spin_lock_irq(&current->sigmask_lock);
+	current->blocked =3D tmpsig;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sigmask_lock);
+
+	if (result !=3D pid) {
+		printk(KERN_WARNING "bt3c_cs: Waiting for pid %d failed (errno=3D%d).\n"=
, pid, -result);
+		return -result;
+	}
+
+	return 0;
+}
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Card services HCI interaction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+
+int bt3c_open(bt3c_info_t *info)
+{
+	struct hci_dev *hdev;
+	int err;
+
+	spin_lock_init(&(info->lock));
+
+	skb_queue_head_init(&(info->txq));
+
+	info->rx_state =3D RECV_WAIT_PACKET_TYPE;
+	info->rx_count =3D 0;
+	info->rx_skb =3D NULL;
+
+	/* Load firmware */
+
+	if ((err =3D bt3c_firmware_load(info)) < 0)
+		return err;
+
+	/* Timeout before it is safe to send the first HCI packet */
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(HZ);
+
+
+	/* Initialize and register HCI device */
+
+	hdev =3D &(info->hdev);
+
+	hdev->type =3D HCI_PCCARD;
+	hdev->driver_data =3D info;
+
+	hdev->open =3D bt3c_hci_open;
+	hdev->close =3D bt3c_hci_close;
+	hdev->flush =3D bt3c_hci_flush;
+	hdev->send =3D bt3c_hci_send_frame;
+	hdev->destruct =3D bt3c_hci_destruct;
+	hdev->ioctl =3D bt3c_hci_ioctl;
+
+	if (hci_register_dev(hdev) < 0) {
+		printk(KERN_WARNING "bt3c_cs: Can't register HCI device %s.\n", hdev->na=
me);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+
+int bt3c_close(bt3c_info_t *info)
+{
+	struct hci_dev *hdev =3D &(info->hdev);
+
+	bt3c_hci_close(hdev);
+
+	if (hci_unregister_dev(hdev) < 0)
+		printk(KERN_WARNING "bt3c_cs: Can't unregister HCI device %s.\n", hdev->=
name);
+
+	return 0;
+}
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Card services =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
+
+
+static void cs_error(client_handle_t handle, int func, int ret)
+{
+	error_info_t err =3D { func, ret };
+
+	CardServices(ReportError, handle, &err);
+}
+
+
+dev_link_t *bt3c_attach(void)
+{
+	bt3c_info_t *info;
+	client_reg_t client_reg;
+	dev_link_t *link;
+	int i, ret;
+
+	/* Create new info device */
+	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	memset(info, 0, sizeof(*info));
+
+	link =3D &info->link;
+	link->priv =3D info;
+
+	link->release.function =3D &bt3c_release;
+	link->release.data =3D (u_long)link;
+	link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
+	link->io.NumPorts1 =3D 8;
+	link->irq.Attributes =3D IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
+	link->irq.IRQInfo1 =3D IRQ_INFO2_VALID | IRQ_LEVEL_ID;
+
+	if (irq_list[0] =3D=3D -1)
+		link->irq.IRQInfo2 =3D irq_mask;
+	else
+		for (i =3D 0; i < 4; i++)
+			link->irq.IRQInfo2 |=3D 1 << irq_list[i];
+
+	link->irq.Handler =3D bt3c_interrupt;
+	link->irq.Instance =3D info;
+
+	link->conf.Attributes =3D CONF_ENABLE_IRQ;
+	link->conf.Vcc =3D 50;
+	link->conf.IntType =3D INT_MEMORY_AND_IO;
+
+	/* Register with Card Services */
+	link->next =3D dev_list;
+	dev_list =3D link;
+	client_reg.dev_info =3D &dev_info;
+	client_reg.Attributes =3D INFO_IO_CLIENT | INFO_CARD_SHARE;
+	client_reg.EventMask =3D
+	    CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+	    CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+	    CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.event_handler =3D &bt3c_event;
+	client_reg.Version =3D 0x0210;
+	client_reg.event_callback_args.client_data =3D link;
+
+	ret =3D CardServices(RegisterClient, &link->handle, &client_reg);
+	if (ret !=3D CS_SUCCESS) {
+		cs_error(link->handle, RegisterClient, ret);
+		bt3c_detach(link);
+		return NULL;
+	}
+
+	return link;
+}
+
+
+void bt3c_detach(dev_link_t *link)
+{
+	bt3c_info_t *info =3D link->priv;
+	dev_link_t **linkp;
+	int ret;
+
+	/* Locate device structure */
+	for (linkp =3D &dev_list; *linkp; linkp =3D &(*linkp)->next)
+		if (*linkp =3D=3D link)
+			break;
+
+	if (*linkp =3D=3D NULL)
+		return;
+
+	del_timer(&link->release);
+
+	if (link->state & DEV_CONFIG)
+		bt3c_release((u_long)link);
+
+	if (link->handle) {
+		ret =3D CardServices(DeregisterClient, link->handle);
+		if (ret !=3D CS_SUCCESS)
+			cs_error(link->handle, DeregisterClient, ret);
+	}
+
+	/* Unlink device structure, free bits */
+	*linkp =3D link->next;
+
+	kfree(info);
+}
+
+
+static int get_tuple(int fn, client_handle_t handle, tuple_t *tuple, cispa=
rse_t *parse)
+{
+	int i;
+
+	i =3D CardServices(fn, handle, tuple);
+	if (i !=3D CS_SUCCESS)
+		return CS_NO_MORE_ITEMS;
+
+	i =3D CardServices(GetTupleData, handle, tuple);
+	if (i !=3D CS_SUCCESS)
+		return i;
+
+	return CardServices(ParseTuple, handle, tuple, parse);
+}
+
+
+#define first_tuple(a, b, c) get_tuple(GetFirstTuple, a, b, c)
+#define next_tuple(a, b, c) get_tuple(GetNextTuple, a, b, c)
+
+void bt3c_config(dev_link_t *link)
+{
+	static ioaddr_t base[5] =3D { 0x3f8, 0x2f8, 0x3e8, 0x2e8, 0x0 };
+	client_handle_t handle =3D link->handle;
+	bt3c_info_t *info =3D link->priv;
+	tuple_t tuple;
+	u_short buf[256];
+	cisparse_t parse;
+	cistpl_cftable_entry_t *cf =3D &parse.cftable_entry;
+	config_info_t config;
+	int i, j, try, last_ret, last_fn;
+
+	tuple.TupleData =3D (cisdata_t *)buf;
+	tuple.TupleOffset =3D 0;
+	tuple.TupleDataMax =3D 255;
+	tuple.Attributes =3D 0;
+
+	/* Get configuration register information */
+	tuple.DesiredTuple =3D CISTPL_CONFIG;
+	last_ret =3D first_tuple(handle, &tuple, &parse);
+	if (last_ret !=3D CS_SUCCESS) {
+		last_fn =3D ParseTuple;
+		goto cs_failed;
+	}
+	link->conf.ConfigBase =3D parse.config.base;
+	link->conf.Present =3D parse.config.rmask[0];
+
+	/* Configure card */
+	link->state |=3D DEV_CONFIG;
+	i =3D CardServices(GetConfigurationInfo, handle, &config);
+	link->conf.Vcc =3D config.Vcc;
+
+	/* First pass: look for a config entry that looks normal. */
+	tuple.TupleData =3D (cisdata_t *)buf;
+	tuple.TupleOffset =3D 0;
+	tuple.TupleDataMax =3D 255;
+	tuple.Attributes =3D 0;
+	tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
+	/* Two tries: without IO aliases, then with aliases */
+	for (try =3D 0; try < 2; try++) {
+		i =3D first_tuple(handle, &tuple, &parse);
+		while (i !=3D CS_NO_MORE_ITEMS) {
+			if (i !=3D CS_SUCCESS)
+				goto next_entry;
+			if (cf->vpp1.present & (1 << CISTPL_POWER_VNOM))
+				link->conf.Vpp1 =3D link->conf.Vpp2 =3D cf->vpp1.param[CISTPL_POWER_VN=
OM] / 10000;
+			if ((cf->io.nwin > 0) && (cf->io.win[0].len =3D=3D 8) && (cf->io.win[0]=
.base !=3D 0)) {
+				link->conf.ConfigIndex =3D cf->index;
+				link->io.BasePort1 =3D cf->io.win[0].base;
+				link->io.IOAddrLines =3D (try =3D=3D 0) ? 16 : cf->io.flags & CISTPL_I=
O_LINES_MASK;
+				i =3D CardServices(RequestIO, link->handle, &link->io);
+				if (i =3D=3D CS_SUCCESS)
+					goto found_port;
+			}
+next_entry:
+			i =3D next_tuple(handle, &tuple, &parse);
+		}
+	}
+
+	/* Second pass: try to find an entry that isn't picky about
+	   its base address, then try to grab any standard serial port
+	   address, and finally try to get any free port. */
+	i =3D first_tuple(handle, &tuple, &parse);
+	while (i !=3D CS_NO_MORE_ITEMS) {
+		if ((i =3D=3D CS_SUCCESS) && (cf->io.nwin > 0) && ((cf->io.flags & CISTP=
L_IO_LINES_MASK) <=3D 3)) {
+			link->conf.ConfigIndex =3D cf->index;
+			for (j =3D 0; j < 5; j++) {
+				link->io.BasePort1 =3D base[j];
+				link->io.IOAddrLines =3D base[j] ? 16 : 3;
+				i =3D CardServices(RequestIO, link->handle, &link->io);
+				if (i =3D=3D CS_SUCCESS)
+					goto found_port;
+			}
+		}
+		i =3D next_tuple(handle, &tuple, &parse);
+	}
+
+found_port:
+	if (i !=3D CS_SUCCESS) {
+		printk(KERN_NOTICE "bt3c_cs: No usable port range found. Giving up.\n");
+		cs_error(link->handle, RequestIO, i);
+		goto failed;
+	}
+
+	i =3D CardServices(RequestIRQ, link->handle, &link->irq);
+	if (i !=3D CS_SUCCESS) {
+		cs_error(link->handle, RequestIRQ, i);
+		link->irq.AssignedIRQ =3D 0;
+	}
+
+	i =3D CardServices(RequestConfiguration, link->handle, &link->conf);
+	if (i !=3D CS_SUCCESS) {
+		cs_error(link->handle, RequestConfiguration, i);
+		goto failed;
+	}
+
+	MOD_INC_USE_COUNT;
+
+	if (bt3c_open(info) !=3D 0)
+		goto failed;
+
+	strcpy(info->node.dev_name, info->hdev.name);
+	link->dev =3D &info->node;
+	link->state &=3D ~DEV_CONFIG_PENDING;
+
+	return;
+
+cs_failed:
+	cs_error(link->handle, last_fn, last_ret);
+
+failed:
+	bt3c_release((u_long)link);
+}
+
+
+void bt3c_release(u_long arg)
+{
+	dev_link_t *link =3D (dev_link_t *)arg;
+	bt3c_info_t *info =3D link->priv;
+
+	if (link->state & DEV_PRESENT)
+		bt3c_close(info);
+
+	MOD_DEC_USE_COUNT;
+
+	link->dev =3D NULL;
+
+	CardServices(ReleaseConfiguration, link->handle);
+	CardServices(ReleaseIO, link->handle, &link->io);
+	CardServices(ReleaseIRQ, link->handle, &link->irq);
+
+	link->state &=3D ~DEV_CONFIG;
+}
+
+
+int bt3c_event(event_t event, int priority, event_callback_args_t *args)
+{
+	dev_link_t *link =3D args->client_data;
+	bt3c_info_t *info =3D link->priv;
+
+	switch (event) {
+	case CS_EVENT_CARD_REMOVAL:
+		link->state &=3D ~DEV_PRESENT;
+		if (link->state & DEV_CONFIG) {
+			bt3c_close(info);
+			mod_timer(&link->release, jiffies + HZ / 20);
+		}
+		break;
+	case CS_EVENT_CARD_INSERTION:
+		link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
+		bt3c_config(link);
+		break;
+	case CS_EVENT_PM_SUSPEND:
+		link->state |=3D DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_RESET_PHYSICAL:
+		if (link->state & DEV_CONFIG)
+			CardServices(ReleaseConfiguration, link->handle);
+		break;
+	case CS_EVENT_PM_RESUME:
+		link->state &=3D ~DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_CARD_RESET:
+		if (DEV_OK(link))
+			CardServices(RequestConfiguration, link->handle, &link->conf);
+		break;
+	}
+
+	return 0;
+}
+
+
+
+/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Module initialization =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D */
+
+
+int __init init_bt3c_cs(void)
+{
+	servinfo_t serv;
+	int err;
+
+	CardServices(GetCardServicesInfo, &serv);
+	if (serv.Revision !=3D CS_RELEASE_CODE) {
+		printk(KERN_NOTICE "bt3c_cs: Card Services release does not match!\n");
+		return -1;
+	}
+
+	err =3D register_pccard_driver(&dev_info, &bt3c_attach, &bt3c_detach);
+
+	return err;
+}
+
+
+void __exit exit_bt3c_cs(void)
+{
+	unregister_pccard_driver(&dev_info);
+
+	while (dev_list !=3D NULL)
+		bt3c_detach(dev_list);
+}
+
+
+module_init(init_bt3c_cs);
+module_exit(exit_bt3c_cs);
diff -urN linux-2.5.27/drivers/bluetooth/dtl1_cs.c linux-2.5.27-mh/drivers/=
bluetooth/dtl1_cs.c
--- linux-2.5.27/drivers/bluetooth/dtl1_cs.c	Sat Jul 20 21:11:14 2002
+++ linux-2.5.27-mh/drivers/bluetooth/dtl1_cs.c	Tue Jul 23 13:50:45 2002
@@ -75,23 +75,22 @@
=20
=20
 typedef struct dtl1_info_t {
-  dev_link_t link;
-  dev_node_t node;
+	dev_link_t link;
+	dev_node_t node;
=20
-  struct hci_dev hdev;
+	struct hci_dev hdev;
=20
-  spinlock_t lock;          /* For serializing operations */
+	spinlock_t lock;		/* For serializing operations */
=20
-  unsigned long flowmask;   /* HCI flow mask */
-  int ri_latch;
+	unsigned long flowmask;		/* HCI flow mask */
+	int ri_latch;
=20
-  struct sk_buff_head txq;
-  unsigned long tx_state;
-
-  unsigned long rx_state;
-  unsigned long rx_count;
-  struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+	unsigned long tx_state;
=20
+	unsigned long rx_state;
+	unsigned long rx_count;
+	struct sk_buff *rx_skb;
 } dtl1_info_t;
=20
=20
@@ -104,7 +103,7 @@
 dev_link_t *dtl1_attach(void);
 void dtl1_detach(dev_link_t *);
=20
-dev_link_t *dev_list =3D NULL;
+static dev_link_t *dev_list =3D NULL;
=20
=20
 /* Transmit states  */
@@ -118,282 +117,253 @@
=20
=20
 typedef struct {
-  u8 type;
-  u8 zero;
-  u16 len;
-} __attribute__ ((packed)) nsh_t;   /* Nokia Specific Header */
+	u8 type;
+	u8 zero;
+	u16 len;
+} __attribute__ ((packed)) nsh_t;	/* Nokia Specific Header */
=20
-#define NSHL  4    /* Nokia Specific Header Length */
+#define NSHL  4				/* Nokia Specific Header Length */
=20
=20
=20
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Interrupt handling =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D */
=20
=20
-static int dtl1_write(unsigned int iobase, int fifo_size, __u8 *buf, int l=
en) {
-
-  int actual =3D 0;
-
-
-  /* Tx FIFO should be empty */
-  if (!(inb(iobase + UART_LSR) & UART_LSR_THRE))
-    return 0;
-
-
-  /* Fill FIFO with current frame */
-  while ((fifo_size-- > 0) && (actual < len)) {
-    /* Transmit next byte */
-    outb(buf[actual], iobase + UART_TX);
-    actual++;
-  }
-
-
-  return actual;
-
-}
-
-
-static void dtl1_write_wakeup(dtl1_info_t *info) {
-
-  if (!info) {
-    printk(KERN_WARNING "dtl1_cs: Call of write_wakeup for unknown device.=
\n");
-    return;
-  }
-
-
-  if (test_bit(XMIT_WAITING, &(info->tx_state))) {
-    set_bit(XMIT_WAKEUP, &(info->tx_state));
-    return;
-  }
-
-  if (test_and_set_bit(XMIT_SENDING, &(info->tx_state))) {
-    set_bit(XMIT_WAKEUP, &(info->tx_state));
-    return;
-  }
-
-
-  do {
-    register unsigned int iobase =3D info->link.io.BasePort1;
-    register struct sk_buff *skb;
-    register int len;
-
-    clear_bit(XMIT_WAKEUP, &(info->tx_state));
-
-    if (!(info->link.state & DEV_PRESENT))
-      return;
-
-
-    if (!(skb =3D skb_dequeue(&(info->txq))))
-      break;
-
-
-    /* Send frame */
-    len =3D dtl1_write(iobase, 32, skb->data, skb->len);
-
-    if (len =3D=3D skb->len) {
-      set_bit(XMIT_WAITING, &(info->tx_state));
-      kfree_skb(skb);
-    }
-    else {
-      skb_pull(skb, len);
-      skb_queue_head(&(info->txq), skb);
-    }
-
-    info->hdev.stat.byte_tx +=3D len;
-
-  } while (test_bit(XMIT_WAKEUP, &(info->tx_state)));
-
-
-  clear_bit(XMIT_SENDING, &(info->tx_state));
-
-}
-
-
-static void dtl1_control(dtl1_info_t *info, struct sk_buff *skb) {
-
-  u8 flowmask =3D *(u8 *)skb->data;
-  int i;
-
-
-  printk(KERN_INFO "dtl1_cs: Nokia control data =3D ");
-  for (i =3D 0; i < skb->len; i++) {
-    printk("%02x ", skb->data[i]);
-  }
-  printk("\n");
-
-
-  /* transition to active state */
-  if (((info->flowmask & 0x07) =3D=3D 0) && ((flowmask & 0x07) !=3D 0)) {
-    clear_bit(XMIT_WAITING, &(info->tx_state));
-    dtl1_write_wakeup(info);
-  }
-
-  info->flowmask =3D flowmask;
-
-
-  kfree_skb(skb);
-
-}
-
-
-static void dtl1_receive(dtl1_info_t *info) {
-
-  unsigned int iobase;
-  nsh_t *nsh;
-  int boguscount =3D 0;
-
-
-  if (!info) {
-    printk(KERN_WARNING "dtl1_cs: Call of receive for unknown device.\n");
-    return;
-  }
-
-
-  iobase =3D info->link.io.BasePort1;
-
-  do {
-    info->hdev.stat.byte_rx++;
-
-    /* Allocate packet */
-    if (info->rx_skb =3D=3D NULL)
-      if (!(info->rx_skb =3D bluez_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMI=
C))) {
-        printk(KERN_WARNING "dtl1_cs: Can't allocate mem for new packet.\n=
");
-        info->rx_state =3D RECV_WAIT_NSH;
-        info->rx_count =3D NSHL;
-        return;
-    }
-
-
-    *skb_put(info->rx_skb, 1) =3D inb(iobase + UART_RX);
-    nsh =3D (nsh_t *)info->rx_skb->data;
-
-    info->rx_count--;
-
-
-    if (info->rx_count =3D=3D 0) {
-
-      switch (info->rx_state) {
-      case RECV_WAIT_NSH:
-        info->rx_state =3D RECV_WAIT_DATA;
-        info->rx_count =3D nsh->len + (nsh->len & 0x0001);
-        break;
-      case RECV_WAIT_DATA:
-        info->rx_skb->pkt_type =3D nsh->type;
-
-        /* remove PAD byte if it exists */
-        if (nsh->len & 0x0001) {
-          info->rx_skb->tail--;
-          info->rx_skb->len--;
-        }
-
-        /* remove NSH */
-        skb_pull(info->rx_skb, NSHL);
-
-
-        switch (info->rx_skb->pkt_type) {
-        case 0x80:
-          /* control data for the Nokia Card */
-          dtl1_control(info, info->rx_skb);
-          break;
-        case 0x82:
-        case 0x83:
-        case 0x84:
-          /* send frame to the HCI layer */
-          info->rx_skb->dev =3D (void *)&(info->hdev);
-          info->rx_skb->pkt_type &=3D 0x0f;
-          hci_recv_frame(info->rx_skb);
-          break;
-        default:
-          /* unknown packet */
-          printk(KERN_WARNING "dtl1_cs: Unknown HCI packet with type 0x%02=
x received.\n", info->rx_skb->pkt_type);
-          kfree_skb(info->rx_skb);
-          break;
-        }
-
-
-        info->rx_state =3D RECV_WAIT_NSH;
-        info->rx_count =3D NSHL;
-        info->rx_skb =3D NULL;
-        break;
-      }
-
-    }
-
-
-    /* Make sure we don't stay here to long */
-    if (boguscount++ > 32)
-      break;
-
-  } while (inb(iobase + UART_LSR) & UART_LSR_DR);
-
-
-}
-
-
-void dtl1_interrupt(int irq, void *dev_inst, struct pt_regs *regs) {
-
-  dtl1_info_t *info =3D dev_inst;
-  unsigned int iobase;
-  unsigned char msr;
-  int boguscount =3D 0;
-  int iir, lsr;
-
-
-  if (!info) {
-    printk(KERN_WARNING "dtl1_cs: Call of irq %d for unknown device.\n", i=
rq);
-    return;
-  }
-
-
-  iobase =3D info->link.io.BasePort1;
-
-
-  spin_lock(&(info->lock));
-
-  iir =3D inb(iobase + UART_IIR) & UART_IIR_ID;
-  while (iir) {
-
-    /* Clear interrupt */
-    lsr =3D inb(iobase + UART_LSR);
-
-    switch (iir) {
-    case UART_IIR_RLSI:
-      printk(KERN_NOTICE "dtl1_cs: RLSI\n");
-      break;
-    case UART_IIR_RDI:
-      /* Receive interrupt */
-      dtl1_receive(info);
-      break;
-    case UART_IIR_THRI:
-      if (lsr & UART_LSR_THRE) {
-        /* Transmitter ready for data */
-        dtl1_write_wakeup(info);
-      }
-      break;
-    default:
-      printk(KERN_NOTICE "dtl1_cs: Unhandled IIR=3D%#x\n", iir);
-      break;
-    }
-
-    /* Make sure we don't stay here to long */
-    if (boguscount++ > 100)
-      break;
-
-    iir =3D inb(iobase + UART_IIR) & UART_IIR_ID;
-
-  }
-
-
-  msr =3D inb(iobase + UART_MSR);
-
-  if (info->ri_latch ^ (msr & UART_MSR_RI)) {
-    info->ri_latch =3D msr & UART_MSR_RI;
-    clear_bit(XMIT_WAITING, &(info->tx_state));
-    dtl1_write_wakeup(info);
-  }
-
-  spin_unlock(&(info->lock));
+static int dtl1_write(unsigned int iobase, int fifo_size, __u8 *buf, int l=
en)
+{
+	int actual =3D 0;
+
+	/* Tx FIFO should be empty */
+	if (!(inb(iobase + UART_LSR) & UART_LSR_THRE))
+		return 0;
+
+	/* Fill FIFO with current frame */
+	while ((fifo_size-- > 0) && (actual < len)) {
+		/* Transmit next byte */
+		outb(buf[actual], iobase + UART_TX);
+		actual++;
+	}
+
+	return actual;
+}
+
+
+static void dtl1_write_wakeup(dtl1_info_t *info)
+{
+	if (!info) {
+		printk(KERN_WARNING "dtl1_cs: Call of write_wakeup for unknown device.\n=
");
+		return;
+	}
+
+	if (test_bit(XMIT_WAITING, &(info->tx_state))) {
+		set_bit(XMIT_WAKEUP, &(info->tx_state));
+		return;
+	}
+
+	if (test_and_set_bit(XMIT_SENDING, &(info->tx_state))) {
+		set_bit(XMIT_WAKEUP, &(info->tx_state));
+		return;
+	}
+
+	do {
+		register unsigned int iobase =3D info->link.io.BasePort1;
+		register struct sk_buff *skb;
+		register int len;
+
+		clear_bit(XMIT_WAKEUP, &(info->tx_state));
+
+		if (!(info->link.state & DEV_PRESENT))
+			return;
+
+		if (!(skb =3D skb_dequeue(&(info->txq))))
+			break;
+
+		/* Send frame */
+		len =3D dtl1_write(iobase, 32, skb->data, skb->len);
+
+		if (len =3D=3D skb->len) {
+			set_bit(XMIT_WAITING, &(info->tx_state));
+			kfree_skb(skb);
+		} else {
+			skb_pull(skb, len);
+			skb_queue_head(&(info->txq), skb);
+		}
+
+		info->hdev.stat.byte_tx +=3D len;
+
+	} while (test_bit(XMIT_WAKEUP, &(info->tx_state)));
+
+	clear_bit(XMIT_SENDING, &(info->tx_state));
+}
+
+
+static void dtl1_control(dtl1_info_t *info, struct sk_buff *skb)
+{
+	u8 flowmask =3D *(u8 *)skb->data;
+	int i;
+
+	printk(KERN_INFO "dtl1_cs: Nokia control data =3D ");
+	for (i =3D 0; i < skb->len; i++) {
+		printk("%02x ", skb->data[i]);
+	}
+	printk("\n");
+
+	/* transition to active state */
+	if (((info->flowmask & 0x07) =3D=3D 0) && ((flowmask & 0x07) !=3D 0)) {
+		clear_bit(XMIT_WAITING, &(info->tx_state));
+		dtl1_write_wakeup(info);
+	}
+
+	info->flowmask =3D flowmask;
+
+	kfree_skb(skb);
+}
+
+
+static void dtl1_receive(dtl1_info_t *info)
+{
+	unsigned int iobase;
+	nsh_t *nsh;
+	int boguscount =3D 0;
+
+	if (!info) {
+		printk(KERN_WARNING "dtl1_cs: Call of receive for unknown device.\n");
+		return;
+	}
+
+	iobase =3D info->link.io.BasePort1;
+
+	do {
+		info->hdev.stat.byte_rx++;
+
+		/* Allocate packet */
+		if (info->rx_skb =3D=3D NULL)
+			if (!(info->rx_skb =3D bluez_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC))=
) {
+				printk(KERN_WARNING "dtl1_cs: Can't allocate mem for new packet.\n");
+				info->rx_state =3D RECV_WAIT_NSH;
+				info->rx_count =3D NSHL;
+				return;
+			}
+
+		*skb_put(info->rx_skb, 1) =3D inb(iobase + UART_RX);
+		nsh =3D (nsh_t *)info->rx_skb->data;
+
+		info->rx_count--;
+
+		if (info->rx_count =3D=3D 0) {
+
+			switch (info->rx_state) {
+			case RECV_WAIT_NSH:
+				info->rx_state =3D RECV_WAIT_DATA;
+				info->rx_count =3D nsh->len + (nsh->len & 0x0001);
+				break;
+			case RECV_WAIT_DATA:
+				info->rx_skb->pkt_type =3D nsh->type;
+
+				/* remove PAD byte if it exists */
+				if (nsh->len & 0x0001) {
+					info->rx_skb->tail--;
+					info->rx_skb->len--;
+				}
+
+				/* remove NSH */
+				skb_pull(info->rx_skb, NSHL);
+
+				switch (info->rx_skb->pkt_type) {
+				case 0x80:
+					/* control data for the Nokia Card */
+					dtl1_control(info, info->rx_skb);
+					break;
+				case 0x82:
+				case 0x83:
+				case 0x84:
+					/* send frame to the HCI layer */
+					info->rx_skb->dev =3D (void *)&(info->hdev);
+					info->rx_skb->pkt_type &=3D 0x0f;
+					hci_recv_frame(info->rx_skb);
+					break;
+				default:
+					/* unknown packet */
+					printk(KERN_WARNING "dtl1_cs: Unknown HCI packet with type 0x%02x rec=
eived.\n", info->rx_skb->pkt_type);
+					kfree_skb(info->rx_skb);
+					break;
+				}
+
+				info->rx_state =3D RECV_WAIT_NSH;
+				info->rx_count =3D NSHL;
+				info->rx_skb =3D NULL;
+				break;
+			}
+
+		}
+
+		/* Make sure we don't stay here to long */
+		if (boguscount++ > 32)
+			break;
+
+	} while (inb(iobase + UART_LSR) & UART_LSR_DR);
+}
+
+
+void dtl1_interrupt(int irq, void *dev_inst, struct pt_regs *regs)
+{
+	dtl1_info_t *info =3D dev_inst;
+	unsigned int iobase;
+	unsigned char msr;
+	int boguscount =3D 0;
+	int iir, lsr;
+
+	if (!info) {
+		printk(KERN_WARNING "dtl1_cs: Call of irq %d for unknown device.\n", irq=
);
+		return;
+	}
+
+	iobase =3D info->link.io.BasePort1;
+
+	spin_lock(&(info->lock));
+
+	iir =3D inb(iobase + UART_IIR) & UART_IIR_ID;
+	while (iir) {
+
+		/* Clear interrupt */
+		lsr =3D inb(iobase + UART_LSR);
+
+		switch (iir) {
+		case UART_IIR_RLSI:
+			printk(KERN_NOTICE "dtl1_cs: RLSI\n");
+			break;
+		case UART_IIR_RDI:
+			/* Receive interrupt */
+			dtl1_receive(info);
+			break;
+		case UART_IIR_THRI:
+			if (lsr & UART_LSR_THRE) {
+				/* Transmitter ready for data */
+				dtl1_write_wakeup(info);
+			}
+			break;
+		default:
+			printk(KERN_NOTICE "dtl1_cs: Unhandled IIR=3D%#x\n", iir);
+			break;
+		}
+
+		/* Make sure we don't stay here to long */
+		if (boguscount++ > 100)
+			break;
+
+		iir =3D inb(iobase + UART_IIR) & UART_IIR_ID;
+
+	}
+
+	msr =3D inb(iobase + UART_MSR);
+
+	if (info->ri_latch ^ (msr & UART_MSR_RI)) {
+		info->ri_latch =3D msr & UART_MSR_RI;
+		clear_bit(XMIT_WAITING, &(info->tx_state));
+		dtl1_write_wakeup(info);
+	}
=20
+	spin_unlock(&(info->lock));
 }
=20
=20
@@ -401,107 +371,94 @@
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D HCI interface =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
=20
=20
-static int dtl1_hci_open(struct hci_dev *hdev) {
-
-  set_bit(HCI_RUNNING, &(hdev->flags));
-
-
-  return 0;
+static int dtl1_hci_open(struct hci_dev *hdev)
+{
+	set_bit(HCI_RUNNING, &(hdev->flags));
=20
+	return 0;
 }
=20
=20
-static int dtl1_hci_flush(struct hci_dev *hdev) {
-
-  dtl1_info_t *info =3D (dtl1_info_t *)(hdev->driver_data);
-
-
-  /* Drop TX queue */
-  skb_queue_purge(&(info->txq));
-
+static int dtl1_hci_flush(struct hci_dev *hdev)
+{
+	dtl1_info_t *info =3D (dtl1_info_t *)(hdev->driver_data);
=20
-  return 0;
+	/* Drop TX queue */
+	skb_queue_purge(&(info->txq));
=20
+	return 0;
 }
=20
=20
-static int dtl1_hci_close(struct hci_dev *hdev) {
+static int dtl1_hci_close(struct hci_dev *hdev)
+{
+	if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
+		return 0;
=20
-  if (!test_and_clear_bit(HCI_RUNNING, &(hdev->flags)))
-    return 0;
-
-
-  dtl1_hci_flush(hdev);
-
-
-  return 0;
+	dtl1_hci_flush(hdev);
=20
+	return 0;
 }
=20
=20
-static int dtl1_hci_send_frame(struct sk_buff *skb) {
-
-  dtl1_info_t *info;
-  struct hci_dev* hdev =3D (struct hci_dev *)(skb->dev);
-  struct sk_buff *s;
-  nsh_t nsh;
-
+static int dtl1_hci_send_frame(struct sk_buff *skb)
+{
+	dtl1_info_t *info;
+	struct hci_dev *hdev =3D (struct hci_dev *)(skb->dev);
+	struct sk_buff *s;
+	nsh_t nsh;
=20
-  if (!hdev) {
-    printk(KERN_WARNING "dtl1_cs: Frame for unknown HCI device (hdev=3DNUL=
L).");
-    return -ENODEV;
-  }
+	if (!hdev) {
+		printk(KERN_WARNING "dtl1_cs: Frame for unknown HCI device (hdev=3DNULL)=
.");
+		return -ENODEV;
+	}
=20
-  info =3D (dtl1_info_t *)(hdev->driver_data);
+	info =3D (dtl1_info_t *)(hdev->driver_data);
=20
+	switch (skb->pkt_type) {
+	case HCI_COMMAND_PKT:
+		hdev->stat.cmd_tx++;
+		nsh.type =3D 0x81;
+		break;
+	case HCI_ACLDATA_PKT:
+		hdev->stat.acl_tx++;
+		nsh.type =3D 0x82;
+		break;
+	case HCI_SCODATA_PKT:
+		hdev->stat.sco_tx++;
+		nsh.type =3D 0x83;
+		break;
+	};
=20
-  switch (skb->pkt_type) {
-  case HCI_COMMAND_PKT:
-    hdev->stat.cmd_tx++;
-    nsh.type =3D 0x81;
-    break;
-  case HCI_ACLDATA_PKT:
-    hdev->stat.acl_tx++;
-    nsh.type =3D 0x82;
-    break;
-  case HCI_SCODATA_PKT:
-    hdev->stat.sco_tx++;
-    nsh.type =3D 0x83;
-    break;
-  };
+	nsh.zero =3D 0;
+	nsh.len =3D skb->len;
=20
-  nsh.zero =3D 0;
-  nsh.len =3D skb->len;
+	s =3D bluez_skb_alloc(NSHL + skb->len + 1, GFP_ATOMIC);
+	skb_reserve(s, NSHL);
+	memcpy(skb_put(s, skb->len), skb->data, skb->len);
+	if (skb->len & 0x0001)
+		*skb_put(s, 1) =3D 0;	/* PAD */
=20
-  s =3D bluez_skb_alloc(NSHL + skb->len + 1, GFP_ATOMIC);
-  skb_reserve(s, NSHL);
-  memcpy(skb_put(s, skb->len), skb->data, skb->len);
-  if (skb->len & 0x0001)
-    *skb_put(s, 1) =3D 0;  /* PAD */
+	/* Prepend skb with Nokia frame header and queue */
+	memcpy(skb_push(s, NSHL), &nsh, NSHL);
+	skb_queue_tail(&(info->txq), s);
=20
-  /* Prepend skb with Nokia frame header and queue */
-  memcpy(skb_push(s, NSHL), &nsh, NSHL);
-  skb_queue_tail(&(info->txq), s);
+	dtl1_write_wakeup(info);
=20
+	kfree_skb(skb);
=20
-  dtl1_write_wakeup(info);
-
-  kfree_skb(skb);
-
-
-  return 0;
-
+	return 0;
 }
=20
=20
-static void dtl1_hci_destruct(struct hci_dev *hdev) {
+static void dtl1_hci_destruct(struct hci_dev *hdev)
+{
 }
=20
=20
-static int dtl1_hci_ioctl(struct hci_dev *hdev, unsigned int cmd, unsigned=
 long arg) {
-
-  return -ENOIOCTLCMD;
-
+static int dtl1_hci_ioctl(struct hci_dev *hdev, unsigned int cmd,  unsigne=
d long arg)
+{
+	return -ENOIOCTLCMD;
 }
=20
=20
@@ -509,101 +466,91 @@
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Card services HCI interaction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
=20
=20
-int dtl1_open(dtl1_info_t *info) {
+int dtl1_open(dtl1_info_t *info)
+{
+	unsigned long flags;
+	unsigned int iobase =3D info->link.io.BasePort1;
+	struct hci_dev *hdev;
=20
-  unsigned long flags;
-  unsigned int iobase =3D info->link.io.BasePort1;
-  struct hci_dev *hdev;
+	spin_lock_init(&(info->lock));
=20
+	skb_queue_head_init(&(info->txq));
=20
-  spin_lock_init(&(info->lock));
+	info->rx_state =3D RECV_WAIT_NSH;
+	info->rx_count =3D NSHL;
+	info->rx_skb =3D NULL;
=20
-  skb_queue_head_init(&(info->txq));
+	set_bit(XMIT_WAITING, &(info->tx_state));
=20
-  info->rx_state =3D RECV_WAIT_NSH;
-  info->rx_count =3D NSHL;
-  info->rx_skb =3D NULL;
+	spin_lock_irqsave(&(info->lock), flags);
=20
-  set_bit(XMIT_WAITING, &(info->tx_state));
+	/* Reset UART */
+	outb(0, iobase + UART_MCR);
=20
+	/* Turn off interrupts */
+	outb(0, iobase + UART_IER);
=20
-  spin_lock_irqsave(&(info->lock), flags);
+	/* Initialize UART */
+	outb(UART_LCR_WLEN8, iobase + UART_LCR);	/* Reset DLAB */
+	outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
=20
-  /* Reset UART */
-  outb(0, iobase + UART_MCR);
+	info->ri_latch =3D inb(info->link.io.BasePort1 + UART_MSR) & UART_MSR_RI;
=20
-  /* Turn off interrupts */
-  outb(0, iobase + UART_IER);
+	/* Turn on interrupts */
+	outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
=20
-  /* Initialize UART */
-  outb(UART_LCR_WLEN8, iobase + UART_LCR);  /* Reset DLAB */
-  outb((UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2), iobase + UART_MCR);
+	spin_unlock_irqrestore(&(info->lock), flags);
=20
-  info->ri_latch =3D inb(info->link.io.BasePort1 + UART_MSR) & UART_MSR_RI=
;
+	/* Timeout before it is safe to send the first HCI packet */
+	set_current_state(TASK_INTERRUPTIBLE);
+	schedule_timeout(HZ * 2);
=20
-  /* Turn on interrupts */
-  outb(UART_IER_RLSI | UART_IER_RDI | UART_IER_THRI, iobase + UART_IER);
=20
-  spin_unlock_irqrestore(&(info->lock), flags);
+	/* Initialize and register HCI device */
=20
+	hdev =3D &(info->hdev);
=20
-  /* Timeout before it is safe to send the first HCI packet */
-  set_current_state(TASK_INTERRUPTIBLE);
-  schedule_timeout(HZ * 2);
+	hdev->type =3D HCI_PCCARD;
+	hdev->driver_data =3D info;
=20
+	hdev->open =3D dtl1_hci_open;
+	hdev->close =3D dtl1_hci_close;
+	hdev->flush =3D dtl1_hci_flush;
+	hdev->send =3D dtl1_hci_send_frame;
+	hdev->destruct =3D dtl1_hci_destruct;
+	hdev->ioctl =3D dtl1_hci_ioctl;
=20
-  /* Initialize and register HCI device */
-
-  hdev =3D &(info->hdev);
-
-  hdev->type =3D HCI_PCCARD;
-  hdev->driver_data =3D info;
-
-  hdev->open     =3D dtl1_hci_open;
-  hdev->close    =3D dtl1_hci_close;
-  hdev->flush    =3D dtl1_hci_flush;
-  hdev->send     =3D dtl1_hci_send_frame;
-  hdev->destruct =3D dtl1_hci_destruct;
-  hdev->ioctl    =3D dtl1_hci_ioctl;
-
-  if (hci_register_dev(hdev) < 0) {
-    printk(KERN_WARNING "dtl1_cs: Can't register HCI device %s.\n", hdev->=
name);
-    return -ENODEV;
-  }
-
-
-  return 0;
+	if (hci_register_dev(hdev) < 0) {
+		printk(KERN_WARNING "dtl1_cs: Can't register HCI device %s.\n", hdev->na=
me);
+		return -ENODEV;
+	}
=20
+	return 0;
 }
=20
=20
-int dtl1_close(dtl1_info_t *info) {
-
-  unsigned long flags;
-  unsigned int iobase =3D info->link.io.BasePort1;
-  struct hci_dev *hdev =3D &(info->hdev);
-
-
-  dtl1_hci_close(hdev);
-
-
-  spin_lock_irqsave(&(info->lock), flags);
-
-  /* Reset UART */
-  outb(0, iobase + UART_MCR);
+int dtl1_close(dtl1_info_t *info)
+{
+	unsigned long flags;
+	unsigned int iobase =3D info->link.io.BasePort1;
+	struct hci_dev *hdev =3D &(info->hdev);
=20
-  /* Turn off interrupts */
-  outb(0, iobase + UART_IER);
+	dtl1_hci_close(hdev);
=20
-  spin_unlock_irqrestore(&(info->lock), flags);
+	spin_lock_irqsave(&(info->lock), flags);
=20
+	/* Reset UART */
+	outb(0, iobase + UART_MCR);
=20
-  if (hci_unregister_dev(hdev) < 0)
-    printk(KERN_WARNING "dtl1_cs: Can't unregister HCI device %s.\n", hdev=
->name);
+	/* Turn off interrupts */
+	outb(0, iobase + UART_IER);
=20
+	spin_unlock_irqrestore(&(info->lock), flags);
=20
-  return 0;
+	if (hci_unregister_dev(hdev) < 0)
+		printk(KERN_WARNING "dtl1_cs: Can't unregister HCI device %s.\n", hdev->=
name);
=20
+	return 0;
 }
=20
=20
@@ -611,291 +558,267 @@
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Card services =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D */
=20
=20
-static void cs_error(client_handle_t handle, int func, int ret) {
-
-  error_info_t err =3D { func, ret };
-
-
-  CardServices(ReportError, handle, &err);
-
-}
-
-
-dev_link_t *dtl1_attach(void) {
-
-  dtl1_info_t *info;
-  client_reg_t client_reg;
-  dev_link_t *link;
-  int i, ret;
-
-
-  /* Create new info device */
-  info =3D kmalloc(sizeof(*info), GFP_KERNEL);
-  if (!info)
-    return NULL;
-  memset(info, 0, sizeof(*info));
-
-
-  link =3D &info->link;
-  link->priv =3D info;
-
-  link->release.function =3D &dtl1_release;
-  link->release.data =3D (u_long)link;
-  link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
-  link->io.NumPorts1 =3D 8;
-  link->irq.Attributes =3D IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
-  link->irq.IRQInfo1 =3D IRQ_INFO2_VALID | IRQ_LEVEL_ID;
-
-  if (irq_list[0] =3D=3D -1)
-    link->irq.IRQInfo2 =3D irq_mask;
-  else
-    for (i =3D 0; i < 4; i++)
-      link->irq.IRQInfo2 |=3D 1 << irq_list[i];
-
-  link->irq.Handler =3D dtl1_interrupt;
-  link->irq.Instance =3D info;
-
-  link->conf.Attributes =3D CONF_ENABLE_IRQ;
-  link->conf.Vcc =3D 50;
-  link->conf.IntType =3D INT_MEMORY_AND_IO;
-
-
-  /* Register with Card Services */
-  link->next =3D dev_list;
-  dev_list =3D link;
-  client_reg.dev_info =3D &dev_info;
-  client_reg.Attributes =3D INFO_IO_CLIENT | INFO_CARD_SHARE;
-  client_reg.EventMask =3D CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL=
 |
-                         CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
-                         CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
-  client_reg.event_handler =3D &dtl1_event;
-  client_reg.Version =3D 0x0210;
-  client_reg.event_callback_args.client_data =3D link;
-
-  ret =3D CardServices(RegisterClient, &link->handle, &client_reg);
-  if (ret !=3D CS_SUCCESS) {
-    cs_error(link->handle, RegisterClient, ret);
-    dtl1_detach(link);
-    return NULL;
-  }
-
-
-  return link;
-
-}
-
-
-void dtl1_detach(dev_link_t *link) {
-
-  dtl1_info_t *info =3D link->priv;
-  dev_link_t **linkp;
-  int ret;
-
-
-  /* Locate device structure */
-  for (linkp =3D &dev_list; *linkp; linkp =3D &(*linkp)->next)
-    if (*linkp =3D=3D link)
-      break;
-
-  if (*linkp =3D=3D NULL)
-    return;
-
-
-  del_timer(&link->release);
-  if (link->state & DEV_CONFIG)
-    dtl1_release((u_long)link);
-
-
-  if (link->handle) {
-    ret =3D CardServices(DeregisterClient, link->handle);
-    if (ret !=3D CS_SUCCESS)
-      cs_error(link->handle, DeregisterClient, ret);
-  }
-
-
-  /* Unlink device structure, free bits */
-  *linkp =3D link->next;
-
-  kfree(info);
-
-}
-
-
-static int get_tuple(int fn, client_handle_t handle, tuple_t *tuple,
-		     cisparse_t *parse) {
-
-  int i;
-
-
-  i =3D CardServices(fn, handle, tuple);
-  if (i !=3D CS_SUCCESS)
-    return CS_NO_MORE_ITEMS;
-
-  i =3D CardServices(GetTupleData, handle, tuple);
-  if (i !=3D CS_SUCCESS)
-    return i;
-
-  return CardServices(ParseTuple, handle, tuple, parse);
+static void cs_error(client_handle_t handle, int func, int ret)
+{
+	error_info_t err =3D { func, ret };
+
+	CardServices(ReportError, handle, &err);
+}
+
+
+dev_link_t *dtl1_attach(void)
+{
+	dtl1_info_t *info;
+	client_reg_t client_reg;
+	dev_link_t *link;
+	int i, ret;
+
+	/* Create new info device */
+	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+	memset(info, 0, sizeof(*info));
+
+	link =3D &info->link;
+	link->priv =3D info;
+
+	link->release.function =3D &dtl1_release;
+	link->release.data =3D (u_long)link;
+	link->io.Attributes1 =3D IO_DATA_PATH_WIDTH_8;
+	link->io.NumPorts1 =3D 8;
+	link->irq.Attributes =3D IRQ_TYPE_EXCLUSIVE | IRQ_HANDLE_PRESENT;
+	link->irq.IRQInfo1 =3D IRQ_INFO2_VALID | IRQ_LEVEL_ID;
+
+	if (irq_list[0] =3D=3D -1)
+		link->irq.IRQInfo2 =3D irq_mask;
+	else
+		for (i =3D 0; i < 4; i++)
+			link->irq.IRQInfo2 |=3D 1 << irq_list[i];
+
+	link->irq.Handler =3D dtl1_interrupt;
+	link->irq.Instance =3D info;
+
+	link->conf.Attributes =3D CONF_ENABLE_IRQ;
+	link->conf.Vcc =3D 50;
+	link->conf.IntType =3D INT_MEMORY_AND_IO;
+
+	/* Register with Card Services */
+	link->next =3D dev_list;
+	dev_list =3D link;
+	client_reg.dev_info =3D &dev_info;
+	client_reg.Attributes =3D INFO_IO_CLIENT | INFO_CARD_SHARE;
+	client_reg.EventMask =3D
+		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+		CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.event_handler =3D &dtl1_event;
+	client_reg.Version =3D 0x0210;
+	client_reg.event_callback_args.client_data =3D link;
+
+	ret =3D CardServices(RegisterClient, &link->handle, &client_reg);
+	if (ret !=3D CS_SUCCESS) {
+		cs_error(link->handle, RegisterClient, ret);
+		dtl1_detach(link);
+		return NULL;
+	}
+
+	return link;
+}
+
+
+void dtl1_detach(dev_link_t *link)
+{
+	dtl1_info_t *info =3D link->priv;
+	dev_link_t **linkp;
+	int ret;
+
+	/* Locate device structure */
+	for (linkp =3D &dev_list; *linkp; linkp =3D &(*linkp)->next)
+		if (*linkp =3D=3D link)
+			break;
+
+	if (*linkp =3D=3D NULL)
+		return;
+
+	del_timer(&link->release);
+	if (link->state & DEV_CONFIG)
+		dtl1_release((u_long)link);
+
+	if (link->handle) {
+		ret =3D CardServices(DeregisterClient, link->handle);
+		if (ret !=3D CS_SUCCESS)
+			cs_error(link->handle, DeregisterClient, ret);
+	}
+
+	/* Unlink device structure, free bits */
+	*linkp =3D link->next;
+
+	kfree(info);
+}
+
+
+static int get_tuple(int fn, client_handle_t handle, tuple_t *tuple, cispa=
rse_t *parse)
+{
+	int i;
+
+	i =3D CardServices(fn, handle, tuple);
+	if (i !=3D CS_SUCCESS)
+		return CS_NO_MORE_ITEMS;
+
+	i =3D CardServices(GetTupleData, handle, tuple);
+	if (i !=3D CS_SUCCESS)
+		return i;
=20
+	return CardServices(ParseTuple, handle, tuple, parse);
 }
=20
=20
 #define first_tuple(a, b, c) get_tuple(GetFirstTuple, a, b, c)
 #define next_tuple(a, b, c) get_tuple(GetNextTuple, a, b, c)
=20
-void dtl1_config(dev_link_t *link) {
-
-  client_handle_t handle =3D link->handle;
-  dtl1_info_t *info =3D link->priv;
-  tuple_t tuple;
-  u_short buf[256];
-  cisparse_t parse;
-  cistpl_cftable_entry_t *cf =3D &parse.cftable_entry;
-  config_info_t config;
-  int i, last_ret, last_fn;
-
-
-  tuple.TupleData =3D (cisdata_t *)buf;
-  tuple.TupleOffset =3D 0;
-  tuple.TupleDataMax =3D 255;
-  tuple.Attributes =3D 0;
-
-  /* Get configuration register information */
-  tuple.DesiredTuple =3D CISTPL_CONFIG;
-  last_ret =3D first_tuple(handle, &tuple, &parse);
-  if (last_ret !=3D CS_SUCCESS) {
-    last_fn =3D ParseTuple;
-    goto cs_failed;
-  }
-  link->conf.ConfigBase =3D parse.config.base;
-  link->conf.Present =3D parse.config.rmask[0];
-
-
-  /* Configure card */
-  link->state |=3D DEV_CONFIG;
-  i =3D CardServices(GetConfigurationInfo, handle, &config);
-  link->conf.Vcc =3D config.Vcc;
-
-  tuple.TupleData =3D (cisdata_t *)buf;
-  tuple.TupleOffset =3D 0; tuple.TupleDataMax =3D 255;
-  tuple.Attributes =3D 0;
-  tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
-
-  /* Look for a generic full-sized window */
-  link->io.NumPorts1 =3D 8;
-  i =3D first_tuple(handle, &tuple, &parse);
-  while (i !=3D CS_NO_MORE_ITEMS) {
-    if ((i =3D=3D CS_SUCCESS) && (cf->io.nwin =3D=3D 1) && (cf->io.win[0].=
len > 8)) {
-      link->conf.ConfigIndex =3D cf->index;
-      link->io.BasePort1 =3D cf->io.win[0].base;
-      link->io.NumPorts1 =3D cf->io.win[0].len; /*yo*/
-      link->io.IOAddrLines =3D cf->io.flags & CISTPL_IO_LINES_MASK;
-      i =3D CardServices(RequestIO, link->handle, &link->io);
-      if (i =3D=3D CS_SUCCESS)
-        break;
-    }
-    i =3D next_tuple(handle, &tuple, &parse);
-  }
-
-  if (i !=3D CS_SUCCESS) {
-    cs_error(link->handle, RequestIO, i);
-    goto failed;
-  }
-
-  i =3D CardServices(RequestIRQ, link->handle, &link->irq);
-  if (i !=3D CS_SUCCESS) {
-    cs_error(link->handle, RequestIRQ, i);
-    link->irq.AssignedIRQ =3D 0;
-  }
-
-  i =3D CardServices(RequestConfiguration, link->handle, &link->conf);
-  if (i !=3D CS_SUCCESS) {
-    cs_error(link->handle, RequestConfiguration, i);
-    goto failed;
-  }
-
-
-  MOD_INC_USE_COUNT;
-
-  if (dtl1_open(info) !=3D 0)
-    goto failed;
-
-
-  link->dev =3D &info->node;
-  link->state &=3D ~DEV_CONFIG_PENDING;
-
-
-  return;
+void dtl1_config(dev_link_t *link)
+{
+	client_handle_t handle =3D link->handle;
+	dtl1_info_t *info =3D link->priv;
+	tuple_t tuple;
+	u_short buf[256];
+	cisparse_t parse;
+	cistpl_cftable_entry_t *cf =3D &parse.cftable_entry;
+	config_info_t config;
+	int i, last_ret, last_fn;
+
+	tuple.TupleData =3D (cisdata_t *)buf;
+	tuple.TupleOffset =3D 0;
+	tuple.TupleDataMax =3D 255;
+	tuple.Attributes =3D 0;
+
+	/* Get configuration register information */
+	tuple.DesiredTuple =3D CISTPL_CONFIG;
+	last_ret =3D first_tuple(handle, &tuple, &parse);
+	if (last_ret !=3D CS_SUCCESS) {
+		last_fn =3D ParseTuple;
+		goto cs_failed;
+	}
+	link->conf.ConfigBase =3D parse.config.base;
+	link->conf.Present =3D parse.config.rmask[0];
+
+	/* Configure card */
+	link->state |=3D DEV_CONFIG;
+	i =3D CardServices(GetConfigurationInfo, handle, &config);
+	link->conf.Vcc =3D config.Vcc;
+
+	tuple.TupleData =3D (cisdata_t *)buf;
+	tuple.TupleOffset =3D 0;
+	tuple.TupleDataMax =3D 255;
+	tuple.Attributes =3D 0;
+	tuple.DesiredTuple =3D CISTPL_CFTABLE_ENTRY;
+
+	/* Look for a generic full-sized window */
+	link->io.NumPorts1 =3D 8;
+	i =3D first_tuple(handle, &tuple, &parse);
+	while (i !=3D CS_NO_MORE_ITEMS) {
+		if ((i =3D=3D CS_SUCCESS) && (cf->io.nwin =3D=3D 1) && (cf->io.win[0].le=
n > 8)) {
+			link->conf.ConfigIndex =3D cf->index;
+			link->io.BasePort1 =3D cf->io.win[0].base;
+			link->io.NumPorts1 =3D cf->io.win[0].len;	/*yo */
+			link->io.IOAddrLines =3D cf->io.flags & CISTPL_IO_LINES_MASK;
+			i =3D CardServices(RequestIO, link->handle, &link->io);
+			if (i =3D=3D CS_SUCCESS)
+				break;
+		}
+		i =3D next_tuple(handle, &tuple, &parse);
+	}
+
+	if (i !=3D CS_SUCCESS) {
+		cs_error(link->handle, RequestIO, i);
+		goto failed;
+	}
+
+	i =3D CardServices(RequestIRQ, link->handle, &link->irq);
+	if (i !=3D CS_SUCCESS) {
+		cs_error(link->handle, RequestIRQ, i);
+		link->irq.AssignedIRQ =3D 0;
+	}
+
+	i =3D CardServices(RequestConfiguration, link->handle, &link->conf);
+	if (i !=3D CS_SUCCESS) {
+		cs_error(link->handle, RequestConfiguration, i);
+		goto failed;
+	}
+
+	MOD_INC_USE_COUNT;
+
+	if (dtl1_open(info) !=3D 0)
+		goto failed;
+
+	strcpy(info->node.dev_name, info->hdev.name);
+	link->dev =3D &info->node;
+	link->state &=3D ~DEV_CONFIG_PENDING;
=20
+	return;
=20
 cs_failed:
-  cs_error(link->handle, last_fn, last_ret);
-failed:
-  dtl1_release((u_long)link);
+	cs_error(link->handle, last_fn, last_ret);
=20
+failed:
+	dtl1_release((u_long)link);
 }
=20
=20
-void dtl1_release(u_long arg) {
-
-  dev_link_t *link =3D (dev_link_t *)arg;
-  dtl1_info_t *info =3D link->priv;
-
-
-  if (link->state & DEV_PRESENT)
-    dtl1_close(info);
-
-  MOD_DEC_USE_COUNT;
-
-
-  link->dev =3D NULL;
-
-  CardServices(ReleaseConfiguration, link->handle);
-  CardServices(ReleaseIO, link->handle, &link->io);
-  CardServices(ReleaseIRQ, link->handle, &link->irq);
-
-  link->state &=3D ~DEV_CONFIG;
-
+void dtl1_release(u_long arg)
+{
+	dev_link_t *link =3D (dev_link_t *)arg;
+	dtl1_info_t *info =3D link->priv;
+
+	if (link->state & DEV_PRESENT)
+		dtl1_close(info);
+
+	MOD_DEC_USE_COUNT;
+
+	link->dev =3D NULL;
+
+	CardServices(ReleaseConfiguration, link->handle);
+	CardServices(ReleaseIO, link->handle, &link->io);
+	CardServices(ReleaseIRQ, link->handle, &link->irq);
+
+	link->state &=3D ~DEV_CONFIG;
 }
=20
=20
-int dtl1_event(event_t event, int priority, event_callback_args_t *args) {
-
-  dev_link_t *link =3D args->client_data;
-  dtl1_info_t *info =3D link->priv;
-
-
-  switch (event) {
-  case CS_EVENT_CARD_REMOVAL:
-    link->state &=3D ~DEV_PRESENT;
-    if (link->state & DEV_CONFIG) {
-      dtl1_close(info);
-      mod_timer(&link->release, jiffies + HZ/20);
-    }
-    break;
-  case CS_EVENT_CARD_INSERTION:
-    link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
-    dtl1_config(link);
-    break;
-  case CS_EVENT_PM_SUSPEND:
-    link->state |=3D DEV_SUSPEND;
-    /* Fall through... */
-  case CS_EVENT_RESET_PHYSICAL:
-    if (link->state & DEV_CONFIG)
-      CardServices(ReleaseConfiguration, link->handle);
-    break;
-  case CS_EVENT_PM_RESUME:
-    link->state &=3D ~DEV_SUSPEND;
-    /* Fall through... */
-  case CS_EVENT_CARD_RESET:
-    if (DEV_OK(link))
-      CardServices(RequestConfiguration, link->handle, &link->conf);
-    break;
-  }
-
-
-  return 0;
+int dtl1_event(event_t event, int priority, event_callback_args_t *args)
+{
+	dev_link_t *link =3D args->client_data;
+	dtl1_info_t *info =3D link->priv;
+
+	switch (event) {
+	case CS_EVENT_CARD_REMOVAL:
+		link->state &=3D ~DEV_PRESENT;
+		if (link->state & DEV_CONFIG) {
+			dtl1_close(info);
+			mod_timer(&link->release, jiffies + HZ / 20);
+		}
+		break;
+	case CS_EVENT_CARD_INSERTION:
+		link->state |=3D DEV_PRESENT | DEV_CONFIG_PENDING;
+		dtl1_config(link);
+		break;
+	case CS_EVENT_PM_SUSPEND:
+		link->state |=3D DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_RESET_PHYSICAL:
+		if (link->state & DEV_CONFIG)
+			CardServices(ReleaseConfiguration, link->handle);
+		break;
+	case CS_EVENT_PM_RESUME:
+		link->state &=3D ~DEV_SUSPEND;
+		/* Fall through... */
+	case CS_EVENT_CARD_RESET:
+		if (DEV_OK(link))
+			CardServices(RequestConfiguration, link->handle, &link->conf);
+		break;
+	}
=20
+	return 0;
 }
=20
=20
@@ -903,33 +826,29 @@
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D Module initialization =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D */
=20
=20
-int __init init_dtl1_cs(void) {
+int __init init_dtl1_cs(void)
+{
+	servinfo_t serv;
+	int err;
=20
-  servinfo_t serv;
-  int err;
+	CardServices(GetCardServicesInfo, &serv);
+	if (serv.Revision !=3D CS_RELEASE_CODE) {
+		printk(KERN_NOTICE "dtl1_cs: Card Services release does not match!\n");
+		return -1;
+	}
=20
+	err =3D register_pccard_driver(&dev_info, &dtl1_attach, &dtl1_detach);
=20
-  CardServices(GetCardServicesInfo, &serv);
-  if (serv.Revision !=3D CS_RELEASE_CODE) {
-    printk(KERN_NOTICE "dtl1_cs: Card Services release does not match!\n")=
;
-    return -1;
-  }
-
-
-  err =3D register_pccard_driver(&dev_info, &dtl1_attach, &dtl1_detach);
-
-
-  return err;
-
+	return err;
 }
=20
-void __exit exit_dtl1_cs(void) {
-
-  unregister_pccard_driver(&dev_info);
=20
-  while (dev_list !=3D NULL)
-    dtl1_detach(dev_list);
+void __exit exit_dtl1_cs(void)
+{
+	unregister_pccard_driver(&dev_info);
=20
+	while (dev_list !=3D NULL)
+		dtl1_detach(dev_list);
 }
=20
=20

--=-RRiqe/RAo9JWj9zQYmyY--

