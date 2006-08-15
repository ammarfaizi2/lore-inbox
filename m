Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWHODfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWHODfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbWHODfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:35:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:24674 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750974AbWHODfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:35:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=MwU2xFqxoZsWJKWEHJiL7lJoOKXzeZr65in0y7gs3PruIUwdfXyJ8fArFKVKV4U44/Pdtnon3nXmnFfHS+DrjrpG3QMAYuRrCBA8I/L0mM/AZZGPGc25ShPN96a721aNiB580bkp1ZvTfH5OeGPFbWht2hXkqrKT5tSKCJy+eeM=
Date: Tue, 15 Aug 2006 07:35:22 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Drop second arg of unregister_chrdev()
Message-ID: <20060815033522.GA5163@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* "name" is trivially unused.
* Requirement to pass to unregister function anything but cookie you've
  got from register counterpart is wrong. It creates opportunity to
  diverge, it create opportunity for bugs if enforced:

	/*
	 * XXX(hch): bp->b_count_desired might be incorrect (see
	 * xfs_buf_associate_memory for details),

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

	 *                                        but fortunately
	 * the Linux version of kmem_free ignores the len argument..
	 */
	 kmem_free(bp->b_addr, bp->b_count_desired);
---

 arch/cris/arch-v10/drivers/pcf8563.c     |    2 +-
 arch/cris/arch-v32/drivers/cryptocop.c   |    4 ++--
 arch/cris/arch-v32/drivers/pcf8563.c     |    2 +-
 arch/i386/kernel/cpuid.c                 |    4 ++--
 arch/i386/kernel/msr.c                   |    4 ++--
 arch/mips/kernel/rtlx.c                  |    2 +-
 arch/mips/kernel/vpe.c                   |    2 +-
 arch/mips/sibyte/sb1250/bcm1250_tbprof.c |    2 +-
 arch/sparc64/solaris/socksys.c           |    2 +-
 drivers/block/acsi_slm.c                 |    4 ++--
 drivers/block/aoe/aoechr.c               |    4 ++--
 drivers/block/paride/pg.c                |    4 ++--
 drivers/block/paride/pt.c                |    4 ++--
 drivers/char/drm/drm_drv.c               |    4 ++--
 drivers/char/dsp56k.c                    |    4 ++--
 drivers/char/dtlk.c                      |    2 +-
 drivers/char/ftape/zftape/zftape-init.c  |    2 +-
 drivers/char/ip2/ip2main.c               |    4 ++--
 drivers/char/ipmi/ipmi_devintf.c         |    4 ++--
 drivers/char/istallion.c                 |    2 +-
 drivers/char/lp.c                        |    4 ++--
 drivers/char/mbcs.c                      |    2 +-
 drivers/char/pcmcia/cm4000_cs.c          |    4 ++--
 drivers/char/pcmcia/cm4040_cs.c          |    4 ++--
 drivers/char/ppdev.c                     |    4 ++--
 drivers/char/stallion.c                  |    2 +-
 drivers/char/tipar.c                     |    4 ++--
 drivers/char/tlclk.c                     |    4 ++--
 drivers/char/viotape.c                   |    4 ++--
 drivers/i2c/i2c-dev.c                    |    4 ++--
 drivers/ide/ide-tape.c                   |    2 +-
 drivers/input/input.c                    |    2 +-
 drivers/isdn/capi/capi.c                 |    6 +++---
 drivers/isdn/hardware/eicon/divamnt.c    |    2 +-
 drivers/isdn/hardware/eicon/divasi.c     |    2 +-
 drivers/isdn/hardware/eicon/divasmain.c  |    2 +-
 drivers/isdn/i4l/isdn_common.c           |    6 +++---
 drivers/media/video/videodev.c           |    4 ++--
 drivers/mtd/mtdchar.c                    |    4 ++--
 drivers/net/ppp_generic.c                |    4 ++--
 drivers/net/wan/cosa.c                   |    6 +++---
 drivers/pcmcia/pcmcia_ioctl.c            |    2 +-
 drivers/s390/char/fs3270.c               |    2 +-
 drivers/sbus/char/bpp.c                  |    2 +-
 drivers/sbus/char/vfc_dev.c              |    2 +-
 drivers/scsi/3w-9xxx.c                   |    2 +-
 drivers/scsi/3w-xxxx.c                   |    2 +-
 drivers/scsi/aacraid/linit.c             |    2 +-
 drivers/scsi/ch.c                        |    4 ++--
 drivers/scsi/dpt_i2o.c                   |    2 +-
 drivers/scsi/gdth.c                      |    2 +-
 drivers/scsi/hptiop.c                    |    2 +-
 drivers/scsi/megaraid.c                  |    2 +-
 drivers/scsi/megaraid/megaraid_mm.c      |    2 +-
 drivers/scsi/megaraid/megaraid_sas.c     |    4 ++--
 drivers/scsi/osst.c                      |    2 +-
 drivers/telephony/phonedev.c             |    2 +-
 drivers/usb/core/file.c                  |    2 +-
 drivers/video/fbmem.c                    |    2 +-
 fs/char_dev.c                            |    2 +-
 fs/coda/psdev.c                          |    6 +++---
 include/linux/fs.h                       |    2 +-
 sound/core/sound.c                       |    4 ++--
 sound/sound_core.c                       |    2 +-
 64 files changed, 97 insertions(+), 97 deletions(-)

