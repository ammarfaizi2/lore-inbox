Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261327AbTCYBmC>; Mon, 24 Mar 2003 20:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTCYB3L>; Mon, 24 Mar 2003 20:29:11 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:14096 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261327AbTCYB2D>;
	Mon, 24 Mar 2003 20:28:03 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.66
In-reply-to: <10485563181803@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Mon, 24 Mar 2003 17:38 -0800
Message-id: <10485563181090@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.357.2, 2003/03/21 12:45:28-08:00, greg@kroah.com

i2c: remove i2c_adapter->name and use dev->name instead.


 drivers/i2c/busses/i2c-ali15x3.c |    8 ++--
 drivers/i2c/busses/i2c-amd756.c  |    6 ++-
 drivers/i2c/busses/i2c-amd8111.c |    4 +-
 drivers/i2c/busses/i2c-i801.c    |    8 ++--
 drivers/i2c/busses/i2c-isa.c     |    4 +-
 drivers/i2c/busses/i2c-piix4.c   |    8 ++--
 drivers/i2c/i2c-algo-bit.c       |   13 +++---
 drivers/i2c/i2c-algo-pcf.c       |   19 ++++------
 drivers/i2c/i2c-core.c           |   73 ++++++++++++++++-----------------------
 drivers/i2c/i2c-dev.c            |   17 +++------
 drivers/i2c/i2c-elektor.c        |   10 +++--
 drivers/i2c/i2c-elv.c            |    4 +-
 drivers/i2c/i2c-philips-par.c    |    4 +-
 drivers/i2c/i2c-velleman.c       |    4 +-
 drivers/i2c/scx200_acb.c         |   28 ++++++--------
 include/linux/i2c.h              |    1 
 16 files changed, 105 insertions(+), 106 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Mon Mar 24 17:28:41 2003
