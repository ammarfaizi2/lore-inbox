Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbRFZKOW>; Tue, 26 Jun 2001 06:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263918AbRFZKON>; Tue, 26 Jun 2001 06:14:13 -0400
Received: from [203.143.19.4] ([203.143.19.4]:13063 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S263485AbRFZKN7>;
	Tue, 26 Jun 2001 06:13:59 -0400
Date: Tue, 26 Jun 2001 00:59:50 +0600
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Fabian Arias <dewback@vtr.net>, Anatoly Ivanov <avi@levi.spb.ru>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] GCC v3 warning fixes #1 (Was: Re: 2.4.5 and gcc v3 final)
Message-ID: <20010626005950.A346@bee.lk>
In-Reply-To: <dewback@vtr.net> <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106241733.f5OHXpW2000565@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Sun, Jun 24, 2001 at 01:33:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 24, 2001 at 01:33:51PM -0400, Horst von Brand wrote:
> 
> What gcc objects to is stuff like:
> 
>    "This is a nice long string
>     that just goes on
>     and on\n"
> 
> which is illegal in C AFAIU. It does not object to:
> 
>    "This long string"
>    "spans several lines, "
>    "but legally.\n"
> 
> The first form does/did appear in several asm()s. Fix them, send a patch.

Here is the first patch, which will fix warnings on many drivers. It is not
tested. But most, if not all, changes should be obvious.

I have tried to keep the coding style as closely as possible to the surronding
code.

Cheers,

Anuradha

-- 

Debian GNU/Linux (kernel 2.4.6-pre5)

Reality is just a crutch for people who can't handle science fiction.



--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-1

