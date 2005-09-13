Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVIMQyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVIMQyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbVIMQyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:54:03 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:56968 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964888AbVIMQxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:53:22 -0400
Date: Tue, 13 Sep 2005 18:52:56 +0200
Message-Id: <200509131652.j8DGquiA022106@localhost.localdomain>
In-reply-to: <200509131649.j8DGnNnw021871@localhost.localdomain>
Subject: [PATCH 1/5] isicom: whitespace
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 isicom.c | 1303 +++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 651 insertions(+), 652 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -20,7 +20,7 @@
  *	3/9/99	sameer			Added support for ISI4616 cards.
  *
  *	16/9/99	sameer			We do not force RTS low anymore.
- *					This is to prevent the firmware 
+ *					This is to prevent the firmware
  *					from getting confused.
  *
  *	26/10/99 sameer			Cosmetic changes:The driver now
@@ -31,28 +31,28 @@
  *
  *	10/5/00  sameer			Fixed isicom_shutdown_board()
  *					to not lower DTR on all the ports
- *					when the last port on the card is 
+ *					when the last port on the card is
  *					closed.
  *
  *	10/5/00  sameer			Signal mask setup command added
- *					to  isicom_setup_port and 
+ *					to  isicom_setup_port and
  *					isicom_shutdown_port.
  *
  *	24/5/00  sameer			The driver is now SMP aware.
- *					
- *	
+ *
+ *
  *	27/11/00 Vinayak P Risbud	Fixed the Driver Crash Problem
- *	
- *	
+ *
+ *
  *	03/01/01  anil .s		Added support for resetting the
  *					internal modems on ISI cards.
  *
  *	08/02/01  anil .s		Upgraded the driver for kernel
  *					2.4.x
  *
- *      11/04/01  Kevin			Fixed firmware load problem with
+ *	11/04/01  Kevin			Fixed firmware load problem with
  *					ISIHP-4X card
- *	
+ *
  *	30/04/01  anil .s		Fixed the remote login through
  *					ISI port problem. Now the link
  *					does not go down before password
@@ -62,9 +62,9 @@
  *					among ISI-PCI cards.
  *
  *	03/05/01  anil .s		Added support to display the version
- *					info during insmod as well as module 
+ *					info during insmod as well as module
  *					listing by lsmod.
- *	
+ *
  *	10/05/01  anil .s		Done the modifications to the source
  *					file and Install script so that the
  *					same installation can be used for
@@ -73,19 +73,19 @@
  *	06/06/01  anil .s		Now we drop both dtr and rts during
  *					shutdown_port as well as raise them
  *					during isicom_config_port.
- *  	
+ *
  *	09/06/01 acme@conectiva.com.br	use capable, not suser, do
  *					restore_flags on failure in
  *					isicom_send_break, verify put_user
  *					result
  *
- *  	11/02/03  ranjeeth		Added support for 230 Kbps and 460 Kbps
- *  					Baud index extended to 21
- *  	
- *  	20/03/03  ranjeeth		Made to work for Linux Advanced server.
- *  					Taken care of license warning.	
- *      
- *	10/12/03  Ravindra		Made to work for Fedora Core 1 of 
+ *	11/02/03  ranjeeth		Added support for 230 Kbps and 460 Kbps
+ *					Baud index extended to 21
+ *
+ *	20/03/03  ranjeeth		Made to work for Linux Advanced server.
+ *					Taken care of license warning.
+ *
+ *	10/12/03  Ravindra		Made to work for Fedora Core 1 of
  *					Red Hat Distribution
  *
  *	06/01/05  Alan Cox 		Merged the ISI and base kernel strands
@@ -93,10 +93,10 @@
  *
  *	***********************************************************
  *
- *	To use this driver you also need the support package. You 
+ *	To use this driver you also need the support package. You
  *	can find this in RPM format on
  *		ftp://ftp.linux.org.uk/pub/linux/alan
- * 	
+ *
  *	You can find the original tools for this direct from Multitech
  *		ftp://ftp.multitech.com/ISI-Cards/
  *
@@ -161,16 +161,15 @@ static unsigned long tx_count = 0;
 static int ISILoad_ioctl(struct inode *inode, struct file *filp, unsigned  int cmd, unsigned long arg);
 
 static void isicom_tx(unsigned long _data);
-static void isicom_start(struct tty_struct * tty);
+static void isicom_start(struct tty_struct *tty);
 
