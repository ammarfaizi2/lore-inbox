Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSFKDHo>; Mon, 10 Jun 2002 23:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSFKDHn>; Mon, 10 Jun 2002 23:07:43 -0400
Received: from pD952A4ED.dip.t-dialin.net ([217.82.164.237]:31196 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316667AbSFKDHZ>; Mon, 10 Jun 2002 23:07:25 -0400
Date: Mon, 10 Jun 2002 21:07:17 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Double quote patches part one: drivers 1/2
Message-ID: <Pine.LNX.4.44.0206102101520.20111-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I spent my whole night correcting the double quotes. Someone pointed out 
yesterday that they had to be corrected. I did a checker script and am now 
running over the kernel.

This patch fixes broken double quotes in printk's and asm's.

Index: thunder-2.5/drivers/acorn/net/ether1.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/acorn/net/ether1.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/acorn/net/ether1.c	10 Jun 2002 15:14:57 -0000	1.1
+++ thunder-2.5/drivers/acorn/net/ether1.c	11 Jun 2002 01:48:58 -0000	1.2
@@ -153,37 +153,39 @@ ether1_writebuffer (struct net_device *d
 		length -= thislen;
 
 		__asm__ __volatile__(
-	"subs	%3, %3, #2
-	bmi	2f
-1:	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%1], #2
-	mov	%0, %0, lsl #16
-	orr	%0, %0, %0, lsr #16
-	str	%0, [%2], #4
-	subs	%3, %3, #2
-	bpl	1b
-2:	adds	%3, %3, #1
-	ldreqb	%0, [%1]
-	streqb	%0, [%2]"
-		: "=&r" (used), "=&r" (data)
-		: "r"  (addr), "r" (thislen), "1" (data));
+	" subs	%3, %3, #2          \n"
+	" bmi	2f                  \n"
+        "1:                         \n"
+	" ldr	%0, [%1], #2        \n"
+	" mov	%0, %0, lsl #16     \n"
+	" orr	%0, %0, %0, lsr #16 \n"
+	" str	%0, [%2], #4        \n"
+	" subs	%3, %3, #2          \n"
+	" bmi	2f                  \n"
+	" ldr	%0, [%1], #2        \n"
+	" mov	%0, %0, lsl #16     \n"
+	" orr	%0, %0, %0, lsr #16 \n"
+	" str	%0, [%2], #4        \n"
+	" subs	%3, %3, #2          \n"
+	" bmi	2f                  \n"
+	" ldr	%0, [%1], #2        \n"
+	" mov	%0, %0, lsl #16     \n"
+	" orr	%0, %0, %0, lsr #16 \n"
+	" str	%0, [%2], #4        \n"
+	" subs	%3, %3, #2          \n"
+	" bmi	2f                  \n"
+	" ldr	%0, [%1], #2        \n"
+	" mov	%0, %0, lsl #16     \n"
+	" orr	%0, %0, %0, lsr #16 \n"
+	" str	%0, [%2], #4        \n"
+	" subs	%3, %3, #2          \n"
+	" bpl	1b                  \n"
+	"2:                         \n"
+	" adds	%3, %3, #1          \n"
+	" ldreqb %0, [%1]           \n"
+	" streqb %0, [%2]           \n"
+	: "=&r" (used), "=&r" (data)
+	: "r"  (addr), "r" (thislen), "1" (data));
 
 		addr = ioaddr(ETHER1_RAM);
 
