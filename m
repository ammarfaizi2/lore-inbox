Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131686AbRAWWoo>; Tue, 23 Jan 2001 17:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131678AbRAWWof>; Tue, 23 Jan 2001 17:44:35 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:58709
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S130387AbRAWWob>; Tue, 23 Jan 2001 17:44:31 -0500
Date: Tue, 23 Jan 2001 23:44:24 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi/u14-35f.c: check_region -> request_region (241p9)
Message-ID: <20010123234424.B9514@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Too fast again and forgot to cc the lists. If anyone replies to this
mail, please cc ballabio_dario@emc.com. Thanks.)

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch makes drivers/scsi/u14-35f.c drop check_region in
favour of checking the return code from request_region. It applies
cleanly against ac10 and 241p9.

Comments?



--- linux-ac10-clean/drivers/scsi/u14-34f.c	Tue Nov 28 02:49:00 2000
+++ linux-ac10/drivers/scsi/u14-34f.c	Mon Jan 22 00:01:10 2001
@@ -729,7 +729,9 @@
 
    sprintf(name, "%s%d", driver_name, j);
 
-   if(check_region(port_base, REGION_SIZE)) {
+   /* Register the I/O space that we use */
+   
+   if(!request_region(port_base, REGION_SIZE, driver_name)) {
 #if defined(DEBUG_DETECT)
       printk("%s: address 0x%03lx in use, skipping probe.\n", name, port_base);
 #endif
@@ -804,9 +806,6 @@
 
    /* If BIOS is disabled, force enable interrupts */
    if (sh[j]->base == 0) outb(CMD_ENA_INTR, sh[j]->io_port + REG_SYS_MASK);
-
-   /* Register the I/O space that we use */
-   request_region(sh[j]->io_port, sh[j]->n_io_port, driver_name);
 
    memset(HD(j), 0, sizeof(struct hostdata));
    HD(j)->heads = mapping_table[config_2.mapping_mode].heads;

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

Good judgement comes from experience. Experience comes from bad judgement. 
  -- Jim Horning 

----- End forwarded message -----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