-static unsigned char * tmp_buf;
+static unsigned char *tmp_buf;
 static DECLARE_MUTEX(tmp_buf_sem);
 
 /*   baud index mappings from linux defns to isi */
 
 static signed char linuxb_to_isib[] = {
-	-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 16, 17,     
-	18, 19
+	-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 16, 17, 18, 19
 };
 
 struct	isi_board {
@@ -216,7 +215,7 @@ static struct isi_port  isi_ports[PORT_C
  *	the kernel lock for the card and have the card in a position that
  *	it wants to talk.
  */
- 
+
 static int lock_card(struct isi_board *card)
 {
 	char		retries;
@@ -225,7 +224,7 @@ static int lock_card(struct isi_board *c
 	for (retries = 0; retries < 100; retries++) {
 		spin_lock_irqsave(&card->card_lock, card->flags);
 		if (inw(base + 0xe) & 0x1) {
-			return 1; 
+			return 1;
 		} else {
 			spin_unlock_irqrestore(&card->card_lock, card->flags);
 			udelay(1000);   /* 1ms */
@@ -244,7 +243,7 @@ static int lock_card_at_interrupt(struct
 		spin_lock_irqsave(&card->card_lock, card->flags);
 
 		if (inw(base + 0xe) & 0x1)
-			return 1; 
+			return 1;
 		else
 			spin_unlock_irqrestore(&card->card_lock, card->flags);
 	}
@@ -260,119 +259,119 @@ static void unlock_card(struct isi_board
 /*
  *  ISI Card specific ops ...
  */
- 
-static void raise_dtr(struct isi_port * port)
+
+static void raise_dtr(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0504, base);
 	InterruptTheCard(base);
 	port->status |= ISI_DTR;
 	unlock_card(card);
 }
 
-static inline void drop_dtr(struct isi_port * port)
-{	
-	struct isi_board * card = port->card;
+static inline void drop_dtr(struct isi_port *port)
+{
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0404, base);
-	InterruptTheCard(base);	
+	InterruptTheCard(base);
 	port->status &= ~ISI_DTR;
 	unlock_card(card);
 }
 
-static inline void raise_rts(struct isi_port * port)
+static inline void raise_rts(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0a04, base);
-	InterruptTheCard(base);	
+	InterruptTheCard(base);
 	port->status |= ISI_RTS;
 	unlock_card(card);
 }
-static inline void drop_rts(struct isi_port * port)
+static inline void drop_rts(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0804, base);
-	InterruptTheCard(base);	
+	InterruptTheCard(base);
 	port->status &= ~ISI_RTS;
 	unlock_card(card);
 }
 
-static inline void raise_dtr_rts(struct isi_port * port)
+static inline void raise_dtr_rts(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0f04, base);
 	InterruptTheCard(base);
 	port->status |= (ISI_DTR | ISI_RTS);
 	unlock_card(card);
 }
 
-static void drop_dtr_rts(struct isi_port * port)
+static void drop_dtr_rts(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw(0x0c04, base);
-	InterruptTheCard(base);	
+	InterruptTheCard(base);
 	port->status &= ~(ISI_RTS | ISI_DTR);
 	unlock_card(card);
 }
 
-static inline void kill_queue(struct isi_port * port, short queue)
+static inline void kill_queue(struct isi_port *port, short queue)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned short base = card->base;
 	unsigned char channel = port->channel;
 
 	if (!lock_card(card))
 		return;
 
-	outw(0x8000 | (channel << card->shift_count) | 0x02 , base);
+	outw(0x8000 | (channel << card->shift_count) | 0x02, base);
 	outw((queue << 8) | 0x06, base);
-	InterruptTheCard(base);	
+	InterruptTheCard(base);
 	unlock_card(card);
 }
 
 
-/* 
+/*
  *  Firmware loader driver specific routines. This needs to mostly die
  *  and be replaced with request_firmware.
  */
@@ -386,19 +385,19 @@ static struct miscdevice isiloader_devic
 	ISILOAD_MISC_MINOR, "isictl", &ISILoad_fops
 };
 
- 
+
 static inline int WaitTillCardIsFree(unsigned short base)
 {
 	unsigned long count=0;
 	while( (!(inw(base+0xe) & 0x1)) && (count++ < 6000000));
-	if (inw(base+0xe)&0x1)  
+	if (inw(base+0xe)&0x1)
 		return 0;
 	else
 		return 1;
 }
 
 static int ISILoad_ioctl(struct inode *inode, struct file *filp,
-		         unsigned int cmd, unsigned long arg)
+	unsigned int cmd, unsigned long arg)
 {
 	unsigned int card, i, j, signature, status, portcount = 0;
 	unsigned long t;
@@ -406,213 +405,211 @@ static int ISILoad_ioctl(struct inode *i
 	bin_frame frame;
 	void __user *argp = (void __user *)arg;
 	/* exec_record exec_rec; */
-	
+
 	if(get_user(card, (int __user *)argp))
 		return -EFAULT;
-		
+
 	if(card < 0 || card >= BOARD_COUNT)
 		return -ENXIO;
-		
+
 	base=isi_card[card].base;
-	
+
 	if(base==0)
 		return -ENXIO;	/* disabled or not used */
-	
+
 	switch(cmd) {
-		case MIOCTL_RESET_CARD:
-			if (!capable(CAP_SYS_ADMIN))
-				return -EPERM;
-			printk(KERN_DEBUG "ISILoad:Resetting Card%d at 0x%x ",card+1,base);
-								
-			inw(base+0x8);
-			
-			for(t=jiffies+HZ/100;time_before(jiffies, t););
-				
-			outw(0,base+0x8); /* Reset */
-			
-			for(j=1;j<=3;j++) {
-				for(t=jiffies+HZ;time_before(jiffies, t););
-				printk(".");
-			}	
-			signature=(inw(base+0x4)) & 0xff;	
-			if (isi_card[card].isa) {
-					
-				if (!(inw(base+0xe) & 0x1) || (inw(base+0x2))) {
-#ifdef ISICOM_DEBUG				
-					printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
-#endif				
-					printk("\nISILoad:ISA Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
-					return -EIO;					
-				}
-			}	
-			else {
-				portcount = inw(base+0x2);
-				if (!(inw(base+0xe) & 0x1) || ((portcount!=0) && (portcount!=4) && (portcount!=8))) {	
+	case MIOCTL_RESET_CARD:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		printk(KERN_DEBUG "ISILoad:Resetting Card%d at 0x%x ",card+1,base);
+
+		inw(base+0x8);
+
+		for(t=jiffies+HZ/100;time_before(jiffies, t););
+
+		outw(0,base+0x8); /* Reset */
+
+		for(j=1;j<=3;j++) {
+			for(t=jiffies+HZ;time_before(jiffies, t););
+			printk(".");
+		}
+		signature=(inw(base+0x4)) & 0xff;
+		if (isi_card[card].isa) {
+
+			if (!(inw(base+0xe) & 0x1) || (inw(base+0x2))) {
 #ifdef ISICOM_DEBUG
-					printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
+				printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
 #endif
-					printk("\nISILoad:PCI Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
-					return -EIO;
-				}
-			}	
-			switch(signature) {
-			case	0xa5:
-			case	0xbb:
-			case	0xdd:	
-					if (isi_card[card].isa) 
-						isi_card[card].port_count = 8;
-					else {
-						if (portcount == 4)
-							isi_card[card].port_count = 4;
-						else
-							isi_card[card].port_count = 8;
-					}	
-				     	isi_card[card].shift_count = 12;
-				     	break;
-				        
-			case	0xcc:	isi_card[card].port_count = 16;
-					isi_card[card].shift_count = 11;
-					break;  			
-					
-			default: printk("ISILoad:Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
-#ifdef ISICOM_DEBUG			
-				 printk("Sig=0x%x\n",signature);
-#endif				 
-				 return -EIO;
+				printk("\nISILoad:ISA Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
+				return -EIO;
+			}
+		}
+		else {
+			portcount = inw(base+0x2);
+			if (!(inw(base+0xe) & 0x1) || ((portcount!=0) && (portcount!=4) && (portcount!=8))) {
+#ifdef ISICOM_DEBUG
+				printk("\nbase+0x2=0x%x , base+0xe=0x%x",inw(base+0x2),inw(base+0xe));
+#endif
+				printk("\nISILoad:PCI Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
+				return -EIO;
 			}
-			printk("-Done\n");
-			return put_user(signature,(unsigned __user *)argp);
-						
+		}
+		switch(signature) {
+		case	0xa5:
+		case	0xbb:
+		case	0xdd:
+				if (isi_card[card].isa)
+					isi_card[card].port_count = 8;
+				else {
+					if (portcount == 4)
+						isi_card[card].port_count = 4;
+					else
+						isi_card[card].port_count = 8;
+				}
+				isi_card[card].shift_count = 12;
+				break;
+
+		case	0xcc:	isi_card[card].port_count = 16;
+				isi_card[card].shift_count = 11;
+				break;
+
+		default: printk("ISILoad:Card%d reset failure (Possible bad I/O Port Address 0x%x).\n",card+1,base);
+#ifdef ISICOM_DEBUG
+			printk("Sig=0x%x\n",signature);
+#endif
+			return -EIO;
+		}
+		printk("-Done\n");
+		return put_user(signature,(unsigned __user *)argp);
+
 	case	MIOCTL_LOAD_FIRMWARE:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-				
+
 			if(copy_from_user(&frame, argp, sizeof(bin_frame)))
 				return -EFAULT;
-			
+
 			if (WaitTillCardIsFree(base))
 				return -EIO;
-			
-			outw(0xf0,base);	/* start upload sequence */ 
+
+			outw(0xf0,base); /* start upload sequence */
 			outw(0x00,base);
-			outw((frame.addr), base);/*      lsb of adderess    */
-			
+			outw((frame.addr), base); /* lsb of adderess */
+
 			word_count=(frame.count >> 1) + frame.count % 2;
 			outw(word_count, base);
 			InterruptTheCard(base);
-			
+
 			for(i=0;i<=0x2f;i++);	/* a wee bit of delay */
-			
-			if (WaitTillCardIsFree(base)) 
+
+			if (WaitTillCardIsFree(base))
 				return -EIO;
-				
+
 			if ((status=inw(base+0x4))!=0) {
-				printk(KERN_WARNING "ISILoad:Card%d rejected load header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n", 
+				printk(KERN_WARNING "ISILoad:Card%d rejected load header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n",
 				card+1, frame.addr, frame.count, status);
 				return -EIO;
 			}
 			outsw(base, (void *) frame.bin_data, word_count);
-			
+
 			InterruptTheCard(base);
-			
-			for(i=0;i<=0x0f;i++);	/* another wee bit of delay */ 
-			
-			if (WaitTillCardIsFree(base)) 
+
+			for(i=0;i<=0x0f;i++);	/* another wee bit of delay */
+
+			if (WaitTillCardIsFree(base))
 				return -EIO;
-				
+
 			if ((status=inw(base+0x4))!=0) {
 				printk(KERN_ERR "ISILoad:Card%d got out of sync.Card Status:0x%x\n",card+1, status);
 				return -EIO;
-			}	
+			}
 			return 0;
-						
+
 	case	MIOCTL_READ_FIRMWARE:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-				
+
 			if(copy_from_user(&frame, argp, sizeof(bin_header)))
 				return -EFAULT;
-			
+
 			if (WaitTillCardIsFree(base))
 				return -EIO;
-			
-			outw(0xf1,base);	/* start download sequence */ 
+
+			outw(0xf1,base); /* start download sequence */
 			outw(0x00,base);
-			outw((frame.addr), base);/*      lsb of adderess    */
-			
+			outw((frame.addr), base); /* lsb of adderess */
+
 			word_count=(frame.count >> 1) + frame.count % 2;
 			outw(word_count+1, base);
 			InterruptTheCard(base);
-			
+
 			for(i=0;i<=0xf;i++);	/* a wee bit of delay */
-			
-			if (WaitTillCardIsFree(base)) 
+
+			if (WaitTillCardIsFree(base))
 				return -EIO;
-				
+
 			if ((status=inw(base+0x4))!=0) {
-				printk(KERN_WARNING "ISILoad:Card%d rejected verify header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n", 
+				printk(KERN_WARNING "ISILoad:Card%d rejected verify header:\nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n",
 				card+1, frame.addr, frame.count, status);
 				return -EIO;
 			}
-			
+
 			inw(base);
 			insw(base, frame.bin_data, word_count);
 			InterruptTheCard(base);
-			
-			for(i=0;i<=0x0f;i++);	/* another wee bit of delay */ 
-			
-			if (WaitTillCardIsFree(base)) 
+
+			for(i=0;i<=0x0f;i++);	/* another wee bit of delay */
+
+			if (WaitTillCardIsFree(base))
 				return -EIO;
-				
+
 			if ((status=inw(base+0x4))!=0) {
 				printk(KERN_ERR "ISILoad:Card%d verify got out of sync.Card Status:0x%x\n",card+1, status);
 				return -EIO;
-			}	
-			
+			}
+
 			if(copy_to_user(argp, &frame, sizeof(bin_frame)))
 				return -EFAULT;
 			return 0;
-	
+
 	case	MIOCTL_XFER_CTRL:
 			if (!capable(CAP_SYS_ADMIN))
 				return -EPERM;
-			if (WaitTillCardIsFree(base)) 
+			if (WaitTillCardIsFree(base))
 				return -EIO;
-					
+
 			outw(0xf2, base);
 			outw(0x800, base);
 			outw(0x0, base);
 			outw(0x0, base);
 			InterruptTheCard(base);
-			outw(0x0, base+0x4);    /* for ISI4608 cards */
-							
+			outw(0x0, base+0x4); /* for ISI4608 cards */
+
 			isi_card[card].status |= FIRMWARE_LOADED;
-			return 0;	
-			
+			return 0;
+
 	default:
-#ifdef ISICOM_DEBUG	
-		printk(KERN_DEBUG "ISILoad: Received Ioctl cmd 0x%x.\n", cmd); 
+#ifdef ISICOM_DEBUG
+		printk(KERN_DEBUG "ISILoad: Received Ioctl cmd 0x%x.\n", cmd);
 #endif
 		return -ENOIOCTLCMD;
-	
 	}
-	
 }
-		        	
+
 
 /*
  *	ISICOM Driver specific routines ...
  *
  */
- 
-static inline int isicom_paranoia_check(struct isi_port const * port, char *name, 
-					const char * routine)
+
+static inline int isicom_paranoia_check(struct isi_port const *port, char *name,
+	const char *routine)
 {
-#ifdef ISICOM_DEBUG 
-	static const char * badmagic = 
+#ifdef ISICOM_DEBUG
+	static const char *badmagic =
 			KERN_WARNING "ISICOM: Warning: bad isicom magic for dev %s in %s.\n";
-	static const char * badport = 
-			KERN_WARNING "ISICOM: Warning: NULL isicom port for dev %s in %s.\n";		
+	static const char *badport =
+			KERN_WARNING "ISICOM: Warning: NULL isicom port for dev %s in %s.\n";
 	if (!port) {
 		printk(badport, name, routine);
 		return 1;
@@ -620,13 +617,13 @@ static inline int isicom_paranoia_check(
 	if (port->magic != ISICOM_MAGIC) {
 		printk(badmagic, name, routine);
 		return 1;
-	}	
-#endif	
+	}
+#endif
 	return 0;
 }
-			
+
 /*
- *	Transmitter. 
+ *	Transmitter.
  *
  *	We shovel data into the card buffers on a regular basis. The card
  *	will do the rest of the work for us.
@@ -636,25 +633,25 @@ static void isicom_tx(unsigned long _dat
 {
 	short count = (BOARD_COUNT-1), card, base;
 	short txcount, wrd, residue, word_count, cnt;
-	struct isi_port * port;
-	struct tty_struct * tty;
-	
+	struct isi_port *port;
+	struct tty_struct *tty;
+
 #ifdef ISICOM_DEBUG
 	++tx_count;
-#endif	
-	
+#endif
+
 	/*	find next active board	*/
 	card = (prev_card + 1) & 0x0003;
 	while(count-- > 0) {
-		if (isi_card[card].status & BOARD_ACTIVE) 
+		if (isi_card[card].status & BOARD_ACTIVE)
 			break;
-		card = (card + 1) & 0x0003;	
+		card = (card + 1) & 0x0003;
 	}
 	if (!(isi_card[card].status & BOARD_ACTIVE))
 		goto sched_again;
-		
+
 	prev_card = card;
-	
+
 	count = isi_card[card].port_count;
 	port = isi_card[card].ports;
 	base = isi_card[card].base;
@@ -663,18 +660,18 @@ static void isicom_tx(unsigned long _dat
 			continue;
 		/* port not active or tx disabled to force flow control */
 		if (!(port->flags & ASYNC_INITIALIZED) ||
-		 	!(port->status & ISI_TXOK))
+				!(port->status & ISI_TXOK))
 			unlock_card(&isi_card[card]);
 			continue;
-		
+
 		tty = port->tty;
-		
-		
+
+
 		if(tty == NULL) {
 			unlock_card(&isi_card[card]);
 			continue;
 		}
-		
+
 		txcount = min_t(short, TX_SIZE, port->xmit_cnt);
 		if (txcount <= 0 || tty->stopped || tty->hw_stopped) {
 			unlock_card(&isi_card[card]);
@@ -682,16 +679,16 @@ static void isicom_tx(unsigned long _dat
 		}
 		if (!(inw(base + 0x02) & (1 << port->channel))) {
 			unlock_card(&isi_card[card]);
-			continue;		
+			continue;
 		}
 #ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n", 
-				txcount, port->channel+1); 
-#endif	
+		printk(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n",
+				txcount, port->channel+1);
+#endif
 		outw((port->channel << isi_card[card].shift_count) | txcount
 					, base);
 		residue = NO;
-		wrd = 0;			
+		wrd = 0;
 		while (1) {
 			cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE - port->xmit_tail));
 			if (residue == YES) {
@@ -702,13 +699,13 @@ static void isicom_tx(unsigned long _dat
 					port->xmit_cnt--;
 					txcount--;
 					cnt--;
-					outw(wrd, base);			
+					outw(wrd, base);
 				}
 				else {
 					outw(wrd, base);
 					break;
 				}
-			}		
+			}
 			if (cnt <= 0) break;
 			word_count = cnt >> 1;
 			outsw(base, port->xmit_buf+port->xmit_tail, word_count);
@@ -731,68 +728,68 @@ static void isicom_tx(unsigned long _dat
 		if (port->xmit_cnt <= WAKEUP_CHARS)
 			schedule_work(&port->bh_tqueue);
 		unlock_card(&isi_card[card]);
-	}	
+	}
 
-	/*	schedule another tx for hopefully in about 10ms	*/	
-sched_again:	
-	if (!re_schedule)	
+	/*	schedule another tx for hopefully in about 10ms	*/
+sched_again:
+	if (!re_schedule)
 		return;
 	init_timer(&tx);
 	tx.expires = jiffies + HZ/100;
 	tx.data = 0;
 	tx.function = isicom_tx;
 	add_timer(&tx);
-	
-	return;	
-}		
- 
+
+	return;
+}
+
 /* 	Interrupt handlers 	*/
 
- 
-static void isicom_bottomhalf(void * data)
+
+static void isicom_bottomhalf(void *data)
 {
-	struct isi_port * port = (struct isi_port *) data;
-	struct tty_struct * tty = port->tty;
-	
+	struct isi_port *port = (struct isi_port *) data;
+	struct tty_struct *tty = port->tty;
+
 	if (!tty)
 		return;
 
-	tty_wakeup(tty);	
+	tty_wakeup(tty);
 	wake_up_interruptible(&tty->write_wait);
-} 		
- 		
+}
+
 /*
- *	Main interrupt handler routine 
+ *	Main interrupt handler routine
  */
- 
+
 static irqreturn_t isicom_interrupt(int irq, void *dev_id,
 					struct pt_regs *regs)
 {
-	struct isi_board * card;
-	struct isi_port * port;
-	struct tty_struct * tty;
+	struct isi_board *card;
+	struct isi_port *port;
+	struct tty_struct *tty;
 	unsigned short base, header, word_count, count;
 	unsigned char channel;
 	short byte_count;
 	unsigned char *rp;
-	
+
 	card = (struct isi_board *) dev_id;
 
 	if (!card || !(card->status & FIRMWARE_LOADED))
 		return IRQ_NONE;
-	
+
 	base = card->base;
 	spin_lock(&card->card_lock);
-	
+
 	if (card->isa == NO) {
 		/*
-		 *      disable any interrupts from the PCI card and lower the
-		 *      interrupt line
+		 * disable any interrupts from the PCI card and lower the
+		 * interrupt line
 		 */
 		outw(0x8000, base+0x04);
 		ClearInterrupt(base);
 	}
-	
+
 	inw(base);		/* get the dummy word out */
 	header = inw(base);
 	channel = (header & 0x7800) >> card->shift_count;
@@ -804,9 +801,9 @@ static irqreturn_t isicom_interrupt(int 
 		if (card->isa)
 			ClearInterrupt(base);
 		else
-			outw(0x0000, base+0x04); /* enable interrupts */		
+			outw(0x0000, base+0x04); /* enable interrupts */
 		spin_unlock(&card->card_lock);
-		return IRQ_HANDLED;			
+		return IRQ_HANDLED;
 	}
 	port = card->ports + channel;
 	if (!(port->flags & ASYNC_INITIALIZED)) {
@@ -815,8 +812,8 @@ static irqreturn_t isicom_interrupt(int 
 		else
 			outw(0x0000, base+0x04); /* enable interrupts */
 		return IRQ_HANDLED;
-	}	
-		
+	}
+
 	tty = port->tty;
 	if (tty == NULL) {
 		word_count = byte_count >> 1;
@@ -833,107 +830,107 @@ static irqreturn_t isicom_interrupt(int 
 		spin_unlock(&card->card_lock);
 		return IRQ_HANDLED;
 	}
-	
+
 	if (header & 0x8000) {		/* Status Packet */
 		header = inw(base);
 		switch(header & 0xff) {
-			case 0:	/* Change in EIA signals */
-				
-				if (port->flags & ASYNC_CHECK_CD) {
-					if (port->status & ISI_DCD) {
-						if (!(header & ISI_DCD)) {
-						/* Carrier has been lost  */
-#ifdef ISICOM_DEBUG						
-							printk(KERN_DEBUG "ISICOM: interrupt: DCD->low.\n");
-#endif							
-							port->status &= ~ISI_DCD;
-							schedule_work(&port->hangup_tq);
-						}
-					}
-					else {
-						if (header & ISI_DCD) {
-						/* Carrier has been detected */
+		case 0:	/* Change in EIA signals */
+
+			if (port->flags & ASYNC_CHECK_CD) {
+				if (port->status & ISI_DCD) {
+					if (!(header & ISI_DCD)) {
+					/* Carrier has been lost  */
 #ifdef ISICOM_DEBUG
-							printk(KERN_DEBUG "ISICOM: interrupt: DCD->high.\n");
-#endif							
-							port->status |= ISI_DCD;
-							wake_up_interruptible(&port->open_wait);
-						}
+						printk(KERN_DEBUG "ISICOM: interrupt: DCD->low.\n");
+#endif
+						port->status &= ~ISI_DCD;
+						schedule_work(&port->hangup_tq);
 					}
 				}
 				else {
-					if (header & ISI_DCD) 
+					if (header & ISI_DCD) {
+					/* Carrier has been detected */
+#ifdef ISICOM_DEBUG
+						printk(KERN_DEBUG "ISICOM: interrupt: DCD->high.\n");
+#endif
 						port->status |= ISI_DCD;
-					else
-						port->status &= ~ISI_DCD;
-				}	
-				
-				if (port->flags & ASYNC_CTS_FLOW) {
-					if (port->tty->hw_stopped) {
-						if (header & ISI_CTS) {
-							port->tty->hw_stopped = 0;
-							/* start tx ing */
-							port->status |= (ISI_TXOK | ISI_CTS);
-							schedule_work(&port->bh_tqueue);
-						}
+						wake_up_interruptible(&port->open_wait);
 					}
-					else {
-						if (!(header & ISI_CTS)) {
-							port->tty->hw_stopped = 1;
-							/* stop tx ing */
-							port->status &= ~(ISI_TXOK | ISI_CTS);
-						}
+				}
+			}
+			else {
+				if (header & ISI_DCD)
+					port->status |= ISI_DCD;
+				else
+					port->status &= ~ISI_DCD;
+			}
+
+			if (port->flags & ASYNC_CTS_FLOW) {
+				if (port->tty->hw_stopped) {
+					if (header & ISI_CTS) {
+						port->tty->hw_stopped = 0;
+						/* start tx ing */
+						port->status |= (ISI_TXOK | ISI_CTS);
+						schedule_work(&port->bh_tqueue);
 					}
 				}
 				else {
-					if (header & ISI_CTS) 
-						port->status |= ISI_CTS;
-					else
-						port->status &= ~ISI_CTS;
+					if (!(header & ISI_CTS)) {
+						port->tty->hw_stopped = 1;
+						/* stop tx ing */
+						port->status &= ~(ISI_TXOK | ISI_CTS);
+					}
 				}
-				
-				if (header & ISI_DSR) 
-					port->status |= ISI_DSR;
-				else
-					port->status &= ~ISI_DSR;
-				
-				if (header & ISI_RI) 
-					port->status |= ISI_RI;
+			}
+			else {
+				if (header & ISI_CTS)
+					port->status |= ISI_CTS;
 				else
-					port->status &= ~ISI_RI;						
-				
-				break;
-				
-			case 1:	/* Received Break !!!	 */
-				tty_insert_flip_char(tty, 0, TTY_BREAK);
-				if (port->flags & ASYNC_SAK)
-					do_SAK(tty);
-				tty_flip_buffer_push(tty);
-				break;
-				
-			case 2:	/* Statistics		 */
-				printk(KERN_DEBUG "ISICOM: isicom_interrupt: stats!!!.\n");			
-				break;
-				
-			default:
-				printk(KERN_WARNING "ISICOM: Intr: Unknown code in status packet.\n");
-				break;
-		}	 
+					port->status &= ~ISI_CTS;
+			}
+
+			if (header & ISI_DSR)
+				port->status |= ISI_DSR;
+			else
+				port->status &= ~ISI_DSR;
+
+			if (header & ISI_RI)
+				port->status |= ISI_RI;
+			else
+				port->status &= ~ISI_RI;
+
+			break;
+
+		case 1:	/* Received Break !!!	 */
+			tty_insert_flip_char(tty, 0, TTY_BREAK);
+			if (port->flags & ASYNC_SAK)
+				do_SAK(tty);
+			tty_flip_buffer_push(tty);
+			break;
+
+		case 2:	/* Statistics		 */
+			printk(KERN_DEBUG "ISICOM: isicom_interrupt: stats!!!.\n");
+			break;
+
+		default:
+			printk(KERN_WARNING "ISICOM: Intr: Unknown code in status packet.\n");
+			break;
+		}
 	}
 	else {				/* Data   Packet */
 
 		count = tty_prepare_flip_string(tty, &rp, byte_count & ~1);
 #ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: Intr: Can rx %d of %d bytes.\n", 
+		printk(KERN_DEBUG "ISICOM: Intr: Can rx %d of %d bytes.\n",
 					count, byte_count);
-#endif			
+#endif
 		word_count = count >> 1;
 		insw(base, rp, word_count);
 		byte_count -= (word_count << 1);
 		if (count & 0x0001) {
 			tty_insert_flip_char(tty,  inw(base) & 0xff, TTY_NORMAL);
 			byte_count -= 2;
-		}	
+		}
 		if (byte_count > 0) {
 			printk(KERN_DEBUG "ISICOM: Intr(0x%x:%d): Flip buffer overflow! dropping bytes...\n",
 					base, channel+1);
@@ -947,102 +944,102 @@ static irqreturn_t isicom_interrupt(int 
 	if (card->isa == YES)
 		ClearInterrupt(base);
 	else
-		outw(0x0000, base+0x04); /* enable interrupts */	
+		outw(0x0000, base+0x04); /* enable interrupts */
 	return IRQ_HANDLED;
-} 
+}
 
-static void isicom_config_port(struct isi_port * port)
+static void isicom_config_port(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
-	struct tty_struct * tty;
+	struct isi_board *card = port->card;
+	struct tty_struct *tty;
 	unsigned long baud;
 	unsigned short channel_setup, base = card->base;
 	unsigned short channel = port->channel, shift_count = card->shift_count;
 	unsigned char flow_ctrl;
-	
+
 	if (!(tty = port->tty) || !tty->termios)
 		return;
 	baud = C_BAUD(tty);
 	if (baud & CBAUDEX) {
 		baud &= ~CBAUDEX;
-		
+
 		/*  if CBAUDEX bit is on and the baud is set to either 50 or 75
 		 *  then the card is programmed for 57.6Kbps or 115Kbps
 		 *  respectively.
-		 */   
-		 
+		 */
+
 		if (baud < 1 || baud > 2)
 			port->tty->termios->c_cflag &= ~CBAUDEX;
 		else
 			baud += 15;
-	}	
+	}
 	if (baud == 15) {
-	
-		/*  the ASYNC_SPD_HI and ASYNC_SPD_VHI options are set 
+
+		/*  the ASYNC_SPD_HI and ASYNC_SPD_VHI options are set
 		 *  by the set_serial_info ioctl ... this is done by
 		 *  the 'setserial' utility.
-		 */  
-			
+		 */
+
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			baud++;     /*  57.6 Kbps */
+			baud++; /*  57.6 Kbps */
 		if ((port->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			baud +=2;   /*  115  Kbps */	 
+			baud +=2; /*  115  Kbps */
 	}
 	if (linuxb_to_isib[baud] == -1) {
 		/* hang up */
-	 	drop_dtr(port);
-	 	return;
-	}	
-	else  
+		drop_dtr(port);
+		return;
+	}
+	else
 		raise_dtr(port);
-		
+
 	if (lock_card(card)) {
 		outw(0x8000 | (channel << shift_count) |0x03, base);
 		outw(linuxb_to_isib[baud] << 8 | 0x03, base);
 		channel_setup = 0;
 		switch(C_CSIZE(tty)) {
-			case CS5:
-				channel_setup |= ISICOM_CS5;
-				break;
-			case CS6:
-				channel_setup |= ISICOM_CS6;
-				break;
-			case CS7:
-				channel_setup |= ISICOM_CS7;
-				break;
-			case CS8:
-				channel_setup |= ISICOM_CS8;
-				break;
+		case CS5:
+			channel_setup |= ISICOM_CS5;
+			break;
+		case CS6:
+			channel_setup |= ISICOM_CS6;
+			break;
+		case CS7:
+			channel_setup |= ISICOM_CS7;
+			break;
+		case CS8:
+			channel_setup |= ISICOM_CS8;
+			break;
 		}
-			
+
 		if (C_CSTOPB(tty))
 			channel_setup |= ISICOM_2SB;
 		if (C_PARENB(tty)) {
 			channel_setup |= ISICOM_EVPAR;
 			if (C_PARODD(tty))
-				channel_setup |= ISICOM_ODPAR;	
+				channel_setup |= ISICOM_ODPAR;
 		}
-		outw(channel_setup, base);	
+		outw(channel_setup, base);
 		InterruptTheCard(base);
-		unlock_card(card);	
-	}	
+		unlock_card(card);
+	}
 	if (C_CLOCAL(tty))
 		port->flags &= ~ASYNC_CHECK_CD;
 	else
-		port->flags |= ASYNC_CHECK_CD;	
-	
+		port->flags |= ASYNC_CHECK_CD;
+
 	/* flow control settings ...*/
 	flow_ctrl = 0;
 	port->flags &= ~ASYNC_CTS_FLOW;
 	if (C_CRTSCTS(tty)) {
 		port->flags |= ASYNC_CTS_FLOW;
 		flow_ctrl |= ISICOM_CTSRTS;
-	}	
-	if (I_IXON(tty))	
+	}
+	if (I_IXON(tty))
 		flow_ctrl |= ISICOM_RESPOND_XONXOFF;
 	if (I_IXOFF(tty))
-		flow_ctrl |= ISICOM_INITIATE_XONXOFF;	
-		
+		flow_ctrl |= ISICOM_INITIATE_XONXOFF;
+
 	if (lock_card(card)) {
 		outw(0x8000 | (channel << shift_count) |0x04, base);
 		outw(flow_ctrl << 8 | 0x05, base);
@@ -1050,22 +1047,22 @@ static void isicom_config_port(struct is
 		InterruptTheCard(base);
 		unlock_card(card);
 	}
-	
+
 	/*	rx enabled -> enable port for rx on the card	*/
 	if (C_CREAD(tty)) {
 		card->port_status |= (1 << channel);
 		outw(card->port_status, base + 0x02);
 	}
 }
- 
-/* open et all */ 
 
-static inline void isicom_setup_board(struct isi_board * bp)
+/* open et all */
+
+static inline void isicom_setup_board(struct isi_board *bp)
 {
 	int channel;
-	struct isi_port * port;
+	struct isi_port *port;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&bp->card_lock, flags);
 	if (bp->status & BOARD_ACTIVE) {
 		spin_unlock_irqrestore(&bp->card_lock, flags);
@@ -1078,49 +1075,49 @@ static inline void isicom_setup_board(st
 		drop_dtr_rts(port);
 	return;
 }
- 
-static int isicom_setup_port(struct isi_port * port)
+
+static int isicom_setup_port(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	unsigned long flags;
-	
+
 	if (port->flags & ASYNC_INITIALIZED) {
 		return 0;
 	}
 	if (!port->xmit_buf) {
 		unsigned long page;
-		
+
 		if (!(page = get_zeroed_page(GFP_KERNEL)))
 			return -ENOMEM;
-		
+
 		if (port->xmit_buf) {
 			free_page(page);
 			return -ERESTARTSYS;
 		}
-		port->xmit_buf = (unsigned char *) page;	
-	}	
+		port->xmit_buf = (unsigned char *) page;
+	}
 
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (port->tty)
 		clear_bit(TTY_IO_ERROR, &port->tty->flags);
 	if (port->count == 1)
 		card->count++;
-		
+
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
-	
+
 	/*	discard any residual data	*/
 	kill_queue(port, ISICOM_KILLTX | ISICOM_KILLRX);
-	
+
 	isicom_config_port(port);
 	port->flags |= ASYNC_INITIALIZED;
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	
-	return 0;		
-} 
- 
-static int block_til_ready(struct tty_struct * tty, struct file * filp, struct isi_port * port) 
+
+	return 0;
+}
+
+static int block_til_ready(struct tty_struct *tty, struct file *filp, struct isi_port *port)
 {
-	struct isi_board * card = port->card;
+	struct isi_board *card = port->card;
 	int do_clocal = 0, retval;
 	unsigned long flags;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1128,30 +1125,30 @@ static int block_til_ready(struct tty_st
 	/* block if port is in the process of being closed */
 
 	if (tty_hung_up_p(filp) || port->flags & ASYNC_CLOSING) {
-#ifdef ISICOM_DEBUG	
+#ifdef ISICOM_DEBUG
 		printk(KERN_DEBUG "ISICOM: block_til_ready: close in progress.\n");
-#endif		
+#endif
 		interruptible_sleep_on(&port->close_wait);
 		if (port->flags & ASYNC_HUP_NOTIFY)
 			return -EAGAIN;
 		else
 			return -ERESTARTSYS;
 	}
-	
+
 	/* if non-blocking mode is set ... */
-	
+
 	if ((filp->f_flags & O_NONBLOCK) || (tty->flags & (1 << TTY_IO_ERROR))) {
-#ifdef ISICOM_DEBUG	
+#ifdef ISICOM_DEBUG
 		printk(KERN_DEBUG "ISICOM: block_til_ready: non-block mode.\n");
-#endif		
+#endif
 		port->flags |= ASYNC_NORMAL_ACTIVE;
-		return 0;	
-	}	
-	
+		return 0;
+	}
+
 	if (C_CLOCAL(tty))
 		do_clocal = 1;
-	
-	/* block waiting for DCD to be asserted, and while 
+
+	/* block waiting for DCD to be asserted, and while
 						callout dev is busy */
 	retval = 0;
 	add_wait_queue(&port->open_wait, &wait);
@@ -1161,27 +1158,27 @@ static int block_til_ready(struct tty_st
 		port->count--;
 	port->blocked_open++;
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	
+
 	while (1) {
 		raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
-		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) { 	
+		if (tty_hung_up_p(filp) || !(port->flags & ASYNC_INITIALIZED)) {
 			if (port->flags & ASYNC_HUP_NOTIFY)
 				retval = -EAGAIN;
 			else
 				retval = -ERESTARTSYS;
 			break;
-		}	
+		}
 		if (!(port->flags & ASYNC_CLOSING) &&
-		    (do_clocal || (port->status & ISI_DCD))) {
+				(do_clocal || (port->status & ISI_DCD))) {
 			break;
-		}	
+		}
 		if (signal_pending(current)) {
 			retval = -ERESTARTSYS;
 			break;
 		}
-		schedule();		
+		schedule();
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&port->open_wait, &wait);
@@ -1195,11 +1192,11 @@ static int block_til_ready(struct tty_st
 	port->flags |= ASYNC_NORMAL_ACTIVE;
 	return 0;
 }
- 
-static int isicom_open(struct tty_struct * tty, struct file * filp)
+
+static int isicom_open(struct tty_struct *tty, struct file *filp)
 {
-	struct isi_port * port;
-	struct isi_board * card;
+	struct isi_port *port;
+	struct isi_board *card;
 	unsigned int line, board;
 	int error;
 
@@ -1208,20 +1205,20 @@ static int isicom_open(struct tty_struct
 		return -ENODEV;
 	board = BOARD(line);
 	card = &isi_card[board];
-	
+
 	if (!(card->status & FIRMWARE_LOADED))
 		return -ENODEV;
-	
+
 	/*  open on a port greater than the port count for the card !!! */
 	if (line > ((board * 16) + card->port_count - 1))
 		return -ENODEV;
 
-	port = &isi_ports[line];	
+	port = &isi_ports[line];
 	if (isicom_paranoia_check(port, tty->name, "isicom_open"))
 		return -ENODEV;
-		
-	isicom_setup_board(card);		
-	
+
+	isicom_setup_board(card);
+
 	port->count++;
 	tty->driver_data = port;
 	port->tty = tty;
@@ -1230,12 +1227,12 @@ static int isicom_open(struct tty_struct
 	if ((error = block_til_ready(tty, filp, port))!=0)
 		return error;
 
-	return 0;      		
+	return 0;
 }
- 
+
 /* close et all */
 
-static inline void isicom_shutdown_board(struct isi_board * bp)
+static inline void isicom_shutdown_board(struct isi_board *bp)
 {
 	unsigned long flags;
 
@@ -1246,15 +1243,15 @@ static inline void isicom_shutdown_board
 	spin_unlock_irqrestore(&bp->card_lock, flags);
 }
 
-static void isicom_shutdown_port(struct isi_port * port)
+static void isicom_shutdown_port(struct isi_port *port)
 {
-	struct isi_board * card = port->card;
-	struct tty_struct * tty;	
+	struct isi_board *card = port->card;
+	struct tty_struct *tty;
 	unsigned long flags;
-	
+
 	tty = port->tty;
 
-	spin_lock_irqsave(&card->card_lock, flags);	
+	spin_lock_irqsave(&card->card_lock, flags);
 	if (!(port->flags & ASYNC_INITIALIZED)) {
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
@@ -1262,32 +1259,32 @@ static void isicom_shutdown_port(struct 
 	if (port->xmit_buf) {
 		free_page((unsigned long) port->xmit_buf);
 		port->xmit_buf = NULL;
-	}	
+	}
 	port->flags &= ~ASYNC_INITIALIZED;
 	/* 3rd October 2000 : Vinayak P Risbud */
 	port->tty = NULL;
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	
+
 	/*Fix done by Anil .S on 30-04-2001
 	remote login through isi port has dtr toggle problem
 	due to which the carrier drops before the password prompt
-	appears on the remote end. Now we drop the dtr only if the 
+	appears on the remote end. Now we drop the dtr only if the
 	HUPCL(Hangup on close) flag is set for the tty*/
-	
-	if (C_HUPCL(tty)) 
+
+	if (C_HUPCL(tty))
 		/* drop dtr on this port */
 		drop_dtr(port);
-		
-	/* any other port uninits  */ 
+
+	/* any other port uninits  */
 	if (tty)
 		set_bit(TTY_IO_ERROR, &tty->flags);
-	
+
 	if (--card->count < 0) {
 		printk(KERN_DEBUG "ISICOM: isicom_shutdown_port: bad board(0x%x) count %d.\n",
 			card->base, card->count);
-		card->count = 0;	
+		card->count = 0;
 	}
-	
+
 	/* last port was closed , shutdown that boad too */
 	if(C_HUPCL(tty)) {
 		if (!card->count)
@@ -1295,27 +1292,27 @@ static void isicom_shutdown_port(struct 
 	}
 }
 
-static void isicom_close(struct tty_struct * tty, struct file * filp)
+static void isicom_close(struct tty_struct *tty, struct file *filp)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	struct isi_board * card = port->card;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_board *card = port->card;
 	unsigned long flags;
-	
+
 	if (!port)
 		return;
 	if (isicom_paranoia_check(port, tty->name, "isicom_close"))
 		return;
-	
-#ifdef ISICOM_DEBUG		
+
+#ifdef ISICOM_DEBUG
 	printk(KERN_DEBUG "ISICOM: Close start!!!.\n");
-#endif	
-	
+#endif
+
 	spin_lock_irqsave(&card->card_lock, flags);
 	if (tty_hung_up_p(filp)) {
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
 	}
-	
+
 	if (tty->count == 1 && port->count != 1) {
 		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count"
 			"tty->count = 1	port count = %d.\n",
@@ -1324,31 +1321,31 @@ static void isicom_close(struct tty_stru
 	}
 	if (--port->count < 0) {
 		printk(KERN_WARNING "ISICOM:(0x%x) isicom_close: bad port count for"
-			"channel%d = %d", card->base, port->channel, 
+			"channel%d = %d", card->base, port->channel,
 			port->count);
-		port->count = 0;	
+		port->count = 0;
 	}
-	
+
 	if (port->count) {
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
-	} 	
+	}
 	port->flags |= ASYNC_CLOSING;
 	tty->closing = 1;
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	
+
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
 		tty_wait_until_sent(tty, port->closing_wait);
-	/* indicate to the card that no more data can be received 
+	/* indicate to the card that no more data can be received
 	   on this port */
 	spin_lock_irqsave(&card->card_lock, flags);
-	if (port->flags & ASYNC_INITIALIZED) {   
+	if (port->flags & ASYNC_INITIALIZED) {
 		card->port_status &= ~(1 << port->channel);
 		outw(card->port_status, card->base + 0x02);
-	}	
+	}
 	isicom_shutdown_port(port);
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	
+
 	if (tty->driver->flush_buffer)
 		tty->driver->flush_buffer(tty);
 	tty_ldisc_flush(tty);
@@ -1359,65 +1356,65 @@ static void isicom_close(struct tty_stru
 	if (port->blocked_open) {
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		if (port->close_delay) {
-#ifdef ISICOM_DEBUG			
+#ifdef ISICOM_DEBUG
 			printk(KERN_DEBUG "ISICOM: scheduling until time out.\n");
-#endif			
+#endif
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		spin_lock_irqsave(&card->card_lock, flags);
 		wake_up_interruptible(&port->open_wait);
-	}	
+	}
 	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
 	wake_up_interruptible(&port->close_wait);
 	spin_unlock_irqrestore(&card->card_lock, flags);
 }
 
 /* write et all */
-static int isicom_write(struct tty_struct * tty,
-			const unsigned char * buf, int count)
+static int isicom_write(struct tty_struct *tty,	const unsigned char *buf,
+	int count)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	struct isi_board * card = port->card;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_board *card = port->card;
 	unsigned long flags;
 	int cnt, total = 0;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_write"))
 		return 0;
-	
+
 	if (!tty || !port->xmit_buf || !tmp_buf)
 		return 0;
-		
+
 	spin_lock_irqsave(&card->card_lock, flags);
-	
-	while(1) {	
+
+	while(1) {
 		cnt = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-					    SERIAL_XMIT_SIZE - port->xmit_head));
-		if (cnt <= 0) 
+					SERIAL_XMIT_SIZE - port->xmit_head));
+		if (cnt <= 0)
 			break;
-		
+
 		memcpy(port->xmit_buf + port->xmit_head, buf, cnt);
 		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE - 1);
 		port->xmit_cnt += cnt;
 		buf += cnt;
 		count -= cnt;
 		total += cnt;
-	}		
+	}
 	if (port->xmit_cnt && !tty->stopped && !tty->hw_stopped)
 		port->status |= ISI_TXOK;
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	return total;	
+	return total;
 }
 
 /* put_char et all */
-static void isicom_put_char(struct tty_struct * tty, unsigned char ch)
+static void isicom_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	struct isi_board * card = port->card;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_board *card = port->card;
 	unsigned long flags;
-	
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_put_char"))
 		return;
-	
+
 	if (!tty || !port->xmit_buf)
 		return;
 
@@ -1426,7 +1423,7 @@ static void isicom_put_char(struct tty_s
 		spin_unlock_irqrestore(&card->card_lock, flags);
 		return;
 	}
-	
+
 	port->xmit_buf[port->xmit_head++] = ch;
 	port->xmit_head &= (SERIAL_XMIT_SIZE - 1);
 	port->xmit_cnt++;
@@ -1434,30 +1431,30 @@ static void isicom_put_char(struct tty_s
 }
 
 /* flush_chars et all */
-static void isicom_flush_chars(struct tty_struct * tty)
+static void isicom_flush_chars(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_chars"))
 		return;
-	
+
 	if (port->xmit_cnt <= 0 || tty->stopped || tty->hw_stopped || !port->xmit_buf)
 		return;
-		
+
 	/* this tells the transmitter to consider this port for
 	   data output to the card ... that's the best we can do. */
-	port->status |= ISI_TXOK;	
+	port->status |= ISI_TXOK;
 }
 
 /* write_room et all */
-static int isicom_write_room(struct tty_struct * tty)
+static int isicom_write_room(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
 	int free;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_write_room"))
 		return 0;
-	
+
 	free = SERIAL_XMIT_SIZE - port->xmit_cnt - 1;
 	if (free < 0)
 		free = 0;
@@ -1465,23 +1462,23 @@ static int isicom_write_room(struct tty_
 }
 
 /* chars_in_buffer et all */
-static int isicom_chars_in_buffer(struct tty_struct * tty)
+static int isicom_chars_in_buffer(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
 	if (isicom_paranoia_check(port, tty->name, "isicom_chars_in_buffer"))
 		return 0;
 	return port->xmit_cnt;
 }
 
 /* ioctl et all */
-static inline void isicom_send_break(struct isi_port * port, unsigned long length)
+static inline void isicom_send_break(struct isi_port *port, unsigned long length)
 {
-	struct isi_board * card = port->card;
-	unsigned short base = card->base;	
-	
+	struct isi_board *card = port->card;
+	unsigned short base = card->base;
+
 	if(!lock_card(card))
 		return;
-		
+
 	outw(0x8000 | ((port->channel) << (card->shift_count)) | 0x3, base);
 	outw((length & 0xff) << 8 | 0x00, base);
 	outw((length & 0xff00), base);
@@ -1492,13 +1489,13 @@ static inline void isicom_send_break(str
 
 static int isicom_tiocmget(struct tty_struct *tty, struct file *file)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
 	/* just send the port status */
 	unsigned short status = port->status;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
-	
+
 	return  ((status & ISI_RTS) ? TIOCM_RTS : 0) |
 		((status & ISI_DTR) ? TIOCM_DTR : 0) |
 		((status & ISI_DCD) ? TIOCM_CAR : 0) |
@@ -1508,13 +1505,13 @@ static int isicom_tiocmget(struct tty_st
 }
 
 static int isicom_tiocmset(struct tty_struct *tty, struct file *file,
-			   unsigned int set, unsigned int clear)
+	unsigned int set, unsigned int clear)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_ioctl"))
 		return -ENODEV;
-	
+
 	if (set & TIOCM_RTS)
 		raise_rts(port);
 	if (set & TIOCM_DTR)
@@ -1526,46 +1523,46 @@ static int isicom_tiocmset(struct tty_st
 		drop_dtr(port);
 
 	return 0;
-}			
+}
 
-static int isicom_set_serial_info(struct isi_port * port,
-					struct serial_struct __user *info)
+static int isicom_set_serial_info(struct isi_port *port,
+	struct serial_struct __user *info)
 {
 	struct serial_struct newinfo;
 	int reconfig_port;
 
 	if(copy_from_user(&newinfo, info, sizeof(newinfo)))
 		return -EFAULT;
-		
-	reconfig_port = ((port->flags & ASYNC_SPD_MASK) != 
-			 (newinfo.flags & ASYNC_SPD_MASK));
-	
+
+	reconfig_port = ((port->flags & ASYNC_SPD_MASK) !=
+		(newinfo.flags & ASYNC_SPD_MASK));
+
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((newinfo.close_delay != port->close_delay) ||
-		    (newinfo.closing_wait != port->closing_wait) ||
-		    ((newinfo.flags & ~ASYNC_USR_MASK) != 
-		     (port->flags & ~ASYNC_USR_MASK)))
+				(newinfo.closing_wait != port->closing_wait) ||
+				((newinfo.flags & ~ASYNC_USR_MASK) !=
+				(port->flags & ~ASYNC_USR_MASK)))
 			return -EPERM;
 		port->flags = ((port->flags & ~ ASYNC_USR_MASK) |
 				(newinfo.flags & ASYNC_USR_MASK));
-	}	
+	}
 	else {
 		port->close_delay = newinfo.close_delay;
-		port->closing_wait = newinfo.closing_wait; 
-		port->flags = ((port->flags & ~ASYNC_FLAGS) | 
+		port->closing_wait = newinfo.closing_wait;
+		port->flags = ((port->flags & ~ASYNC_FLAGS) |
 				(newinfo.flags & ASYNC_FLAGS));
 	}
 	if (reconfig_port) {
 		isicom_config_port(port);
 	}
-	return 0;		 
-}		
+	return 0;
+}
 
-static int isicom_get_serial_info(struct isi_port * port, 
-					struct serial_struct __user *info)
+static int isicom_get_serial_info(struct isi_port *port,
+	struct serial_struct __user *info)
 {
 	struct serial_struct out_info;
-	
+
 	memset(&out_info, 0, sizeof(out_info));
 /*	out_info.type = ? */
 	out_info.line = port - isi_ports;
@@ -1578,12 +1575,12 @@ static int isicom_get_serial_info(struct
 	if(copy_to_user(info, &out_info, sizeof(out_info)))
 		return -EFAULT;
 	return 0;
-}					
+}
 
-static int isicom_ioctl(struct tty_struct * tty, struct file * filp,
-			unsigned int cmd, unsigned long arg) 
+static int isicom_ioctl(struct tty_struct *tty, struct file *filp,
+	unsigned int cmd, unsigned long arg)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
 	void __user *argp = (void __user *)arg;
 	int retval;
 
@@ -1591,139 +1588,140 @@ static int isicom_ioctl(struct tty_struc
 		return -ENODEV;
 
 	switch(cmd) {
-		case TCSBRK:
-			retval = tty_check_change(tty);
-			if (retval)
-				return retval;
-			tty_wait_until_sent(tty, 0);
-			if (!arg)
-				isicom_send_break(port, HZ/4);
-			return 0;
-			
-		case TCSBRKP:	
-			retval = tty_check_change(tty);
-			if (retval)
-				return retval;
-			tty_wait_until_sent(tty, 0);
-			isicom_send_break(port, arg ? arg * (HZ/10) : HZ/4);
-			return 0;
-			
-		case TIOCGSOFTCAR:
-			return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
-			
-		case TIOCSSOFTCAR:
-			if(get_user(arg, (unsigned long __user *) argp))
-				return -EFAULT;
-			tty->termios->c_cflag =
-				((tty->termios->c_cflag & ~CLOCAL) |
-				(arg ? CLOCAL : 0));
-			return 0;	
-			
-		case TIOCGSERIAL:
-			return isicom_get_serial_info(port, argp);
-		
-		case TIOCSSERIAL:
-			return isicom_set_serial_info(port, argp);
-					
-		default:
-			return -ENOIOCTLCMD;						
+	case TCSBRK:
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+		tty_wait_until_sent(tty, 0);
+		if (!arg)
+			isicom_send_break(port, HZ/4);
+		return 0;
+
+	case TCSBRKP:
+		retval = tty_check_change(tty);
+		if (retval)
+			return retval;
+		tty_wait_until_sent(tty, 0);
+		isicom_send_break(port, arg ? arg * (HZ/10) : HZ/4);
+		return 0;
+
+	case TIOCGSOFTCAR:
+		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long __user *)argp);
+
+	case TIOCSSOFTCAR:
+		if(get_user(arg, (unsigned long __user *) argp))
+			return -EFAULT;
+		tty->termios->c_cflag =
+			((tty->termios->c_cflag & ~CLOCAL) |
+			(arg ? CLOCAL : 0));
+		return 0;
+
+	case TIOCGSERIAL:
+		return isicom_get_serial_info(port, argp);
+
+	case TIOCSSERIAL:
+		return isicom_set_serial_info(port, argp);
+
+	default:
+		return -ENOIOCTLCMD;
 	}
 	return 0;
 }
 
 /* set_termios et all */
