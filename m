Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289000AbSAIUGg>; Wed, 9 Jan 2002 15:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289002AbSAIUGY>; Wed, 9 Jan 2002 15:06:24 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:29939 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S288985AbSAIUEM>;
	Wed, 9 Jan 2002 15:04:12 -0500
Date: Wed, 9 Jan 2002 12:04:07 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [PATCH] : ir247_drv_region-2.diff
Message-ID: <20020109120407.E12039@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir247_drv_region-2.diff :
-----------------------
	<Patch from Steven>
	o [CORRECT] Cleanup check_region()/request_region() in various drivers

diff -u -p linux/drivers/net/irda/w83977af_ir.d8.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda/w83977af_ir.d8.c	Tue Jan  8 15:21:46 2002
+++ linux/drivers/net/irda/w83977af_ir.c	Tue Jan  8 16:03:00 2002
@@ -160,7 +160,7 @@ int w83977af_open(int i, unsigned int io
 {
 	struct net_device *dev;
         struct w83977af_ir *self;
-	int ret;
+	void *ret;
 	int err;
 
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
@@ -190,14 +190,13 @@ int w83977af_open(int i, unsigned int io
         self->io.fifo_size = 32;
 
 	/* Lock the port that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
+	ret = request_region(self->io.fir_base, self->io.fir_ext, driver_name);
+	if (!ret) { 
 		IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
 		      self->io.fir_base);
 		/* w83977af_cleanup( self);  */
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -u -p linux/drivers/net/irda/nsc-ircc.d8.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda/nsc-ircc.d8.c	Tue Jan  8 15:21:36 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Tue Jan  8 16:04:07 2002
@@ -246,7 +246,7 @@ static int nsc_ircc_open(int i, chipio_t
 	struct net_device *dev;
 	struct nsc_ircc_cb *self;
         struct pm_dev *pmdev;
-	int ret;
+	void *ret;
 	int err;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
@@ -282,15 +282,14 @@ static int nsc_ircc_open(int i, chipio_t
         self->io.fifo_size = 32;
 	
 	/* Reserve the ioports that we need */
-	ret = check_region(self->io.fir_base, self->io.fir_ext);
-	if (ret < 0) { 
+	ret = request_region(self->io.fir_base, self->io.fir_ext, driver_name);
+	if (!ret) {
 		WARNING(__FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			self->io.fir_base);
 		dev_self[i] = NULL;
 		kfree(self);
 		return -ENODEV;
 	}
-	request_region(self->io.fir_base, self->io.fir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
diff -u -p linux/drivers/net/irda/irport.d8.c linux/drivers/net/irda/irport.c
--- linux/drivers/net/irda/irport.d8.c	Tue Jan  8 15:21:54 2002
+++ linux/drivers/net/irda/irport.c	Tue Jan  8 16:02:51 2002
@@ -140,7 +140,7 @@ irport_open(int i, unsigned int iobase, 
 {
 	struct net_device *dev;
 	struct irport_cb *self;
-	int ret;
+	void *ret;
 	int err;
 
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
@@ -169,13 +169,12 @@ irport_open(int i, unsigned int iobase, 
         self->io.fifo_size = 16;
 
 	/* Lock the port that we need */
-	ret = check_region(self->io.sir_base, self->io.sir_ext);
-	if (ret < 0) { 
+	ret = request_region(self->io.sir_base, self->io.sir_ext, driver_name);
+	if (!ret) { 
 		IRDA_DEBUG(0, __FUNCTION__ "(), can't get iobase of 0x%03x\n",
 			   self->io.sir_base);
 		return NULL;
 	}
-	request_region(self->io.sir_base, self->io.sir_ext, driver_name);
 
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&self->qos);