--- a/arch/cris/arch-v10/drivers/pcf8563.c
+++ b/arch/cris/arch-v10/drivers/pcf8563.c
@@ -180,7 +180,7 @@ err:
 void __exit
 pcf8563_exit(void)
 {
-	if (unregister_chrdev(PCF8563_MAJOR, DEVICE_NAME) < 0) {
+	if (unregister_chrdev(PCF8563_MAJOR) < 0) {
 		printk(KERN_INFO "%s: Unable to unregister device.\n", PCF8563_NAME);
 	}
 }
--- a/arch/cris/arch-v32/drivers/cryptocop.c
+++ b/arch/cris/arch-v32/drivers/cryptocop.c
@@ -3476,13 +3476,13 @@ static int init_stream_coprocessor(void)
 
 	err = init_cryptocop();
 	if (err) {
-		(void)unregister_chrdev(CRYPTOCOP_MAJOR, cryptocop_name);
+		(void)unregister_chrdev(CRYPTOCOP_MAJOR);
 		return err;
 	}
 	err = cryptocop_job_queue_init();
 	if (err) {
 		release_cryptocop();
-		(void)unregister_chrdev(CRYPTOCOP_MAJOR, cryptocop_name);
+		(void)unregister_chrdev(CRYPTOCOP_MAJOR);
 		return err;
 	}
 	/* Init the descriptor pool. */
--- a/arch/cris/arch-v32/drivers/pcf8563.c
+++ b/arch/cris/arch-v32/drivers/pcf8563.c
@@ -193,7 +193,7 @@ err:
 void __exit
 pcf8563_exit(void)
 {
-	if (unregister_chrdev(PCF8563_MAJOR, DEVICE_NAME) < 0) {
+	if (unregister_chrdev(PCF8563_MAJOR) < 0) {
 		printk(KERN_INFO "%s: Unable to unregister device.\n", PCF8563_NAME);
 	}
 }
--- a/arch/i386/kernel/cpuid.c
+++ b/arch/i386/kernel/cpuid.c
@@ -222,7 +222,7 @@ out_class:
 	}
 	class_destroy(cpuid_class);
 out_chrdev:
-	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");	
+	unregister_chrdev(CPUID_MAJOR);	
 out:
 	return err;
 }
@@ -234,7 +234,7 @@ static void __exit cpuid_exit(void)
 	for_each_online_cpu(cpu)
 		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
 	class_destroy(cpuid_class);
-	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
+	unregister_chrdev(CPUID_MAJOR);
 	unregister_hotcpu_notifier(&cpuid_class_cpu_notifier);
 }
 
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -305,7 +305,7 @@ out_class:
 		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, i));
 	class_destroy(msr_class);
 out_chrdev:
-	unregister_chrdev(MSR_MAJOR, "cpu/msr");
+	unregister_chrdev(MSR_MAJOR);
 out:
 	return err;
 }
@@ -316,7 +316,7 @@ static void __exit msr_exit(void)
 	for_each_online_cpu(cpu)
 		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
 	class_destroy(msr_class);
-	unregister_chrdev(MSR_MAJOR, "cpu/msr");
+	unregister_chrdev(MSR_MAJOR);
 	unregister_hotcpu_notifier(&msr_class_cpu_notifier);
 }
 
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -529,7 +529,7 @@ static int rtlx_module_init(void)
 
 static void __exit rtlx_module_exit(void)
 {
-	unregister_chrdev(major, module_name);
+	unregister_chrdev(major);
 }
 
 module_init(rtlx_module_init);
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -1483,7 +1483,7 @@ static void __exit vpe_module_exit(void)
 		}
 	}
 
-	unregister_chrdev(major, module_name);
+	unregister_chrdev(major);
 }
 
 module_init(vpe_module_init);
--- a/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
+++ b/arch/mips/sibyte/sb1250/bcm1250_tbprof.c
@@ -399,7 +399,7 @@ static int __init sbprof_tb_init(void)
 
 static void __exit sbprof_tb_cleanup(void)
 {
-	unregister_chrdev(SBPROF_TB_MAJOR, DEVNAME);
+	unregister_chrdev(SBPROF_TB_MAJOR);
 }
 
 module_init(sbprof_tb_init);
--- a/arch/sparc64/solaris/socksys.c
+++ b/arch/sparc64/solaris/socksys.c
@@ -202,6 +202,6 @@ init_socksys(void)
 void
 cleanup_socksys(void)
 {
-	if (unregister_chrdev(30, "socksys"))
+	if (unregister_chrdev(30))
 		printk ("Couldn't unregister socksys character device\n");
 }
--- a/drivers/block/acsi_slm.c
+++ b/drivers/block/acsi_slm.c
@@ -998,7 +998,7 @@ int slm_init( void )
 	
 	if (!(SLMBuffer = atari_stram_alloc( SLM_BUFFER_SIZE, "SLM" ))) {
 		printk( KERN_ERR "Unable to get SLM ST-Ram buffer.\n" );
-		unregister_chrdev( ACSI_MAJOR, "slm" );
+		unregister_chrdev( ACSI_MAJOR );
 		return -ENOMEM;
 	}
 	BufferP = SLMBuffer;