-static void isicom_set_termios(struct tty_struct * tty, struct termios * old_termios)
+static void isicom_set_termios(struct tty_struct *tty,
+	struct termios *old_termios)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_set_termios"))
 		return;
-	
+
 	if (tty->termios->c_cflag == old_termios->c_cflag &&
-	    tty->termios->c_iflag == old_termios->c_iflag)
+			tty->termios->c_iflag == old_termios->c_iflag)
 		return;
-		
+
 	isicom_config_port(port);
-	
+
 	if ((old_termios->c_cflag & CRTSCTS) &&
-	    !(tty->termios->c_cflag & CRTSCTS)) {	
+			!(tty->termios->c_cflag & CRTSCTS)) {
 		tty->hw_stopped = 0;
-		isicom_start(tty);   
-	}    
+		isicom_start(tty);
+	}
 }
 
 /* throttle et all */
-static void isicom_throttle(struct tty_struct * tty)
+static void isicom_throttle(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	struct isi_board * card = port->card;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_board *card = port->card;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_throttle"))
 		return;
-	
+
 	/* tell the card that this port cannot handle any more data for now */
 	card->port_status &= ~(1 << port->channel);
 	outw(card->port_status, card->base + 0x02);
 }
 
 /* unthrottle et all */
-static void isicom_unthrottle(struct tty_struct * tty)
+static void isicom_unthrottle(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	struct isi_board * card = port->card;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_board *card = port->card;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_unthrottle"))
 		return;
-	
+
 	/* tell the card that this port is ready to accept more data */
 	card->port_status |= (1 << port->channel);
 	outw(card->port_status, card->base + 0x02);
 }
 
 /* stop et all */
