Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316416AbSFDFFK>; Tue, 4 Jun 2002 01:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316422AbSFDFFJ>; Tue, 4 Jun 2002 01:05:09 -0400
Received: from mail315.mail.bellsouth.net ([205.152.58.175]:64420 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S316416AbSFDFEz>; Tue, 4 Jun 2002 01:04:55 -0400
Message-ID: <3CFC4A64.B0238CF@bellsouth.net>
Date: Tue, 04 Jun 2002 01:04:36 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "linux-i2c@tk.uni-linz.ac.at" <linux-i2c@tk.uni-linz.ac.at>
Subject: Re: [patch] 2.5.20 i2c device updates
In-Reply-To: <3CFC4A39.F3524EB9@bellsouth.net>
Content-Type: multipart/mixed;
 boundary="------------55A2ED23AE2F2685D5804F09"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55A2ED23AE2F2685D5804F09
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Albert Cranford wrote:
> 
> Hello Linus,
> The attached patch cleans up printk's for the i2c devices.
> Albert
> --
> Albert Cranford Deerfield Beach FL USA
> ac9410@bellsouth.net

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------55A2ED23AE2F2685D5804F09
Content-Type: text/plain; charset=iso-8859-1;
 name="47-i2c-3-patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="47-i2c-3-patch"

# i2c-algo-bit.c: Leave kernel time_before/after_eq
#   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
#   Remove #include <linux/sched.h> since i2c.h has it now.
# i2c-algo-pcf.c: Remove #include <linux/sched.h> since i2c.h has it now.
#   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
#   Remove #include <linux/sched.h> since i2c.h has it now.
# i2c/i2c-elektor.c: Leave kernel __exit pcf_isa_exit(void)
#   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
# i2c-elv.c: Leave kernel __exit bit_elv_exit(void)
#   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
# i2c-philips-par.c: Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
# i2c/i2c-velleman.c: Leave kernel __exit bit_velle_exit(void)
#   Remove #ifdef MODULE_LICENSE around MODULE_LICENSE.
# Drop i2c-algo-8xx.[ch] deltas
# Drop i2c-algo-ppc405.[ch] deltas
# Drop i2c-pcf-epp.c deltas
# Drop i2c-ppc405.[ch] deltas
# Drop i2c-ppc405adap.h deltas
# Drop i2c-pport.c deltas
# Drop i2c-rpx.c deltas
#
--- linux/drivers/i2c/i2c-algo-bit.c.orig	2002-05-09 18:21:26.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-bit.c	2002-05-23 17:20:18.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-algo-bit.c,v 1.30 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-algo-bit.c,v 1.34 2001/11/19 18:45:02 mds Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -32,7 +32,6 @@
 #include <asm/uaccess.h>
 #include <linux/ioport.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
@@ -122,7 +121,7 @@
 		}
 		cond_resched();
 	}
-	DEBSTAT(printk("needed %ld jiffies\n", jiffies-start));
+	DEBSTAT(printk(KERN_DEBUG "needed %ld jiffies\n", jiffies-start));
 #ifdef SLO_IO
 	SLO_IO
 #endif
@@ -178,12 +177,12 @@
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	/* assert: scl is low */
-	DEB2(printk(" i2c_outb:%2.2X\n",c&0xff));
+	DEB2(printk(KERN_DEBUG " i2c_outb:%2.2X\n",c&0xff));
 	for ( i=7 ; i>=0 ; i-- ) {
 		sb = c & ( 1 << i );
 		setsda(adap,sb);
 		udelay(adap->udelay);
-		DEBPROTO(printk("%d",sb!=0));
+		DEBPROTO(printk(KERN_DEBUG "%d",sb!=0));
 		if (sclhi(adap)<0) { /* timed out */
 			sdahi(adap); /* we don't want to block the net */
 			return -ETIMEDOUT;
@@ -200,10 +199,10 @@
 	};
 	/* read ack: SDA should be pulled down by slave */
 	ack=getsda(adap);	/* ack: sda is pulled low ->success.	 */
-	DEB2(printk(" i2c_outb: getsda() =  0x%2.2x\n", ~ack ));
+	DEB2(printk(KERN_DEBUG " i2c_outb: getsda() =  0x%2.2x\n", ~ack ));
 
-	DEBPROTO( printk("[%2.2x]",c&0xff) );
-	DEBPROTO(if (0==ack){ printk(" A ");} else printk(" NA ") );
+	DEBPROTO( printk(KERN_DEBUG "[%2.2x]",c&0xff) );
+	DEBPROTO(if (0==ack){ printk(KERN_DEBUG " A ");} else printk(KERN_DEBUG " NA ") );
 	scllo(adap);
 	return 0==ack;		/* return 1 if device acked	 */
 	/* assert: scl is low (sda undef) */
@@ -219,7 +218,7 @@
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
 
 	/* assert: scl is low */
-	DEB2(printk("i2c_inb.\n"));
+	DEB2(printk(KERN_DEBUG "i2c_inb.\n"));
 
 	sdahi(adap);
 	for (i=0;i<8;i++) {
@@ -232,7 +231,7 @@
 		scllo(adap);
 	}
 	/* assert: scl is low */
-	DEBPROTO(printk(" %2.2x", indata & 0xff));
+	DEBPROTO(printk(KERN_DEBUG " %2.2x", indata & 0xff));
 	return (int) (indata & 0xff);
 }
 