@@ -474,9 +474,11 @@
 
 static struct i2c_adapter ali15x3_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
 static struct pci_device_id ali15x3_ids[] __devinitdata = {
@@ -500,8 +502,8 @@
 	/* set up the driverfs linkage to our parent device */
 	ali15x3_adapter.dev.parent = &dev->dev;
 
-	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
-		ali15x3_smba);
+	snprintf(ali15x3_adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus ALI15X3 adapter at %04x", ali15x3_smba);
 	return i2c_add_adapter(&ali15x3_adapter);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Mon Mar 24 17:28:41 2003
@@ -312,9 +312,11 @@
 
 static struct i2c_adapter amd756_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
 enum chiptype { AMD756, AMD766, AMD768, NFORCE };
@@ -376,7 +378,7 @@
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
 
-	sprintf(amd756_adapter.name,
+	snprintf(amd756_adapter.dev.name, DEVICE_NAME_SIZE,
 		"SMBus AMD75x adapter at %04x", amd756_ioport);
 
 	error = i2c_add_adapter(&amd756_adapter);
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Mon Mar 24 17:28:41 2003
@@ -357,8 +357,8 @@
 		goto out_kfree;
 
 	smbus->adapter.owner = THIS_MODULE;
-	sprintf(smbus->adapter.name,
-			"SMBus2 AMD8111 adapter at %04x", smbus->base);
+	snprintf(smbus->adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus2 AMD8111 adapter at %04x", smbus->base);
 	smbus->adapter.id = I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD8111;
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Mon Mar 24 17:28:41 2003
@@ -546,9 +546,11 @@
 
 static struct i2c_adapter i801_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
 static struct pci_device_id i801_ids[] __devinitdata = {
@@ -597,8 +599,8 @@
 	/* set up the driverfs linkage to our parent device */
 	i801_adapter.dev.parent = &dev->dev;
 
-	sprintf(i801_adapter.name, "SMBus I801 adapter at %04x",
-		i801_smba);
+	snprintf(i801_adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus I801 adapter at %04x", i801_smba);
 	return i2c_add_adapter(&i801_adapter);
 }
 
diff -Nru a/drivers/i2c/busses/i2c-isa.c b/drivers/i2c/busses/i2c-isa.c
--- a/drivers/i2c/busses/i2c-isa.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/busses/i2c-isa.c	Mon Mar 24 17:28:41 2003
@@ -39,9 +39,11 @@
 /* There can only be one... */
 static struct i2c_adapter isa_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "ISA main adapter",
 	.id		= I2C_ALGO_ISA | I2C_HW_ISA,
 	.algo		= &isa_algorithm,
+	.dev		= {
+		.name	= "ISA main adapter",
+	},
 };
 
 static int __init i2c_isa_init(void)
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Mon Mar 24 17:28:41 2003
@@ -394,9 +394,11 @@
 
 static struct i2c_adapter piix4_adapter = {
 	.owner		= THIS_MODULE,
-	.name		= "unset",
 	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
 	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
 };
 
 static struct pci_device_id piix4_ids[] __devinitdata = {
@@ -449,8 +451,8 @@
 	/* set up the driverfs linkage to our parent device */
 	piix4_adapter.dev.parent = &dev->dev;
 
-	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
-		piix4_smba);
+	snprintf(piix4_adapter.dev.name, DEVICE_NAME_SIZE,
+		"SMBus PIIX4 adapter at %04x", piix4_smba);
 
 	retval = i2c_add_adapter(&piix4_adapter);
 
diff -Nru a/drivers/i2c/i2c-algo-bit.c b/drivers/i2c/i2c-algo-bit.c
--- a/drivers/i2c/i2c-algo-bit.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-algo-bit.c	Mon Mar 24 17:28:41 2003
@@ -23,6 +23,8 @@
 
 /* $Id: i2c-algo-bit.c,v 1.44 2003/01/21 08:08:16 kmalkki Exp $ */
 
+/* #define DEBUG 1 */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -338,16 +340,14 @@
 
 	while (count > 0) {
 		c = *temp;
-		DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: %s sendbytes: writing %2.2X\n",
-			    i2c_adap->name, c&0xff));
+		DEB2(dev_dbg(&i2c_adap->dev, "sendbytes: writing %2.2X\n", c&0xff));
 		retval = i2c_outb(i2c_adap,c);
 		if ((retval>0) || (nak_ok && (retval==0)))  { /* ok or ignored NAK */
 			count--; 
 			temp++;
 			wrcount++;
 		} else { /* arbitration or no acknowledge */
-			printk(KERN_ERR "i2c-algo-bit.o: %s sendbytes: error - bailout.\n",
-			       i2c_adap->name);
+			dev_err(&i2c_adap->dev, "sendbytes: error - bailout.\n");
 			i2c_stop(adap);
 			return (retval<0)? retval : -EFAULT;
 			        /* got a better one ?? */
@@ -527,13 +527,12 @@
 	struct i2c_algo_bit_data *bit_adap = adap->algo_data;
 
 	if (bit_test) {
-		int ret = test_bus(bit_adap, adap->name);
+		int ret = test_bus(bit_adap, adap->dev.name);
 		if (ret<0)
 			return -ENODEV;
 	}
 
-	DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: hw routines for %s registered.\n",
-	            adap->name));
+	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
 	/* register new adapter to i2c module... */
 
diff -Nru a/drivers/i2c/i2c-algo-pcf.c b/drivers/i2c/i2c-algo-pcf.c
--- a/drivers/i2c/i2c-algo-pcf.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-algo-pcf.c	Mon Mar 24 17:28:41 2003
@@ -27,6 +27,8 @@
    messages, proper stop/repstart signaling during receive,
    added detect code */
 
+/* #define DEBUG 1 */		/* to pick up dev_dbg calls */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
@@ -222,21 +224,19 @@
 	int wrcount, status, timeout;
     
 	for (wrcount=0; wrcount<count; ++wrcount) {
-		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
-		      i2c_adap->name, buf[wrcount]&0xff));
+		DEB2(dev_dbg(&i2c_adap->dev, "i2c_write: writing %2.2X\n",
+				buf[wrcount]&0xff));
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
 			i2c_stop(adap);
-			printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
-			       "error - timeout.\n", i2c_adap->name);
+			dev_err(&i2c_adap->dev, "i2c_write: error - timeout.\n");
 			return -EREMOTEIO; /* got a better one ?? */
 		}
 #ifndef STUB_I2C
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
-			printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
-			       "error - no ack.\n", i2c_adap->name);
+			dev_err(&i2c_adap->dev, "i2c_write: error - no ack.\n");
 			return -EREMOTEIO; /* got a better one ?? */
 		}
 #endif
