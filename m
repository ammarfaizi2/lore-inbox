Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030938AbWKPDEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030938AbWKPDEQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 22:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030940AbWKPDEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 22:04:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:43139 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030938AbWKPDEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 22:04:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kPHq9ynGjrcFeG1nV0cSZ1FyeOpw1dEnQ8yQdjKtA4e/01G3Zd9RhBIbdJF29O0dy0v47eQOL6ntpkNGsx/CKSTClJmbWmnyLXzyNwMzUKd7Uupcey2IVJjJ0PoIedh3tB0z6kIO+7q1aLXMCn9g2++jh52FtxMtVB2FZYJpaXs=
Message-ID: <a44ae5cd0611151904k7f8cc856kca3526b62c997a38@mail.gmail.com>
Date: Wed, 15 Nov 2006 19:04:11 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19-rc5-mm2 -- bcm43xx busted (backing out the bcm43xx patches fixes it)
Cc: Bcm43xx-dev@lists.berlios.de, "Michael Buesch" <mb@bu3sch.de>,
       "John W. Linville" <linville@tuxdriver.com>,
       "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Larry.Finger@lwfinger.net
In-Reply-To: <200611152116.30734.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0611141521pd342109jaae9e27aca3d2200@mail.gmail.com>
	 <200611152116.30734.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, I am not sure whether you want it inline or attached.

--- linux-2.6.19-rc5/drivers/net/wireless/bcm43xx/bcm43xx.h
2006-11-07 21:14:05.000000000 -0800
+++ devel/drivers/net/wireless/bcm43xx/bcm43xx.h        2006-11-14
01:10:12.000000000 -0800
@@ -159,6 +159,7 @@

 /* Chipcommon registers. */
 #define BCM43xx_CHIPCOMMON_CAPABILITIES        0x04
+#define BCM43xx_CHIPCOMMON_CTL                 0x28
 #define BCM43xx_CHIPCOMMON_PLLONDELAY          0xB0
 #define BCM43xx_CHIPCOMMON_FREFSELDELAY                0xB4
 #define BCM43xx_CHIPCOMMON_SLOWCLKCTL          0xB8
@@ -172,6 +173,33 @@
 /* SBTOPCI2 values. */
 #define BCM43xx_SBTOPCI2_PREFETCH      0x4
 #define BCM43xx_SBTOPCI2_BURST         0x8
+#define BCM43xx_SBTOPCI2_MEMREAD_MULTI 0x20
+
+/* PCI-E core registers. */
+#define BCM43xx_PCIECORE_REG_ADDR      0x0130
+#define BCM43xx_PCIECORE_REG_DATA      0x0134
+#define BCM43xx_PCIECORE_MDIO_CTL      0x0128
+#define BCM43xx_PCIECORE_MDIO_DATA     0x012C
+
+/* PCI-E registers. */
+#define BCM43xx_PCIE_TLP_WORKAROUND    0x0004
+#define BCM43xx_PCIE_DLLP_LINKCTL      0x0100
+
+/* PCI-E MDIO bits. */
+#define BCM43xx_PCIE_MDIO_ST   0x40000000
+#define BCM43xx_PCIE_MDIO_WT   0x10000000
+#define BCM43xx_PCIE_MDIO_DEV  22
+#define BCM43xx_PCIE_MDIO_REG  18
+#define BCM43xx_PCIE_MDIO_TA   0x00020000
+#define BCM43xx_PCIE_MDIO_TC   0x0100
+
+/* MDIO devices. */
+#define BCM43xx_MDIO_SERDES_RX 0x1F
+
+/* SERDES RX registers. */
+#define BCM43xx_SERDES_RXTIMER 0x2
+#define BCM43xx_SERDES_CDR     0x6
+#define BCM43xx_SERDES_CDR_BW  0x7

 /* Chipcommon capabilities. */
 #define BCM43xx_CAPABILITIES_PCTL              0x00040000
@@ -221,6 +249,7 @@
 #define BCM43xx_COREID_USB20_HOST       0x819
 #define BCM43xx_COREID_USB20_DEV        0x81a
 #define BCM43xx_COREID_SDIO_HOST        0x81b
