Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263998AbTCVWtU>; Sat, 22 Mar 2003 17:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263992AbTCVWsh>; Sat, 22 Mar 2003 17:48:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17797
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263930AbTCVWpJ>; Sat, 22 Mar 2003 17:45:09 -0500
Date: Sun, 23 Mar 2003 00:00:49 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303230000.h2N00nZX020752@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: parallel port
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has been floating around for ages, and in -ac for a while too - is
there some reason it wasnt merged or did it just escape ?

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/init.c linux-2.5.65-ac3/drivers/parport/init.c
--- linux-2.5.65-bk3/drivers/parport/init.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/init.c	2003-03-06 23:08:36.000000000 +0000
@@ -227,17 +227,3 @@
 EXPORT_SYMBOL(parport_find_device);
 EXPORT_SYMBOL(parport_find_class);
 #endif
-
-void inc_parport_count(void)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-void dec_parport_count(void)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_amiga.c linux-2.5.65-ac3/drivers/parport/parport_amiga.c
--- linux-2.5.65-bk3/drivers/parport/parport_amiga.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_amiga.c	2003-03-06 23:08:46.000000000 +0000
@@ -195,51 +195,40 @@
 	mb();
 }
 
-static void amiga_inc_use_count(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void amiga_dec_use_count(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static struct parport_operations pp_amiga_ops = {
-	amiga_write_data,
-	amiga_read_data,
+	.write_data	= amiga_write_data,
+	.read_data	= amiga_read_data,
 
-	amiga_write_control,
-	amiga_read_control,
-	amiga_frob_control,
+	.write_control	= amiga_write_control,
+	.read_control	= amiga_read_control,
+	.frob_control	= amiga_frob_control,
 
-	amiga_read_status,
+	.read_status	= amiga_read_status,
 
-	amiga_enable_irq,
-	amiga_disable_irq,
+	.enable_irq	= amiga_enable_irq,
+	.disable_irq	= amiga_disable_irq,
 
-	amiga_data_forward,
-	amiga_data_reverse,
+	.data_forward	= amiga_data_forward,
+	.data_reverse	= amiga_data_reverse,
 
-	amiga_init_state,
-	amiga_save_state,
-	amiga_restore_state,
+	.init_state	= amiga_init_state,
+	.save_state	= amiga_save_state,
+	.restore_state	= amiga_restore_state,
 
-	amiga_inc_use_count,
-	amiga_dec_use_count,
+	.epp_write_data	= parport_ieee1284_epp_write_data,
+	.epp_read_data	= parport_ieee1284_epp_read_data,
+	.epp_write_addr	= parport_ieee1284_epp_write_addr,
+	.epp_read_addr	= parport_ieee1284_epp_read_addr,
 
-	parport_ieee1284_epp_write_data,
-	parport_ieee1284_epp_read_data,
-	parport_ieee1284_epp_write_addr,
-	parport_ieee1284_epp_read_addr,
+	.ecp_write_data	= parport_ieee1284_ecp_write_data,
+	.ecp_read_data	= parport_ieee1284_ecp_read_data,
+	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
 
-	parport_ieee1284_ecp_write_data,
-	parport_ieee1284_ecp_read_data,
-	parport_ieee1284_ecp_write_addr,
+	.compat_write_data	= parport_ieee1284_write_compat,
+	.nibble_read_data	= parport_ieee1284_read_nibble,
+	.byte_read_data		= parport_ieee1284_read_byte,
 
-	parport_ieee1284_write_compat,
-	parport_ieee1284_read_nibble,
-	parport_ieee1284_read_byte,
+	.owner		= THIS_MODULE,
 };
 
 /* ----------- Initialisation code --------------------------------- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_arc.c linux-2.5.65-ac3/drivers/parport/parport_arc.c
--- linux-2.5.65-bk3/drivers/parport/parport_arc.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_arc.c	2003-03-06 23:08:51.000000000 +0000
@@ -65,56 +65,41 @@
 	return data_copy;
 }
 
-static void arc_inc_use_count(void)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void arc_dec_use_count(void)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 static struct parport_operations parport_arc_ops = 
 {
-	arc_write_data,
-	arc_read_data,
+	.write_data	= arc_write_data,
+	.read_data	= arc_read_data,
 
-	arc_write_control,
-	arc_read_control,
-	arc_frob_control,
+	.write_control	= arc_write_control,
+	.read_control	= arc_read_control,
+	.frob_control	= arc_frob_control,
 
-	arc_read_status,
+	.read_status	= arc_read_status,
 
-	arc_enable_irq,
-	arc_disable_irq,
+	.enable_irq	= arc_enable_irq,
+	.disable_irq	= arc_disable_irq,
 
-	arc_data_forward,
-	arc_data_reverse,
+	.data_forward	= arc_data_forward,
+	.data_reverse	= arc_data_reverse,
 
-	arc_init_state,
-	arc_save_state,
-	arc_restore_state,
+	.init_state	= arc_init_state,
+	.save_state	= arc_save_state,
+	.restore_state	= arc_restore_state,
 
-	arc_inc_use_count,
-	arc_dec_use_count,
+	.epp_write_data	= parport_ieee1284_epp_write_data,
+	.epp_read_data	= parport_ieee1284_epp_read_data,
+	.epp_write_addr	= parport_ieee1284_epp_write_addr,
+	.epp_read_addr	= parport_ieee1284_epp_read_addr,
 
-	parport_ieee1284_epp_write_data,
-	parport_ieee1284_epp_read_data,
-	parport_ieee1284_epp_write_addr,
-	parport_ieee1284_epp_read_addr,
-
-	parport_ieee1284_ecp_write_data,
-	parport_ieee1284_ecp_read_data,
-	parport_ieee1284_ecp_write_addr,
+	.ecp_write_data	= parport_ieee1284_ecp_write_data,
+	.ecp_read_data	= parport_ieee1284_ecp_read_data,
+	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
 	
-	parport_ieee1284_write_compat,
-	parport_ieee1284_read_nibble,
-	parport_ieee1284_read_byte,
+	.compat_write_data	= parport_ieee1284_write_compat,
+	.nibble_read_data	= parport_ieee1284_read_nibble,
+	.byte_read_data		= parport_ieee1284_read_byte,
+
+	.owner		= THIS_MODULE,
 };
 
 /* --- Initialisation code -------------------------------- */
@@ -123,18 +108,24 @@
 {
 	/* Archimedes hardware provides only one port, at a fixed address */
 	struct parport *p;
+	struct resource res;
+	char *fake_name = "parport probe");
 
-	if (check_region(PORT_BASE, 1))
+	res = request_region(PORT_BASE, 1, fake_name);
+	if (res == NULL)
 		return 0;
 
 	p = parport_register_port (PORT_BASE, IRQ_PRINTERACK,
 				   PARPORT_DMA_NONE, &parport_arc_ops);
 
-	if (!p)
+	if (!p) {
+		release_region(PORT_BASE, 1);
 		return 0;
+	}
 
 	p->modes = PARPORT_MODE_ARCSPP;
 	p->size = 1;
+	rename_region(res, p->name);
 
 	printk(KERN_INFO "%s: Archimedes on-board port, using irq %d\n",
 	       p->irq);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_atari.c linux-2.5.65-ac3/drivers/parport/parport_atari.c
--- linux-2.5.65-bk3/drivers/parport/parport_atari.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_atari.c	2003-03-06 23:08:56.000000000 +0000
@@ -147,53 +147,40 @@
 #endif
 }
 
-static void
-parport_atari_inc_use_count(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void
-parport_atari_dec_use_count(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static struct parport_operations parport_atari_ops = {
-	parport_atari_write_data,
-	parport_atari_read_data,
+	.write_data	= parport_atari_write_data,
+	.read_data	= parport_atari_read_data,
 
-	parport_atari_write_control,
-	parport_atari_read_control,
-	parport_atari_frob_control,
+	.write_control	= parport_atari_write_control,
+	.read_control	= parport_atari_read_control,
+	.frob_control	= parport_atari_frob_control,
 
-	parport_atari_read_status,
+	.read_status	= parport_atari_read_status,
 
-	parport_atari_enable_irq,
-	parport_atari_disable_irq,
+	.enable_irq	= parport_atari_enable_irq,
+	.disable_irq	= parport_atari_disable_irq,
 
-	parport_atari_data_forward,
-	parport_atari_data_reverse,
+	.data_forward	= parport_atari_data_forward,
+	.data_reverse	= parport_atari_data_reverse,
 
-	parport_atari_init_state,
-	parport_atari_save_state,
-	parport_atari_restore_state,
+	.init_state	= parport_atari_init_state,
+	.save_state	= parport_atari_save_state,
+	.restore_state	= parport_atari_restore_state,
 
-	parport_atari_inc_use_count,
-	parport_atari_dec_use_count,
+	.epp_write_data	= parport_ieee1284_epp_write_data,
+	.epp_read_data	= parport_ieee1284_epp_read_data,
+	.epp_write_addr	= parport_ieee1284_epp_write_addr,
+	.epp_read_addr	= parport_ieee1284_epp_read_addr,
 
-	parport_ieee1284_epp_write_data,
-	parport_ieee1284_epp_read_data,
-	parport_ieee1284_epp_write_addr,
-	parport_ieee1284_epp_read_addr,
+	.ecp_write_data	= parport_ieee1284_ecp_write_data,
+	.ecp_read_data	= parport_ieee1284_ecp_read_data,
+	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
 
-	parport_ieee1284_ecp_write_data,
-	parport_ieee1284_ecp_read_data,
-	parport_ieee1284_ecp_write_addr,
+	.compat_write_data	= parport_ieee1284_write_compat,
+	.nibble_read_data	= parport_ieee1284_read_nibble,
+	.byte_read_data		= parport_ieee1284_read_byte,
 
-	parport_ieee1284_write_compat,
-	parport_ieee1284_read_nibble,
-	parport_ieee1284_read_byte,
+	.owner		= THIS_MODULE,
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_gsc.c linux-2.5.65-ac3/drivers/parport/parport_gsc.c
--- linux-2.5.65-bk3/drivers/parport/parport_gsc.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_gsc.c	2003-03-06 23:09:01.000000000 +0000
@@ -190,17 +190,6 @@
 	parport_writeb (s->u.pc.ctr, CONTROL (p));
 }
 
-void parport_gsc_inc_use_count(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-void parport_gsc_dec_use_count(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
-
 struct parport_operations parport_gsc_ops = 
 {
 	.write_data	= parport_gsc_write_data,
@@ -222,9 +211,6 @@
 	.save_state	= parport_gsc_save_state,
 	.restore_state	= parport_gsc_restore_state,
 
-	.inc_use_count	= parport_gsc_inc_use_count,
-	.dec_use_count	= parport_gsc_dec_use_count,
-
 	.epp_write_data	= parport_ieee1284_epp_write_data,
 	.epp_read_data	= parport_ieee1284_epp_read_data,
 	.epp_write_addr	= parport_ieee1284_epp_write_addr,
@@ -237,6 +223,8 @@
 	.compat_write_data 	= parport_ieee1284_write_compat,
 	.nibble_read_data	= parport_ieee1284_read_nibble,
 	.byte_read_data		= parport_ieee1284_read_byte,
+
+	.owner		= THIS_MODULE,
 };
 
 /* --- Mode detection ------------------------------------- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_mfc3.c linux-2.5.65-ac3/drivers/parport/parport_mfc3.c
--- linux-2.5.65-bk3/drivers/parport/parport_mfc3.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_mfc3.c	2003-03-06 23:09:05.000000000 +0000
@@ -281,51 +281,40 @@
 	pia(p)->cra |= PIA_DDR;
 }
 
-static void mfc3_inc_use_count(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void mfc3_dec_use_count(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static struct parport_operations pp_mfc3_ops = {
-	mfc3_write_data,
-	mfc3_read_data,
+	.write_data	= mfc3_write_data,
+	.read_data	= mfc3_read_data,
 
-	mfc3_write_control,
-	mfc3_read_control,
-	mfc3_frob_control,
+	.write_control	= mfc3_write_control,
+	.read_control	= mfc3_read_control,
+	.frob_control	= mfc3_frob_control,
 
-	mfc3_read_status,
+	.read_status	= mfc3_read_status,
 
-	mfc3_enable_irq,
-	mfc3_disable_irq,
+	.enable_irq	= mfc3_enable_irq,
+	.disable_irq	= mfc3_disable_irq,
 
-	mfc3_data_forward, 
-	mfc3_data_reverse, 
+	.data_forward	= mfc3_data_forward, 
+	.data_reverse	= mfc3_data_reverse, 
 
-	mfc3_init_state,
-	mfc3_save_state,
-	mfc3_restore_state,
+	.init_state	= mfc3_init_state,
+	.save_state	= mfc3_save_state,
+	.restore_state	= mfc3_restore_state,
 
-	mfc3_inc_use_count,
-	mfc3_dec_use_count,
+	.epp_write_data	= parport_ieee1284_epp_write_data,
+	.epp_read_data	= parport_ieee1284_epp_read_data,
+	.epp_write_addr	= parport_ieee1284_epp_write_addr,
+	.epp_read_addr	= parport_ieee1284_epp_read_addr,
 
-	parport_ieee1284_epp_write_data,
-	parport_ieee1284_epp_read_data,
-	parport_ieee1284_epp_write_addr,
-	parport_ieee1284_epp_read_addr,
+	.ecp_write_data	= parport_ieee1284_ecp_write_data,
+	.ecp_read_data	= parport_ieee1284_ecp_read_data,
+	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
 
-	parport_ieee1284_ecp_write_data,
-	parport_ieee1284_ecp_read_data,
-	parport_ieee1284_ecp_write_addr,
+	.compat_write_data	= parport_ieee1284_write_compat,
+	.nibble_read_data	= parport_ieee1284_read_nibble,
+	.byte_read_data		= parport_ieee1284_read_byte,
 
-	parport_ieee1284_write_compat,
-	parport_ieee1284_read_nibble,
-	parport_ieee1284_read_byte,
+	.owner		= THIS_MODULE,
 };
 
 /* ----------- Initialisation code --------------------------------- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_pc.c linux-2.5.65-ac3/drivers/parport/parport_pc.c
--- linux-2.5.65-bk3/drivers/parport/parport_pc.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_pc.c	2003-03-06 23:08:41.000000000 +0000
@@ -1232,57 +1232,41 @@
  *	******************************************
  */
 
-
-void parport_pc_inc_use_count(void)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-void parport_pc_dec_use_count(void)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 struct parport_operations parport_pc_ops = 
 {
-	parport_pc_write_data,
-	parport_pc_read_data,
+	.write_data	= parport_pc_write_data,
+	.read_data	= parport_pc_read_data,
 
-	parport_pc_write_control,
-	parport_pc_read_control,
-	parport_pc_frob_control,
+	.write_control	= parport_pc_write_control,
+	.read_control	= parport_pc_read_control,
+	.frob_control	= parport_pc_frob_control,
 
-	parport_pc_read_status,
+	.read_status	= parport_pc_read_status,
 
-	parport_pc_enable_irq,
-	parport_pc_disable_irq,
+	.enable_irq	= parport_pc_enable_irq,
+	.disable_irq	= parport_pc_disable_irq,
 
-	parport_pc_data_forward,
-	parport_pc_data_reverse,
+	.data_forward	= parport_pc_data_forward,
+	.data_reverse	= parport_pc_data_reverse,
 
-	parport_pc_init_state,
-	parport_pc_save_state,
-	parport_pc_restore_state,
+	.init_state	= parport_pc_init_state,
+	.save_state	= parport_pc_save_state,
+	.restore_state	= parport_pc_restore_state,
 
-	parport_pc_inc_use_count,
-	parport_pc_dec_use_count,
+	.epp_write_data	= parport_ieee1284_epp_write_data,
+	.epp_read_data	= parport_ieee1284_epp_read_data,
+	.epp_write_addr	= parport_ieee1284_epp_write_addr,
+	.epp_read_addr	= parport_ieee1284_epp_read_addr,
 
-	parport_ieee1284_epp_write_data,
-	parport_ieee1284_epp_read_data,
-	parport_ieee1284_epp_write_addr,
-	parport_ieee1284_epp_read_addr,
+	.ecp_write_data	= parport_ieee1284_ecp_write_data,
+	.ecp_read_data	= parport_ieee1284_ecp_read_data,
+	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
 
-	parport_ieee1284_ecp_write_data,
-	parport_ieee1284_ecp_read_data,
-	parport_ieee1284_ecp_write_addr,
+	.compat_write_data	= parport_ieee1284_write_compat,
+	.nibble_read_data	= parport_ieee1284_read_nibble,
+	.byte_read_data		= parport_ieee1284_read_byte,
 
-	parport_ieee1284_write_compat,
-	parport_ieee1284_read_nibble,
-	parport_ieee1284_read_byte,
+	.owner		= THIS_MODULE,
 };
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
@@ -2212,16 +2196,32 @@
 	struct parport tmp;
 	struct parport *p = &tmp;
 	int probedirq = PARPORT_IRQ_NONE;
-	if (check_region(base, 3)) return NULL;
+	struct resource *base_res;
+	struct resource	*ECR_res = NULL;
+	struct resource	*EPP_res = NULL;
+	char *fake_name = "parport probe";
+
+	/*
+	 * Chicken and Egg problem.  request_region() wants the name of
+	 * the owner, but this instance will not know that name until
+	 * after the parport_register_port() call.  Give request_region()
+	 * a fake name until after parport_register_port(), then use
+	 * rename_region() to set correct name.
+	 */
+	base_res = request_region(base, 3, fake_name);
+	if (base_res == NULL)
+		return NULL;
 	priv = kmalloc (sizeof (struct parport_pc_private), GFP_KERNEL);
 	if (!priv) {
 		printk (KERN_DEBUG "parport (0x%lx): no memory!\n", base);
+		release_region(base, 3);
 		return NULL;
 	}
 	ops = kmalloc (sizeof (struct parport_operations), GFP_KERNEL);
 	if (!ops) {
 		printk (KERN_DEBUG "parport (0x%lx): no memory for ops!\n",
 			base);
+		release_region(base, 3);
 		kfree (priv);
 		return NULL;
 	}
@@ -2242,32 +2242,39 @@
 	p->private_data = priv;
 	p->physport = p;
 
-	if (base_hi && !check_region(base_hi,3))
-		parport_ECR_present(p);
+	if (base_hi) {
+		ECR_res = request_region(base_hi, 3, fake_name);
+		if (ECR_res)
+			parport_ECR_present(p);
+	}
 
 	if (base != 0x3bc) {
-		if (!check_region(base+0x3, 5)) {
+		EPP_res = request_region(base+0x3, 5, fake_name);
+		if (EPP_res)
 			if (!parport_EPP_supported(p))
 				parport_ECPEPP_supported(p);
-		}
 	}
-	if (!parport_SPP_supported (p)) {
+	if (!parport_SPP_supported (p))
 		/* No port. */
-		kfree (priv);
-		kfree (ops);
-		return NULL;
-	}
+		goto errout;
 	if (priv->ecr)
 		parport_ECPPS2_supported(p);
 	else
 		parport_PS2_supported (p);
 
 	if (!(p = parport_register_port(base, PARPORT_IRQ_NONE,
-					PARPORT_DMA_NONE, ops))) {
-		kfree (priv);
-		kfree (ops);
-		return NULL;
-	}
+					PARPORT_DMA_NONE, ops)))
+		goto errout;
+
+	/*
+	 * Now the real name is known... Replace the fake name
+	 * in the resources with the correct one.
+	 */
+	rename_region(base_res, p->name);
+	if (ECR_res)
+		rename_region(ECR_res, p->name);
+	if (EPP_res)
+		rename_region(EPP_res, p->name);
 
 	p->base_hi = base_hi;
 	p->modes = tmp.modes;
@@ -2343,11 +2350,11 @@
 		printk(KERN_INFO "%s: irq %d detected\n", p->name, probedirq);
 	parport_proc_register(p);
 
-	request_region (p->base, 3, p->name);
-	if (p->size > 3)
-		request_region (p->base + 3, p->size - 3, p->name);
-	if (p->modes & PARPORT_MODE_ECP)
-		request_region (p->base_hi, 3, p->name);
+	/* If No ECP release the ports grabbed above. */
+	if (ECR_res && (p->modes & PARPORT_MODE_ECP) == 0) {
+		release_region(base_hi, 3);
+		ECR_res = NULL;
+	}
 
 	if (p->irq != PARPORT_IRQ_NONE) {
 		if (request_irq (p->irq, parport_pc_interrupt,
@@ -2401,6 +2408,17 @@
 	parport_announce_port (p);
 
 	return p;
+
+errout:
+	release_region(p->base, 3);
+	if (ECR_res)
+		release_region(base_hi, 3);
+	if (EPP_res)
+		release_region(base+0x3, 5);
+
+	kfree (priv);
+	kfree (ops);
+	return NULL;
 }
 
 void parport_pc_unregister_port (struct parport *p)
@@ -2437,9 +2455,11 @@
 					 int autodma)
 {
 	short inta_addr[6] = { 0x2A0, 0x2C0, 0x220, 0x240, 0x1E0 };
+	struct resource *base_res;
 	u32 ite8872set;
 	u32 ite8872_lpt, ite8872_lpthi;
 	u8 ite8872_irq, type;
+	char *fake_name = "parport probe";
 	int irq;
 	int i;
 
@@ -2447,7 +2467,8 @@
 	
 	// make sure which one chip
 	for(i = 0; i < 5; i++) {
-		if (check_region (inta_addr[i], 0x8) >= 0) {
+		base_res = request_region(inta_addr[i], 0x8, fake_name);
+		if (base_res) {
 			int test;
 			pci_write_config_dword (pdev, 0x60,
 						0xe7000000 | inta_addr[i]);
@@ -2455,6 +2476,7 @@
 						0x00000000 | inta_addr[i]);
 			test = inb (inta_addr[i]);
 			if (test != 0xff) break;
+			release_region(inta_addr[i], 0x8);
 		}
 	}
 	if(i >= 5) {
@@ -2515,6 +2537,10 @@
 	if (autoirq != PARPORT_IRQ_AUTO)
 		irq = PARPORT_IRQ_NONE;
 
+	/*
+	 * Release the resource so that parport_pc_probe_port can get it.
+	 */
+	release_resource(base_res);
 	if (parport_pc_probe_port (ite8872_lpt, ite8872_lpthi,
 				   irq, PARPORT_DMA_NONE, NULL)) {
 		printk (KERN_INFO
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/parport_sunbpp.c linux-2.5.65-ac3/drivers/parport/parport_sunbpp.c
--- linux-2.5.65-bk3/drivers/parport/parport_sunbpp.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/parport_sunbpp.c	2003-03-06 23:08:12.000000000 +0000
@@ -249,56 +249,41 @@
 	parport_sunbpp_write_control(p, s->u.pc.ctr);
 }
 
-static void parport_sunbpp_inc_use_count(void)
-{
-#ifdef MODULE
-	MOD_INC_USE_COUNT;
-#endif
-}
-
-static void parport_sunbpp_dec_use_count(void)
-{
-#ifdef MODULE
-	MOD_DEC_USE_COUNT;
-#endif
-}
-
 static struct parport_operations parport_sunbpp_ops = 
 {
-	parport_sunbpp_write_data,
-	parport_sunbpp_read_data,
+	.write_data	= parport_sunbpp_write_data,
+	.read_data	= parport_sunbpp_read_data,
 
-	parport_sunbpp_write_control,
-	parport_sunbpp_read_control,
-	parport_sunbpp_frob_control,
+	.write_control	= parport_sunbpp_write_control,
+	.read_control	= parport_sunbpp_read_control,
+	.frob_control	= parport_sunbpp_frob_control,
 
-	parport_sunbpp_read_status,
+	.read_status	= parport_sunbpp_read_status,
 
-	parport_sunbpp_enable_irq,
-        parport_sunbpp_disable_irq,
+	.enable_irq	= parport_sunbpp_enable_irq,
+	.disable_irq	= parport_sunbpp_disable_irq,
 
-        parport_sunbpp_data_forward,
-        parport_sunbpp_data_reverse,
+	.data_forward	= parport_sunbpp_data_forward,
+	.data_reverse	= parport_sunbpp_data_reverse,
 
-        parport_sunbpp_init_state,
-        parport_sunbpp_save_state,
-        parport_sunbpp_restore_state,
+	.init_state	= parport_sunbpp_init_state,
+	.save_state	= parport_sunbpp_save_state,
+	.restore_state	= parport_sunbpp_restore_state,
 
-        parport_sunbpp_inc_use_count,
-        parport_sunbpp_dec_use_count,
+	.epp_write_data	= parport_ieee1284_epp_write_data,
+	.epp_read_data	= parport_ieee1284_epp_read_data,
+	.epp_write_addr	= parport_ieee1284_epp_write_addr,
+	.epp_read_addr	= parport_ieee1284_epp_read_addr,
 
-        parport_ieee1284_epp_write_data,
-        parport_ieee1284_epp_read_data,
-        parport_ieee1284_epp_write_addr,
-        parport_ieee1284_epp_read_addr,
+	.ecp_write_data	= parport_ieee1284_ecp_write_data,
+	.ecp_read_data	= parport_ieee1284_ecp_read_data,
+	.ecp_write_addr	= parport_ieee1284_ecp_write_addr,
 
-        parport_ieee1284_ecp_write_data,
-        parport_ieee1284_ecp_read_data,
-        parport_ieee1284_ecp_write_addr,
+	.compat_write_data	= parport_ieee1284_write_compat,
+	.nibble_read_data	= parport_ieee1284_read_nibble,
+	.byte_read_data		= parport_ieee1284_read_byte,
 
-        parport_ieee1284_write_compat,
-        parport_ieee1284_read_nibble,
-        parport_ieee1284_read_byte,
+	.owner		= THIS_MODULE,
 };
 
 static int __init init_one_port(struct sbus_dev *sdev)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/parport/share.c linux-2.5.65-ac3/drivers/parport/share.c
--- linux-2.5.65-bk3/drivers/parport/share.c	2003-03-22 19:33:50.000000000 +0000
+++ linux-2.5.65-ac3/drivers/parport/share.c	2003-03-06 23:08:36.000000000 +0000
@@ -55,37 +55,44 @@
 static void dead_onearg (struct parport *p){}
 static void dead_initstate (struct pardevice *d, struct parport_state *s) { }
 static void dead_state (struct parport *p, struct parport_state *s) { }
-static void dead_noargs (void) { }
 static size_t dead_write (struct parport *p, const void *b, size_t l, int f)
 { return 0; }
 static size_t dead_read (struct parport *p, void *b, size_t l, int f)
 { return 0; }
 static struct parport_operations dead_ops = {
-	dead_write_lines,	/* data */
-	dead_read_lines,
-	dead_write_lines,	/* control */
-	dead_read_lines,
-	dead_frob_lines,
-	dead_read_lines,	/* status */
-	dead_onearg,		/* enable_irq */
-	dead_onearg,		/* disable_irq */
-	dead_onearg,		/* data_forward */
-	dead_onearg,		/* data_reverse */
-	dead_initstate,		/* init_state */
-	dead_state,
-	dead_state,
-	dead_noargs,		/* xxx_use_count */
-	dead_noargs,
-	dead_write,		/* epp */
-	dead_read,
-	dead_write,
-	dead_read,
-	dead_write,		/* ecp */
-	dead_read,
-	dead_write,
-	dead_write,		/* compat */
-	dead_read,		/* nibble */
-	dead_read		/* byte */
+	.write_data	= dead_write_lines,	/* data */
+	.read_data	= dead_read_lines,
+
+	.write_control	= dead_write_lines,	/* control */
+	.read_control	= dead_read_lines,
+	.frob_control	= dead_frob_lines,
+
+	.read_status	= dead_read_lines,	/* status */
+
+	.enable_irq	= dead_onearg,		/* enable_irq */
+	.disable_irq	= dead_onearg,		/* disable_irq */
+
+	.data_forward	= dead_onearg,		/* data_forward */
+	.data_reverse	= dead_onearg,		/* data_reverse */
+
+	.init_state	= dead_initstate,	/* init_state */
+	.save_state	= dead_state,
+	.restore_state	= dead_state,
+
+	.epp_write_data	= dead_write,		/* epp */
+	.epp_read_data	= dead_read,
+	.epp_write_addr	= dead_write,
+	.epp_read_addr	= dead_read,
+
+	.ecp_write_data	= dead_write,		/* ecp */
+	.ecp_read_data	= dead_read,
+	.ecp_write_addr	= dead_write,
+ 
+	.compat_write_data	= dead_write,	/* compat */
+	.nibble_read_data	= dead_read,	/* nibble */
+	.byte_read_data		= dead_read,	/* byte */
+
+	.owner		= NULL,
 };
 
 /* Call attach(port) for each registered driver. */
@@ -390,25 +397,6 @@
 		return NULL;
 	}
 
-	/* Search for the lowest free parport number. */
-
-	spin_lock_irq (&parportlist_lock);
-	for (portnum = 0; ; portnum++) {
-		struct parport *itr = portlist;
-		while (itr) {
-			if (itr->number == portnum)
-				/* No good, already used. */
-				break;
-			else
-				itr = itr->next;
-		}
-
-		if (itr == NULL)
-			/* Got to the end of the list. */
-			break;
-	}
-	spin_unlock_irq (&parportlist_lock);
-	
 	/* Init our structure */
  	memset(tmp, 0, sizeof(struct parport));
 	tmp->base = base;
@@ -420,7 +408,6 @@
 	tmp->devices = tmp->cad = NULL;
 	tmp->flags = 0;
 	tmp->ops = ops;
-	tmp->portnum = tmp->number = portnum;
 	tmp->physport = tmp;
 	memset (tmp->probe_info, 0, 5 * sizeof (struct parport_device_info));
 	tmp->cad_lock = RW_LOCK_UNLOCKED;
@@ -438,9 +425,32 @@
 		kfree(tmp);
 		return NULL;
 	}
+	/* Search for the lowest free parport number. */
+
+	spin_lock_irq (&parportlist_lock);
+	for (portnum = 0; ; portnum++) {
+		struct parport *itr = portlist;
+		while (itr) {
+			if (itr->number == portnum)
+				/* No good, already used. */
+				break;
+			else
+				itr = itr->next;
+		}
+
+		if (itr == NULL)
+			/* Got to the end of the list. */
+			break;
+	}
+
+	/*
+	 * Now that the portnum is known finish doing the Init.
+	 */
+	tmp->portnum = tmp->number = portnum;
 	sprintf(name, "parport%d", portnum);
 	tmp->name = name;
 
+	
 	/*
 	 * Chain the entry to our list.
 	 *
@@ -448,8 +458,6 @@
 	 * to clear irq on the local CPU. -arca
 	 */
 
-	spin_lock(&parportlist_lock);
-
 	/* We are locked against anyone else performing alterations, but
 	 * because of parport_enumerate people can still _read_ the list
 	 * while we are changing it; so be careful..
@@ -664,8 +672,10 @@
            kmalloc.  To be absolutely safe, we have to require that
            our caller doesn't sleep in between parport_enumerate and
            parport_register_device.. */
-	inc_parport_count();
-	port->ops->inc_use_count();
+	if (!try_module_get(port->ops->owner)) {
+		return NULL;
+	}
+		
 	parport_get_port (port);
 
 	tmp = kmalloc(sizeof(struct pardevice), GFP_KERNEL);
@@ -736,9 +746,9 @@
  out_free_pardevice:
 	kfree (tmp);
  out:
-	dec_parport_count();
-	port->ops->dec_use_count();
 	parport_put_port (port);
+	module_put(port->ops->owner);
+
 	return NULL;
 }
 
@@ -801,8 +811,7 @@
 	kfree(dev->state);
 	kfree(dev);
 
-	dec_parport_count();
-	port->ops->dec_use_count();
+	module_put(port->ops->owner);
 	parport_put_port (port);
 
 	/* Yes, that's right, someone _could_ still have a pointer to
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/include/linux/parport.h linux-2.5.65-ac3/include/linux/parport.h
--- linux-2.5.65-bk3/include/linux/parport.h	2003-03-22 19:34:04.000000000 +0000
+++ linux-2.5.65-ac3/include/linux/parport.h	2003-03-06 23:08:36.000000000 +0000
@@ -166,9 +166,6 @@
 	void (*save_state)(struct parport *, struct parport_state *);
 	void (*restore_state)(struct parport *, struct parport_state *);
 
-	void (*inc_use_count)(void);
-	void (*dec_use_count)(void);
-
 	/* Block read/write */
 	size_t (*epp_write_data) (struct parport *port, const void *buf,
 				  size_t len, int flags);
@@ -192,6 +189,7 @@
 				    size_t len, int flags);
 	size_t (*byte_read_data) (struct parport *port, void *buf,
 				  size_t len, int flags);
+	struct module *owner;
 };
 
 struct parport_device_info {
@@ -541,9 +539,6 @@
 extern int parport_default_proc_register(void);
 extern int parport_default_proc_unregister(void);
 
-extern void dec_parport_count(void);
-extern void inc_parport_count(void);
-
 /* If PC hardware is the only type supported, we can optimise a bit.  */
 #if (defined(CONFIG_PARPORT_PC) || defined(CONFIG_PARPORT_PC_MODULE)) && !(defined(CONFIG_PARPORT_ARC) || defined(CONFIG_PARPORT_ARC_MODULE)) && !(defined(CONFIG_PARPORT_AMIGA) || defined(CONFIG_PARPORT_AMIGA_MODULE)) && !(defined(CONFIG_PARPORT_MFC3) || defined(CONFIG_PARPORT_MFC3_MODULE)) && !(defined(CONFIG_PARPORT_ATARI) || defined(CONFIG_PARPORT_ATARI_MODULE)) && !(defined(CONFIG_USB_USS720) || defined(CONFIG_USB_USS720_MODULE)) && !(defined(CONFIG_PARPORT_SUNBPP) || defined(CONFIG_PARPORT_SUNBPP_MODULE)) && !defined(CONFIG_PARPORT_OTHER)
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/include/linux/parport_pc.h linux-2.5.65-ac3/include/linux/parport_pc.h
--- linux-2.5.65-bk3/include/linux/parport_pc.h	2003-03-22 19:34:04.000000000 +0000
+++ linux-2.5.65-ac3/include/linux/parport_pc.h	2003-03-06 23:08:41.000000000 +0000
@@ -215,10 +215,6 @@
 
 extern void parport_pc_restore_state(struct parport *p, struct parport_state *s);
 
-extern void parport_pc_inc_use_count(void);
-
-extern void parport_pc_dec_use_count(void);
-
 /* PCMCIA code will want to get us to look at a port.  Provide a mechanism. */
 extern struct parport *parport_pc_probe_port (unsigned long base,
 					      unsigned long base_hi,