@@ -263,14 +263,14 @@
 
 		if (wait_for_pin(adap, &status)) {
 			i2c_stop(adap);
-			printk(KERN_ERR "i2c-algo-pcf.o: pcf_readbytes timed out.\n");
+			dev_err(&i2c_adap->dev, "pcf_readbytes timed out.\n");
 			return (-1);
 		}
 
 #ifndef STUB_I2C
 		if ((status & I2C_PCF_LRB) && (i != count)) {
 			i2c_stop(adap);
-			printk(KERN_ERR "i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
+			dev_err(&i2c_adap->dev, "i2c_read: i2c_inb, No ack.\n");
 			return (-1);
 		}
 #endif
@@ -445,8 +445,7 @@
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 	int rval;
 
-	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: hw routines for %s registered.\n",
-	            adap->name));
+	DEB2(dev_dbg(&adap->dev, "hw routines registered.\n"));
 
 	/* register new adapter to i2c module... */
 
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-core.c	Mon Mar 24 17:28:41 2003
@@ -23,6 +23,8 @@
 
 /* $Id: i2c-core.c,v 1.95 2003/01/22 05:25:08 kmalkki Exp $ */
 
+/* #define DEBUG 1 */		/* needed to pick up the dev_dbg() calls */
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -82,9 +84,8 @@
 		if (NULL == adapters[i])
 			break;
 	if (I2C_ADAP_MAX == i) {
-		printk(KERN_WARNING 
-		       " i2c-core.o: register_adapter(%s) - enlarge I2C_ADAP_MAX.\n",
-			adap->name);
+		dev_warn(&adap->dev,
+			"register_adapter - enlarge I2C_ADAP_MAX.\n");
 		res = -ENOMEM;
 		goto out_unlock;
 	}
@@ -105,7 +106,6 @@
 	if (adap->dev.parent == NULL)
 		adap->dev.parent = &legacy_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", i);
-	strcpy(adap->dev.name, "i2c controller");
 	device_register(&adap->dev);
 
 	/* inform drivers of new adapters */
@@ -116,8 +116,7 @@
 			drivers[j]->attach_adapter(adap);
 	up(&core_lists);
 	
-	DEB(printk(KERN_DEBUG "i2c-core.o: adapter %s registered as adapter %d.\n",
-	           adap->name,i));
+	DEB(dev_dbg(&adap->dev, "registered as adapter %d.\n", i));
 
  out_unlock:
 	up(&core_lists);
@@ -134,8 +133,7 @@
 		if (adap == adapters[i])
 			break;
 	if (I2C_ADAP_MAX == i) {
-		printk( KERN_WARNING "i2c-core.o: unregister_adapter adap [%s] not found.\n",
-			adap->name);
+		dev_warn(&adap->dev, "unregister_adapter adap not found.\n");
 		res = -ENODEV;
 		goto out_unlock;
 	}
@@ -148,9 +146,9 @@
 	for (j = 0; j < I2C_DRIVER_MAX; j++) 
 		if (drivers[j] && (drivers[j]->flags & I2C_DF_DUMMY))
 			if ((res = drivers[j]->attach_adapter(adap))) {
-				printk(KERN_WARNING "i2c-core.o: can't detach adapter %s "
+				dev_warn(&adap->dev, "can't detach adapter"
 				       "while detaching driver %s: driver not "
-				       "detached!",adap->name,drivers[j]->name);
+				       "detached!", drivers[j]->name);
 				goto out_unlock;
 			}
 
@@ -164,10 +162,10 @@
 		     * must be deleted, as this would cause invalid states.
 		     */
 			if ((res=client->driver->detach_client(client))) {
-				printk(KERN_ERR "i2c-core.o: adapter %s not "
+				dev_err(&adap->dev, "adapter not "
 					"unregistered, because client at "
 					"address %02x can't be detached. ",
-					adap->name, client->addr);
+					client->addr);
 				goto out_unlock;
 			}
 		}
@@ -180,7 +178,7 @@
 
 	adapters[i] = NULL;
 
-	DEB(printk(KERN_DEBUG "i2c-core.o: adapter unregistered: %s\n",adap->name));
+	DEB(dev_dbg(&adap->dev, "adapter unregistered\n"));
 
  out_unlock:
 	up(&core_lists);
@@ -272,8 +270,7 @@
 		struct i2c_adapter *adap = adapters[k];
 		if (adap == NULL) /* skip empty entries. */
 			continue;