-static void isicom_stop(struct tty_struct * tty)
+static void isicom_stop(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
 
 	if (isicom_paranoia_check(port, tty->name, "isicom_stop"))
 		return;
-	
+
 	/* this tells the transmitter not to consider this port for
 	   data output to the card. */
 	port->status &= ~ISI_TXOK;
 }
 
 /* start et all */
-static void isicom_start(struct tty_struct * tty)
+static void isicom_start(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_start"))
 		return;
-	
+
 	/* this tells the transmitter to consider this port for
 	   data output to the card. */
 	port->status |= ISI_TXOK;
 }
 
 /* hangup et all */
-static void do_isicom_hangup(void * data)
+static void do_isicom_hangup(void *data)
 {
-	struct isi_port * port = (struct isi_port *) data;
-	struct tty_struct * tty;
-	
+	struct isi_port *port = (struct isi_port *) data;
+	struct tty_struct *tty;
+
 	tty = port->tty;
 	if (tty)
 		tty_hangup(tty);
 }
 
-static void isicom_hangup(struct tty_struct * tty)
+static void isicom_hangup(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_hangup"))
 		return;
-	
+
 	isicom_shutdown_port(port);
 	port->count = 0;
 	port->flags &= ~ASYNC_NORMAL_ACTIVE;
@@ -1732,19 +1730,19 @@ static void isicom_hangup(struct tty_str
 }
 
 /* flush_buffer et all */
-static void isicom_flush_buffer(struct tty_struct * tty)
+static void isicom_flush_buffer(struct tty_struct *tty)
 {
-	struct isi_port * port = (struct isi_port *) tty->driver_data;
-	struct isi_board * card = port->card;
+	struct isi_port *port = (struct isi_port *) tty->driver_data;
+	struct isi_board *card = port->card;
 	unsigned long flags;
-	
+
 	if (isicom_paranoia_check(port, tty->name, "isicom_flush_buffer"))
 		return;
-	
+
 	spin_lock_irqsave(&card->card_lock, flags);
 	port->xmit_cnt = port->xmit_head = port->xmit_tail = 0;
 	spin_unlock_irqrestore(&card->card_lock, flags);
-	
+
 	wake_up_interruptible(&tty->write_wait);
 	tty_wakeup(tty);
 }
@@ -1768,12 +1766,12 @@ static int __devinit register_ioregion(v
 static void unregister_ioregion(void)
 {
 	int count;
-	for (count=0; count < BOARD_COUNT; count++ ) 
+	for (count=0; count < BOARD_COUNT; count++ )
 		if (isi_card[count].base) {
 			release_region(isi_card[count].base,16);
-#ifdef ISICOM_DEBUG			
+#ifdef ISICOM_DEBUG
 			printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x released for Card%d.\n",isi_card[count].base,isi_card[count].base+15,count+1);
-#endif			
+#endif
 		}
 }
 
@@ -1814,11 +1812,11 @@ static int __devinit register_drivers(vo
 	isicom_normal->type	= TTY_DRIVER_TYPE_SERIAL;
 	isicom_normal->subtype	= SERIAL_TYPE_NORMAL;
 	isicom_normal->init_termios	= tty_std_termios;
-	isicom_normal->init_termios.c_cflag	= 
+	isicom_normal->init_termios.c_cflag	=
 				B9600 | CS8 | CREAD | HUPCL |CLOCAL;
 	isicom_normal->flags	= TTY_DRIVER_REAL_RAW;
 	tty_set_operations(isicom_normal, &isicom_ops);
-	
+
 	if ((error=tty_register_driver(isicom_normal))!=0) {
 		printk(KERN_DEBUG "ISICOM: Couldn't register the dialin driver, error=%d\n",
 			error);
@@ -1843,13 +1841,13 @@ static int __devinit register_isr(void)
 
 	for (count=0; count < BOARD_COUNT; count++ ) {
 		if (isi_card[count].base) {
-			irqflags = (isi_card[count].isa == YES) ? 
-					SA_INTERRUPT : 
+			irqflags = (isi_card[count].isa == YES) ?
+					SA_INTERRUPT :
 					(SA_INTERRUPT | SA_SHIRQ);
 
-			if (request_irq(isi_card[count].irq, 
-					isicom_interrupt, 
-					irqflags, 
+			if (request_irq(isi_card[count].irq,
+					isicom_interrupt,
+					irqflags,
 					ISICOM_NAME, &isi_card[count])) {
 
 				printk(KERN_WARNING "ISICOM: Could not"
@@ -1862,7 +1860,7 @@ static int __devinit register_isr(void)
 			}
 			else
 				done++;
-		}	
+		}
 	}
 	return done;
 }
@@ -1880,42 +1878,42 @@ static void __exit unregister_isr(void)
 static int __devinit isicom_init(void)
 {
 	int card, channel, base;
-	struct isi_port * port;
+	struct isi_port *port;
 	unsigned long page;
-	
-	if (!tmp_buf) { 
+
+	if (!tmp_buf) {
 		page = get_zeroed_page(GFP_KERNEL);
-	      	if (!page) {
-#ifdef ISICOM_DEBUG	      	
-	      		printk(KERN_DEBUG "ISICOM: Couldn't allocate page for tmp_buf.\n");
+		if (!page) {
+#ifdef ISICOM_DEBUG
+			printk(KERN_DEBUG "ISICOM: Couldn't allocate page for tmp_buf.\n");
 #else
 			printk(KERN_ERR "ISICOM: Not enough memory...\n");
-#endif	      
-	      		return 0;
-	      	}	
-	      	tmp_buf = (unsigned char *) page;
+#endif
+			return 0;
+		}
+		tmp_buf = (unsigned char *) page;
 	}
-	
-	if (!register_ioregion()) 
+
+	if (!register_ioregion())
 	{
 		printk(KERN_ERR "ISICOM: All required I/O space found busy.\n");
 		free_page((unsigned long)tmp_buf);
 		return 0;
 	}
-	if (register_drivers()) 
+	if (register_drivers())
 	{
 		unregister_ioregion();
 		free_page((unsigned long)tmp_buf);
 		return 0;
 	}
-	if (!register_isr()) 
+	if (!register_isr())
 	{
 		unregister_drivers();
 		/*  ioports already uregistered in register_isr */
 		free_page((unsigned long)tmp_buf);
-		return 0;		
+		return 0;
 	}
-	
+
 	memset(isi_ports, 0, sizeof(isi_ports));
 	for (card = 0; card < BOARD_COUNT; card++) {
 		port = &isi_ports[card * 16];
@@ -1926,24 +1924,24 @@ static int __devinit isicom_init(void)
 			port->magic = ISICOM_MAGIC;
 			port->card = &isi_card[card];
 			port->channel = channel;
-		 	port->close_delay = 50 * HZ/100;
-		 	port->closing_wait = 3000 * HZ/100;
-		 	INIT_WORK(&port->hangup_tq, do_isicom_hangup, port);
-		 	INIT_WORK(&port->bh_tqueue, isicom_bottomhalf, port);
-		 	port->status = 0;
-			init_waitqueue_head(&port->open_wait);	 				
+			port->close_delay = 50 * HZ/100;
+			port->closing_wait = 3000 * HZ/100;
+			INIT_WORK(&port->hangup_tq, do_isicom_hangup, port);
+			INIT_WORK(&port->bh_tqueue, isicom_bottomhalf, port);
+			port->status = 0;
+			init_waitqueue_head(&port->open_wait);
 			init_waitqueue_head(&port->close_wait);
 			/*  . . .  */
- 		}
-	} 
-	
-	return 1;	
+		}
+	}
+
+	return 1;
 }
 
 /*
  *	Insmod can set static symbols so keep these static
  */
- 
+
 static int io[4];
 static int irq[4];
 
@@ -1961,9 +1959,9 @@ static int __devinit isicom_setup(void)
 	int retval, card, idx, count;
 	unsigned char pciirq;
 	unsigned int ioaddr;
-	                
+
 	card = 0;
-	for(idx=0; idx < BOARD_COUNT; idx++) {	
+	for(idx=0; idx < BOARD_COUNT; idx++) {
 		if (io[idx]) {
 			isi_card[idx].base=io[idx];
 			isi_card[idx].irq=irq[idx];
@@ -1975,23 +1973,23 @@ static int __devinit isicom_setup(void)
 			isi_card[idx].irq = 0;
 		}
 	}
-	
+
 	for (idx=0 ;idx < card; idx++) {
 		if (!((isi_card[idx].irq==2)||(isi_card[idx].irq==3)||
-		    (isi_card[idx].irq==4)||(isi_card[idx].irq==5)||
-		    (isi_card[idx].irq==7)||(isi_card[idx].irq==10)||
-		    (isi_card[idx].irq==11)||(isi_card[idx].irq==12)||
-		    (isi_card[idx].irq==15))) {
-			
+			(isi_card[idx].irq==4)||(isi_card[idx].irq==5)||
+			(isi_card[idx].irq==7)||(isi_card[idx].irq==10)||
+			(isi_card[idx].irq==11)||(isi_card[idx].irq==12)||
+			(isi_card[idx].irq==15))) {
+
 			if (isi_card[idx].base) {
 				printk(KERN_ERR "ISICOM: Irq %d unsupported. Disabling Card%d...\n",
 					isi_card[idx].irq, idx+1);
 				isi_card[idx].base=0;
 				card--;
-			}	
+			}
 		}
-	}	
-	
+	}
+
 	if (card < BOARD_COUNT) {
 		for (idx=0; idx < DEVID_COUNT; idx++) {
 			dev = NULL;
@@ -2000,21 +1998,22 @@ static int __devinit isicom_setup(void)
 					break;
 				if (card >= BOARD_COUNT)
 					break;
-					
+
 				if (pci_enable_device(dev))
 					break;
 
 				/* found a PCI ISI card! */
-				ioaddr = pci_resource_start (dev, 3); /* i.e at offset 0x1c in the
-								       * PCI configuration register
-								       * space.
-								       */
+				ioaddr = pci_resource_start (dev, 3);
+				/* i.e at offset 0x1c in the
+				 * PCI configuration register
+				 * space.
+				 */
 				pciirq = dev->irq;
 				printk(KERN_INFO "ISI PCI Card(Device ID 0x%x)\n", isicom_pci_tbl[idx].device);
 				/*
 				 * allot the first empty slot in the array
-				 */				
-				for (count=0; count < BOARD_COUNT; count++) {				
+				 */
+				for (count=0; count < BOARD_COUNT; count++) {
 					if (isi_card[count].base == 0) {
 						isi_card[count].base = ioaddr;
 						isi_card[count].irq = pciirq;
@@ -2023,35 +2022,35 @@ static int __devinit isicom_setup(void)
 						break;
 					}
 				}
-			}				
+			}
 			if (card >= BOARD_COUNT) break;
 		}
 	}