@@ -244,69 +243,69 @@
 	int scl,sda;
 	sda=getsda(adap);
 	if (adap->getscl==NULL) {
-		printk("i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
+		printk(KERN_WARNING "i2c-algo-bit.o: Warning: Adapter can't read from clock line - skipping test.\n");
 		return 0;		
 	}
 	scl=getscl(adap);
-	printk("i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
+	printk(KERN_INFO "i2c-algo-bit.o: Adapter: %s scl: %d  sda: %d -- testing...\n",
 	       name,getscl(adap),getsda(adap));
 	if (!scl || !sda ) {
-		printk("i2c-algo-bit.o: %s seems to be busy.\n",name);
+		printk(KERN_INFO " i2c-algo-bit.o: %s seems to be busy.\n",name);
 		goto bailout;
 	}
 	sdalo(adap);
-	printk("i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
+	printk(KERN_DEBUG "i2c-algo-bit.o:1 scl: %d  sda: %d \n",getscl(adap),
 	       getsda(adap));
 	if ( 0 != getsda(adap) ) {
-		printk("i2c-algo-bit.o: %s SDA stuck high!\n",name);
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck high!\n",name);
 		sdahi(adap);
 		goto bailout;
 	}
 	if ( 0 == getscl(adap) ) {
-		printk("i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while pulling SDA low!\n",
 			name);
 		goto bailout;
 	}		
 	sdahi(adap);
-	printk("i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
+	printk(KERN_DEBUG "i2c-algo-bit.o:2 scl: %d  sda: %d \n",getscl(adap),
 	       getsda(adap));
 	if ( 0 == getsda(adap) ) {
-		printk("i2c-algo-bit.o: %s SDA stuck low!\n",name);
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA stuck low!\n",name);
 		sdahi(adap);
 		goto bailout;
 	}
 	if ( 0 == getscl(adap) ) {
-		printk("i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL unexpected low while SDA high!\n",
 		       name);
 	goto bailout;
 	}
 	scllo(adap);
-	printk("i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
+	printk(KERN_DEBUG "i2c-algo-bit.o:3 scl: %d  sda: %d \n",getscl(adap),
 	       getsda(adap));
 	if ( 0 != getscl(adap) ) {
-		printk("i2c-algo-bit.o: %s SCL stuck high!\n",name);
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck high!\n",name);
 		sclhi(adap);
 		goto bailout;
 	}
 	if ( 0 == getsda(adap) ) {
-		printk("i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while pulling SCL low!\n",
 			name);
 		goto bailout;
 	}
 	sclhi(adap);
-	printk("i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
+	printk(KERN_DEBUG "i2c-algo-bit.o:4 scl: %d  sda: %d \n",getscl(adap),
 	       getsda(adap));
 	if ( 0 == getscl(adap) ) {
-		printk("i2c-algo-bit.o: %s SCL stuck low!\n",name);
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SCL stuck low!\n",name);
 		sclhi(adap);
 		goto bailout;
 	}
 	if ( 0 == getsda(adap) ) {
-		printk("i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
+		printk(KERN_WARNING "i2c-algo-bit.o: %s SDA unexpected low while SCL high!\n",
 			name);
 		goto bailout;
 	}
-	printk("i2c-algo-bit.o: %s passed test.\n",name);
+	printk(KERN_INFO "i2c-algo-bit.o: %s passed test.\n",name);
 	return 0;
 bailout:
 	sdahi(adap);
@@ -340,7 +339,7 @@
 		i2c_start(adap);
 		udelay(adap->udelay);
 	}
-	DEB2(if (i) printk("i2c-algo-bit.o: needed %d retries for %d\n",
+	DEB2(if (i) printk(KERN_DEBUG "i2c-algo-bit.o: needed %d retries for %d\n",
 	                   i,addr));
 	return ret;
 }
@@ -355,7 +354,7 @@
 
 	while (count > 0) {
 		c = *temp;
-		DEB2(printk("i2c-algo-bit.o: %s i2c_write: writing %2.2X\n",
+		DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: %s i2c_write: writing %2.2X\n",
 			    i2c_adap->name, c&0xff));
 		retval = i2c_outb(i2c_adap,c);
 		if (retval>0) {
@@ -363,7 +362,7 @@
 			temp++;
 			wrcount++;
 		} else { /* arbitration or no acknowledge */
-			printk("i2c-algo-bit.o: %s i2c_write: error - bailout.\n",
+			printk(KERN_ERR "i2c-algo-bit.o: %s i2c_write: error - bailout.\n",
 			       i2c_adap->name);
 			i2c_stop(adap);
 			return (retval<0)? retval : -EFAULT;
@@ -391,7 +390,7 @@
 			*temp = inval;
 			rdcount++;
 		} else {   /* read timed out */
-			printk("i2c-algo-bit.o: i2c_read: i2c_inb timed out.\n");
+			printk(KERN_ERR "i2c-algo-bit.o: i2c_read: i2c_inb timed out.\n");
 			break;
 		}
 
@@ -404,7 +403,7 @@
 		}
 		if (sclhi(adap)<0) {	/* timeout */
 			sdahi(adap);
-			printk("i2c-algo-bit.o: i2c_read: Timeout at ack\n");
+			printk(KERN_ERR "i2c-algo-bit.o: i2c_read: Timeout at ack\n");
 			return -ETIMEDOUT;
 		};
 		scllo(adap);
@@ -434,18 +433,18 @@
 	if ( (flags & I2C_M_TEN)  ) { 
 		/* a ten bit address */
 		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk("addr0: %d\n",addr));
+		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(i2c_adap, addr, retries);
 		if (ret!=1) {
-			printk("died at extended address code.\n");
+			printk(KERN_ERR "died at extended address code.\n");
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
 		ret = i2c_outb(i2c_adap,msg->addr & 0x7f);
 		if (ret != 1) {
 			/* the chip did not ack / xmission error occurred */
-			printk("died at 2nd address code.\n");
+			printk(KERN_ERR "died at 2nd address code.\n");
 			return -EREMOTEIO;
 		}
 		if ( flags & I2C_M_RD ) {
@@ -454,7 +453,7 @@
 			addr |= 0x01;
 			ret = try_address(i2c_adap, addr, retries);
 			if (ret!=1) {
-				printk("died at extended address code.\n");
+				printk(KERN_ERR "died at extended address code.\n");
 				return -EREMOTEIO;
 			}
 		}
@@ -489,7 +488,7 @@
 			}
 			ret = bit_doAddress(i2c_adap,pmsg,i2c_adap->retries);
 			if (ret != 0) {
-				DEB2(printk("i2c-algo-bit.o: NAK from device adr %#2x msg #%d\n"
+				DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: NAK from device adr %#2x msg #%d\n"
 				       ,msgs[i].addr,i));
 				return (ret<0) ? ret : -EREMOTEIO;
 			}
@@ -497,14 +496,14 @@
 		if (pmsg->flags & I2C_M_RD ) {
 			/* read bytes into buffer*/
 			ret = readbytes(i2c_adap,pmsg->buf,pmsg->len);
-			DEB2(printk("i2c-algo-bit.o: read %d bytes.\n",ret));
+			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: read %d bytes.\n",ret));
 			if (ret < pmsg->len ) {
 				return (ret<0)? ret : -EREMOTEIO;
 			}
 		} else {
 			/* write bytes from buffer */
 			ret = sendbytes(i2c_adap,pmsg->buf,pmsg->len);
-			DEB2(printk("i2c-algo-bit.o: wrote %d bytes.\n",ret));
+			DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: wrote %d bytes.\n",ret));
 			if (ret < pmsg->len ) {
 				return (ret<0) ? ret : -EREMOTEIO;
 			}
@@ -554,7 +553,7 @@
 			return -ENODEV;
 	}
 
-	DEB2(printk("i2c-algo-bit.o: hw routines for %s registered.\n",
+	DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: hw routines for %s registered.\n",
 	            adap->name));
 
 	/* register new adapter to i2c module... */
@@ -598,7 +597,7 @@
 	if ((res = i2c_del_adapter(adap)) < 0)
 		return res;
 
-	DEB2(printk("i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
+	DEB2(printk(KERN_DEBUG "i2c-algo-bit.o: adapter unregistered: %s\n",adap->name));
 
 #ifdef MODULE
 	MOD_DEC_USE_COUNT;
@@ -608,7 +607,7 @@
 
 int __init i2c_algo_bit_init (void)
 {
-	printk("i2c-algo-bit.o: i2c bit algorithm module\n");
+	printk(KERN_INFO "i2c-algo-bit.o: i2c bit algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return 0;
 }
 
--- linux/drivers/i2c/i2c-algo-pcf.c.orig	2002-05-09 18:25:27.000000000 -0400
+++ linux/drivers/i2c/i2c-algo-pcf.c	2002-05-23 17:21:11.000000000 -0400
@@ -36,7 +36,6 @@
 #include <asm/uaccess.h>
 #include <linux/ioport.h>
 #include <linux/errno.h>
-#include <linux/sched.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pcf.h>
@@ -99,7 +98,7 @@
 	}
 #endif
 	if (timeout <= 0) {
-		printk("Timeout waiting for Bus Busy\n");
+		printk(KERN_ERR "Timeout waiting for Bus Busy\n");
 	}
 	
 	return (timeout<=0);
@@ -144,15 +143,14 @@
 {
 	unsigned char temp;
 
-	DEB3(printk("i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
+	DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: PCF state 0x%02x\n", get_pcf(adap, 1)));
 
 	/* S1=0x80: S0 selected, serial interface off */
 	set_pcf(adap, 1, I2C_PCF_PIN);
 	/* check to see S1 now used as R/W ctrl -
 	   PCF8584 does that when ESO is zero */
-	/* PCF also resets PIN bit */
-	if ((temp = get_pcf(adap, 1)) != (0)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
+	if (((temp = get_pcf(adap, 1)) & 0x7f) != (0)) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S0 (0x%02x).\n", temp));
 		return -ENXIO; /* definetly not PCF8584 */
 	}
 
@@ -160,15 +158,15 @@
 	i2c_outb(adap, get_own(adap));
 	/* check it's realy writen */
 	if ((temp = i2c_inb(adap)) != get_own(adap)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S0 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
 	/* S1=0xA0, next byte in S2					*/
 	set_pcf(adap, 1, I2C_PCF_PIN | I2C_PCF_ES1);
 	/* check to see S2 now selected */
-	if ((temp = get_pcf(adap, 1)) != I2C_PCF_ES1) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
+	if (((temp = get_pcf(adap, 1)) & 0x7f) != I2C_PCF_ES1) {
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -176,7 +174,7 @@
 	i2c_outb(adap, get_clock(adap));
 	/* check it's realy writen, the only 5 lowest bits does matter */
 	if (((temp = i2c_inb(adap)) & 0x1f) != get_clock(adap)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't set S2 (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 
@@ -185,11 +183,11 @@
 
 	/* check to see PCF is realy idled and we can access status register */
 	if ((temp = get_pcf(adap, 1)) != (I2C_PCF_PIN | I2C_PCF_BB)) {
-		DEB2(printk("i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: PCF detection failed -- can't select S1` (0x%02x).\n", temp));
 		return -ENXIO;
 	}
 	
-	printk("i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
+	printk(KERN_DEBUG "i2c-algo-pcf.o: deteted and initialized PCF8584.\n");
 
 	return 0;
 }
@@ -215,7 +213,7 @@
 		i2c_stop(adap);
 		udelay(adap->udelay);
 	}
-	DEB2(if (i) printk("i2c-algo-pcf.o: needed %d retries for %d\n",i,
+	DEB2(if (i) printk(KERN_DEBUG "i2c-algo-pcf.o: needed %d retries for %d\n",i,
 	                   addr));
 	return ret;
 }
@@ -228,20 +226,20 @@
 	int wrcount, status, timeout;
     
 	for (wrcount=0; wrcount<count; ++wrcount) {
-		DEB2(printk("i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
+		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: %s i2c_write: writing %2.2X\n",
 		      i2c_adap->name, buf[wrcount]&0xff));
 		i2c_outb(adap, buf[wrcount]);
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: %s i2c_write: "
+			printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
 			       "error - timeout.\n", i2c_adap->name);
 			return -EREMOTEIO; /* got a better one ?? */
 		}
 #ifndef STUB_I2C
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: %s i2c_write: "
+			printk(KERN_ERR "i2c-algo-pcf.o: %s i2c_write: "
 			       "error - no ack.\n", i2c_adap->name);
 			return -EREMOTEIO; /* got a better one ?? */
 		}
@@ -269,14 +267,14 @@
 
 		if (wait_for_pin(adap, &status)) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: pcf_readbytes timed out.\n");
+			printk(KERN_ERR "i2c-algo-pcf.o: pcf_readbytes timed out.\n");
 			return (-1);
 		}
 
 #ifndef STUB_I2C
 		if ((status & I2C_PCF_LRB) && (i != count)) {
 			i2c_stop(adap);
-			printk("i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
+			printk(KERN_ERR "i2c-algo-pcf.o: i2c_read: i2c_inb, No ack.\n");
 			return (-1);
 		}
 #endif
@@ -312,18 +310,18 @@
 	if ( (flags & I2C_M_TEN)  ) { 
 		/* a ten bit address */
 		addr = 0xf0 | (( msg->addr >> 7) & 0x03);
-		DEB2(printk("addr0: %d\n",addr));
+		DEB2(printk(KERN_DEBUG "addr0: %d\n",addr));
 		/* try extended address code...*/
 		ret = try_address(adap, addr, retries);
 		if (ret!=1) {
-			printk("died at extended address code.\n");
+			printk(KERN_ERR "died at extended address code.\n");
 			return -EREMOTEIO;
 		}
 		/* the remaining 8 bit address */
 		i2c_outb(adap,msg->addr & 0x7f);
 /* Status check comes here */
 		if (ret != 1) {
-			printk("died at 2nd address code.\n");
+			printk(KERN_ERR "died at 2nd address code.\n");
 			return -EREMOTEIO;
 		}
 		if ( flags & I2C_M_RD ) {
@@ -332,7 +330,7 @@
 			addr |= 0x01;
 			ret = try_address(adap, addr, retries);
 			if (ret!=1) {
-				printk("died at extended address code.\n");
+				printk(KERN_ERR "died at extended address code.\n");
 				return -EREMOTEIO;
 			}
 		}
@@ -360,7 +358,7 @@
 	/* Check for bus busy */
 	timeout = wait_for_bb(adap);
 	if (timeout) {
-		DEB2(printk("i2c-algo-pcf.o: "
+		DEB2(printk(KERN_ERR "i2c-algo-pcf.o: "
 		            "Timeout waiting for BB in pcf_xfer\n");)
 		return -EIO;
 	}
@@ -368,7 +366,7 @@
 	for (i = 0;ret >= 0 && i < num; i++) {
 		pmsg = &msgs[i];
 
-		DEB2(printk("i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: Doing %s %d bytes to 0x%02x - %d of %d messages\n",
 		     pmsg->flags & I2C_M_RD ? "read" : "write",
                      pmsg->len, pmsg->addr, i + 1, num);)
     
@@ -383,7 +381,7 @@
 		timeout = wait_for_pin(adap, &status);
 		if (timeout) {
 			i2c_stop(adap);
-			DEB2(printk("i2c-algo-pcf.o: Timeout waiting "
+			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: Timeout waiting "
 				    "for PIN(1) in pcf_xfer\n");)
 			return (-EREMOTEIO);
 		}
@@ -392,12 +390,12 @@
 		/* Check LRB (last rcvd bit - slave ack) */
 		if (status & I2C_PCF_LRB) {
 			i2c_stop(adap);
-			DEB2(printk("i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
+			DEB2(printk(KERN_ERR "i2c-algo-pcf.o: No LRB(1) in pcf_xfer\n");)
 			return (-EREMOTEIO);
 		}
 #endif
     
-		DEB3(printk("i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
+		DEB3(printk(KERN_DEBUG "i2c-algo-pcf.o: Msg %d, addr=0x%x, flags=0x%x, len=%d\n",
 			    i, msgs[i].addr, msgs[i].flags, msgs[i].len);)
     
 		/* Read */
@@ -407,20 +405,20 @@
                                             (i + 1 == num));
         
 			if (ret != pmsg->len) {
-				DEB2(printk("i2c-algo-pcf.o: fail: "
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only read %d bytes.\n",ret));
 			} else {
-				DEB2(printk("i2c-algo-pcf.o: read %d bytes.\n",ret));
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: read %d bytes.\n",ret));
 			}
 		} else { /* Write */
 			ret = pcf_sendbytes(i2c_adap, pmsg->buf, pmsg->len,
                                             (i + 1 == num));
         
 			if (ret != pmsg->len) {
-				DEB2(printk("i2c-algo-pcf.o: fail: "
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: fail: "
 					    "only wrote %d bytes.\n",ret));
 			} else {
-				DEB2(printk("i2c-algo-pcf.o: wrote %d bytes.\n",ret));
+				DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: wrote %d bytes.\n",ret));
 			}
 		}
 	}
@@ -461,7 +459,7 @@
 	int i, status;
 	struct i2c_algo_pcf_data *pcf_adap = adap->algo_data;
 
-	DEB2(printk("i2c-algo-pcf.o: hw routines for %s registered.\n",
+	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: hw routines for %s registered.\n",
 	            adap->name));
 
 	/* register new adapter to i2c module... */
@@ -514,7 +512,7 @@
 	int res;
 	if ((res = i2c_del_adapter(adap)) < 0)
 		return res;
-	DEB2(printk("i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
+	DEB2(printk(KERN_DEBUG "i2c-algo-pcf.o: adapter unregistered: %s\n",adap->name));
 
 #ifdef MODULE
 	MOD_DEC_USE_COUNT;
@@ -524,7 +522,7 @@
 
 int __init i2c_algo_pcf_init (void)
 {
-	printk("i2c-algo-pcf.o: i2c pcf8584 algorithm module\n");
+	printk(KERN_INFO "i2c-algo-pcf.o: i2c pcf8584 algorithm module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return 0;
 }
 
--- linux/drivers/i2c/i2c-elektor.c.orig	2002-05-09 18:21:40.000000000 -0400
+++ linux/drivers/i2c/i2c-elektor.c	2002-05-24 20:34:34.000000000 -0400
@@ -74,11 +74,12 @@
 {
 	int address = ctl ? (base + 1) : base;
 
-	if (ctl && irq) {
+	/* enable irq if any specified for serial operation */
+	if (ctl && irq && (val & I2C_PCF_ESO)) {
 		val |= I2C_PCF_ENI;
 	}
 
-	DEB3(printk("i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
+	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Write 0x%X 0x%02X\n", address, val & 255));
 
 	switch (mmapped) {
 	case 0: /* regular I/O */
@@ -99,7 +100,7 @@
 	int address = ctl ? (base + 1) : base;
 	int val = mmapped ? readb(address) : inb(address);
 
-	DEB3(printk("i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
+	DEB3(printk(KERN_DEBUG "i2c-elektor.o: Read 0x%X 0x%02X\n", address, val));
 
 	return (val);
 }
@@ -142,7 +143,7 @@
 {
 	if (!mmapped) {
 		if (check_region(base, 2) < 0 ) {
-			printk("i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
+			printk(KERN_ERR "i2c-elektor.o: requested I/O region (0x%X:2) is in use.\n", base);
 			return -ENODEV;
 		} else {
 			request_region(base, 2, "i2c (isa bus adapter)");
@@ -150,7 +151,7 @@
 	}
 	if (irq > 0) {
 		if (request_irq(irq, pcf_isa_handler, 0, "PCF8584", 0) < 0) {
-			printk("i2c-elektor.o: Request irq%d failed\n", irq);
+			printk(KERN_ERR "i2c-elektor.o: Request irq%d failed\n", irq);
 			irq = 0;
 		} else
 			enable_irq(irq);
@@ -238,7 +239,7 @@
 			/* yeap, we've found cypress, let's check config */
 			if (!pci_read_config_byte(cy693_dev, 0x47, &config)) {
 				
-				DEB3(printk("i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
+				DEB3(printk(KERN_DEBUG "i2c-elektor.o: found cy82c693, config register 0x47 = 0x%02x.\n", config));
 
 				/* UP2000 board has this register set to 0xe1,
                                    but the most significant bit as seems can be 
@@ -260,7 +261,7 @@
 					   8.25 MHz (PCI/4) clock
 					   (this can be read from cypress) */
 					clock = I2C_PCF_CLK | I2C_PCF_TRNS90;
-					printk("i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
+					printk(KERN_INFO "i2c-elektor.o: found API UP2000 like board, will probe PCF8584 later.\n");
 				}
 			}
 		}
@@ -269,11 +270,11 @@
 
 	/* sanity checks for mmapped I/O */
 	if (mmapped && base < 0xc8000) {
-		printk("i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
+		printk(KERN_ERR "i2c-elektor.o: incorrect base address (0x%0X) specified for mmapped I/O.\n", base);
 		return -ENODEV;
 	}
 
-	printk("i2c-elektor.o: i2c pcf8584-isa adapter module\n");
+	printk(KERN_INFO "i2c-elektor.o: i2c pcf8584-isa adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	if (base == 0) {
 		base = DEFAULT_BASE;
@@ -283,13 +284,15 @@
 	init_waitqueue_head(&pcf_wait);
 #endif
 	if (pcf_isa_init() == 0) {
-		if (i2c_pcf_add_bus(&pcf_isa_ops) < 0)
+		if (i2c_pcf_add_bus(&pcf_isa_ops) < 0) {
+			pcf_isa_exit();
 			return -ENODEV;
+		}
 	} else {
 		return -ENODEV;
 	}
 	
-	printk("i2c-elektor.o: found device at %#x.\n", base);
+	printk(KERN_ERR "i2c-elektor.o: found device at %#x.\n", base);
 
 	return 0;
 }
--- linux/drivers/i2c/i2c-elv.c.orig	2002-05-09 18:25:30.000000000 -0400
+++ linux/drivers/i2c/i2c-elv.c	2002-05-14 18:01:25.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-elv.c,v 1.17 2001/07/29 02:44:25 mds Exp $ */
+/* $Id: i2c-elv.c,v 1.21 2001/11/19 18:45:02 mds Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -29,9 +29,7 @@
 #include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/init.h>
-
 #include <asm/uaccess.h>
-
 #include <linux/ioport.h>
 #include <asm/io.h>
 #include <linux/errno.h>
@@ -95,14 +93,14 @@
 	} else {
 						/* test for ELV adap. 	*/
 		if (inb(base+1) & 0x80) {	/* BUSY should be high	*/
-			DEBINIT(printk("i2c-elv.o: Busy was low.\n"));
+			DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Busy was low.\n"));
 			return -ENODEV;
 		} else {
 			outb(0x0c,base+2);	/* SLCT auf low		*/
 			udelay(400);
 			if ( !(inb(base+1) && 0x10) ) {
 				outb(0x04,base+2);
-				DEBINIT(printk("i2c-elv.o: Select was high.\n"));
+				DEBINIT(printk(KERN_DEBUG "i2c-elv.o: Select was high.\n"));
 				return -ENODEV;
 			}
 		}
@@ -170,7 +168,7 @@
 
 int __init i2c_bitelv_init(void)
 {
-	printk("i2c-elv.o: i2c ELV parallel port adapter module\n");
+	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
@@ -190,7 +188,7 @@
 			return -ENODEV;
 		}
 	}
-	printk("i2c-elv.o: found device at %#x.\n",base);
+	printk(KERN_DEBUG "i2c-elv.o: found device at %#x.\n",base);
 	return 0;
 }
 
--- linux/drivers/i2c/i2c-philips-par.c.orig	2002-05-09 18:21:56.000000000 -0400
+++ linux/drivers/i2c/i2c-philips-par.c	2002-05-14 18:02:15.000000000 -0400
@@ -21,7 +21,7 @@
 /* With some changes from Kyösti Mälkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-/* $Id: i2c-philips-par.c,v 1.18 2000/07/06 19:21:49 frodo Exp $ */
+/* $Id: i2c-philips-par.c,v 1.23 2002/02/06 08:50:58 simon Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/ioport.h>
@@ -29,7 +29,6 @@
 #include <linux/init.h>
 #include <linux/stddef.h>
 #include <linux/parport.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -190,18 +189,18 @@
 	struct i2c_par *adapter = kmalloc(sizeof(struct i2c_par),
 					  GFP_KERNEL);
 	if (!adapter) {
-		printk("i2c-philips-par: Unable to malloc.\n");
+		printk(KERN_ERR "i2c-philips-par: Unable to malloc.\n");
 		return;
 	}
 
-	printk("i2c-philips-par.o: attaching to %s\n", port->name);
+	printk(KERN_DEBUG "i2c-philips-par.o: attaching to %s\n", port->name);
 
 	adapter->pdev = parport_register_device(port, "i2c-philips-par",
 						NULL, NULL, NULL, 
 						PARPORT_FLAG_EXCL,
 						NULL);
 	if (!adapter->pdev) {
-		printk("i2c-philips-par: Unable to register with parport.\n");
+		printk(KERN_ERR "i2c-philips-par: Unable to register with parport.\n");
 		return;
 	}
 
@@ -210,15 +209,18 @@
 	adapter->bit_lp_data = type ? bit_lp_data2 : bit_lp_data;
 	adapter->bit_lp_data.data = port;
 
+	if (parport_claim_or_block(adapter->pdev) < 0 ) {
+		printk(KERN_ERR "i2c-philips-par: Could not claim parallel port.\n");
+		return;
+	}
 	/* reset hardware to sane state */
-	parport_claim_or_block(adapter->pdev);
 	bit_lp_setsda(port, 1);
 	bit_lp_setscl(port, 1);
 	parport_release(adapter->pdev);
 
 	if (i2c_bit_add_bus(&adapter->adapter) < 0)
 	{
-		printk("i2c-philips-par: Unable to register with I2C.\n");
+		printk(KERN_ERR "i2c-philips-par: Unable to register with I2C.\n");
 		parport_unregister_device(adapter->pdev);
 		kfree(adapter);
 		return;		/* No good */
@@ -264,7 +266,7 @@
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,4)
 	struct parport *port;
 #endif
-	printk("i2c-philips-par.o: i2c Philips parallel port adapter module\n");
+	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,4)
 	parport_register_driver(&i2c_driver);
--- linux/drivers/i2c/i2c-velleman.c.orig	2002-05-09 18:23:06.000000000 -0400
+++ linux/drivers/i2c/i2c-velleman.c	2002-05-14 18:04:11.000000000 -0400
@@ -18,7 +18,7 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-velleman.c,v 1.19 2000/01/24 02:06:33 mds Exp $ */
+/* $Id: i2c-velleman.c,v 1.23 2001/11/19 18:45:02 mds Exp $ */
 
 #include <linux/kernel.h>
 #include <linux/ioport.h>
@@ -27,7 +27,6 @@
 #include <linux/string.h>  /* for 2.0 kernels to get NULL   */
 #include <asm/errno.h>     /* for 2.0 kernels to get ENODEV */
 #include <asm/io.h>
-
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -91,7 +90,7 @@
 static int bit_velle_init(void)
 {
 	if (check_region(base,(base == 0x3bc)? 3 : 8) < 0 ) {
-		DEBE(printk("i2c-velleman.o: Port %#x already in use.\n",
+		DEBE(printk(KERN_DEBUG "i2c-velleman.o: Port %#x already in use.\n",
 		     base));
 		return -ENODEV;
 	} else {
@@ -160,7 +159,7 @@
 
 int __init  i2c_bitvelle_init(void)
 {
-	printk("i2c-velleman.o: i2c Velleman K8000 adapter module\n");
+	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
@@ -180,7 +179,7 @@
 			return -ENODEV;
 		}
 	}
-	printk("i2c-velleman.o: found device at %#x.\n",base);
+	printk(KERN_DEBUG "i2c-velleman.o: found device at %#x.\n",base);
 	return 0;
 }
 

--------------55A2ED23AE2F2685D5804F09--