@@ -1026,7 +1026,7 @@ int init_module(void)
 
 void cleanup_module(void)
 {
-	if (unregister_chrdev( ACSI_MAJOR, "slm" ) != 0)
+	if (unregister_chrdev( ACSI_MAJOR ) != 0)
 		printk( KERN_ERR "acsi_slm: cleanup_module failed\n");
 	atari_stram_free( SLMBuffer );
 }
--- a/drivers/block/aoe/aoechr.c
+++ b/drivers/block/aoe/aoechr.c
@@ -257,7 +257,7 @@ aoechr_init(void)
 	spin_lock_init(&emsgs_lock);
 	aoe_class = class_create(THIS_MODULE, "aoe");
 	if (IS_ERR(aoe_class)) {
-		unregister_chrdev(AOE_MAJOR, "aoechr");
+		unregister_chrdev(AOE_MAJOR);
 		return PTR_ERR(aoe_class);
 	}
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
@@ -276,6 +276,6 @@ aoechr_exit(void)
 	for (i = 0; i < ARRAY_SIZE(chardevs); ++i)
 		class_device_destroy(aoe_class, MKDEV(AOE_MAJOR, chardevs[i].minor));
 	class_destroy(aoe_class);
-	unregister_chrdev(AOE_MAJOR, "aoechr");
+	unregister_chrdev(AOE_MAJOR);
 }
 
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -683,7 +683,7 @@ static int __init pg_init(void)
 	goto out;
 
 out_chrdev:
-	unregister_chrdev(major, "pg");
+	unregister_chrdev(major);
 out:
 	return err;
 }
@@ -698,7 +698,7 @@ static void __exit pg_exit(void)
 			class_device_destroy(pg_class, MKDEV(major, unit));
 	}
 	class_destroy(pg_class);
-	unregister_chrdev(major, name);
+	unregister_chrdev(major);
 
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -980,7 +980,7 @@ static int __init pt_init(void)
 	goto out;
 
 out_chrdev:
-	unregister_chrdev(major, "pt");
+	unregister_chrdev(major);
 out:
 	return err;
 }
@@ -994,7 +994,7 @@ static void __exit pt_exit(void)
 			class_device_destroy(pt_class, MKDEV(major, unit + 128));
 		}
 	class_destroy(pt_class);
-	unregister_chrdev(major, name);
+	unregister_chrdev(major);
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present)
 			pi_release(pt[unit].pi);
--- a/drivers/char/drm/drm_drv.c
+++ b/drivers/char/drm/drm_drv.c
@@ -395,7 +395,7 @@ static int __init drm_core_init(void)
       err_p3:
 	drm_sysfs_destroy(drm_class);
       err_p2:
-	unregister_chrdev(DRM_MAJOR, "drm");
+	unregister_chrdev(DRM_MAJOR);
 	drm_free(drm_heads, sizeof(*drm_heads) * drm_cards_limit, DRM_MEM_STUB);
       err_p1:
 	return ret;
@@ -406,7 +406,7 @@ static void __exit drm_core_exit(void)
 	remove_proc_entry("dri", NULL);
 	drm_sysfs_destroy(drm_class);
 
-	unregister_chrdev(DRM_MAJOR, "drm");
+	unregister_chrdev(DRM_MAJOR);
 
 	drm_free(drm_heads, sizeof(*drm_heads) * drm_cards_limit, DRM_MEM_STUB);
 }
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -521,7 +521,7 @@ static int __init dsp56k_init_driver(voi
 	goto out;
 
 out_chrdev:
-	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
+	unregister_chrdev(DSP56K_MAJOR);
 out:
 	return err;
 }
@@ -531,7 +531,7 @@ static void __exit dsp56k_cleanup_driver
 {
 	class_device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
 	class_destroy(dsp56k_class);
-	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
+	unregister_chrdev(DSP56K_MAJOR);
 }
 module_exit(dsp56k_cleanup_driver);
 
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -352,7 +352,7 @@ static void __exit dtlk_cleanup (void)
 						   signals... */
 
 	dtlk_write_tts(DTLK_CLEAR);
-	unregister_chrdev(dtlk_major, "dtlk");
+	unregister_chrdev(dtlk_major);
 	release_region(dtlk_port_lpc, DTLK_IO_EXTENT);
 }
 
--- a/drivers/char/ftape/zftape/zftape-init.c
+++ b/drivers/char/ftape/zftape/zftape-init.c
@@ -354,7 +354,7 @@ static void zft_exit(void)
 	int i;
 	TRACE_FUN(ft_t_flow);
 