-		DEB2(printk(KERN_DEBUG "i2c-core.o: examining adapter %s:\n",
-			    adap->name));
+		DEB2(dev_dbg(&adap->dev, "examining adapter\n"));
 		if (driver->flags & I2C_DF_DUMMY) {
 		/* DUMMY drivers do not register their clients, so we have to
 		 * use a trick here: we call driver->attach_adapter to
@@ -281,11 +278,10 @@
 		 * this or hell will break loose...  
 		 */
 			if ((res = driver->attach_adapter(adap))) {
-				printk(KERN_WARNING "i2c-core.o: while unregistering "
-				       "dummy driver %s, adapter %s could "
+				dev_warn(&adap->dev, "while unregistering "
+				       "dummy driver %s, adapter could "
 				       "not be detached properly; driver "
-				       "not unloaded!",driver->name,
-				       adap->name);
+				       "not unloaded!",driver->name);
 				goto out_unlock;
 			}
 		} else {
@@ -296,19 +292,16 @@
 					DEB2(printk(KERN_DEBUG "i2c-core.o: "
 						    "detaching client %s:\n",
 					            client->name));
-					if ((res = driver->
-							detach_client(client)))
-					{
-						printk(KERN_ERR "i2c-core.o: while "
+					if ((res = driver->detach_client(client))) {
+ 						dev_err(&adap->dev, "while "
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
-						       "adapter `%s' could not "
+						       "adapter could not "
 						       "be detached; driver "
 						       "not unloaded!",
 						       driver->name,
-						       client->addr,
-						       adap->name);
+						       client->addr);
 						goto out_unlock;
 					}
 				}
@@ -374,16 +367,14 @@
 	
 	if (adapter->client_register)  {
 		if (adapter->client_register(client))  {
-			printk(KERN_DEBUG
-			       "i2c-core.o: warning: client_register seems "
-			       "to have failed for client %02x at adapter %s\n",
-			       client->addr, adapter->name);
+			dev_warn(&adapter->dev, "warning: client_register "
+				"seems to have failed for client %02x\n",
+				client->addr);
 		}
 	}
 
-	DEB(printk(KERN_DEBUG
-		   "i2c-core.o: client [%s] registered to adapter [%s] "
-		   "(pos. %d).\n", client->name, adapter->name, i));
+	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter "
+			"(pos. %d).\n", client->name, i));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;
@@ -579,7 +570,7 @@
 			seq_printf(s, "dummy     ");
 
 		seq_printf(s, "\t%-32s\t%-32s\n",
-			      adapter->name, adapter->algo->name);
+			      adapter->dev.name, adapter->algo->name);
 	}
 	up(&core_lists);
 
@@ -688,8 +679,7 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	DEB2(printk(KERN_DEBUG "i2c-core.o: master_xfer: %s with %d msgs.\n",
-		            adap->name,num));
+ 	 	DEB2(dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num));
 
 		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,msgs,num);
@@ -697,8 +687,7 @@
 
 		return ret;
 	} else {
-		printk(KERN_ERR "i2c-core.o: I2C adapter %04x: I2C level transfers not supported\n",
-		       adap->id);
+		dev_err(&adap->dev, "I2C level transfers not supported\n");
 		return -ENOSYS;
 	}
 }
@@ -715,8 +704,8 @@
 		msg.len = count;
 		(const char *)msg.buf = buf;
 	
-		DEB2(printk(KERN_DEBUG "i2c-core.o: master_send: writing %d bytes on %s.\n",
-			count,client->adapter->name));
+		DEB2(dev_dbg(&client->adapter->dev, "master_send: writing %d bytes.\n",
+				count));
 	
 		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,&msg,1);
@@ -745,8 +734,8 @@
 		msg.len = count;
 		msg.buf = buf;
 
-		DEB2(printk(KERN_DEBUG "i2c-core.o: master_recv: reading %d bytes on %s.\n",
-			count,client->adapter->name));
+		DEB2(dev_dbg(&client->adapter->dev, "master_recv: reading %d bytes.\n",
+				count));
 	
 		down(&adap->bus);
 		ret = adap->algo->master_xfer(adap,&msg,1);
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-dev.c	Mon Mar 24 17:28:41 2003
@@ -30,6 +30,9 @@
 
 /* $Id: i2c-dev.c,v 1.53 2003/01/21 08:08:16 kmalkki Exp $ */
 
+/* If you want debugging uncomment: */
+/* #define DEBUG 1 */
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -41,10 +44,6 @@
 #include <linux/i2c-dev.h>
 #include <asm/uaccess.h>
 