-	
+
 	if (!(isi_card[0].base || isi_card[1].base || isi_card[2].base || isi_card[3].base)) {
-		printk(KERN_ERR "ISICOM: No valid card configuration. Driver cannot be initialized...\n"); 
+		printk(KERN_ERR "ISICOM: No valid card configuration. Driver cannot be initialized...\n");
 		return -EIO;
-	}	
+	}
 
 	retval = misc_register(&isiloader_device);
 	if (retval < 0) {
 		printk(KERN_ERR "ISICOM: Unable to register firmware loader driver.\n");
 		return retval;
 	}
-	
+
 	if (!isicom_init()) {
-		if (misc_deregister(&isiloader_device)) 
+		if (misc_deregister(&isiloader_device))
 			printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
 		return -EIO;
 	}
-	
+
 	init_timer(&tx);
 	tx.expires = jiffies + 1;
 	tx.data = 0;
 	tx.function = isicom_tx;
 	re_schedule = 1;
 	add_timer(&tx);
-	
+
 	return 0;
 }
 
@@ -2062,7 +2061,7 @@ static void __exit isicom_exit(void)
 	msleep(1000);
 	unregister_isr();
 	unregister_drivers();
-	unregister_ioregion();	
+	unregister_ioregion();
 	if(tmp_buf)
 		free_page((unsigned long)tmp_buf);
 	if (misc_deregister(&isiloader_device))