diff -u --recursive --new-file linux-2.4.6-pre5/drivers/atm/iphase.c linux/drivers/atm/iphase.c
--- linux-2.4.6-pre5/drivers/atm/iphase.c	Mon Jun 25 23:50:30 2001
+++ linux/drivers/atm/iphase.c	Tue Jun 26 00:41:28 2001
@@ -203,8 +203,8 @@
         ltimeout = dev->desc_tbl[i].iavcc->ltimeout; 
         delta = jiffies - dev->desc_tbl[i].timestamp;
         if (delta >= ltimeout) {
-           IF_ABR(printk("RECOVER run!! desc_tbl %d = %d  delta = %ld, 
-               time = %ld\n", i,dev->desc_tbl[i].timestamp, delta, jiffies);)
+           IF_ABR(printk("RECOVER run!! desc_tbl %d = %d  delta = %ld, time = %ld\n",
+				   i,dev->desc_tbl[i].timestamp, delta, jiffies);)
            if (dev->ffL.tcq_rd == dev->ffL.tcq_st) 
               dev->ffL.tcq_rd =  dev->ffL.tcq_ed;
            else 
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/char/cyclades.c linux/drivers/char/cyclades.c
--- linux-2.4.6-pre5/drivers/char/cyclades.c	Mon Jun 25 23:50:08 2001
+++ linux/drivers/char/cyclades.c	Tue Jun 26 00:08:38 2001
@@ -3440,8 +3440,8 @@
 		}
 #ifdef CY_DEBUG_DTR
 		printk("cyc:set_line_char dropping DTR\n");
-		printk("     status: 0x%x,
-		    0x%x\n", cy_readb(base_addr+(CyMSVR1<<index)),
+		printk("     status: 0x%x, 0x%x\n",
+		    cy_readb(base_addr+(CyMSVR1<<index)),
 		    cy_readb(base_addr+(CyMSVR2<<index)));
 #endif
 	    }else{
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/char/h8.c linux/drivers/char/h8.c
--- linux-2.4.6-pre5/drivers/char/h8.c	Mon Jun 25 23:50:09 2001
+++ linux/drivers/char/h8.c	Tue Jun 26 00:24:20 2001
@@ -575,8 +575,8 @@
         }
 
         if (intrbuf.word & H8_POWER_BUTTON) {
-                printk("Power switch pressed - please wait - preparing to power 
-off\n");
+                printk("Power switch pressed - please wait - preparing to \
+power off\n");
                 h8_set_event_mask(H8_POWER_BUTTON);
                 wake_up(&h8_monitor_wait);
         }
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/char/rio/riocmd.c linux/drivers/char/rio/riocmd.c
--- linux-2.4.6-pre5/drivers/char/rio/riocmd.c	Mon Jun 25 23:50:11 2001
+++ linux/drivers/char/rio/riocmd.c	Tue Jun 26 00:26:38 2001
@@ -462,8 +462,8 @@
 		rio_dprintk (RIO_DEBUG_CMD, "PACKET information: Length	  0x%x (%d)\n", PacketP->len,PacketP->len );
 		rio_dprintk (RIO_DEBUG_CMD, "PACKET information: Control	 0x%x (%d)\n", PacketP->control, PacketP->control);
 		rio_dprintk (RIO_DEBUG_CMD, "PACKET information: Check	   0x%x (%d)\n", PacketP->csum, PacketP->csum );
-		rio_dprintk (RIO_DEBUG_CMD, "COMMAND information: Host Port Number 0x%x, 
-					Command Code 0x%x\n", PktCmdP->PhbNum, PktCmdP->Command );
+		rio_dprintk (RIO_DEBUG_CMD, "COMMAND information: Host Port Number 0x%x, Command Code 0x%x\n",
+			     PktCmdP->PhbNum, PktCmdP->Command );
 		return TRUE;
 	}
 
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/i2c/i2c-core.c linux/drivers/i2c/i2c-core.c
--- linux-2.4.6-pre5/drivers/i2c/i2c-core.c	Mon Jun 25 23:50:31 2001
+++ linux/drivers/i2c/i2c-core.c	Tue Jun 26 00:42:55 2001
@@ -381,10 +381,10 @@
 						printk("i2c-core.o: while "
 						       "unregistering driver "
 						       "`%s', the client at "
-						       "address %02x of
-						       adapter `%s' could not
-						       be detached; driver
-						       not unloaded!",
+						       "address %02x of "
+						       "adapter `%s' could not "
+						       "be detached; driver "
+						       "not unloaded!",
 						       driver->name,
 						       client->addr,
 						       adap->name);
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/i2o/i2o_core.c linux/drivers/i2o/i2o_core.c
--- linux-2.4.6-pre5/drivers/i2o/i2o_core.c	Mon Jun 25 23:50:30 2001
+++ linux/drivers/i2o/i2o_core.c	Tue Jun 26 00:39:38 2001
@@ -3319,8 +3319,8 @@
 	{
 		if(i2o_quiesce_controller(c))
 		{
-			printk(KERN_WARNING "i2o: Could not quiesce %s."  "
-				Verify setup on next system power up.\n", c->name);
+			printk(KERN_WARNING "i2o: Could not quiesce %s."
+				"  Verify setup on next system power up.\n", c->name);
 		}
 	}
 
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/net/pcmcia/fmvj18x_cs.c linux/drivers/net/pcmcia/fmvj18x_cs.c
--- linux-2.4.6-pre5/drivers/net/pcmcia/fmvj18x_cs.c	Mon Jun 25 23:50:06 2001
+++ linux/drivers/net/pcmcia/fmvj18x_cs.c	Tue Jun 26 00:13:06 2001
@@ -572,8 +572,7 @@
     case XXX10304:
 	/* Read MACID from Buggy CIS */
 	if (fmvj18x_get_hwinfo(link, tuple.TupleData) == -1) {
-	    printk(KERN_NOTICE "fmvj18x_cs: unable to read hardware net 
-		address.");
+	    printk(KERN_NOTICE "fmvj18x_cs: unable to read hardware net address.");
 	    unregister_netdev(dev);
 	    goto failed;
 	}
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/net/tokenring/olympic.c linux/drivers/net/tokenring/olympic.c
--- linux-2.4.6-pre5/drivers/net/tokenring/olympic.c	Mon Jun 25 23:50:01 2001
+++ linux/drivers/net/tokenring/olympic.c	Tue Jun 26 00:12:29 2001
@@ -598,8 +598,7 @@
 	printk(" stat_ring[7]: %p\n", &(olympic_priv->olympic_rx_status_ring[7])  );
 
 	printk("RXCDA: %x, rx_ring[0]: %p\n",readl(olympic_mmio+RXCDA),&olympic_priv->olympic_rx_ring[0]);
-	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr =
-%08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
+	printk("Rx_ring_dma_addr = %08x, rx_status_dma_addr = %08x\n",olympic_priv->rx_ring_dma_addr,olympic_priv->rx_status_ring_dma_addr) ; 
 #endif
 
 	writew((((readw(olympic_mmio+RXENQ)) & 0x8000) ^ 0x8000) | i,olympic_mmio+RXENQ);
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/scsi/aic7xxx/aicasm/aicasm.c linux/drivers/scsi/aic7xxx/aicasm/aicasm.c
--- linux-2.4.6-pre5/drivers/scsi/aic7xxx/aicasm/aicasm.c	Mon Jun 25 23:50:15 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm.c	Tue Jun 26 00:32:57 2001
@@ -264,8 +264,8 @@
 {
 
 	(void)fprintf(stderr,
-"usage: %-16s [-nostdinc] [-I-] [-I directory] [-o output_file]
-			[-r register_output_file] [-l program_list_file]
+"usage: %-16s [-nostdinc] [-I-] [-I directory] [-o output_file]\n\
+			[-r register_output_file] [-l program_list_file]\n\
 			input_file\n",
 			appname);
 	exit(EX_USAGE);
@@ -311,8 +311,8 @@
 
 	instrcount = 0;
 	fprintf(ofile,
-"/*
-  * DO NOT EDIT - This file is automatically generated.
+"/*\n\
+  * DO NOT EDIT - This file is automatically generated.\n\
   */\n");
 
 	fprintf(ofile, "static uint8_t seqprog[] = {\n");
@@ -344,12 +344,12 @@
 	    cur_node != NULL;
 	    cur_node = SLIST_NEXT(cur_node,links)) {
 		fprintf(ofile,
-"static int ahc_patch%d_func(struct ahc_softc *ahc);
-
-static int
-ahc_patch%d_func(struct ahc_softc *ahc)
-{
-	return (%s);
+"static int ahc_patch%d_func(struct ahc_softc *ahc);\n\
+\n\
+static int\n\
+ahc_patch%d_func(struct ahc_softc *ahc)\n\
+{\n\
+	return (%s);\n\
 }\n\n",
 			cur_node->symbol->info.condinfo->func_num,
 			cur_node->symbol->info.condinfo->func_num,
@@ -357,12 +357,12 @@
 	}
 
 	fprintf(ofile,
-"typedef int patch_func_t (struct ahc_softc *);
-struct patch {
-	patch_func_t	*patch_func;
-	uint32_t	begin	   :10,
-			skip_instr :10,
-			skip_patch :12;
+"typedef int patch_func_t (struct ahc_softc *);\n\
+struct patch {\n\
+	patch_func_t	*patch_func;\n\
+	uint32_t	begin	   :10,\n\
+			skip_instr :10,\n\
+			skip_patch :12;\n\
 } patches[] = {\n");
 
 	for(cur_patch = STAILQ_FIRST(&patches);
@@ -377,9 +377,9 @@
 	fprintf(ofile, "\n};\n");
 
 	fprintf(ofile,
-"struct cs {
-	u_int16_t	begin;
-	u_int16_t	end;
+"struct cs {\n\
+	u_int16_t	begin;\n\
+	u_int16_t	end;\n\
 } critical_sections[] = {\n");
 
 	for(cs = TAILQ_FIRST(&cs_tailq);
@@ -393,7 +393,7 @@
 	fprintf(ofile, "\n};\n");
 
 	fprintf(ofile,
-"const int num_critical_sections = sizeof(critical_sections)
+"const int num_critical_sections = sizeof(critical_sections)\n\
 				 / sizeof(*critical_sections);\n");
 
 	fprintf(stderr, "%s: %d instructions used\n", appname, instrcount);
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c
--- linux-2.4.6-pre5/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c	Mon Jun 25 23:50:15 2001
+++ linux/drivers/scsi/aic7xxx/aicasm/aicasm_symbol.c	Tue Jun 26 00:32:47 2001
@@ -388,8 +388,8 @@
 
 		/* Output what we have */
 		fprintf(ofile,
-"/*
-  * DO NOT EDIT - This file is automatically generated.
+"/*\n\
+  * DO NOT EDIT - This file is automatically generated.\n\
   */\n");
 		while (registers.slh_first != NULL) {
 			symbol_node_t *curnode;
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/scsi/sun3_NCR5380.c linux/drivers/scsi/sun3_NCR5380.c
--- linux-2.4.6-pre5/drivers/scsi/sun3_NCR5380.c	Mon Jun 25 23:50:17 2001
+++ linux/drivers/scsi/sun3_NCR5380.c	Tue Jun 26 00:34:32 2001
@@ -1229,7 +1229,7 @@
 					    BASR_ACK)) ==
        (BASR_PHASE_MATCH | BASR_ACK)) {
 	    printk("scsi%d: BASR %02x\n", HOSTNO, NCR5380_read(BUS_AND_STATUS_REG));
-	    printk("scsi%d: bus stuck in data phase -- probably a
+	    printk("scsi%d: bus stuck in data phase -- probably a\
  single byte overrun!\n", HOSTNO); 
 	    printk("not prepared for this error!\n");
 	    printk("please e-mail sammy@oh.verio.com with a description of how this\n");
diff -u --recursive --new-file linux-2.4.6-pre5/drivers/usb/serial/keyspan.c linux/drivers/usb/serial/keyspan.c
--- linux-2.4.6-pre5/drivers/usb/serial/keyspan.c	Mon Jun 25 23:50:29 2001
+++ linux/drivers/usb/serial/keyspan.c	Tue Jun 26 00:38:12 2001
@@ -548,8 +548,7 @@
 
 	do {
 		if (urb->status) {
-			dbg(__FUNCTION__ "nonzero status: %x on endpoint
-%d.",
+			dbg(__FUNCTION__ "nonzero status: %x on endpoint %d.",
 			    urb->status, usb_pipeendpoint(urb->pipe));
 			return;
 		}

--u3/rZRmxL6MmkK24--