-/* If you want debugging uncomment: */
-/* #define DEBUG */
-
-
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
@@ -386,11 +385,11 @@
 	char name[12];
 
 	if ((i = i2c_adapter_id(adap)) < 0) {
-		printk(KERN_DEBUG "i2c-dev.o: Unknown adapter ?!?\n");
+		dev_dbg(&adap->dev, "Unknown adapter ?!?\n");
 		return -ENODEV;
 	}
 	if (i >= I2CDEV_ADAPS_MAX) {
-		printk(KERN_DEBUG "i2c-dev.o: Adapter number too large?!? (%d)\n",i);
+		dev_dbg(&adap->dev, "Adapter number too large?!? (%d)\n",i);
 		return -ENODEV;
 	}
 
@@ -401,14 +400,12 @@
 			DEVFS_FL_DEFAULT, I2C_MAJOR, i,
 			S_IFCHR | S_IRUSR | S_IWUSR,
 			&i2cdev_fops, NULL);
-		printk(KERN_DEBUG "i2c-dev.o: Registered '%s' as minor %d\n",adap->name,i);
+		dev_dbg(&adap->dev, "Registered as minor %d\n", i);
 	} else {
 		/* This is actually a detach_adapter call! */
 		devfs_remove("i2c/%d", i);
 		i2cdev_adaps[i] = NULL;
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-dev.o: Adapter unregistered: %s\n",adap->name);
-#endif
+		dev_dbg(&adap->dev, "Adapter unregistered\n");
 	}
 
 	return 0;
diff -Nru a/drivers/i2c/i2c-elektor.c b/drivers/i2c/i2c-elektor.c
--- a/drivers/i2c/i2c-elektor.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-elektor.c	Mon Mar 24 17:28:41 2003
@@ -174,10 +174,12 @@
 };
 
 static struct i2c_adapter pcf_isa_ops = {
-	.owner		   = THIS_MODULE,
-	.name		   = "PCF8584 ISA adapter",
-	.id		   = I2C_HW_P_ELEK,
-	.algo_data	   = &pcf_isa_data,
+	.owner		= THIS_MODULE,
+	.id		= I2C_HW_P_ELEK,
+	.algo_data	= &pcf_isa_data,
+	.dev		= {
+		.name	= "PCF8584 ISA adapter",
+	},
 };
 
 static int __init i2c_pcfisa_init(void) 
diff -Nru a/drivers/i2c/i2c-elv.c b/drivers/i2c/i2c-elv.c
--- a/drivers/i2c/i2c-elv.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-elv.c	Mon Mar 24 17:28:41 2003
@@ -129,9 +129,11 @@
 
 static struct i2c_adapter bit_elv_ops = {
 	.owner		= THIS_MODULE,
-	.name		= "ELV Parallel port adaptor",
 	.id		= I2C_HW_B_ELV,
 	.algo_data	= &bit_elv_data,
+	.dev		= {
+		.name	= "ELV Parallel port adaptor",
+	},
 };
 
 static int __init i2c_bitelv_init(void)
diff -Nru a/drivers/i2c/i2c-philips-par.c b/drivers/i2c/i2c-philips-par.c
--- a/drivers/i2c/i2c-philips-par.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-philips-par.c	Mon Mar 24 17:28:41 2003
@@ -151,8 +151,10 @@
 
 static struct i2c_adapter bit_lp_ops = {
 	.owner		= THIS_MODULE,
-	.name		= "Philips Parallel port adapter",
 	.id		= I2C_HW_B_LP,
+	.dev		= {
+		.name	= "Philips Parallel port adapter",
+	},
 };
 
 static void i2c_parport_attach (struct parport *port)
diff -Nru a/drivers/i2c/i2c-velleman.c b/drivers/i2c/i2c-velleman.c
--- a/drivers/i2c/i2c-velleman.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/i2c-velleman.c	Mon Mar 24 17:28:41 2003
@@ -114,9 +114,11 @@
 
 static struct i2c_adapter bit_velle_ops = {
 	.owner		= THIS_MODULE,
-	.name		= "Velleman K8000",
 	.id		= I2C_HW_B_VELLE,
 	.algo_data	= &bit_velle_data,
+	.dev		= {
+		.name	= "Velleman K8000",
+	},
 };
 
 static int __init i2c_bitvelle_init(void)