-	if (unregister_chrdev(QIC117_TAPE_MAJOR, "zft") != 0) {
+	if (unregister_chrdev(QIC117_TAPE_MAJOR) != 0) {
 		TRACE(ft_t_warn, "failed");
 	} else {
 		TRACE(ft_t_info, "successful");
--- a/drivers/char/ip2/ip2main.c
+++ b/drivers/char/ip2/ip2main.c
@@ -425,7 +425,7 @@ #endif
 		printk(KERN_ERR "IP2: failed to unregister tty driver (%d)\n", err);
 	}
 	put_tty_driver(ip2_tty_driver);
-	if ( ( err = unregister_chrdev ( IP2_IPL_MAJOR, pcIpl ) ) ) {
+	if ( ( err = unregister_chrdev ( IP2_IPL_MAJOR ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister IPL driver (%d)\n", err);
 	}
 	remove_proc_entry("ip2mem", &proc_root);
@@ -778,7 +778,7 @@ retry:
 out_class:
 	class_destroy(ip2_class);
 out_chrdev:
-	unregister_chrdev(IP2_IPL_MAJOR, "ip2");
+	unregister_chrdev(IP2_IPL_MAJOR);
 out:
 	return err;
 }
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -868,7 +868,7 @@ static __init int init_ipmi_devintf(void
 
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
-		unregister_chrdev(ipmi_major, DEVICE_NAME);
+		unregister_chrdev(ipmi_major);
 		class_destroy(ipmi_class);
 		printk(KERN_WARNING "ipmi: can't register smi watcher\n");
 		return rv;
@@ -890,7 +890,7 @@ static __exit void cleanup_ipmi(void)
 	mutex_unlock(&reg_list_mutex);
 	class_destroy(ipmi_class);
 	ipmi_smi_watcher_unregister(&smi_watcher);
-	unregister_chrdev(ipmi_major, DEVICE_NAME);
+	unregister_chrdev(ipmi_major);
 }
 module_exit(cleanup_ipmi);
 
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -816,7 +816,7 @@ static void __exit istallion_module_exit
 	for (i = 0; i < 4; i++)
 		class_device_destroy(istallion_class, MKDEV(STL_SIOMEMMAJOR, i));
 	class_destroy(istallion_class);
-	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+	if ((i = unregister_chrdev(STL_SIOMEMMAJOR)))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
 
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -928,7 +928,7 @@ #endif
 out_class:
 	class_destroy(lp_class);
 out_devfs:
-	unregister_chrdev(LP_MAJOR, "lp");
+	unregister_chrdev(LP_MAJOR);
 	return err;
 }
 
@@ -970,7 +970,7 @@ #ifdef CONFIG_LP_CONSOLE
 	unregister_console (&lpcons);
 #endif
 
-	unregister_chrdev(LP_MAJOR, "lp");
+	unregister_chrdev(LP_MAJOR);
 	for (offset = 0; offset < LP_NO; offset++) {
 		if (lp_table[offset].dev == NULL)
 			continue;
--- a/drivers/char/mbcs.c
+++ b/drivers/char/mbcs.c
@@ -818,7 +818,7 @@ static void __exit mbcs_exit(void)
 {
 	int rv;
 
-	rv = unregister_chrdev(mbcs_major, DEVICE_NAME);
+	rv = unregister_chrdev(mbcs_major);
 	if (rv < 0)
 		DBG(KERN_ALERT "Error in unregister_chrdev: %d\n", rv);
 
--- a/drivers/char/pcmcia/cm4000_cs.c
+++ b/drivers/char/pcmcia/cm4000_cs.c
@@ -1985,7 +1985,7 @@ static int __init cmm_init(void)
 
 	rc = pcmcia_register_driver(&cm4000_driver);
 	if (rc < 0) {
-		unregister_chrdev(major, DEVICE_NAME);
+		unregister_chrdev(major);
 		return rc;
 	}
 
@@ -1996,7 +1996,7 @@ static void __exit cmm_exit(void)
 {
 	printk(KERN_INFO MODULE_NAME ": unloading\n");
 	pcmcia_unregister_driver(&cm4000_driver);
-	unregister_chrdev(major, DEVICE_NAME);
+	unregister_chrdev(major);
 	class_destroy(cmm_class);
 };
 
--- a/drivers/char/pcmcia/cm4040_cs.c
+++ b/drivers/char/pcmcia/cm4040_cs.c
@@ -733,7 +733,7 @@ static int __init cm4040_init(void)
 
 	rc = pcmcia_register_driver(&reader_driver);
 	if (rc < 0) {
-		unregister_chrdev(major, DEVICE_NAME);
+		unregister_chrdev(major);
 		return rc;
 	}
 
@@ -744,7 +744,7 @@ static void __exit cm4040_exit(void)
 {
 	printk(KERN_INFO MODULE_NAME ": unloading\n");
 	pcmcia_unregister_driver(&reader_driver);
-	unregister_chrdev(major, DEVICE_NAME);
+	unregister_chrdev(major);
 	class_destroy(cmx_class);
 }
 
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -792,7 +792,7 @@ static int __init ppdev_init (void)
 out_class:
 	class_destroy(ppdev_class);
 out_chrdev:
-	unregister_chrdev(PP_MAJOR, CHRDEV);
+	unregister_chrdev(PP_MAJOR);
 out:
 	return err;
 }
@@ -802,7 +802,7 @@ static void __exit ppdev_cleanup (void)
 	/* Clean up all parport stuff */
 	parport_unregister_driver(&pp_driver);
 	class_destroy(ppdev_class);
-	unregister_chrdev (PP_MAJOR, CHRDEV);
+	unregister_chrdev (PP_MAJOR);
 }
 
 module_init(ppdev_init);
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -757,7 +757,7 @@ #endif
 	}
 	for (i = 0; i < 4; i++)
 		class_device_destroy(stallion_class, MKDEV(STL_SIOMEMMAJOR, i));
-	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+	if ((i = unregister_chrdev(STL_SIOMEMMAJOR)))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
 	class_destroy(stallion_class);
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -513,7 +513,7 @@ out_class:
 	class_destroy(tipar_class);
 
 out_chrdev:
-	unregister_chrdev(TIPAR_MAJOR, "tipar");
+	unregister_chrdev(TIPAR_MAJOR);
 out:
 	return err;	
 }