+#define BCM43xx_COREID_PCIE            0x820

 /* Core Information Registers */
 #define BCM43xx_CIR_BASE               0xf00
@@ -365,6 +394,9 @@
 #define BCM43xx_DEFAULT_SHORT_RETRY_LIMIT      7
 #define BCM43xx_DEFAULT_LONG_RETRY_LIMIT       4

+/* FIXME: the next line is a guess as to what the maximum RSSI value
might be */
+#define RX_RSSI_MAX                            60
+
 /* Max size of a security key */
 #define BCM43xx_SEC_KEYSIZE                    16
 /* Security algorithms. */
--- linux-2.6.19-rc5/drivers/net/wireless/bcm43xx/bcm43xx_main.c
 2006-11-07 21:14:05.000000000 -0800
+++ devel/drivers/net/wireless/bcm43xx/bcm43xx_main.c   2006-11-14
01:10:21.000000000 -0800
@@ -130,6 +130,10 @@ MODULE_PARM_DESC(fwpostfix, "Postfix for
        { PCI_VENDOR_ID_BROADCOM, 0x4301, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
        /* Broadcom 4307 802.11b */
        { PCI_VENDOR_ID_BROADCOM, 0x4307, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       /* Broadcom 4311 802.11(a)/b/g */
+       { PCI_VENDOR_ID_BROADCOM, 0x4311, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+       /* Broadcom 4312 802.11a/b/g */
+       { PCI_VENDOR_ID_BROADCOM, 0x4312, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
        /* Broadcom 4318 802.11b/g */
        { PCI_VENDOR_ID_BROADCOM, 0x4318, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
        /* Broadcom 4319 802.11a/b/g */
@@ -746,7 +750,7 @@ int bcm43xx_sprom_write(struct bcm43xx_p
        if (err)
                goto err_ctlreg;
        spromctl |= 0x10; /* SPROM WRITE enable. */
-       bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
+       err = bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL,
spromctl);
        if (err)
                goto err_ctlreg;
        /* We must burn lots of CPU cycles here, but that does not
@@ -768,7 +772,7 @@ int bcm43xx_sprom_write(struct bcm43xx_p
                mdelay(20);
        }
        spromctl &= ~0x10; /* SPROM WRITE enable. */
-       bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL, spromctl);
+       err = bcm43xx_pci_write_config32(bcm, BCM43xx_PCICFG_SPROMCTL,
spromctl);
        if (err)
                goto err_ctlreg;
        mdelay(500);
@@ -1463,6 +1467,23 @@ static void handle_irq_transmit_status(s
        }
 }

+static void drain_txstatus_queue(struct bcm43xx_private *bcm)
+{
+       u32 dummy;
+
+       if (bcm->current_core->rev < 5)
+               return;
+       /* Read all entries from the microcode TXstatus FIFO
+        * and throw them away.
+        */
+       while (1) {
+               dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_0);
+               if (!dummy)
+                       break;
+               dummy = bcm43xx_read32(bcm, BCM43xx_MMIO_XMITSTAT_1);
+       }
+}
+
 static void bcm43xx_generate_noise_sample(struct bcm43xx_private *bcm)
 {
        bcm43xx_shm_write16(bcm, BCM43xx_SHM_SHARED, 0x408, 0x7F7F);
@@ -2583,8 +2604,9 @@ static int bcm43xx_probe_cores(struct bc
        /* fetch sb_id_hi from core information registers */
        sb_id_hi = bcm43xx_read32(bcm, BCM43xx_CIR_SB_ID_HI);

-       core_id = (sb_id_hi & 0xFFF0) >> 4;
-       core_rev = (sb_id_hi & 0xF);
+       core_id = (sb_id_hi & 0x8FF0) >> 4;
+       core_rev = (sb_id_hi & 0x7000) >> 8;
+       core_rev |= (sb_id_hi & 0xF);
        core_vendor = (sb_id_hi & 0xFFFF0000) >> 16;

        /* if present, chipcommon is always core 0; read the chipid from it */
@@ -2662,14 +2684,10 @@ static int bcm43xx_probe_cores(struct bc
                bcm->chip_id, bcm->chip_rev);
        dprintk(KERN_INFO PFX "Number of cores: %d\n", core_count);
        if (bcm->core_chipcommon.available) {
-               dprintk(KERN_INFO PFX "Core 0: ID 0x%x, rev 0x%x,
vendor 0x%x, %s\n",
-                       core_id, core_rev, core_vendor,
-                       bcm43xx_core_enabled(bcm) ? "enabled" : "disabled");
-       }
-
-       if (bcm->core_chipcommon.available)
+               dprintk(KERN_INFO PFX "Core 0: ID 0x%x, rev 0x%x,
vendor 0x%x\n",
+                       core_id, core_rev, core_vendor);
                current_core = 1;
-       else
+       } else
                current_core = 0;
        for ( ; current_core < core_count; current_core++) {
                struct bcm43xx_coreinfo *core;
@@ -2687,13 +2705,13 @@ static int bcm43xx_probe_cores(struct bc
                core_rev = (sb_id_hi & 0xF);
                core_vendor = (sb_id_hi & 0xFFFF0000) >> 16;

-               dprintk(KERN_INFO PFX "Core %d: ID 0x%x, rev 0x%x,
vendor 0x%x, %s\n",
-                       current_core, core_id, core_rev, core_vendor,
-                       bcm43xx_core_enabled(bcm) ? "enabled" : "disabled" );
+               dprintk(KERN_INFO PFX "Core %d: ID 0x%x, rev 0x%x,
vendor 0x%x\n",
+                       current_core, core_id, core_rev, core_vendor);

                core = NULL;
                switch (core_id) {
                case BCM43xx_COREID_PCI:
+               case BCM43xx_COREID_PCIE:
                        core = &bcm->core_pci;
                        if (core->available) {
                                printk(KERN_WARNING PFX "Multiple PCI
cores found.\n");
@@ -2732,12 +2750,12 @@ static int bcm43xx_probe_cores(struct bc
                        case 6:
                        case 7:
                        case 9:
+                       case 10:
                                break;
                        default:
-                               printk(KERN_ERR PFX "Error:
Unsupported 80211 core revision %u\n",
+                               printk(KERN_WARNING PFX
+                                      "Unsupported 80211 core revision %u\n",
                                       core_rev);
-                               err = -ENODEV;
-                               goto out;
                        }
                        bcm->nr_80211_available++;
                        core->priv = ext_80211;
@@ -2851,16 +2869,11 @@ static int bcm43xx_wireless_core_init(st
        u32 sbimconfiglow;
        u8 limit;

-       if (bcm->chip_rev < 5) {
+       if (bcm->core_pci.rev <= 5 && bcm->core_pci.id != BCM43xx_COREID_PCIE) {
                sbimconfiglow = bcm43xx_read32(bcm, BCM43xx_CIR_SBIMCONFIGLOW);
                sbimconfiglow &= ~ BCM43xx_SBIMCONFIGLOW_REQUEST_TOUT_MASK;
                sbimconfiglow &= ~ BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_MASK;
-               if (bcm->bustype == BCM43xx_BUSTYPE_PCI)
-                       sbimconfiglow |= 0x32;
-               else if (bcm->bustype == BCM43xx_BUSTYPE_SB)
-                       sbimconfiglow |= 0x53;
-               else
-                       assert(0);
+               sbimconfiglow |= 0x32;
                bcm43xx_write32(bcm, BCM43xx_CIR_SBIMCONFIGLOW, sbimconfiglow);
        }

@@ -2987,22 +3000,64 @@ static void bcm43xx_pcicore_broadcast_va

 static int bcm43xx_pcicore_commit_settings(struct bcm43xx_private *bcm)
 {
-       int err;
-       struct bcm43xx_coreinfo *old_core;
+       int err = 0;

-       old_core = bcm->current_core;
-       err = bcm43xx_switch_core(bcm, &bcm->core_pci);
-       if (err)
-               goto out;
+       bcm->irq_savedstate = bcm43xx_interrupt_disable(bcm, BCM43xx_IRQ_ALL);

-       bcm43xx_pcicore_broadcast_value(bcm, 0xfd8, 0x00000000);
+       if (bcm->core_chipcommon.available) {
+               err = bcm43xx_switch_core(bcm, &bcm->core_chipcommon);
+               if (err)
+                       goto out;
+
+               bcm43xx_pcicore_broadcast_value(bcm, 0xfd8, 0x00000000);
+
+               /* this function is always called when a PCI core is mapped */
+               err = bcm43xx_switch_core(bcm, &bcm->core_pci);
+               if (err)
+                       goto out;
+       } else
+               bcm43xx_pcicore_broadcast_value(bcm, 0xfd8, 0x00000000);
+
+       bcm43xx_interrupt_enable(bcm, bcm->irq_savedstate);

-       bcm43xx_switch_core(bcm, old_core);
-       assert(err == 0);
 out:
        return err;
 }

+static u32 bcm43xx_pcie_reg_read(struct bcm43xx_private *bcm, u32 address)
+{
+       bcm43xx_write32(bcm, BCM43xx_PCIECORE_REG_ADDR, address);
+       return bcm43xx_read32(bcm, BCM43xx_PCIECORE_REG_DATA);
+}
+
+static void bcm43xx_pcie_reg_write(struct bcm43xx_private *bcm, u32 address,
+                                   u32 data)
+{
+       bcm43xx_write32(bcm, BCM43xx_PCIECORE_REG_ADDR, address);
+       bcm43xx_write32(bcm, BCM43xx_PCIECORE_REG_DATA, data);
+}
+
+static void bcm43xx_pcie_mdio_write(struct bcm43xx_private *bcm, u8
dev, u8 reg,
+                                   u16 data)
+{
+       int i;
+
+       bcm43xx_write32(bcm, BCM43xx_PCIECORE_MDIO_CTL, 0x0082);
+       bcm43xx_write32(bcm, BCM43xx_PCIECORE_MDIO_DATA, BCM43xx_PCIE_MDIO_ST |
+                       BCM43xx_PCIE_MDIO_WT | (dev << BCM43xx_PCIE_MDIO_DEV) |
+                       (reg << BCM43xx_PCIE_MDIO_REG) | BCM43xx_PCIE_MDIO_TA |
+                       data);
+       udelay(10);
+
+       for (i = 0; i < 10; i++) {
+               if (bcm43xx_read32(bcm, BCM43xx_PCIECORE_MDIO_CTL) &
+                   BCM43xx_PCIE_MDIO_TC)
+                       break;
+               msleep(1);
+       }
+       bcm43xx_write32(bcm, BCM43xx_PCIECORE_MDIO_CTL, 0);
+}
+
 /* Make an I/O Core usable. "core_mask" is the bitmask of the cores to enable.
  * To enable core 0, pass a core_mask of 1<<0
  */
@@ -3022,7 +3077,8 @@ static int bcm43xx_setup_backplane_pci_c
        if (err)
                goto out;

-       if (bcm->core_pci.rev < 6) {
+       if (bcm->current_core->rev < 6 ||
+               bcm->current_core->id == BCM43xx_COREID_PCI) {
                value = bcm43xx_read32(bcm, BCM43xx_CIR_SBINTVEC);
                value |= (1 << backplane_flag_nr);
                bcm43xx_write32(bcm, BCM43xx_CIR_SBINTVEC, value);
@@ -3040,21 +3096,46 @@ static int bcm43xx_setup_backplane_pci_c
                }
        }

-       value = bcm43xx_read32(bcm, BCM43xx_PCICORE_SBTOPCI2);
-       value |= BCM43xx_SBTOPCI2_PREFETCH | BCM43xx_SBTOPCI2_BURST;
-       bcm43xx_write32(bcm, BCM43xx_PCICORE_SBTOPCI2, value);
-
-       if (bcm->core_pci.rev < 5) {
-               value = bcm43xx_read32(bcm, BCM43xx_CIR_SBIMCONFIGLOW);
-               value |= (2 << BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_SHIFT)
-                        & BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_MASK;
-               value |= (3 << BCM43xx_SBIMCONFIGLOW_REQUEST_TOUT_SHIFT)
-                        & BCM43xx_SBIMCONFIGLOW_REQUEST_TOUT_MASK;
-               bcm43xx_write32(bcm, BCM43xx_CIR_SBIMCONFIGLOW, value);
-               err = bcm43xx_pcicore_commit_settings(bcm);
-               assert(err == 0);
+       if (bcm->current_core->id == BCM43xx_COREID_PCI) {
+               value = bcm43xx_read32(bcm, BCM43xx_PCICORE_SBTOPCI2);
+               value |= BCM43xx_SBTOPCI2_PREFETCH | BCM43xx_SBTOPCI2_BURST;
+               bcm43xx_write32(bcm, BCM43xx_PCICORE_SBTOPCI2, value);
+
+               if (bcm->current_core->rev < 5) {
+                       value = bcm43xx_read32(bcm, BCM43xx_CIR_SBIMCONFIGLOW);
+                       value |= (2 << BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_SHIFT)
+                                & BCM43xx_SBIMCONFIGLOW_SERVICE_TOUT_MASK;
+                       value |= (3 << BCM43xx_SBIMCONFIGLOW_REQUEST_TOUT_SHIFT)
+                                & BCM43xx_SBIMCONFIGLOW_REQUEST_TOUT_MASK;
+                       bcm43xx_write32(bcm, BCM43xx_CIR_SBIMCONFIGLOW, value);
+                       err = bcm43xx_pcicore_commit_settings(bcm);
+                       assert(err == 0);
+               } else if (bcm->current_core->rev >= 11) {
+                       value = bcm43xx_read32(bcm, BCM43xx_PCICORE_SBTOPCI2);
+                       value |= BCM43xx_SBTOPCI2_MEMREAD_MULTI;
+                       bcm43xx_write32(bcm, BCM43xx_PCICORE_SBTOPCI2, value);
+               }
+       } else {
+               if (bcm->current_core->rev == 0 ||
bcm->current_core->rev == 1) {
+                       value = bcm43xx_pcie_reg_read(bcm,
BCM43xx_PCIE_TLP_WORKAROUND);
+                       value |= 0x8;
+                       bcm43xx_pcie_reg_write(bcm, BCM43xx_PCIE_TLP_WORKAROUND,
+                                              value);
+               }
+               if (bcm->current_core->rev == 0) {
+                       bcm43xx_pcie_mdio_write(bcm, BCM43xx_MDIO_SERDES_RX,
+                                               BCM43xx_SERDES_RXTIMER, 0x8128);
+                       bcm43xx_pcie_mdio_write(bcm, BCM43xx_MDIO_SERDES_RX,
+                                               BCM43xx_SERDES_CDR, 0x0100);
+                       bcm43xx_pcie_mdio_write(bcm, BCM43xx_MDIO_SERDES_RX,
+                                               BCM43xx_SERDES_CDR_BW, 0x1466);
+               } else if (bcm->current_core->rev == 1) {
+                       value = bcm43xx_pcie_reg_read(bcm,
BCM43xx_PCIE_DLLP_LINKCTL);
+                       value |= 0x40;
+                       bcm43xx_pcie_reg_write(bcm, BCM43xx_PCIE_DLLP_LINKCTL,
+                                              value);
+               }
        }
-
 out_switch_back:
        err = bcm43xx_switch_core(bcm, old_core);
 out:
@@ -3123,55 +3204,27 @@ static void bcm43xx_periodic_every15sec(

 static void do_periodic_work(struct bcm43xx_private *bcm)
 {
-       unsigned int state;
-
-       state = bcm->periodic_state;
-       if (state % 8 == 0)
+       if (bcm->periodic_state % 8 == 0)
                bcm43xx_periodic_every120sec(bcm);
-       if (state % 4 == 0)
+       if (bcm->periodic_state % 4 == 0)
                bcm43xx_periodic_every60sec(bcm);
-       if (state % 2 == 0)
+       if (bcm->periodic_state % 2 == 0)
                bcm43xx_periodic_every30sec(bcm);
-       if (state % 1 == 0)
-               bcm43xx_periodic_every15sec(bcm);
-       bcm->periodic_state = state + 1;
+       bcm43xx_periodic_every15sec(bcm);

        schedule_delayed_work(&bcm->periodic_work, HZ * 15);
 }

-/* Estimate a "Badness" value based on the periodic work
- * state-machine state. "Badness" is worse (bigger), if the
- * periodic work will take longer.
- */
-static int estimate_periodic_work_badness(unsigned int state)
-{
-       int badness = 0;
-
-       if (state % 8 == 0) /* every 120 sec */
-               badness += 10;
-       if (state % 4 == 0) /* every 60 sec */
-               badness += 5;
-       if (state % 2 == 0) /* every 30 sec */
-               badness += 1;
-       if (state % 1 == 0) /* every 15 sec */
-               badness += 1;
-
-#define BADNESS_LIMIT  4
-       return badness;
-}
-
 static void bcm43xx_periodic_work_handler(void *d)
 {
        struct bcm43xx_private *bcm = d;
        struct net_device *net_dev = bcm->net_dev;
        unsigned long flags;
        u32 savedirqs = 0;
-       int badness;
        unsigned long orig_trans_start = 0;

        mutex_lock(&bcm->mutex);
-       badness = estimate_periodic_work_badness(bcm->periodic_state);
-       if (badness > BADNESS_LIMIT) {
+       if (unlikely(bcm->periodic_state % 4 == 0)) {
                /* Periodic work will take a long time, so we want it to
                 * be preemtible.
                 */
@@ -3203,7 +3256,7 @@ static void bcm43xx_periodic_work_handle

        do_periodic_work(bcm);

-       if (badness > BADNESS_LIMIT) {
+       if (unlikely(bcm->periodic_state % 4 == 0)) {
                spin_lock_irqsave(&bcm->irq_lock, flags);
                tasklet_enable(&bcm->isr_tasklet);
                bcm43xx_interrupt_enable(bcm, savedirqs);
@@ -3214,6 +3267,7 @@ static void bcm43xx_periodic_work_handle
                net_dev->trans_start = orig_trans_start;
        }
        mmiowb();
+       bcm->periodic_state++;
        spin_unlock_irqrestore(&bcm->irq_lock, flags);
        mutex_unlock(&bcm->mutex);
 }
@@ -3532,6 +3586,7 @@ int bcm43xx_select_wireless_core(struct
        bcm43xx_macfilter_clear(bcm, BCM43xx_MACFILTER_ASSOC);
        bcm43xx_macfilter_set(bcm, BCM43xx_MACFILTER_SELF, (u8
*)(bcm->net_dev->dev_addr));
        bcm43xx_security_init(bcm);
+       drain_txstatus_queue(bcm);
        ieee80211softmac_start(bcm->net_dev);

        /* Let's go! Be careful after enabling the IRQs.
@@ -3658,7 +3713,7 @@ static int bcm43xx_read_phyinfo(struct b
                bcm->ieee->freq_band = IEEE80211_24GHZ_BAND;
                break;
        case BCM43xx_PHYTYPE_G:
-               if (phy_rev > 7)
+               if (phy_rev > 8)
                        phy_rev_ok = 0;
                bcm->ieee->modulation = IEEE80211_OFDM_MODULATION |
                                        IEEE80211_CCK_MODULATION;
@@ -3670,6 +3725,8 @@ static int bcm43xx_read_phyinfo(struct b
                       phy_type);
                return -ENODEV;
        };
+       bcm->ieee->perfect_rssi = RX_RSSI_MAX;
+       bcm->ieee->worst_rssi = 0;
        if (!phy_rev_ok) {
                printk(KERN_WARNING PFX "Invalid PHY Revision %x\n",
                       phy_rev);
--- linux-2.6.19-rc5/drivers/net/wireless/bcm43xx/bcm43xx_power.c
 2006-06-17 23:01:22.000000000 -0700
+++ devel/drivers/net/wireless/bcm43xx/bcm43xx_power.c  2006-11-14
01:10:12.000000000 -0800
@@ -153,8 +153,6 @@ int bcm43xx_pctl_init(struct bcm43xx_pri
        int err, maxfreq;
        struct bcm43xx_coreinfo *old_core;

-       if (!(bcm->chipcommon_capabilities & BCM43xx_CAPABILITIES_PCTL))
-               return 0;
        old_core = bcm->current_core;
        err = bcm43xx_switch_core(bcm, &bcm->core_chipcommon);
        if (err == -ENODEV)
@@ -162,11 +160,27 @@ int bcm43xx_pctl_init(struct bcm43xx_pri
        if (err)
                goto out;

-       maxfreq = bcm43xx_pctl_clockfreqlimit(bcm, 1);
-       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_PLLONDELAY,
-                       (maxfreq * 150 + 999999) / 1000000);
-       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_FREFSELDELAY,
-                       (maxfreq * 15 + 999999) / 1000000);
+       if (bcm->chip_id == 0x4321) {
+               if (bcm->chip_rev == 0)
+                       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_CTL, 0x03A4);
+               if (bcm->chip_rev == 1)
+                       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_CTL, 0x00A4);
+       }
+
+       if (bcm->chipcommon_capabilities & BCM43xx_CAPABILITIES_PCTL) {
+               if (bcm->current_core->rev >= 10) {
+                       /* Set Idle Power clock rate to 1Mhz */
+                       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_SYSCLKCTL,
+                                      (bcm43xx_read32(bcm,
BCM43xx_CHIPCOMMON_SYSCLKCTL)
+                                      & 0x0000FFFF) | 0x40000);
+               } else {
+                       maxfreq = bcm43xx_pctl_clockfreqlimit(bcm, 1);
+                       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_PLLONDELAY,
+                                      (maxfreq * 150 + 999999) / 1000000);
+                       bcm43xx_write32(bcm, BCM43xx_CHIPCOMMON_FREFSELDELAY,
+                                      (maxfreq * 15 + 999999) / 1000000);
+               }
+       }

        err = bcm43xx_switch_core(bcm, old_core);
        assert(err == 0);
--- linux-2.6.19-rc5/drivers/net/wireless/bcm43xx/bcm43xx_wx.c
2006-11-07 21:14:05.000000000 -0800
+++ devel/drivers/net/wireless/bcm43xx/bcm43xx_wx.c     2006-11-14
01:10:12.000000000 -0800
@@ -47,9 +47,6 @@
 #define BCM43xx_WX_VERSION     18

 #define MAX_WX_STRING          80
-/* FIXME: the next line is a guess as to what the maximum RSSI value
might be */
-#define RX_RSSI_MAX            60
-

 static int bcm43xx_wx_get_name(struct net_device *net_dev,
                                struct iw_request_info *info,
@@ -693,6 +690,7 @@ static int bcm43xx_wx_set_swencryption(s
        bcm->ieee->host_encrypt = !!on;
        bcm->ieee->host_decrypt = !!on;
        bcm->ieee->host_build_iv = !on;
+       bcm->ieee->host_strip_iv_icv = !on;
        spin_unlock_irqrestore(&bcm->irq_lock, flags);
        mutex_unlock(&bcm->mutex);

--- linux-2.6.19-rc5/drivers/net/wireless/bcm43xx/bcm43xx_xmit.c
 2006-11-07 21:14:05.000000000 -0800
+++ devel/drivers/net/wireless/bcm43xx/bcm43xx_xmit.c   2006-11-14
01:10:12.000000000 -0800
@@ -543,25 +543,6 @@ int bcm43xx_rx(struct bcm43xx_private *b
                break;
        }

-       frame_ctl = le16_to_cpu(wlhdr->frame_ctl);
-       if ((frame_ctl & IEEE80211_FCTL_PROTECTED) &&
!bcm->ieee->host_decrypt) {
-               frame_ctl &= ~IEEE80211_FCTL_PROTECTED;
-               wlhdr->frame_ctl = cpu_to_le16(frame_ctl);
-               /* trim IV and ICV */
-               /* FIXME: this must be done only for WEP encrypted packets */
-               if (skb->len < 32) {
-                       dprintkl(KERN_ERR PFX "RX packet dropped
(PROTECTED flag "
-                                             "set and length < 32)\n");
-                       return -EINVAL;
-               } else {
-                       memmove(skb->data + 4, skb->data, 24);
-                       skb_pull(skb, 4);
-                       skb_trim(skb, skb->len - 4);
-                       stats.len -= 8;
-               }
-               wlhdr = (struct ieee80211_hdr_4addr *)(skb->data);
-       }
-
        switch (WLAN_FC_GET_TYPE(frame_ctl)) {
        case IEEE80211_FTYPE_MGMT:
                ieee80211_rx_mgt(bcm->ieee, wlhdr, &stats);