diff -Nru a/drivers/i2c/scx200_acb.c b/drivers/i2c/scx200_acb.c
--- a/drivers/i2c/scx200_acb.c	Mon Mar 24 17:28:41 2003
+++ b/drivers/i2c/scx200_acb.c	Mon Mar 24 17:28:41 2003
@@ -140,8 +140,7 @@
 
 	switch (iface->state) {
 	case state_idle:
-		printk(KERN_WARNING NAME ": %s, interrupt in idle state\n", 
-		       iface->adapter.name);
+		dev_warn(&iface->adapter.dev, "interrupt in idle state\n",);
 		break;
 
 	case state_address:
@@ -226,8 +225,8 @@
 	return;
 
  error:
-	printk(KERN_ERR NAME ": %s, %s in state %s\n", iface->adapter.name, 
-	       errmsg, scx200_acb_state_name[iface->state]);
+	dev_err(&iface->adapter.dev, "%s in state %s\n", errmsg,
+		scx200_acb_state_name[iface->state]);
 
 	iface->state = state_idle;
 	iface->result = -EIO;
@@ -236,8 +235,8 @@
 
 static void scx200_acb_timeout(struct scx200_acb_iface *iface) 
 {
-	printk(KERN_ERR NAME ": %s, timeout in state %s\n", 
-	       iface->adapter.name, scx200_acb_state_name[iface->state]);
+	dev_err(&iface->adapter.dev, "timeout in state %s\n",
+		scx200_acb_state_name[iface->state]);
 
 	iface->state = state_idle;
 	iface->result = -EIO;
@@ -331,13 +330,12 @@
 	    size, address, command, len, rw == I2C_SMBUS_READ);
 
 	if (!len && rw == I2C_SMBUS_READ) {
-		printk(KERN_WARNING NAME ": %s, zero length read\n", 
-		       adapter->name);
+		dev_warn(&adapter->dev, "zero length read\n");
 		return -EINVAL;
 	}
 
 	if (len && !buffer) {
-		printk(KERN_WARNING NAME ": %s, nonzero length but no buffer\n", adapter->name);
+		dev_warn(&adapter->dev, "nonzero length but no buffer\n");
 		return -EFAULT;
 	}
 
@@ -458,17 +456,17 @@
 	memset(iface, 0, sizeof(*iface));
 	adapter = &iface->adapter;
 	adapter->data = iface;
-	sprintf(adapter->name, "SCx200 ACB%d", index);
+	snprintf(adapter->dev.name, DEVICE_NAME_SIZE, "SCx200 ACB%d", index);
 	adapter->owner = THIS_MODULE;
 	adapter->id = I2C_ALGO_SMBUS;
 	adapter->algo = &scx200_acb_algorithm;
 
 	init_MUTEX(&iface->sem);
 
-	sprintf(description, "NatSemi SCx200 ACCESS.bus [%s]", adapter->name);
+	snprintf(description, sizeof(description), "NatSemi SCx200 ACCESS.bus [%s]", adapter->dev.name);
 	if (request_region(base, 8, description) == 0) {
-		printk(KERN_ERR NAME ": %s, can't allocate io 0x%x-0x%x\n", 
-		       adapter->name, base, base + 8-1);
+		dev_err(&adapter->dev, "can't allocate io 0x%x-0x%x\n",
+			base, base + 8-1);
 		rc = -EBUSY;
 		goto errout;
 	}
@@ -476,14 +474,14 @@
 
 	rc = scx200_acb_probe(iface);
 	if (rc) {
-		printk(KERN_WARNING NAME ": %s, probe failed\n", adapter->name);
+		dev_warn(&adapter->dev, "probe failed\n");
 		goto errout;
 	}
 
 	scx200_acb_reset(iface);
 
 	if (i2c_add_adapter(adapter) < 0) {
-		printk(KERN_ERR NAME ": %s, failed to register\n", adapter->name);
+		dev_err(&adapter->dev, "failed to register\n");
 		rc = -ENODEV;
 		goto errout;
 	}
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Mon Mar 24 17:28:41 2003
+++ b/include/linux/i2c.h	Mon Mar 24 17:28:41 2003
@@ -210,7 +210,6 @@
  */
 struct i2c_adapter {
 	struct module *owner;
-	char name[32];	/* some useful name to identify the adapter	*/
 	unsigned int id;/* == is algo->id | hwdep.struct->id, 		*/
 			/* for registered values see below		*/
 	struct i2c_algorithm *algo;/* the algorithm to access the bus	*/