@@ -526,7 +526,7 @@ tipar_cleanup_module(void)
 	/* Unregistering module */
 	parport_unregister_driver(&tipar_driver);
 
-	unregister_chrdev(TIPAR_MAJOR, "tipar");
+	unregister_chrdev(TIPAR_MAJOR);
 
 	for (i = 0; i < PP_NO; i++) {
 		if (table[i].dev == NULL)
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -823,7 +823,7 @@ out3:
 out2:
 	kfree(alarm_events);
 out1:
-	unregister_chrdev(tlclk_major, "telco_clock");
+	unregister_chrdev(tlclk_major);
 	return ret;
 }
 
@@ -832,7 +832,7 @@ static void __exit tlclk_cleanup(void)
 	sysfs_remove_group(&tlclk_device->dev.kobj, &tlclk_attribute_group);
 	platform_device_unregister(tlclk_device);
 	misc_deregister(&tlclk_miscdev);
-	unregister_chrdev(tlclk_major, "telco_clock");
+	unregister_chrdev(tlclk_major);
 
 	release_region(TLCLK_BASE, 8);
 	del_timer_sync(&switchover_timer);
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -1063,7 +1063,7 @@ int __init viotap_init(void)
 unreg_class:
 	class_destroy(tape_class);
 unreg_chrdev:
-	unregister_chrdev(VIOTAPE_MAJOR, "viotape");
+	unregister_chrdev(VIOTAPE_MAJOR);
 clear_handler:
 	vio_clearHandler(viomajorsubtype_tape);
 	viopath_close(viopath_hostLp, viomajorsubtype_tape, VIOTAPE_MAXREQ + 2);
@@ -1102,7 +1102,7 @@ static void __exit viotap_exit(void)
 	remove_proc_entry("iSeries/viotape", NULL);
 	vio_unregister_driver(&viotape_driver);
 	class_destroy(tape_class);
-	ret = unregister_chrdev(VIOTAPE_MAJOR, "viotape");
+	ret = unregister_chrdev(VIOTAPE_MAJOR);
 	if (ret < 0)
 		printk(VIOTAPE_KERN_WARN "Error unregistering device: %d\n",
 				ret);
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -500,7 +500,7 @@ static int __init i2c_dev_init(void)
 out_unreg_class:
 	class_destroy(i2c_dev_class);
 out_unreg_chrdev:
-	unregister_chrdev(I2C_MAJOR, "i2c");
+	unregister_chrdev(I2C_MAJOR);
 out:
 	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
 	return res;
@@ -510,7 +510,7 @@ static void __exit i2c_dev_exit(void)
 {
 	i2c_del_driver(&i2cdev_driver);
 	class_destroy(i2c_dev_class);
-	unregister_chrdev(I2C_MAJOR,"i2c");
+	unregister_chrdev(I2C_MAJOR);
 }
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4915,7 +4915,7 @@ static void __exit idetape_exit (void)
 {
 	driver_unregister(&idetape_driver.gen_driver);
 	class_destroy(idetape_sysfs_class);
-	unregister_chrdev(IDETAPE_MAJOR, "ht");
+	unregister_chrdev(IDETAPE_MAJOR);
 }
 
 static int __init idetape_init(void)
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1152,7 +1152,7 @@ static int __init input_init(void)
 static void __exit input_exit(void)
 {
 	input_proc_exit();
-	unregister_chrdev(INPUT_MAJOR, "input");
+	unregister_chrdev(INPUT_MAJOR);
 	class_unregister(&input_class);
 }
 
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1508,7 +1508,7 @@ static int __init capi_init(void)
 	}
 	capi_class = class_create(THIS_MODULE, "capi");
 	if (IS_ERR(capi_class)) {
-		unregister_chrdev(capi_major, "capi20");
+		unregister_chrdev(capi_major);
 		return PTR_ERR(capi_class);
 	}
 
@@ -1518,7 +1518,7 @@ #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
 		class_device_destroy(capi_class, MKDEV(capi_major, 0));
 		class_destroy(capi_class);
-		unregister_chrdev(capi_major, "capi20");
+		unregister_chrdev(capi_major);
 		return -ENOMEM;
 	}
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
@@ -1546,7 +1546,7 @@ static void __exit capi_exit(void)
 
 	class_device_destroy(capi_class, MKDEV(capi_major, 0));
 	class_destroy(capi_class);