@@ -215,35 +217,37 @@ ether1_readbuffer (struct net_device *de
 		length -= thislen;
 
 		__asm__ __volatile__(
-	"subs	%3, %3, #2
-	bmi	2f
-1:	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bmi	2f
-	ldr	%0, [%2], #4
-	strb	%0, [%1], #1
-	mov	%0, %0, lsr #8
-	strb	%0, [%1], #1
-	subs	%3, %3, #2
-	bpl	1b
-2:	adds	%3, %3, #1
-	ldreqb	%0, [%2]
-	streqb	%0, [%1]"
+	" subs	%3, %3, #2      \n"
+	" bmi	2f              \n"
+        "1:                     \n"
+	" ldr	%0, [%2], #4    \n"
+	" strb	%0, [%1], #1    \n"
+	" mov	%0, %0, lsr #8  \n"
+	" strb	%0, [%1], #1    \n"
+	" subs	%3, %3, #2      \n"
+	" bmi	2f              \n"
+	" ldr	%0, [%2], #4    \n"
+	" strb	%0, [%1], #1    \n"
+	" mov	%0, %0, lsr #8  \n"
+	" strb	%0, [%1], #1    \n"
+	" subs	%3, %3, #2      \n"
+	" bmi	2f              \n"
+	" ldr	%0, [%2], #4    \n"
+	" strb	%0, [%1], #1    \n"
+	" mov	%0, %0, lsr #8  \n"
+	" strb	%0, [%1], #1    \n"
+	" subs	%3, %3, #2      \n"
+	" bmi	2f              \n"
+	" ldr	%0, [%2], #4    \n"
+	" strb	%0, [%1], #1    \n"
+	" mov	%0, %0, lsr #8  \n"
+	" strb	%0, [%1], #1    \n"
+	" subs	%3, %3, #2      \n"
+	" bpl	1b              \n"
+	"2:	                \n"
+	" adds	%3, %3, #1      \n"
+	" ldreqb	%0, [%2]\n"
+	" streqb	%0, [%1]"
 		: "=&r" (used), "=&r" (data)
 		: "r"  (addr), "r" (thislen), "1" (data));
 
Index: thunder-2.5/drivers/atm/iphase.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/atm/iphase.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/atm/iphase.c	10 Jun 2002 15:17:03 -0000	1.1
+++ thunder-2.5/drivers/atm/iphase.c	11 Jun 2002 01:54:21 -0000	1.2
@@ -207,8 +207,8 @@ static u16 get_desc (IADEV *dev, struct 
         ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
         delta = jiffies - dev->desc_tbl[i].timestamp;
         if (delta >= ltimeout) {
-           IF_ABR(printk("RECOVER run!! desc_tbl %d = %d  delta = %ld, 
-               time = %ld\n", i,dev->desc_tbl[i].timestamp, delta, jiffies);)
+           IF_ABR(printk("RECOVER run!! desc_tbl %d = %d  delta = %ld,\n"
+               "time = %ld\n", i,dev->desc_tbl[i].timestamp, delta, jiffies);)
            if (dev->ffL.tcq_rd == dev->ffL.tcq_st) 
               dev->ffL.tcq_rd =  dev->ffL.tcq_ed;
            else 
Index: thunder-2.5/drivers/atm/lanai.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/atm/lanai.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/atm/lanai.c	10 Jun 2002 15:17:01 -0000	1.1
+++ thunder-2.5/drivers/atm/lanai.c	11 Jun 2002 01:57:20 -0000	1.2
@@ -2108,8 +2108,8 @@ static inline int __init lanai_pci_start
 	}
 	result = pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &w);
 	if (result != PCIBIOS_SUCCESSFUL) {
-		printk(KERN_ERR DEV_LABEL "(itf %d): can't read ""
-		    PCI_SUBSYSTEM_ID: %d\n", lanai->number, result);
+		printk(KERN_ERR DEV_LABEL "(itf %d): can't read "
+		    "PCI_SUBSYSTEM_ID: %d\n", lanai->number, result);
 		return -EINVAL;
 	}
 	if ((result = check_board_id_and_rev("PCI", w, NULL)) != 0)
Index: thunder-2.5/drivers/char/cyclades.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/char/cyclades.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/char/cyclades.c	10 Jun 2002 15:14:19 -0000	1.1
+++ thunder-2.5/drivers/char/cyclades.c	11 Jun 2002 02:06:58 -0000	1.2
@@ -3449,8 +3452,8 @@ set_line_char(struct cyclades_port * inf
 		}
 #ifdef CY_DEBUG_DTR
 		printk("cyc:set_line_char dropping DTR\n");
-		printk("     status: 0x%x,
-		    0x%x\n", cy_readb(base_addr+(CyMSVR1<<index)),
+		printk("     status: 0x%x,"
+		    "0x%x\n", cy_readb(base_addr+(CyMSVR1<<index)),
 		    cy_readb(base_addr+(CyMSVR2<<index)));
 #endif
 	    }else{
Index: thunder-2.5/drivers/char/h8.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/char/h8.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/char/h8.c	10 Jun 2002 15:14:21 -0000	1.1
+++ thunder-2.5/drivers/char/h8.c	11 Jun 2002 02:13:56 -0000	1.2
@@ -577,8 +577,8 @@ h8_read_event_status(void)
         }
 
         if (intrbuf.word & H8_POWER_BUTTON) {
-                printk(KERN_CRIT "Power switch pressed - please wait - preparing to power 
-off\n");
+                printk(KERN_CRIT "Power switch pressed - please wait -"
+		       " preparing to power off\n");
                 h8_set_event_mask(H8_POWER_BUTTON);
                 wake_up(&h8_monitor_wait);
         }
Index: thunder-2.5/drivers/char/rio/riocmd.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/char/rio/riocmd.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/char/rio/riocmd.c	10 Jun 2002 15:14:32 -0000	1.1
+++ thunder-2.5/drivers/char/rio/riocmd.c	11 Jun 2002 02:19:05 -0000	1.2
@@ -462,8 +462,8 @@ PKT *PacketP; 
 		rio_dprintk (RIO_DEBUG_CMD, "PACKET information: Length	  0x%x (%d)\n", PacketP->len,PacketP->len );
 		rio_dprintk (RIO_DEBUG_CMD, "PACKET information: Control	 0x%x (%d)\n", PacketP->control, PacketP->control);
 		rio_dprintk (RIO_DEBUG_CMD, "PACKET information: Check	   0x%x (%d)\n", PacketP->csum, PacketP->csum );
-		rio_dprintk (RIO_DEBUG_CMD, "COMMAND information: Host Port Number 0x%x, 
-					Command Code 0x%x\n", PktCmdP->PhbNum, PktCmdP->Command );
+		rio_dprintk (RIO_DEBUG_CMD, "COMMAND information: Host Port Number 0x%x,\n"
+					"Command Code 0x%x\n", PktCmdP->PhbNum, PktCmdP->Command );
 		return TRUE;
 	}
 
Index: thunder-2.5/drivers/i2c/busses/i2c-ali1535.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/i2c/busses/i2c-ali1535.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/i2c/busses/i2c-ali1535.c	10 Jun 2002 17:19:32 -0000	1.1
+++ thunder-2.5/drivers/i2c/busses/i2c-ali1535.c	11 Jun 2002 02:20:58 -0000	1.2
@@ -669,8 +669,8 @@ EXPORT_NO_SYMBOLS;
 #ifdef MODULE
 
 MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>,
-      Mark D. Studebaker <mdsxyz123@yahoo.com> and Dan Eaton <dan.eaton@rocketlogix.com>");
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>,\n"
+      "Mark D. Studebaker <mdsxyz123@yahoo.com> and Dan Eaton <dan.eaton@rocketlogix.com>");
 MODULE_DESCRIPTION("ALI1535 SMBus driver");
 
 int init_module(void)
Index: thunder-2.5/drivers/ide/ide-pmac.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/ide/ide-pmac.c,v
retrieving revision 1.2
retrieving revision 1.3
diff -u -3 -p -r1.2 -r1.3
--- thunder-2.5/drivers/ide/ide-pmac.c	10 Jun 2002 17:14:22 -0000	1.2
+++ thunder-2.5/drivers/ide/ide-pmac.c	11 Jun 2002 02:30:17 -0000	1.3
@@ -1492,15 +1492,15 @@ static int pmac_udma_irq_status(struct a
 	if (!(in_le32(&dma->status) & ACTIVE))
 		return 1;
 	if (!drive->waiting_for_dma)
-		printk(KERN_WARNING "ide%d, ide_dma_test_irq \
-				called while not waiting\n", ix);
+		printk(KERN_WARNING "ide%d, ide_dma_test_irq "
+				"called while not waiting\n", ix);
 
 	/* If dbdma didn't execute the STOP command yet, the
 	 * active bit is still set */
 	drive->waiting_for_dma++;
 	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
-		printk(KERN_WARNING "ide%d, timeout waiting \
-				for dbdma command stop\n", ix);
+		printk(KERN_WARNING "ide%d, timeout waiting "
+				"for dbdma command stop\n", ix);
 		return 1;
 	}
 	udelay(1);
Index: thunder-2.5/drivers/i2c/chips/lm87.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/i2c/chips/lm87.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/i2c/chips/lm87.c	10 Jun 2002 17:19:34 -0000	1.1
+++ thunder-2.5/drivers/i2c/chips/lm87.c	11 Jun 2002 02:32:09 -0000	1.2
@@ -1059,10 +1059,10 @@ MODULE_LICENSE("GPL");
 #endif
 
 MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl>,
-      Philip Edelbrock <phil@netroedge.com>, 
-      Mark Studebaker <mdsxyz123@yahoo.com>,
-      and Stephen Rousset <stephen.rousset@rocketlogix.com>");
+    ("Frodo Looijaard <frodol@dds.nl>, "
+     "Philip Edelbrock <phil@netroedge.com>, "
+     "Mark Studebaker <mdsxyz123@yahoo.com>, "
+     "and Stephen Rousset <stephen.rousset@rocketlogix.com>");
 
 MODULE_DESCRIPTION("LM87 driver");
 
Index: thunder-2.5/drivers/ieee1394/dv1394.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/ieee1394/dv1394.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/ieee1394/dv1394.c	10 Jun 2002 15:17:16 -0000	1.1
+++ thunder-2.5/drivers/ieee1394/dv1394.c	11 Jun 2002 02:34:07 -0000	1.2
@@ -2148,12 +2148,7 @@ static int dv1394_procfs_read( char *pag
 	struct video_card *video = (struct video_card*) data;
 
 	snprintf( page, count, 
-		"\
-format=%s\n\
-channel=%d\n\
-cip_n=%lu\n\
-cip_d=%lu\n\
-syt_offset=%u\n",
+		"format=%s\nchannel=%d\ncip_n=%lu\ncip_d=%lu\nsyt_offset=%u\n",
 		(video->pal_or_ntsc == DV1394_NTSC ? "NTSC" : "PAL"),
 		video->channel,
 		video->cip_n, video->cip_d, video->syt_offset );
Index: thunder-2.5/drivers/media/video/c-qcam.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/media/video/c-qcam.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/media/video/c-qcam.c	10 Jun 2002 15:13:48 -0000	1.1
+++ thunder-2.5/drivers/media/video/c-qcam.c	11 Jun 2002 02:36:42 -0000	1.2
@@ -846,9 +846,9 @@ MODULE_AUTHOR("Philip Blundell <philb@gn
 MODULE_DESCRIPTION(BANNER);
 MODULE_LICENSE("GPL");
 
-MODULE_PARM_DESC(parport ,"parport=<auto|n[,n]...> for port detection method\n\
-probe=<0|1|2> for camera detection method\n\
-force_rgb=<0|1> for RGB data format (default BGR)");
+MODULE_PARM_DESC(parport ,"parport=<auto|n[,n]...> for port detection method\n"
+		          "probe=<0|1|2> for camera detection method\n"
+                          "force_rgb=<0|1> for RGB data format (default BGR)");
 MODULE_PARM(parport, "1-" __MODULE_STRING(MAX_CAMS) "i");
 MODULE_PARM(probe, "i");
 MODULE_PARM(force_rgb, "i");
Index: thunder-2.5/drivers/media/video/w9966.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/media/video/w9966.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/media/video/w9966.c	10 Jun 2002 15:13:46 -0000	1.1
+++ thunder-2.5/drivers/media/video/w9966.c	11 Jun 2002 02:38:43 -0000	1.2
@@ -128,10 +128,10 @@ static const char* pardev[] = {[0 ... W9
 static const char* pardev[] = {[0 ... W9966_MAXCAMS] = "aggressive"};
 #endif
 MODULE_PARM(pardev, "1-" __MODULE_STRING(W9966_MAXCAMS) "s");
-MODULE_PARM_DESC(pardev, "pardev: where to search for\n\
-\teach camera. 'aggressive' means brute-force search.\n\
-\tEg: >pardev=parport3,aggressive,parport2,parport1< would assign
-\tcam 1 to parport3 and search every parport for cam 2 etc...");
+MODULE_PARM_DESC(pardev, "pardev: where to search for\n"
+		 "\teach camera. 'aggressive' means brute-force search.\n"
+		 "\tEg: >pardev=parport3,aggressive,parport2,parport1< would assign\n"
+		 "\tcam 1 to parport3 and search every parport for cam 2 etc...");
 
 static int parmode = 0;
 MODULE_PARM(parmode, "i");
Index: thunder-2.5/drivers/net/am79c961a.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/am79c961a.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/net/am79c961a.c	10 Jun 2002 15:12:57 -0000	1.1
+++ thunder-2.5/drivers/net/am79c961a.c	11 Jun 2002 02:44:52 -0000	1.2
@@ -54,25 +54,25 @@ static const char version[] =
 #ifdef __arm__
 static void write_rreg(u_long base, u_int reg, u_int val)
 {
-	__asm__("str%?h	%1, [%2]	@ NET_RAP
-		str%?h	%0, [%2, #-4]	@ NET_RDP
-		" : : "r" (val), "r" (reg), "r" (ISAIO_BASE + 0x0464));
+	__asm__("str%?h	%1, [%2]	@ NET_RAP\n"
+		"str%?h	%0, [%2, #-4]	@ NET_RDP"
+		: : "r" (val), "r" (reg), "r" (ISAIO_BASE + 0x0464));
 }
 
 static inline unsigned short read_rreg(u_long base_addr, u_int reg)
 {
 	unsigned short v;
-	__asm__("str%?h	%1, [%2]	@ NET_RAP
-		ldr%?h	%0, [%2, #-4]	@ NET_RDP
-		" : "=r" (v): "r" (reg), "r" (ISAIO_BASE + 0x0464));
+	__asm__("str%?h	%1, [%2]	@ NET_RAP\n"
+		"ldr%?h	%0, [%2, #-4]	@ NET_RDP"
+		: "=r" (v): "r" (reg), "r" (ISAIO_BASE + 0x0464));
 	return v;
 }
 
 static inline void write_ireg(u_long base, u_int reg, u_int val)
 {
-	__asm__("str%?h	%1, [%2]	@ NET_RAP
-		str%?h	%0, [%2, #8]	@ NET_IDP
-		" : : "r" (val), "r" (reg), "r" (ISAIO_BASE + 0x0464));
+	__asm__("str%?h	%1, [%2]	@ NET_RAP\n"
+		"str%?h	%0, [%2, #8]	@ NET_IDP"
+		: : "r" (val), "r" (reg), "r" (ISAIO_BASE + 0x0464));
 }
 
 #define am_writeword(dev,off,val) __raw_writew(val, ISAMEM_BASE + ((off) << 1))
@@ -91,16 +91,16 @@ am_writebuffer(struct net_device *dev, u
 	}
 	while (length > 8) {
 		unsigned int tmp, tmp2;
-		__asm__ __volatile__("
-			ldm%?ia	%1!, {%2, %3}
-			str%?h	%2, [%0], #4
-			mov%?	%2, %2, lsr #16
-			str%?h	%2, [%0], #4
-			str%?h	%3, [%0], #4
-			mov%?	%3, %3, lsr #16
-			str%?h	%3, [%0], #4
-		" : "=&r" (offset), "=&r" (buf), "=r" (tmp), "=r" (tmp2)
-		  : "0" (offset), "1" (buf));
+		__asm__ __volatile__(
+			"ldm%?ia	%1!, {%2, %3}\n"
+			"str%?h	%2, [%0], #4         \n"
+			"mov%?	%2, %2, lsr #16      \n"
+			"str%?h	%2, [%0], #4         \n"
+			"str%?h	%3, [%0], #4         \n"
+			"mov%?	%3, %3, lsr #16      \n"
+			"str%?h	%3, [%0], #4"
+		: "=&r" (offset), "=&r" (buf), "=r" (tmp), "=r" (tmp2)
+		: "0" (offset), "1" (buf));
 		length -= 8;
 	}
 	while (length > 0) {
@@ -118,36 +118,36 @@ am_readbuffer(struct net_device *dev, u_
 	length = (length + 1) & ~1;
 	if ((int)buf & 2) {
 		unsigned int tmp;
-		__asm__ __volatile__("
-			ldr%?h	%2, [%0], #4
-			str%?b	%2, [%1], #1
-			mov%?	%2, %2, lsr #8
-			str%?b	%2, [%1], #1
-		" : "=&r" (offset), "=&r" (buf), "=r" (tmp): "0" (offset), "1" (buf));
+		__asm__ __volatile__(
+			"ldr%?h	%2, [%0], #4  \n"
+			"str%?b	%2, [%1], #1  \n"
+			"mov%?	%2, %2, lsr #8\n"
+			"str%?b	%2, [%1], #1"
+		: "=&r" (offset), "=&r" (buf), "=r" (tmp): "0" (offset), "1" (buf));
 		length -= 2;
 	}
 	while (length > 8) {
 		unsigned int tmp, tmp2, tmp3;
-		__asm__ __volatile__("
-			ldr%?h	%2, [%0], #4
-			ldr%?h	%3, [%0], #4
-			orr%?	%2, %2, %3, lsl #16
-			ldr%?h	%3, [%0], #4
-			ldr%?h	%4, [%0], #4
-			orr%?	%3, %3, %4, lsl #16
-			stm%?ia	%1!, {%2, %3}
-		" : "=&r" (offset), "=&r" (buf), "=r" (tmp), "=r" (tmp2), "=r" (tmp3)
+		__asm__ __volatile__(
+			"ldr%?h	%2, [%0], #4       \n"
+			"ldr%?h	%3, [%0], #4       \n"
+			"orr%?	%2, %2, %3, lsl #16\n"
+			"ldr%?h	%3, [%0], #4       \n"
+			"ldr%?h	%4, [%0], #4       \n"
+			"orr%?	%3, %3, %4, lsl #16\n"
+			"stm%?ia	%1!, {%2, %3}"
+		: "=&r" (offset), "=&r" (buf), "=r" (tmp), "=r" (tmp2), "=r" (tmp3)
 		  : "0" (offset), "1" (buf));
 		length -= 8;
 	}
 	while (length > 0) {
 		unsigned int tmp;
-		__asm__ __volatile__("
-			ldr%?h	%2, [%0], #4
-			str%?b	%2, [%1], #1
-			mov%?	%2, %2, lsr #8
-			str%?b	%2, [%1], #1
-		" : "=&r" (offset), "=&r" (buf), "=r" (tmp) : "0" (offset), "1" (buf));
+		__asm__ __volatile__(
+			"ldr%?h	%2, [%0], #4  \n"
+			"str%?b	%2, [%1], #1  \n"
+			"mov%?	%2, %2, lsr #8\n"
+			"str%?b	%2, [%1], #1"
+		: "=&r" (offset), "=&r" (buf), "=r" (tmp) : "0" (offset), "1" (buf));
 		length -= 2;
 	}
 }
Index: thunder-2.5/drivers/net/depca.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/depca.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/net/depca.c	10 Jun 2002 15:12:49 -0000	1.1
+++ thunder-2.5/drivers/net/depca.c	11 Jun 2002 02:47:27 -0000	1.2
@@ -1373,8 +1373,8 @@ mca_probe(struct net_device *dev, u_long
 		** If the MCA configuration says the card should be here,
 		** it really should be here.
 		*/
-		printk(KERN_ERR "%s: MCA reports card at 0x%lx but it is not
-responding.\n", dev->name, iobase);
+		printk(KERN_ERR "%s: MCA reports card at 0x%lx but it is not "
+		                "responding.\n", dev->name, iobase);
 	    }
        
 	    if (check_region(iobase, DEPCA_TOTAL_SIZE) == 0) {
Index: thunder-2.5/drivers/net/pcmcia/fmvj18x_cs.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/pcmcia/fmvj18x_cs.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/net/pcmcia/fmvj18x_cs.c	10 Jun 2002 15:13:19 -0000	1.1
+++ thunder-2.5/drivers/net/pcmcia/fmvj18x_cs.c	11 Jun 2002 02:49:12 -0000	1.2
@@ -571,8 +571,8 @@ req_irq:
     case XXX10304:
 	/* Read MACID from Buggy CIS */
 	if (fmvj18x_get_hwinfo(link, tuple.TupleData) == -1) {
-	    printk(KERN_NOTICE "fmvj18x_cs: unable to read hardware net 
-		address.");
+	    printk(KERN_NOTICE "fmvj18x_cs: unable to read hardware net "
+		               "address.");
 	    unregister_netdev(dev);
 	    goto failed;
 	}
Index: thunder-2.5/drivers/net/wan/sdla_chdlc.c
===================================================================
RCS file: /var/cvs/thunder-2.5/drivers/net/wan/sdla_chdlc.c,v
retrieving revision 1.1
retrieving revision 1.2
diff -u -3 -p -r1.1 -r1.2
--- thunder-2.5/drivers/net/wan/sdla_chdlc.c	10 Jun 2002 15:13:29 -0000	1.1
+++ thunder-2.5/drivers/net/wan/sdla_chdlc.c	11 Jun 2002 02:52:32 -0000	1.2
@@ -591,8 +591,8 @@ int wpc_init (sdla_t* card, wandev_conf_
 	
 
 		if (chdlc_set_intr_mode(card, APP_INT_ON_TIMER)){
-			printk (KERN_INFO "%s: 
-				Failed to set interrupt triggers!\n",
+			printk (KERN_INFO "%s: "
+				"Failed to set interrupt triggers!\n",
 				card->devname);
 			return -EIO;	
         	}
@@ -3426,20 +3426,20 @@ static int udp_pkt_type(struct sk_buff *
 	 chdlc_udp_pkt_t *chdlc_udp_pkt = (chdlc_udp_pkt_t *)skb->data;
 
 #ifdef _WAN_UDP_DEBUG
-		printk(KERN_INFO "SIG %s = %s\n\
-				  UPP %x = %x\n\
-				  PRT %x = %x\n\
-				  REQ %i = %i\n\
-				  36 th = %x 37th = %x\n",
-				  chdlc_udp_pkt->wp_mgmt.signature,
-				  UDPMGMT_SIGNATURE,
-				  chdlc_udp_pkt->udp_pkt.udp_dst_port,
-				  ntohs(card->wandev.udp_port),
-				  chdlc_udp_pkt->ip_pkt.protocol,
-				  UDPMGMT_UDP_PROTOCOL,
-				  chdlc_udp_pkt->wp_mgmt.request_reply,
-				  UDPMGMT_REQUEST,
-				  skb->data[36], skb->data[37]);
+		printk(KERN_INFO "SIG %s = %s\n"
+				 "UPP %x = %x\n"
+				 "PRT %x = %x\n"
+				 "REQ %i = %i\n"
+				 "36 th = %x 37th = %x\n",
+				 chdlc_udp_pkt->wp_mgmt.signature,
+				 UDPMGMT_SIGNATURE,
+				 chdlc_udp_pkt->udp_pkt.udp_dst_port,
+				 ntohs(card->wandev.udp_port),
+				 chdlc_udp_pkt->ip_pkt.protocol,
+				 UDPMGMT_UDP_PROTOCOL,
+				 chdlc_udp_pkt->wp_mgmt.request_reply,
+				 UDPMGMT_REQUEST,
+				 skb->data[36], skb->data[37]);
 #endif	
 		
 	if (!strncmp(chdlc_udp_pkt->wp_mgmt.signature,UDPMGMT_SIGNATURE,8) &&

---
Lighweight patch manager using Pine. If you have any objections, tell me.

