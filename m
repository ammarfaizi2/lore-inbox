Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbTLEXI6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 18:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264890AbTLEXI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 18:08:58 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:60811
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264886AbTLEXIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 18:08:50 -0500
Date: Sat, 6 Dec 2003 00:09:22 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1 - scsi/pcmcia qlogic still does not build (m)
Message-ID: <20031205230922.GF2121@dualathlon.random>
References: <20031205022225.GA1565@dualathlon.random> <3FD07392.A47A0A6D@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD07392.A47A0A6D@eyal.emu.id.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 11:01:22PM +1100, Eyal Lebedinsky wrote:
> Andrea Arcangeli wrote:
> > 
> > This should be the last 2.4-aa kernel ;)
> 
> I guess nobody volunteered to fix it since -pre6aa2...
> 
> It builds just fine in vanilla 2.4.23.

is the error still the same as in your email with ID
20031002152648.GB1240@velociraptor.random right?

If nobody sends a fix I'll have another quick look after I'm back from
vacations on Thu.

Also for the i2c troubles (you mentioned those last time), you can try
if this helps.


diff -urNp linux-2.4.21/drivers/i2c/i2c-elektor.c linux-2.4.21.SUSE/drivers/i2c/i2c-elektor.c
--- linux-2.4.21/drivers/i2c/i2c-elektor.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-elektor.c	2003-10-24 12:06:19.000000000 +0200
@@ -167,7 +167,6 @@ static struct i2c_algo_pcf_data pcf_isa_
 	.waitforpin = pcf_isa_waitforpin,
 	.udelay	    = 10,
 	.mdelay	    = 10,