-	unregister_chrdev(capi_major, "capi20");
+	unregister_chrdev(capi_major);
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	capinc_tty_exit();
--- a/drivers/isdn/hardware/eicon/divamnt.c
+++ b/drivers/isdn/hardware/eicon/divamnt.c
@@ -176,7 +176,7 @@ static struct file_operations divas_main
 
 static void divas_maint_unregister_chrdev(void)
 {
-	unregister_chrdev(major, DEVNAME);
+	unregister_chrdev(major);
 }
 
 static int DIVA_INIT_FUNCTION divas_maint_register_chrdev(void)
--- a/drivers/isdn/hardware/eicon/divasi.c
+++ b/drivers/isdn/hardware/eicon/divasi.c
@@ -143,7 +143,7 @@ static struct file_operations divas_idi_
 
 static void divas_idi_unregister_chrdev(void)
 {
-	unregister_chrdev(major, DEVNAME);
+	unregister_chrdev(major);
 }
 
 static int DIVA_INIT_FUNCTION divas_idi_register_chrdev(void)
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -676,7 +676,7 @@ static struct file_operations divas_fops
 
 static void divas_unregister_chrdev(void)
 {
-	unregister_chrdev(major, DEVNAME);
+	unregister_chrdev(major);
 }
 
 static int DIVA_INIT_FUNCTION divas_register_chrdev(void)
--- a/drivers/isdn/i4l/isdn_common.c
+++ b/drivers/isdn/i4l/isdn_common.c
@@ -2321,14 +2321,14 @@ #endif
 	if ((isdn_tty_modem_init()) < 0) {
 		printk(KERN_WARNING "isdn: Could not register tty devices\n");
 		vfree(dev);
-		unregister_chrdev(ISDN_MAJOR, "isdn");
+		unregister_chrdev(ISDN_MAJOR);
 		return -EIO;
 	}
 #ifdef CONFIG_ISDN_PPP
 	if (isdn_ppp_init() < 0) {
 		printk(KERN_WARNING "isdn: Could not create PPP-device-structs\n");
 		isdn_tty_exit();
-		unregister_chrdev(ISDN_MAJOR, "isdn");
+		unregister_chrdev(ISDN_MAJOR);
 		vfree(dev);
 		return -EIO;
 	}
@@ -2369,7 +2369,7 @@ #endif
 		return;
 	}
 	isdn_tty_exit();
-	unregister_chrdev(ISDN_MAJOR, "isdn");
+	unregister_chrdev(ISDN_MAJOR);
 	del_timer(&dev->timer);
 	/* call vfree with interrupts enabled, else it will hang */
 	vfree(dev);
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -1651,7 +1651,7 @@ static int __init videodev_init(void)
 
 	ret = class_register(&video_class);
 	if (ret < 0) {
-		unregister_chrdev(VIDEO_MAJOR, VIDEO_NAME);
+		unregister_chrdev(VIDEO_MAJOR);
 		printk(KERN_WARNING "video_dev: class_register failed\n");
 		return -EIO;
 	}
@@ -1662,7 +1662,7 @@ static int __init videodev_init(void)
 static void __exit videodev_exit(void)
 {
 	class_unregister(&video_class);
-	unregister_chrdev(VIDEO_MAJOR, VIDEO_NAME);
+	unregister_chrdev(VIDEO_MAJOR);
 }
 
 module_init(videodev_init)
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -785,7 +785,7 @@ static int __init init_mtdchar(void)
 
 	if (IS_ERR(mtd_class)) {
 		printk(KERN_ERR "Error creating mtd class.\n");
-		unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
+		unregister_chrdev(MTD_CHAR_MAJOR);
 		return PTR_ERR(mtd_class);
 	}
 
@@ -797,7 +797,7 @@ static void __exit cleanup_mtdchar(void)
 {
 	unregister_mtd_user(&notifier);
 	class_destroy(mtd_class);
-	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
+	unregister_chrdev(MTD_CHAR_MAJOR);
 }
 
 module_init(init_mtdchar);
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -869,7 +869,7 @@ out:
 	return err;
 
 out_chrdev:
-	unregister_chrdev(PPP_MAJOR, "ppp");
+	unregister_chrdev(PPP_MAJOR);
 	goto out;
 }
 
@@ -2670,7 +2670,7 @@ static void __exit ppp_cleanup(void)
 	if (atomic_read(&ppp_unit_count) || atomic_read(&channel_count))
 		printk(KERN_ERR "PPP: removing module but units remain!\n");
 	cardmap_destroy(&all_ppp_units);
-	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
+	if (unregister_chrdev(PPP_MAJOR) != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
 	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR, 0));
 	class_destroy(ppp_class);
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -387,7 +387,7 @@ #endif
 		cosa_probe(io[i], irq[i], dma[i]);
 	if (!nr_cards) {
 		printk(KERN_WARNING "cosa: no devices found.\n");
-		unregister_chrdev(cosa_major, "cosa");
+		unregister_chrdev(cosa_major);
 		err = -ENODEV;
 		goto out;
 	}
@@ -404,7 +404,7 @@ #endif
 	goto out;
 	
 out_chrdev:
-	unregister_chrdev(cosa_major, "cosa");
+	unregister_chrdev(cosa_major);
 out:
 	return err;
 }
@@ -432,7 +432,7 @@ static void __exit cosa_exit(void)
 		free_dma(cosa->dma);
 		release_region(cosa->datareg,is_8bit(cosa)?2:4);
 	}
-	unregister_chrdev(cosa_major, "cosa");
+	unregister_chrdev(cosa_major);
 }
 module_exit(cosa_exit);
 
--- a/drivers/pcmcia/pcmcia_ioctl.c
+++ b/drivers/pcmcia/pcmcia_ioctl.c
@@ -793,5 +793,5 @@ #ifdef CONFIG_PROC_FS
 	}
 #endif
 	if (major_dev != -1)
-		unregister_chrdev(major_dev, "pcmcia");
+		unregister_chrdev(major_dev);
 }
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -519,7 +519,7 @@ fs3270_init(void)
 static void __exit
 fs3270_exit(void)
 {
-	unregister_chrdev(IBM_FS3270_MAJOR, "fs3270");
+	unregister_chrdev(IBM_FS3270_MAJOR);
 }
 
 MODULE_LICENSE("GPL");
--- a/drivers/sbus/char/bpp.c
+++ b/drivers/sbus/char/bpp.c
@@ -1038,7 +1038,7 @@ static void __exit bpp_cleanup(void)
 {
 	unsigned idx;
 
-	unregister_chrdev(BPP_MAJOR, dev_name);
+	unregister_chrdev(BPP_MAJOR);
 
 	for (idx = 0;  idx < BPP_NO; idx++) {
 		if (instances[idx].present)
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -720,7 +720,7 @@ void cleanup_module(void)
 {
 	struct vfc_dev **devp;
 
-	unregister_chrdev(VFC_MAJOR,vfcstr);
+	unregister_chrdev(VFC_MAJOR);
 
 	for (devp = vfc_dev_lst; *devp; devp++)
 		deinit_vfc_device(*devp);
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2166,7 +2166,7 @@ static void twa_remove(struct pci_dev *p
 
 	/* Unregister character device */
 	if (twa_major >= 0) {
-		unregister_chrdev(twa_major, "twa");
+		unregister_chrdev(twa_major);
 		twa_major = -1;
 	}
 
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2441,7 +2441,7 @@ static void tw_remove(struct pci_dev *pd
 
 	/* Unregister character device */
 	if (twe_major >= 0) {
-		unregister_chrdev(twe_major, "twe");
+		unregister_chrdev(twe_major);
 		twe_major = -1;
 	}
 
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1046,7 +1046,7 @@ static int __init aac_init(void)
 static void __exit aac_exit(void)
 {
 	if (aac_cfg_major > -1)
-		unregister_chrdev(aac_cfg_major, "aac");
+		unregister_chrdev(aac_cfg_major);
 	pci_unregister_driver(&aac_pci_driver);
 }
 
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -994,7 +994,7 @@ static int __init init_ch_module(void)
 	return 0;
 
  fail2:
-	unregister_chrdev(SCSI_CHANGER_MAJOR, "ch");
+	unregister_chrdev(SCSI_CHANGER_MAJOR);
  fail1:
 	class_destroy(ch_sysfs_class);
 	return rc;
@@ -1003,7 +1003,7 @@ static int __init init_ch_module(void)
 static void __exit exit_ch_module(void) 
 {
 	scsi_unregister_driver(&ch_template.gendrv);
-	unregister_chrdev(SCSI_CHANGER_MAJOR, "ch");
+	unregister_chrdev(SCSI_CHANGER_MAJOR);
 	class_destroy(ch_sysfs_class);
 }
 
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1079,7 +1079,7 @@ static void adpt_i2o_delete_hba(adpt_hba
 	kfree(pHba);
 
 	if(hba_count <= 0){
-		unregister_chrdev(DPTI_I2O_MAJOR, DPT_DRIVER);   
+		unregister_chrdev(DPTI_I2O_MAJOR);   
 	}
 }
 
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -4779,7 +4779,7 @@ #endif
 #ifdef GDTH_STATISTICS
             del_timer(&gdth_timer);
 #endif
-            unregister_chrdev(major,"gdth");
+            unregister_chrdev(major);
             unregister_reboot_notifier(&gdth_notifier);
         }
     }
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -1482,7 +1482,7 @@ static int __init hptiop_module_init(voi
 static void __exit hptiop_module_exit(void)
 {
 	dprintk("hptiop_module_exit\n");
-	unregister_chrdev(hptiop_cdev_major, "hptiop");
+	unregister_chrdev(hptiop_cdev_major);
 	pci_unregister_driver(&hptiop_pci_driver);
 }
 
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -5100,7 +5100,7 @@ static void __exit megaraid_exit(void)
 	/*
 	 * Unregister the character device interface to the driver.
 	 */
-	unregister_chrdev(major, "megadev_legacy");
+	unregister_chrdev(major);
 
 	pci_unregister_driver(&megaraid_pci_driver);
 
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -1238,7 +1238,7 @@ mraid_mm_exit(void)
 {
 	con_log(CL_DLEVEL1 , ("exiting common mod\n"));
 
-	unregister_chrdev(majorno, "megadev");
+	unregister_chrdev(majorno);
 }
 
 module_init(mraid_mm_init);
--- a/drivers/scsi/megaraid/megaraid_sas.c
+++ b/drivers/scsi/megaraid/megaraid_sas.c
@@ -2858,7 +2858,7 @@ static int __init megasas_init(void)
 
 	if (rval) {
 		printk(KERN_DEBUG "megasas: PCI hotplug regisration failed \n");
-		unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
+		unregister_chrdev(megasas_mgmt_majorno);
 	}
 
 	driver_create_file(&megasas_pci_driver.driver, &driver_attr_version);
@@ -2878,7 +2878,7 @@ static void __exit megasas_exit(void)
 			   &driver_attr_release_date);
 
 	pci_unregister_driver(&megasas_pci_driver);
-	unregister_chrdev(megasas_mgmt_majorno, "megaraid_sas_ioctl");
+	unregister_chrdev(megasas_mgmt_majorno);
 }
 
 module_init(megasas_init);
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5925,7 +5925,7 @@ static void __exit exit_osst (void)
 
 	osst_remove_driverfs_files(&osst_template.gendrv);
 	scsi_unregister_driver(&osst_template.gendrv);
-	unregister_chrdev(OSST_MAJOR, "osst");
+	unregister_chrdev(OSST_MAJOR);
 	osst_sysfs_cleanup();
 
 	if (os_scsi_tapes) {
--- a/drivers/telephony/phonedev.c
+++ b/drivers/telephony/phonedev.c
@@ -155,7 +155,7 @@ static int __init telephony_init(void)
 
 static void __exit telephony_exit(void)
 {
-	unregister_chrdev(PHONE_MAJOR, "telephony");
+	unregister_chrdev(PHONE_MAJOR);
 }
 
 module_init(telephony_init);
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -120,7 +120,7 @@ int usb_major_init(void)
 
 void usb_major_cleanup(void)
 {
-	unregister_chrdev(USB_MAJOR, "usb");
+	unregister_chrdev(USB_MAJOR);
 }
 
 /**
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1416,7 +1416,7 @@ static void __exit
 fbmem_exit(void)
 {
 	class_destroy(fb_class);
-	unregister_chrdev(FB_MAJOR, "fb");
+	unregister_chrdev(FB_MAJOR);
 }
 
 module_exit(fbmem_exit);
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -253,7 +253,7 @@ void unregister_chrdev_region(dev_t from
 	}
 }
 
-int unregister_chrdev(unsigned int major, const char *name)
+int unregister_chrdev(unsigned int major)
 {
 	struct char_device_struct *cd;
 	cd = __unregister_chrdev_region(major, 0, 256);
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -371,7 +371,7 @@ static int init_coda_psdev(void)
 	goto out;
 
 out_chrdev:
-	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
+	unregister_chrdev(CODA_PSDEV_MAJOR);
 out:
 	return err;
 }
@@ -411,7 +411,7 @@ out:
 	for (i = 0; i < MAX_CODADEVS; i++)
 		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
 	class_destroy(coda_psdev_class);
-	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
+	unregister_chrdev(CODA_PSDEV_MAJOR);
 	coda_sysctl_clean();
 out1:
 	coda_destroy_inodecache();
@@ -430,7 +430,7 @@ static void __exit exit_coda(void)
 	for (i = 0; i < MAX_CODADEVS; i++)
 		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
 	class_destroy(coda_psdev_class);
-	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
+	unregister_chrdev(CODA_PSDEV_MAJOR);
 	coda_sysctl_clean();
 	coda_destroy_inodecache();
 }
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1473,7 +1473,7 @@ extern int alloc_chrdev_region(dev_t *, 
 extern int register_chrdev_region(dev_t, unsigned, const char *);
 extern int register_chrdev(unsigned int, const char *,
 			   const struct file_operations *);
-extern int unregister_chrdev(unsigned int, const char *);
+extern int unregister_chrdev(unsigned int);
 extern void unregister_chrdev_region(dev_t, unsigned);
 extern int chrdev_open(struct inode *, struct file *);
 extern void chrdev_show(struct seq_file *,off_t);
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -406,7 +406,7 @@ static int __init alsa_sound_init(void)
 		return -EIO;
 	}
 	if (snd_info_init() < 0) {
-		unregister_chrdev(major, "alsa");
+		unregister_chrdev(major);
 		return -ENOMEM;
 	}
 	snd_info_minor_register();
@@ -420,7 +420,7 @@ static void __exit alsa_sound_exit(void)
 {
 	snd_info_minor_unregister();
 	snd_info_done();
-	if (unregister_chrdev(major, "alsa") != 0)
+	if (unregister_chrdev(major) != 0)
 		snd_printk(KERN_ERR "unable to unregister major device number %d\n", major);
 }
 
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -564,7 +564,7 @@ static void __exit cleanup_soundcore(voi
 {
 	/* We have nothing to really do here - we know the lists must be
 	   empty */
-	unregister_chrdev(SOUND_MAJOR, "sound");
+	unregister_chrdev(SOUND_MAJOR);
 	class_destroy(sound_class);
 }
 