-	.timeout    = HZ,
 };
 
 static struct i2c_adapter pcf_isa_ops = {
@@ -179,6 +178,7 @@ static struct i2c_adapter pcf_isa_ops = 
 
 static int __init i2c_pcfisa_init(void) 
 {
+	pcf_isa_data.timeout = HZ;
 #ifdef __alpha__
 	/* check to see we have memory mapped PCF8584 connected to the 
 	Cypress cy82c693 PCI-ISA bridge as on UP2000 board */
diff -urNp linux-2.4.21/drivers/i2c/i2c-elv.c linux-2.4.21.SUSE/drivers/i2c/i2c-elv.c
--- linux-2.4.21/drivers/i2c/i2c-elv.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-elv.c	2003-10-24 12:06:19.000000000 +0200
@@ -124,7 +124,6 @@ static struct i2c_algo_bit_data bit_elv_
 	.getscl		= bit_elv_getscl,
 	.udelay		= 80,
 	.mdelay		= 80,
-	.timeout	= HZ
 };
 
 static struct i2c_adapter bit_elv_ops = {
@@ -137,6 +136,7 @@ static struct i2c_adapter bit_elv_ops = 
 static int __init i2c_bitelv_init(void)
 {
 	printk(KERN_INFO "i2c-elv.o: i2c ELV parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	bit_elv_data.timeout = HZ;
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
diff -urNp linux-2.4.21/drivers/i2c/i2c-hydra.c linux-2.4.21.SUSE/drivers/i2c/i2c-hydra.c
--- linux-2.4.21/drivers/i2c/i2c-hydra.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-hydra.c	2003-10-24 12:06:19.000000000 +0200
@@ -107,7 +107,6 @@ static struct i2c_algo_bit_data bit_hydr
 	.getscl		= bit_hydra_getscl,
 	.udelay		= 5,
 	.mdelay		= 5,
-	.timeout	= HZ
 };
 
 static struct i2c_adapter bit_hydra_ops = {
@@ -154,6 +153,7 @@ static struct pci_driver hydra_driver = 
 
 static int __init i2c_hydra_init(void)
 {
+	bit_hydra_data.timeout = HZ;
 	return pci_module_init(&hydra_driver);
 }
 
diff -urNp linux-2.4.21/drivers/i2c/i2c-i810.c linux-2.4.21.SUSE/drivers/i2c/i2c-i810.c
--- linux-2.4.21/drivers/i2c/i2c-i810.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-i810.c	2003-10-24 12:06:19.000000000 +0200
@@ -189,7 +189,6 @@ static struct i2c_algo_bit_data i810_i2c
 	.getscl		= bit_i810i2c_getscl,
 	.udelay		= CYCLE_DELAY,
 	.mdelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT,
 };
 
 static struct i2c_adapter i810_i2c_adapter = {
@@ -206,7 +205,6 @@ static struct i2c_algo_bit_data i810_ddc
 	.getscl		= bit_i810ddc_getscl,
 	.udelay		= CYCLE_DELAY,
 	.mdelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT,
 };
 
 static struct i2c_adapter i810_ddc_adapter = {
@@ -293,6 +291,10 @@ static int __init i2c_i810_init(void)
 /*
 	return pci_module_init(&i810_driver);
 */
+
+	i810_i2c_bit_data.timeout = TIMEOUT;
+	i810_ddc_bit_data.timeout = TIMEOUT;
+
 	pci_for_each_dev(dev) {
 		id = pci_match_device(i810_ids, dev);
 		if(id)
diff -urNp linux-2.4.21/drivers/i2c/i2c-philips-par.c linux-2.4.21.SUSE/drivers/i2c/i2c-philips-par.c
--- linux-2.4.21/drivers/i2c/i2c-philips-par.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-philips-par.c	2003-10-24 12:06:19.000000000 +0200
@@ -137,7 +137,6 @@ static struct i2c_algo_bit_data bit_lp_d
 	.getscl		= bit_lp_getscl,
 	.udelay		= 80,
 	.mdelay		= 80,
-	.timeout	= HZ
 }; 
 
 static struct i2c_algo_bit_data bit_lp_data2 = {
@@ -146,7 +145,6 @@ static struct i2c_algo_bit_data bit_lp_d
 	.getsda		= bit_lp_getsda2,
 	.udelay		= 80,
 	.mdelay		= 80,
-	.timeout	= HZ
 }; 
 
 static struct i2c_adapter bit_lp_ops = {
@@ -236,6 +234,9 @@ int __init i2c_bitlp_init(void)
 {
 	printk(KERN_INFO "i2c-philips-par.o: i2c Philips parallel port adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
+	bit_lp_data.timeout = HZ;
+	bit_lp_data2.timeout = HZ;
+
 	parport_register_driver(&i2c_driver);
 	
 	return 0;
diff -urNp linux-2.4.21/drivers/i2c/i2c-savage4.c linux-2.4.21.SUSE/drivers/i2c/i2c-savage4.c
--- linux-2.4.21/drivers/i2c/i2c-savage4.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-savage4.c	2003-10-24 12:06:19.000000000 +0200
@@ -158,7 +158,6 @@ static struct i2c_algo_bit_data sav_i2c_
 	.getscl		= bit_savi2c_getscl,
 	.udelay		= CYCLE_DELAY,
 	.mdelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT
 };
 
 static struct i2c_adapter savage4_i2c_adapter = {
@@ -215,6 +214,9 @@ static int __init i2c_savage4_init(void)
 /*
 	return pci_module_init(&savage4_driver);
 */
+
+	sav_i2c_bit_data.timeout = TIMEOUT;
+
 	pci_for_each_dev(dev) {
 		id = pci_match_device(savage4_ids, dev);
 		if(id)
diff -urNp linux-2.4.21/drivers/i2c/i2c-velleman.c linux-2.4.21.SUSE/drivers/i2c/i2c-velleman.c
--- linux-2.4.21/drivers/i2c/i2c-velleman.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-velleman.c	2003-10-24 12:06:19.000000000 +0200
@@ -110,7 +110,6 @@ static struct i2c_algo_bit_data bit_vell
 	.getscl		= bit_velle_getscl,
 	.udelay		= 10,
 	.mdelay		= 10,
-	.timeout	= HZ
 };
 
 static struct i2c_adapter bit_velle_ops = {
@@ -123,6 +122,7 @@ static struct i2c_adapter bit_velle_ops 
 static int __init i2c_bitvelle_init(void)
 {
 	printk(KERN_INFO "i2c-velleman.o: i2c Velleman K8000 adapter module version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	bit_velle_data.timeout = HZ;
 	if (base==0) {
 		/* probe some values */
 		base=DEFAULT_BASE;
diff -urNp linux-2.4.21/drivers/i2c/i2c-via.c linux-2.4.21.SUSE/drivers/i2c/i2c-via.c
--- linux-2.4.21/drivers/i2c/i2c-via.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-via.c	2003-10-24 12:06:19.000000000 +0200
@@ -89,7 +89,6 @@ static struct i2c_algo_bit_data bit_data
 	.getscl		= bit_via_getscl,
 	.udelay		= 5,
 	.mdelay		= 5,
-	.timeout	= HZ
 };
 
 static struct i2c_adapter vt586b_adapter = {
@@ -179,6 +178,9 @@ static int __init i2c_vt586b_init(void)
 /*
 	return pci_module_init(&vt586b_driver);
 */
+
+	bit_data.timeout = HZ;
+
 	pci_for_each_dev(dev) {
 		id = pci_match_device(vt586b_ids, dev);
 		if(id)
diff -urNp linux-2.4.21/drivers/i2c/i2c-voodoo3.c linux-2.4.21.SUSE/drivers/i2c/i2c-voodoo3.c
--- linux-2.4.21/drivers/i2c/i2c-voodoo3.c	2003-10-24 12:05:45.000000000 +0200
+++ linux-2.4.21.SUSE/drivers/i2c/i2c-voodoo3.c	2003-10-24 12:06:19.000000000 +0200
@@ -178,7 +178,6 @@ static struct i2c_algo_bit_data voo_i2c_
 	.getscl		= bit_vooi2c_getscl,
 	.udelay		= CYCLE_DELAY,
 	.mdelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT
 };
 
 static struct i2c_adapter voodoo3_i2c_adapter = {
@@ -195,7 +194,6 @@ static struct i2c_algo_bit_data voo_ddc_
 	.getscl		= bit_vooddc_getscl,
 	.udelay		= CYCLE_DELAY,
 	.mdelay		= CYCLE_DELAY,
-	.timeout	= TIMEOUT
 };
 
 static struct i2c_adapter voodoo3_ddc_adapter = {
@@ -263,6 +261,10 @@ static int __init i2c_voodoo3_init(void)
 /*
 	return pci_module_init(&voodoo3_driver);
 */
+
+	voo_i2c_bit_data.timeout = TIMEOUT;
+	voo_ddc_bit_data.timeout = TIMEOUT;
+
 	pci_for_each_dev(dev) {
 		id = pci_match_device(voodoo3_ids, dev);
 		if(id)

Thanks.
