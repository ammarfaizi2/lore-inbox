Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSG3WzJ>; Tue, 30 Jul 2002 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSG3WzJ>; Tue, 30 Jul 2002 18:55:09 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:8710 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317352AbSG3Wwm>;
	Tue, 30 Jul 2002 18:52:42 -0400
Date: Tue, 30 Jul 2002 15:54:43 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
Message-ID: <20020730225442.GB17826@kroah.com>
References: <20020730225359.GA17826@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730225359.GA17826@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 21:52:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.543   -> 1.544  
#	drivers/video/fbmem.c	1.24    -> 1.25   
#	drivers/sbus/audio/audio.c	1.9     -> 1.10   
#	drivers/block/acsi_slm.c	1.4     -> 1.5    
#	drivers/usb/misc/tiglusb.c	1.7     -> 1.8    
#	   drivers/char/lp.c	1.19    -> 1.20   
#	arch/m68k/atari/joystick.c	1.4     -> 1.5    
#	drivers/net/wan/cosa.c	1.9     -> 1.10   
#	drivers/sbus/char/bpp.c	1.5     -> 1.6    
#	drivers/char/istallion.c	1.10    -> 1.11   
#	drivers/media/video/videodev.c	1.13    -> 1.14   
#	  sound/core/sound.c	1.6     -> 1.7    
#	drivers/ide/ide-tape.c	1.51    -> 1.52   
#	     fs/devfs/base.c	1.45    -> 1.46   
#	drivers/char/stallion.c	1.10    -> 1.11   
#	drivers/block/paride/pt.c	1.10    -> 1.11   
#	drivers/char/vc_screen.c	1.5     -> 1.6    
#	arch/sparc64/solaris/socksys.c	1.7     -> 1.8    
#	drivers/isdn/i4l/isdn_common.c	1.21    -> 1.22   
#	 drivers/char/misc.c	1.10    -> 1.11   
#	drivers/char/ftape/zftape/zftape-init.c	1.8     -> 1.9    
#	net/netlink/netlink_dev.c	1.7     -> 1.8    
#	 drivers/char/dtlk.c	1.8     -> 1.9    
#	  sound/sound_core.c	1.10    -> 1.11   
#	drivers/s390/char/tapechar.c	1.7     -> 1.8    
#	drivers/char/ppdev.c	1.13    -> 1.14   
#	   drivers/scsi/sg.c	1.18    -> 1.19   
#	 drivers/scsi/osst.c	1.15    -> 1.16   
#	drivers/char/tpqic02.c	1.13    -> 1.14   
#	drivers/macintosh/adb.c	1.9     -> 1.10   
#	  drivers/char/mem.c	1.21    -> 1.22   
#	drivers/char/dsp56k.c	1.9     -> 1.10   
#	        fs/devices.c	1.7     -> 1.8    
#	drivers/input/input.c	1.11    -> 1.12   
#	drivers/sbus/char/vfc_dev.c	1.6     -> 1.7    
#	drivers/char/tty_io.c	1.35    -> 1.36   
#	drivers/s390/char/tubfs.c	1.5     -> 1.6    
#	    drivers/md/lvm.c	1.29    -> 1.30   
#	     fs/coda/psdev.c	1.11    -> 1.12   
#	   drivers/scsi/st.c	1.20    -> 1.21   
#	drivers/mtd/mtdchar.c	1.8     -> 1.9    
#	drivers/sbus/char/sunkbd.c	1.6     -> 1.7    
#	include/linux/devfs_fs_kernel.h	1.12    -> 1.13   
#	drivers/sgi/char/shmiq.c	1.6     -> 1.7    
#	drivers/i2c/i2c-dev.c	1.11    -> 1.12   
#	drivers/block/paride/pg.c	1.10    -> 1.11   
#	drivers/net/ppp_generic.c	1.12    -> 1.13   
#	drivers/isdn/capi/capi.c	1.33    -> 1.34   
#	drivers/usb/core/file.c	1.3     -> 1.4    
#	drivers/char/ip2main.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/30	greg@kroah.com	1.544
# Removed devfs_register_chrdev and devfs_unregister_chrdev.
# 
# Use register_chrdev and unregister_chrdev as before, and everything will work.
# --------------------------------------------
#
diff -Nru a/arch/m68k/atari/joystick.c b/arch/m68k/atari/joystick.c
--- a/arch/m68k/atari/joystick.c	Tue Jul 30 15:50:04 2002
+++ b/arch/m68k/atari/joystick.c	Tue Jul 30 15:50:04 2002
@@ -134,7 +134,7 @@
     init_waitqueue_head(&joystick[0].wait);
     init_waitqueue_head(&joystick[1].wait);
 
-    if (devfs_register_chrdev(MAJOR_NR, "Joystick", &atari_joystick_fops))
+    if (register_chrdev(MAJOR_NR, "Joystick", &atari_joystick_fops))
 	printk("unable to get major %d for joystick devices\n", MAJOR_NR);
     devfs_register_series (NULL, "joysticks/digital%u", 2, DEVFS_FL_DEFAULT,
 			   MAJOR_NR, 128, S_IFCHR | S_IRUSR | S_IWUSR,
diff -Nru a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
--- a/arch/sparc64/solaris/socksys.c	Tue Jul 30 15:50:04 2002
+++ b/arch/sparc64/solaris/socksys.c	Tue Jul 30 15:50:04 2002
@@ -181,7 +181,7 @@
 	int (*sys_close)(unsigned int) = 
 		(int (*)(unsigned int))SYS(close);
 	
-	ret = devfs_register_chrdev (30, "socksys", &socksys_fops);
+	ret = register_chrdev (30, "socksys", &socksys_fops);
 	if (ret < 0) {
 		printk ("Couldn't register socksys character device\n");
 		return ret;
@@ -208,7 +208,7 @@
 void
 cleanup_socksys(void)
 {
-	if (devfs_unregister_chrdev(30, "socksys"))
+	if (unregister_chrdev(30, "socksys"))
 		printk ("Couldn't unregister socksys character device\n");
 	devfs_unregister (devfs_handle);
 }
diff -Nru a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/block/acsi_slm.c	Tue Jul 30 15:50:04 2002
@@ -998,14 +998,14 @@
 int slm_init( void )
 
 {
-	if (devfs_register_chrdev( MAJOR_NR, "slm", &slm_fops )) {
+	if (register_chrdev( MAJOR_NR, "slm", &slm_fops )) {
 		printk( KERN_ERR "Unable to get major %d for ACSI SLM\n", MAJOR_NR );
 		return -EBUSY;
 	}
 	
 	if (!(SLMBuffer = atari_stram_alloc( SLM_BUFFER_SIZE, NULL, "SLM" ))) {
 		printk( KERN_ERR "Unable to get SLM ST-Ram buffer.\n" );
-		devfs_unregister_chrdev( MAJOR_NR, "slm" );
+		unregister_chrdev( MAJOR_NR, "slm" );
 		return -ENOMEM;
 	}
 	BufferP = SLMBuffer;
@@ -1038,7 +1038,7 @@
 void cleanup_module(void)
 {
 	devfs_unregister (devfs_handle);
-	if (devfs_unregister_chrdev( MAJOR_NR, "slm" ) != 0)
+	if (unregister_chrdev( MAJOR_NR, "slm" ) != 0)
 		printk( KERN_ERR "acsi_slm: cleanup_module failed\n");
 	atari_stram_free( SLMBuffer );
 }
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/block/paride/pg.c	Tue Jul 30 15:50:05 2002
@@ -637,7 +637,7 @@
 	if (pg_detect())
 		return -1;
 
-	if (devfs_register_chrdev(major,name,&pg_fops)) {
+	if (register_chrdev(major,name,&pg_fops)) {
 		printk("pg_init: unable to get major number %d\n",
 			major);
 		for (unit=0;unit<PG_UNITS;unit++)
@@ -656,7 +656,7 @@
 	int unit;
 
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev(major,name);
+	unregister_chrdev(major,name);
 
 	for (unit=0;unit<PG_UNITS;unit++)
 		if (PG.present) pi_release(PI);
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/block/paride/pt.c	Tue Jul 30 15:50:04 2002
@@ -907,7 +907,7 @@
 	if (pt_detect())
 		return -1;
 
-	if (devfs_register_chrdev(major,name,&pt_fops)) {
+	if (register_chrdev(major,name,&pt_fops)) {
 		printk("pt_init: unable to get major number %d\n",
 			major);
 		for (unit=0;unit<PT_UNITS;unit++)
@@ -929,7 +929,7 @@
 {
 	int unit;
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev(major,name);
+	unregister_chrdev(major,name);
 	for (unit=0;unit<PT_UNITS;unit++)
 		if (PT.present)
 			pi_release(PI);
diff -Nru a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/char/dsp56k.c	Tue Jul 30 15:50:05 2002
@@ -510,7 +510,7 @@
 		return -ENODEV;
 	}
 
-	if(devfs_register_chrdev(DSP56K_MAJOR, "dsp56k", &dsp56k_fops)) {
+	if(register_chrdev(DSP56K_MAJOR, "dsp56k", &dsp56k_fops)) {
 		printk("DSP56k driver: Unable to register driver\n");
 		return -ENODEV;
 	}
@@ -526,7 +526,7 @@
 
 static void __exit dsp56k_cleanup_driver(void)
 {
-	devfs_unregister_chrdev(DSP56K_MAJOR, "dsp56k");
+	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 	devfs_unregister(devfs_handle);
 }
 module_exit(dsp56k_cleanup_driver);
diff -Nru a/drivers/char/dtlk.c b/drivers/char/dtlk.c
--- a/drivers/char/dtlk.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/dtlk.c	Tue Jul 30 15:50:04 2002
@@ -340,7 +340,7 @@
 	dtlk_port_lpc = 0;
 	dtlk_port_tts = 0;
 	dtlk_busy = 0;
-	dtlk_major = devfs_register_chrdev(0, "dtlk", &dtlk_fops);
+	dtlk_major = register_chrdev(0, "dtlk", &dtlk_fops);
 	if (dtlk_major == 0) {
 		printk(KERN_ERR "DoubleTalk PC - cannot register device\n");
 		return 0;
@@ -369,7 +369,7 @@
 						   signals... */
 
 	dtlk_write_tts(DTLK_CLEAR);
-	devfs_unregister_chrdev(dtlk_major, "dtlk");
+	unregister_chrdev(dtlk_major, "dtlk");
 	devfs_unregister(devfs_handle);
 	release_region(dtlk_port_lpc, DTLK_IO_EXTENT);
 }
diff -Nru a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/ftape/zftape/zftape-init.c	Tue Jul 30 15:50:04 2002
@@ -345,7 +345,7 @@
 	TRACE(ft_t_info, "zft_init @ 0x%p", zft_init);
 	TRACE(ft_t_info,
 	      "installing zftape VFS interface for ftape driver ...");
-	TRACE_CATCH(devfs_register_chrdev(QIC117_TAPE_MAJOR, "zft", &zft_cdev),);
+	TRACE_CATCH(register_chrdev(QIC117_TAPE_MAJOR, "zft", &zft_cdev),);
 
 	for (i = 0; i < 4; i++) {
 		char devname[9];
@@ -419,7 +419,7 @@
 
 	TRACE_FUN(ft_t_flow);
 
-	if (devfs_unregister_chrdev(QIC117_TAPE_MAJOR, "zft") != 0) {
+	if (unregister_chrdev(QIC117_TAPE_MAJOR, "zft") != 0) {
 		TRACE(ft_t_warn, "failed");
 	} else {
 		TRACE(ft_t_info, "successful");
diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/char/ip2main.c	Tue Jul 30 15:50:05 2002
@@ -531,12 +531,7 @@
 	if ( ( err = tty_unregister_driver ( &ip2_callout_driver ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister callout driver (%d)\n", err);
 	}
-#ifdef	CONFIG_DEVFS_FS
-	if ( ( err = devfs_unregister_chrdev ( IP2_IPL_MAJOR, pcIpl ) ) )
-#else
-	if ( ( err = unregister_chrdev ( IP2_IPL_MAJOR, pcIpl ) ) )
-#endif
-	{
+	if ( ( err = unregister_chrdev ( IP2_IPL_MAJOR, pcIpl ) ) ) {
 		printk(KERN_ERR "IP2: failed to unregister IPL driver (%d)\n", err);
 	}
 	remove_proc_entry("ip2mem", &proc_root);
@@ -866,12 +861,7 @@
 		printk(KERN_ERR "IP2: failed to register callout driver (%d)\n", err);
 	} else
 	/* Register the IPL driver. */
-#ifdef	CONFIG_DEVFS_FS
-	if (( err = devfs_register_chrdev ( IP2_IPL_MAJOR, pcIpl, &ip2_ipl )))
-#else
-	if ( ( err = register_chrdev ( IP2_IPL_MAJOR, pcIpl, &ip2_ipl ) ) )
-#endif
-	{
+	if ( ( err = register_chrdev ( IP2_IPL_MAJOR, pcIpl, &ip2_ipl ) ) ) {
 		printk(KERN_ERR "IP2: failed to register IPL device (%d)\n", err );
 	} else
 	/* Register the read_procmem thing */
diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/istallion.c	Tue Jul 30 15:50:04 2002
@@ -869,7 +869,7 @@
 		return;
 	}
 	devfs_unregister (devfs_handle);
-	if ((i = devfs_unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
 	if (stli_tmpwritebuf != (char *) NULL)
@@ -5329,7 +5329,7 @@
  *	Set up a character driver for the shared memory region. We need this
  *	to down load the slave code image. Also it is a useful debugging tool.
  */
-	if (devfs_register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stli_fsiomem))
+	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stli_fsiomem))
 		printk(KERN_ERR "STALLION: failed to register serial memory "
 				"device\n");
 
diff -Nru a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/lp.c	Tue Jul 30 15:50:04 2002
@@ -903,7 +903,7 @@
 		lp_table[i].timeout = 10 * HZ;
 	}
 
-	if (devfs_register_chrdev (LP_MAJOR, "lp", &lp_fops)) {
+	if (register_chrdev (LP_MAJOR, "lp", &lp_fops)) {
 		printk ("lp: unable to get major %d\n", LP_MAJOR);
 		return -EIO;
 	}
@@ -965,7 +965,7 @@
 #endif
 
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev(LP_MAJOR, "lp");
+	unregister_chrdev(LP_MAJOR, "lp");
 	for (offset = 0; offset < LP_NO; offset++) {
 		if (lp_table[offset].dev == NULL)
 			continue;
diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/char/mem.c	Tue Jul 30 15:50:05 2002
@@ -651,7 +651,7 @@
 
 int __init chr_dev_init(void)
 {
-	if (devfs_register_chrdev(MEM_MAJOR,"mem",&memory_fops))
+	if (register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 	memory_devfs_register();
 	rand_initialize();
diff -Nru a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/misc.c	Tue Jul 30 15:50:04 2002
@@ -281,7 +281,7 @@
 #ifdef CONFIG_I8K
 	i8k_init();
 #endif
-	if (devfs_register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
+	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);
 		return -EIO;
diff -Nru a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/ppdev.c	Tue Jul 30 15:50:04 2002
@@ -749,7 +749,7 @@
 
 static int __init ppdev_init (void)
 {
-	if (devfs_register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
+	if (register_chrdev (PP_MAJOR, CHRDEV, &pp_fops)) {
 		printk (KERN_WARNING CHRDEV ": unable to get major %d\n",
 			PP_MAJOR);
 		return -EIO;
@@ -768,7 +768,7 @@
 {
 	/* Clean up all parport stuff */
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev (PP_MAJOR, CHRDEV);
+	unregister_chrdev (PP_MAJOR, CHRDEV);
 }
 
 module_init(ppdev_init);
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/stallion.c	Tue Jul 30 15:50:04 2002
@@ -810,7 +810,7 @@
 		return;
 	}
 	devfs_unregister (devfs_handle);
-	if ((i = devfs_unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
+	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
 
@@ -3208,7 +3208,7 @@
  *	Set up a character driver for per board stuff. This is mainly used
  *	to do stats ioctls on the ports.
  */
-	if (devfs_register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
+	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
 		printk("STALLION: failed to register serial board device\n");
 	devfs_handle = devfs_mk_dir (NULL, "staliomem", NULL);
 	devfs_register_series (devfs_handle, "%u", 4, DEVFS_FL_DEFAULT,
diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/char/tpqic02.c	Tue Jul 30 15:50:05 2002
@@ -2846,7 +2846,7 @@
 #endif
 	printk(TPQIC02_NAME ": DMA buffers: %u blocks\n", NR_BLK_BUF);
 	/* If we got this far, install driver functions */
-	if (devfs_register_chrdev
+	if (register_chrdev
 	    (QIC02_TAPE_MAJOR, TPQIC02_NAME, &qic02_tape_fops)) {
 		printk(TPQIC02_NAME ": Unable to get chrdev major %d\n",
 		       QIC02_TAPE_MAJOR);
@@ -2930,7 +2930,7 @@
 	if (status_zombie == NO) {
 		qic02_release_resources();
 	}
-	devfs_unregister_chrdev(QIC02_TAPE_MAJOR, TPQIC02_NAME);
+	unregister_chrdev(QIC02_TAPE_MAJOR, TPQIC02_NAME);
 	devfs_find_and_unregister(NULL, "ntpqic11", QIC02_TAPE_MAJOR, 2,
 				  DEVFS_SPECIAL_CHR, 0);
 	devfs_find_and_unregister(NULL, "tpqic11", QIC02_TAPE_MAJOR, 3,
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/char/tty_io.c	Tue Jul 30 15:50:05 2002
@@ -2070,7 +2070,7 @@
 	if (driver->flags & TTY_DRIVER_INSTALLED)
 		return 0;
 
-	error = devfs_register_chrdev(driver->major, driver->name, &tty_fops);
+	error = register_chrdev(driver->major, driver->name, &tty_fops);
 	if (error < 0)
 		return error;
 	else if(driver->major == 0)
@@ -2117,11 +2117,11 @@
 		return -ENOENT;
 
 	if (othername == NULL) {
-		retval = devfs_unregister_chrdev(driver->major, driver->name);
+		retval = unregister_chrdev(driver->major, driver->name);
 		if (retval)
 			return retval;
 	} else
-		devfs_register_chrdev(driver->major, othername, &tty_fops);
+		register_chrdev(driver->major, othername, &tty_fops);
 
 	if (driver->prev)
 		driver->prev->next = driver->next;
diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/char/vc_screen.c	Tue Jul 30 15:50:04 2002
@@ -501,7 +501,7 @@
 {
 	int error;
 
-	error = devfs_register_chrdev(VCS_MAJOR, "vcs", &vcs_fops);
+	error = register_chrdev(VCS_MAJOR, "vcs", &vcs_fops);
 
 	if (error)
 		printk("unable to get major %d for vcs device", VCS_MAJOR);
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/i2c/i2c-dev.c	Tue Jul 30 15:50:05 2002
@@ -489,11 +489,7 @@
 	printk(KERN_INFO "i2c-dev.o: i2c /dev entries driver module version %s (%s)\n", I2C_VERSION, I2C_DATE);
 
 	i2cdev_initialized = 0;
-#ifdef CONFIG_DEVFS_FS
-	if (devfs_register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops)) {
-#else
 	if (register_chrdev(I2C_MAJOR,"i2c",&i2cdev_fops)) {
-#endif
 		printk(KERN_ERR "i2c-dev.o: unable to get major %d for i2c bus\n",
 		       I2C_MAJOR);
 		return -EIO;
@@ -528,10 +524,8 @@
 	if (i2cdev_initialized >= 1) {
 #ifdef CONFIG_DEVFS_FS
 		devfs_unregister(devfs_handle);
-		if ((res = devfs_unregister_chrdev(I2C_MAJOR, "i2c"))) {
-#else
-		if ((res = unregister_chrdev(I2C_MAJOR,"i2c"))) {
 #endif
+		if ((res = unregister_chrdev(I2C_MAJOR,"i2c"))) {
 			printk(KERN_ERR "i2c-dev.o: unable to release major %d for i2c bus\n",
 			       I2C_MAJOR);
 			return res;
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/ide/ide-tape.c	Tue Jul 30 15:50:04 2002
@@ -5911,7 +5911,7 @@
 	for (minor = 0; minor < MAX_HWIFS * MAX_DRIVES; minor++)
 		if (idetape_chrdevs[minor].drive != NULL)
 			return 0;
-	devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
+	unregister_chrdev (IDETAPE_MAJOR, "ht");
 	idetape_chrdev_present = 0;
 	return 0;
 }
@@ -5973,7 +5973,7 @@
 			idetape_chrdevs[minor].drive = NULL;
 
 	if (!idetape_chrdev_present &&
-	    devfs_register_chrdev (IDETAPE_MAJOR, "ht", &idetape_fops)) {
+	    register_chrdev (IDETAPE_MAJOR, "ht", &idetape_fops)) {
 		printk(KERN_ERR "ide-tape: Failed to register character device interface\n");
 		return;
 	}
@@ -6017,7 +6017,7 @@
 	supported++;
 
 	if (!idetape_chrdev_present && !supported) {
-		devfs_unregister_chrdev (IDETAPE_MAJOR, "ht");
+		unregister_chrdev (IDETAPE_MAJOR, "ht");
 	} else
 		idetape_chrdev_present = 1;
 
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/input/input.c	Tue Jul 30 15:50:05 2002
@@ -820,7 +820,7 @@
 	entry = create_proc_read_entry("handlers", 0, proc_bus_input_dir, input_handlers_read, NULL);
 	entry->owner = THIS_MODULE;
 #endif
-	if (devfs_register_chrdev(INPUT_MAJOR, "input", &input_fops)) {
+	if (register_chrdev(INPUT_MAJOR, "input", &input_fops)) {
 		printk(KERN_ERR "input: unable to register char major %d", INPUT_MAJOR);
 		return -EBUSY;
 	}
@@ -838,7 +838,7 @@
 	remove_proc_entry("input", proc_bus);
 #endif
 	devfs_unregister(input_devfs_handle);
-        if (devfs_unregister_chrdev(INPUT_MAJOR, "input"))
+        if (unregister_chrdev(INPUT_MAJOR, "input"))
                 printk(KERN_ERR "input: can't unregister char major %d", INPUT_MAJOR);
 }
 
diff -Nru a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/isdn/capi/capi.c	Tue Jul 30 15:50:05 2002
@@ -1485,7 +1485,7 @@
 	} else
 		strcpy(rev, "1.0");
 
-	if (devfs_register_chrdev(capi_major, "capi20", &capi_fops)) {
+	if (register_chrdev(capi_major, "capi20", &capi_fops)) {
 		printk(KERN_ERR "capi20: unable to get major %d\n", capi_major);
 		MOD_DEC_USE_COUNT;
 		return -EIO;
@@ -1498,7 +1498,7 @@
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
-		devfs_unregister_chrdev(capi_major, "capi20");
+		unregister_chrdev(capi_major, "capi20");
 		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
@@ -1526,7 +1526,7 @@
 {
 	proc_exit();
 
-	devfs_unregister_chrdev(capi_major, "capi20");
+	unregister_chrdev(capi_major, "capi20");
 	devfs_find_and_unregister(NULL, "isdn/capi20", capi_major, 0, DEVFS_SPECIAL_CHR, 0);
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
diff -Nru a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
--- a/drivers/isdn/i4l/isdn_common.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/isdn/i4l/isdn_common.c	Tue Jul 30 15:50:04 2002
@@ -2266,7 +2266,7 @@
 		init_waitqueue_head(&dev->mdm.info[i].open_wait);
 		init_waitqueue_head(&dev->mdm.info[i].close_wait);
 	}
-	if (devfs_register_chrdev(ISDN_MAJOR, "isdn", &isdn_fops)) {
+	if (register_chrdev(ISDN_MAJOR, "isdn", &isdn_fops)) {
 		printk(KERN_WARNING "isdn: Could not register control devices\n");
 		vfree(dev);
 		return -EIO;
@@ -2280,7 +2280,7 @@
 			tty_unregister_driver(&dev->mdm.tty_modem);
 		vfree(dev);
 		isdn_cleanup_devfs();
-		devfs_unregister_chrdev(ISDN_MAJOR, "isdn");
+		unregister_chrdev(ISDN_MAJOR, "isdn");
 		return -EIO;
 	}
 #ifdef CONFIG_ISDN_PPP
@@ -2291,7 +2291,7 @@
 		for (i = 0; i < ISDN_MAX_CHANNELS; i++)
 			kfree(dev->mdm.info[i].xmit_buf - 4);
 		isdn_cleanup_devfs();
-		devfs_unregister_chrdev(ISDN_MAJOR, "isdn");
+		unregister_chrdev(ISDN_MAJOR, "isdn");
 		vfree(dev);
 		return -EIO;
 	}
@@ -2354,7 +2354,7 @@
 		kfree(dev->mdm.info[i].fax);
 #endif
 	}
-	if (devfs_unregister_chrdev(ISDN_MAJOR, "isdn") != 0) {
+	if (unregister_chrdev(ISDN_MAJOR, "isdn") != 0) {
 		printk(KERN_WARNING "isdn: controldevice busy, remove cancelled\n");
 		restore_flags(flags);
 	} else {
diff -Nru a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/macintosh/adb.c	Tue Jul 30 15:50:05 2002
@@ -815,7 +815,7 @@
 static void
 adbdev_init(void)
 {
-	if (devfs_register_chrdev(ADB_MAJOR, "adb", &adb_fops))
+	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops))
 		printk(KERN_ERR "adb: unable to get major %d\n", ADB_MAJOR);
 	else
 		devfs_register (NULL, "adb", DEVFS_FL_DEFAULT,
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/md/lvm.c	Tue Jul 30 15:50:05 2002
@@ -388,9 +388,9 @@
  */
 int lvm_init(void)
 {
-	if (devfs_register_chrdev(LVM_CHAR_MAJOR,
+	if (register_chrdev(LVM_CHAR_MAJOR,
 				  lvm_name, &lvm_chr_fops) < 0) {
-		printk(KERN_ERR "%s -- devfs_register_chrdev failed\n",
+		printk(KERN_ERR "%s -- register_chrdev failed\n",
 		       lvm_name);
 		return -EIO;
 	}
@@ -398,9 +398,9 @@
 	if (devfs_register_blkdev(MAJOR_NR, lvm_name, &lvm_blk_dops) < 0)
 	{
 		printk("%s -- devfs_register_blkdev failed\n", lvm_name);
-		if (devfs_unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
+		if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
 			printk(KERN_ERR
-			       "%s -- devfs_unregister_chrdev failed\n",
+			       "%s -- unregister_chrdev failed\n",
 			       lvm_name);
 		return -EIO;
 	}
@@ -442,8 +442,8 @@
  */
 static void lvm_cleanup(void)
 {
-	if (devfs_unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
-		printk(KERN_ERR "%s -- devfs_unregister_chrdev failed\n",
+	if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
+		printk(KERN_ERR "%s -- unregister_chrdev failed\n",
 		       lvm_name);
 	if (devfs_unregister_blkdev(MAJOR_NR, lvm_name) < 0)
 		printk(KERN_ERR "%s -- devfs_unregister_blkdev failed\n",
diff -Nru a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/media/video/videodev.c	Tue Jul 30 15:50:04 2002
@@ -484,8 +484,7 @@
 static int __init videodev_init(void)
 {
 	printk(KERN_INFO "Linux video capture interface: v1.00\n");
-	if(devfs_register_chrdev(VIDEO_MAJOR,"video_capture", &video_fops))
-	{
+	if (register_chrdev(VIDEO_MAJOR,"video_capture", &video_fops)) {
 		printk("video_dev: unable to get major %d\n", VIDEO_MAJOR);
 		return -EIO;
 	}
@@ -502,7 +501,7 @@
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	videodev_proc_destroy ();
 #endif
-	devfs_unregister_chrdev(VIDEO_MAJOR, "video_capture");
+	unregister_chrdev(VIDEO_MAJOR, "video_capture");
 }
 
 module_init(videodev_init)
diff -Nru a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/mtd/mtdchar.c	Tue Jul 30 15:50:05 2002
@@ -494,26 +494,17 @@
 
 static int __init init_mtdchar(void)
 {
-#ifdef CONFIG_DEVFS_FS
-	if (devfs_register_chrdev(MTD_CHAR_MAJOR, "mtd", &mtd_fops))
-	{
+	if (register_chrdev(MTD_CHAR_MAJOR, "mtd", &mtd_fops)) {
 		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
 		       MTD_CHAR_MAJOR);
 		return -EAGAIN;
 	}
 
+#ifdef CONFIG_DEVFS_FS
 	devfs_dir_handle = devfs_mk_dir(NULL, "mtd", NULL);
 
 	register_mtd_user(&notifier);
-#else
-	if (register_chrdev(MTD_CHAR_MAJOR, "mtd", &mtd_fops))
-	{
-		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
-		       MTD_CHAR_MAJOR);
-		return -EAGAIN;
-	}
 #endif
-
 	return 0;
 }
 
@@ -522,10 +513,8 @@
 #ifdef CONFIG_DEVFS_FS
 	unregister_mtd_user(&notifier);
 	devfs_unregister(devfs_dir_handle);
-	devfs_unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
-#else
-	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
 #endif
+	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
 }
 
 module_init(init_mtdchar);
diff -Nru a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/net/ppp_generic.c	Tue Jul 30 15:50:05 2002
@@ -785,7 +785,7 @@
 	int err;
 
 	printk(KERN_INFO "PPP generic driver version " PPP_VERSION "\n");
-	err = devfs_register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
+	err = register_chrdev(PPP_MAJOR, "ppp", &ppp_device_fops);
 	if (err)
 		printk(KERN_ERR "failed to register PPP device (%d)\n", err);
 	devfs_handle = devfs_register(NULL, "ppp", DEVFS_FL_DEFAULT,
@@ -2509,7 +2509,7 @@
 	if (atomic_read(&ppp_unit_count) || atomic_read(&channel_count))
 		printk(KERN_ERR "PPP: removing module but units remain!\n");
 	cardmap_destroy(&all_ppp_units);
-	if (devfs_unregister_chrdev(PPP_MAJOR, "ppp") != 0)
+	if (unregister_chrdev(PPP_MAJOR, "ppp") != 0)
 		printk(KERN_ERR "PPP: failed to unregister PPP device\n");
 	devfs_unregister(devfs_handle);
 }
diff -Nru a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/net/wan/cosa.c	Tue Jul 30 15:50:04 2002
@@ -373,13 +373,13 @@
 	printk(KERN_INFO "cosa: SMP found. Please mail any success/failure reports to the author.\n");
 #endif
 	if (cosa_major > 0) {
-		if (devfs_register_chrdev(cosa_major, "cosa", &cosa_fops)) {
+		if (register_chrdev(cosa_major, "cosa", &cosa_fops)) {
 			printk(KERN_WARNING "cosa: unable to get major %d\n",
 				cosa_major);
 			return -EIO;
 		}
 	} else {
-		if (!(cosa_major=devfs_register_chrdev(0, "cosa", &cosa_fops))) {
+		if (!(cosa_major=register_chrdev(0, "cosa", &cosa_fops))) {
 			printk(KERN_WARNING "cosa: unable to register chardev\n");
 			return -EIO;
 		}
@@ -395,7 +395,7 @@
 			       &cosa_fops, NULL);
 	if (!nr_cards) {
 		printk(KERN_WARNING "cosa: no devices found.\n");
-		devfs_unregister_chrdev(cosa_major, "cosa");
+		unregister_chrdev(cosa_major, "cosa");
 		return -ENODEV;
 	}
 	return 0;
@@ -422,7 +422,7 @@
 		free_dma(cosa->dma);
 		release_region(cosa->datareg,is_8bit(cosa)?2:4);
 	}
-	devfs_unregister_chrdev(cosa_major, "cosa");
+	unregister_chrdev(cosa_major, "cosa");
 }
 #endif
 
diff -Nru a/drivers/s390/char/tapechar.c b/drivers/s390/char/tapechar.c
--- a/drivers/s390/char/tapechar.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/s390/char/tapechar.c	Tue Jul 30 15:50:04 2002
@@ -128,11 +128,7 @@
 	tape_init();
 
 	/* Register the tape major number to the kernel */
-#ifdef CONFIG_DEVFS_FS
-	result = devfs_register_chrdev (tapechar_major, "tape", &tape_fops);
-#else
 	result = register_chrdev (tapechar_major, "tape", &tape_fops);
-#endif
 	if (result < 0) {
 		PRINT_WARN (KERN_ERR "tape: can't get major %d\n", tapechar_major);
 		tape_sprintf_event (tape_dbf_area,3,"c:initfail\n");
@@ -178,11 +174,7 @@
 void
 tapechar_uninit (void)
 {
-#ifdef CONFIG_DEVFS_FS
-	devfs_unregister_chrdev (tapechar_major, "tape");
-#else
 	unregister_chrdev (tapechar_major, "tape");
-#endif
 }
 
 
diff -Nru a/drivers/s390/char/tubfs.c b/drivers/s390/char/tubfs.c
--- a/drivers/s390/char/tubfs.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/s390/char/tubfs.c	Tue Jul 30 15:50:05 2002
@@ -74,26 +74,19 @@
 {
 	int rc;
 
-#ifdef CONFIG_DEVFS_FS
-	rc = devfs_register_chrdev (IBM_FS3270_MAJOR, "fs3270", &fs3270_fops);
+	rc = register_chrdev(IBM_FS3270_MAJOR, "fs3270", &fs3270_fops);
 	if (rc) {
 		printk(KERN_ERR "tubmod can't get major nbr %d: error %d\n",
 			IBM_FS3270_MAJOR, rc);
 		return -1;
 	}
+#ifdef CONFIG_DEVFS_FS
 	fs3270_devfs_dir = devfs_mk_dir(NULL, "3270", NULL);
 	fs3270_devfs_tub = 
 		devfs_register(fs3270_devfs_dir, "tub", DEVFS_FL_DEFAULT,
 			       IBM_FS3270_MAJOR, 0,
 			       S_IFCHR | S_IRUGO | S_IWUGO, 
 			       &fs3270_fops, NULL);
-#else
-	rc = register_chrdev(IBM_FS3270_MAJOR, "fs3270", &fs3270_fops);
-	if (rc) {
-		printk(KERN_ERR "tubmod can't get major nbr %d: error %d\n",
-			IBM_FS3270_MAJOR, rc);
-		return -1;
-	}
 #endif
 	fs3270_major = IBM_FS3270_MAJOR;
 	return 0;
diff -Nru a/drivers/sbus/audio/audio.c b/drivers/sbus/audio/audio.c
--- a/drivers/sbus/audio/audio.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/sbus/audio/audio.c	Tue Jul 30 15:50:04 2002
@@ -2123,7 +2123,7 @@
 static int __init sparcaudio_init(void)
 {
 	/* Register our character device driver with the VFS. */
-	if (devfs_register_chrdev(SOUND_MAJOR, "sparcaudio", &sparcaudio_fops))
+	if (register_chrdev(SOUND_MAJOR, "sparcaudio", &sparcaudio_fops))
 		return -EIO;
 
 	devfs_handle = devfs_mk_dir (NULL, "sound", NULL);
@@ -2132,7 +2132,7 @@
 
 static void __exit sparcaudio_exit(void)
 {
-	devfs_unregister_chrdev(SOUND_MAJOR, "sparcaudio");
+	unregister_chrdev(SOUND_MAJOR, "sparcaudio");
 	devfs_unregister (devfs_handle);
 }
 
diff -Nru a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/sbus/char/bpp.c	Tue Jul 30 15:50:04 2002
@@ -1041,7 +1041,7 @@
 	if (rc == 0)
 		return -ENODEV;
 
-	rc = devfs_register_chrdev(BPP_MAJOR, dev_name, &bpp_fops);
+	rc = register_chrdev(BPP_MAJOR, dev_name, &bpp_fops);
 	if (rc < 0)
 		return rc;
 
@@ -1062,7 +1062,7 @@
 	unsigned idx;
 
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev(BPP_MAJOR, dev_name);
+	unregister_chrdev(BPP_MAJOR, dev_name);
 
 	for (idx = 0 ;  idx < BPP_NO ;  idx += 1) {
 		if (instances[idx].present)
diff -Nru a/drivers/sbus/char/sunkbd.c b/drivers/sbus/char/sunkbd.c
--- a/drivers/sbus/char/sunkbd.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/sbus/char/sunkbd.c	Tue Jul 30 15:50:05 2002
@@ -1615,7 +1615,7 @@
 			KBD_MAJOR, 0,
 			S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH,
 			&kbd_fops, NULL);
-	if (devfs_register_chrdev (KBD_MAJOR, "kbd", &kbd_fops)){
+	if (register_chrdev (KBD_MAJOR, "kbd", &kbd_fops)){
 		printk ("Could not register /dev/kbd device\n");
 		return;
 	}
diff -Nru a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
--- a/drivers/sbus/char/vfc_dev.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/sbus/char/vfc_dev.c	Tue Jul 30 15:50:05 2002
@@ -676,7 +676,7 @@
 	memset(vfc_dev_lst, 0, sizeof(struct vfc_dev *) * (cards + 1));
 	vfc_dev_lst[cards] = NULL;
 
-	ret = devfs_register_chrdev(VFC_MAJOR, vfcstr, &vfc_fops);
+	ret = register_chrdev(VFC_MAJOR, vfcstr, &vfc_fops);
 	if(ret) {
 		printk(KERN_ERR "Unable to get major number %d\n", VFC_MAJOR);
 		kfree(vfc_dev_lst);
@@ -732,7 +732,7 @@
 {
 	struct vfc_dev **devp;
 
-	devfs_unregister_chrdev(VFC_MAJOR,vfcstr);
+	unregister_chrdev(VFC_MAJOR,vfcstr);
 
 	for (devp = vfc_dev_lst; *devp; devp++)
 		deinit_vfc_device(*devp);
diff -Nru a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/scsi/osst.c	Tue Jul 30 15:50:05 2002
@@ -5585,11 +5585,7 @@
   if (osst_template.dev_noticed == 0) return 0;
 
   if(!osst_registered) {
-#ifdef CONFIG_DEVFS_FS
-	if (devfs_register_chrdev(MAJOR_NR,"osst",&osst_fops)) {
-#else
 	if (register_chrdev(MAJOR_NR,"osst",&osst_fops)) {
-#endif
 		printk(KERN_ERR "osst :W: Unable to get major %d for OnStream tapes\n",MAJOR_NR);
 		return 1;
 	}
@@ -5605,11 +5601,7 @@
 				   GFP_ATOMIC);
   if (os_scsi_tapes == NULL) {
 	printk(KERN_ERR "osst :W: Unable to allocate array for OnStream SCSI tapes.\n");
-#ifdef CONFIG_DEVFS_FS
-	devfs_unregister_chrdev(MAJOR_NR, "osst");
-#else
 	unregister_chrdev(MAJOR_NR, "osst");
-#endif
 	return 1;
   }
 
@@ -5621,11 +5613,7 @@
 				    GFP_ATOMIC);
   if (osst_buffers == NULL) {
 	printk(KERN_ERR "osst :W: Unable to allocate tape buffer pointers.\n");
-#ifdef CONFIG_DEVFS_FS
-	devfs_unregister_chrdev(MAJOR_NR, "osst");
-#else
 	unregister_chrdev(MAJOR_NR, "osst");
-#endif
 	kfree(os_scsi_tapes);
 	return 1;
   }
@@ -5684,11 +5672,7 @@
   OS_Scsi_Tape * STp;
 
   scsi_unregister_device(&osst_template);
-#ifdef CONFIG_DEVFS_FS
-  devfs_unregister_chrdev(MAJOR_NR, "osst");
-#else
   unregister_chrdev(MAJOR_NR, "osst");
-#endif
   osst_registered--;
   if(os_scsi_tapes != NULL) {
 	for (i=0; i < osst_template.dev_max; ++i) {
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/scsi/sg.c	Tue Jul 30 15:50:05 2002
@@ -1348,8 +1348,7 @@
 
     write_lock_irqsave(&sg_dev_arr_lock, iflags);
     if(!sg_registered) {
-	if (devfs_register_chrdev(SCSI_GENERIC_MAJOR,"sg",&sg_fops))
-        {
+	if (register_chrdev(SCSI_GENERIC_MAJOR,"sg",&sg_fops)) {
             printk(KERN_ERR "Unable to get major %d for generic SCSI device\n",
                    SCSI_GENERIC_MAJOR);
 	    write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
@@ -1611,7 +1610,7 @@
     sg_proc_cleanup();
 #endif  /* CONFIG_PROC_FS */
     scsi_unregister_device(&sg_template);
-    devfs_unregister_chrdev(SCSI_GENERIC_MAJOR, "sg");
+    unregister_chrdev(SCSI_GENERIC_MAJOR, "sg");
     if(sg_dev_arr != NULL) {
 	kfree((char *)sg_dev_arr);
         sg_dev_arr = NULL;
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/scsi/st.c	Tue Jul 30 15:50:05 2002
@@ -3826,7 +3826,7 @@
 		verstr, st_fixed_buffer_size, st_write_threshold,
 		st_max_sg_segs);
 
-	if (devfs_register_chrdev(SCSI_TAPE_MAJOR, "st", &st_fops) >= 0) {
+	if (register_chrdev(SCSI_TAPE_MAJOR, "st", &st_fops) >= 0) {
 		if (scsi_register_device(&st_template) == 0) {
 			st_template.scsi_driverfs_driver.name = 
 				(char *)st_template.tag;
@@ -3846,7 +3846,7 @@
 	int i;
 
 	scsi_unregister_device(&st_template);
-	devfs_unregister_chrdev(SCSI_TAPE_MAJOR, "st");
+	unregister_chrdev(SCSI_TAPE_MAJOR, "st");
 	if (scsi_tapes != NULL) {
 		for (i=0; i < st_template.dev_max; ++i)
 			if (scsi_tapes[i])
diff -Nru a/drivers/sgi/char/shmiq.c b/drivers/sgi/char/shmiq.c
--- a/drivers/sgi/char/shmiq.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/sgi/char/shmiq.c	Tue Jul 30 15:50:05 2002
@@ -466,7 +466,7 @@
 shmiq_init (void)
 {
 	printk ("SHMIQ setup\n");
-	devfs_register_chrdev(SHMIQ_MAJOR, "shmiq", &shmiq_fops);
+	register_chrdev(SHMIQ_MAJOR, "shmiq", &shmiq_fops);
 	devfs_register (NULL, "shmiq", DEVFS_FL_DEFAULT,
 			SHMIQ_MAJOR, 0, S_IFCHR | S_IRUSR | S_IWUSR,
 			&shmiq_fops, NULL);
diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	Tue Jul 30 15:50:05 2002
+++ b/drivers/usb/core/file.c	Tue Jul 30 15:50:05 2002
@@ -71,7 +71,7 @@
 
 int usb_major_init(void)
 {
-	if (devfs_register_chrdev(USB_MAJOR, "usb", &usb_fops)) {
+	if (register_chrdev(USB_MAJOR, "usb", &usb_fops)) {
 		err("unable to get major %d for usb devices", USB_MAJOR);
 		return -EBUSY;
 	}
@@ -84,7 +84,7 @@
 void usb_major_cleanup(void)
 {
 	devfs_unregister(usb_devfs_handle);
-	devfs_unregister_chrdev(USB_MAJOR, "usb");
+	unregister_chrdev(USB_MAJOR, "usb");
 }
 
 /**
diff -Nru a/drivers/usb/misc/tiglusb.c b/drivers/usb/misc/tiglusb.c
--- a/drivers/usb/misc/tiglusb.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/usb/misc/tiglusb.c	Tue Jul 30 15:50:04 2002
@@ -476,7 +476,7 @@
 	}
 
 	/* register device */
-	if (devfs_register_chrdev (TIUSB_MAJOR, "tiglusb", &tiglusb_fops)) {
+	if (register_chrdev (TIUSB_MAJOR, "tiglusb", &tiglusb_fops)) {
 		err ("unable to get major %d", TIUSB_MAJOR);
 		return -EIO;
 	}
@@ -487,7 +487,7 @@
 	/* register USB module */
 	result = usb_register (&tiglusb_driver);
 	if (result < 0) {
-		devfs_unregister_chrdev (TIUSB_MAJOR, "tiglusb");
+		unregister_chrdev (TIUSB_MAJOR, "tiglusb");
 		return -1;
 	}
 
@@ -501,7 +501,7 @@
 {
 	usb_deregister (&tiglusb_driver);
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev (TIUSB_MAJOR, "tiglusb");
+	unregister_chrdev (TIUSB_MAJOR, "tiglusb");
 }
 
 /* --------------------------------------------------------------------- */
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Tue Jul 30 15:50:04 2002
+++ b/drivers/video/fbmem.c	Tue Jul 30 15:50:04 2002
@@ -845,7 +845,7 @@
 	create_proc_read_entry("fb", 0, 0, fbmem_read_proc, NULL);
 
 	devfs_handle = devfs_mk_dir (NULL, "fb", NULL);
-	if (devfs_register_chrdev(FB_MAJOR,"fb",&fb_fops))
+	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
 #ifdef CONFIG_FB_OF
diff -Nru a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c	Tue Jul 30 15:50:05 2002
+++ b/fs/coda/psdev.c	Tue Jul 30 15:50:05 2002
@@ -366,7 +366,7 @@
 
 static int init_coda_psdev(void)
 {
-	if(devfs_register_chrdev(CODA_PSDEV_MAJOR,"coda_psdev",
+	if(register_chrdev(CODA_PSDEV_MAJOR,"coda_psdev",
 				 &coda_psdev_fops)) {
               printk(KERN_ERR "coda_psdev: unable to get major %d\n", 
 		     CODA_PSDEV_MAJOR);
@@ -411,7 +411,7 @@
 	return 0;
 out:
 	devfs_unregister(devfs_handle);
-	devfs_unregister_chrdev(CODA_PSDEV_MAJOR,"coda_psdev");
+	unregister_chrdev(CODA_PSDEV_MAJOR,"coda_psdev");
 	coda_sysctl_clean();
 out1:
 	coda_destroy_inodecache();
@@ -428,7 +428,7 @@
                 printk("coda: failed to unregister filesystem\n");
         }
 	devfs_unregister(devfs_handle);
-	devfs_unregister_chrdev(CODA_PSDEV_MAJOR, "coda_psdev");
+	unregister_chrdev(CODA_PSDEV_MAJOR, "coda_psdev");
 	coda_sysctl_clean();
 	coda_destroy_inodecache();
 }
diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Tue Jul 30 15:50:04 2002
+++ b/fs/devfs/base.c	Tue Jul 30 15:50:04 2002
@@ -2228,22 +2228,16 @@
 
 
 /**
- *	devfs_register_chrdev - Optionally register a conventional character driver.
- *	@major: The major number for the driver.
- *	@name: The name of the driver (as seen in /proc/devices).
- *	@fops: The &file_operations structure pointer.
+ *	devfs_should_register_chrdev - should we register a conventional character driver.
  *
- *	This function will register a character driver provided the "devfs=only"
- *	option was not provided at boot time.
- *	Returns 0 on success, else a negative error code on failure.
+ *	If "devfs=only" this function will return -1, otherwise 0 is returned.
  */
-
-int devfs_register_chrdev (unsigned int major, const char *name,
-			   struct file_operations *fops)
+int devfs_should_register_chrdev (void)
 {
-    if (boot_options & OPTION_ONLY) return 0;
-    return register_chrdev (major, name, fops);
-}   /*  End Function devfs_register_chrdev  */
+    if (boot_options & OPTION_ONLY)
+	    return -1;
+    return 0;
+}
 
 
 /**
@@ -2266,20 +2260,16 @@
 
 
 /**
- *	devfs_unregister_chrdev - Optionally unregister a conventional character driver.
- *	@major: The major number for the driver.
- *	@name: The name of the driver (as seen in /proc/devices).
+ *	devfs_should_unregister_chrdev - should we unregister a conventional character driver.
  *
- *	This function will unregister a character driver provided the "devfs=only"
- *	option was not provided at boot time.
- *	Returns 0 on success, else a negative error code on failure.
+ *	If "devfs=only" this function will return -1, otherwise 0 is returned
  */
-
-int devfs_unregister_chrdev (unsigned int major, const char *name)
+int devfs_should_unregister_chrdev (void)
 {
-    if (boot_options & OPTION_ONLY) return 0;
-    return unregister_chrdev (major, name);
-}   /*  End Function devfs_unregister_chrdev  */
+    if (boot_options & OPTION_ONLY)
+	    return -1;
+    return 0;
+}
 
 
 /**
@@ -2385,9 +2375,7 @@
 EXPORT_SYMBOL(devfs_auto_unregister);
 EXPORT_SYMBOL(devfs_get_unregister_slave);
 EXPORT_SYMBOL(devfs_get_name);
-EXPORT_SYMBOL(devfs_register_chrdev);
 EXPORT_SYMBOL(devfs_register_blkdev);
-EXPORT_SYMBOL(devfs_unregister_chrdev);
 EXPORT_SYMBOL(devfs_unregister_blkdev);
 
 
diff -Nru a/fs/devices.c b/fs/devices.c
--- a/fs/devices.c	Tue Jul 30 15:50:05 2002
+++ b/fs/devices.c	Tue Jul 30 15:50:05 2002
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 
@@ -97,6 +98,8 @@
 
 int register_chrdev(unsigned int major, const char * name, struct file_operations *fops)
 {
+	if (devfs_should_register_chrdev())
+		return 0;
 	if (major == 0) {
 		write_lock(&chrdevs_lock);
 		for (major = MAX_CHRDEV-1; major > 0; major--) {
@@ -125,6 +128,8 @@
 
 int unregister_chrdev(unsigned int major, const char * name)
 {
+	if (devfs_should_register_chrdev())
+		return 0;
 	if (major >= MAX_CHRDEV)
 		return -EINVAL;
 	write_lock(&chrdevs_lock);
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Tue Jul 30 15:50:05 2002
+++ b/include/linux/devfs_fs_kernel.h	Tue Jul 30 15:50:05 2002
@@ -94,11 +94,10 @@
 extern void devfs_auto_unregister (devfs_handle_t master,devfs_handle_t slave);
 extern devfs_handle_t devfs_get_unregister_slave (devfs_handle_t master);
 extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
-extern int devfs_register_chrdev (unsigned int major, const char *name,
-				  struct file_operations *fops);
+extern int devfs_should_register_chrdev (void);
 extern int devfs_register_blkdev (unsigned int major, const char *name,
 				  struct block_device_operations *bdops);
-extern int devfs_unregister_chrdev (unsigned int major, const char *name);
+extern int devfs_should_unregister_chrdev (void);
 extern int devfs_unregister_blkdev (unsigned int major, const char *name);
 
 extern void devfs_register_tape (devfs_handle_t de);
@@ -239,19 +238,18 @@
 {
     return NULL;
 }
-static inline int devfs_register_chrdev (unsigned int major, const char *name,
-					 struct file_operations *fops)
+static inline int devfs_should_register_chrdev (void)
 {
-    return register_chrdev (major, name, fops);
+    return 0;
 }
 static inline int devfs_register_blkdev (unsigned int major, const char *name,
 					 struct block_device_operations *bdops)
 {
     return register_blkdev (major, name, bdops);
 }
-static inline int devfs_unregister_chrdev (unsigned int major,const char *name)
+static inline int devfs_unregister_chrdev (void)
 {
-    return unregister_chrdev (major, name);
+    return 0;
 }
 static inline int devfs_unregister_blkdev (unsigned int major,const char *name)
 {
diff -Nru a/net/netlink/netlink_dev.c b/net/netlink/netlink_dev.c
--- a/net/netlink/netlink_dev.c	Tue Jul 30 15:50:04 2002
+++ b/net/netlink/netlink_dev.c	Tue Jul 30 15:50:04 2002
@@ -182,7 +182,7 @@
 
 int __init init_netlink(void)
 {
-	if (devfs_register_chrdev(NETLINK_MAJOR,"netlink", &netlink_fops)) {
+	if (register_chrdev(NETLINK_MAJOR,"netlink", &netlink_fops)) {
 		printk(KERN_ERR "netlink: unable to get major %d\n", NETLINK_MAJOR);
 		return -EIO;
 	}
@@ -217,7 +217,7 @@
 void cleanup_module(void)
 {
 	devfs_unregister (devfs_handle);
-	devfs_unregister_chrdev(NETLINK_MAJOR, "netlink");
+	unregister_chrdev(NETLINK_MAJOR, "netlink");
 }
 
 #endif
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Tue Jul 30 15:50:04 2002
+++ b/sound/core/sound.c	Tue Jul 30 15:50:04 2002
@@ -315,10 +315,8 @@
 #else
 	devfs_handle = devfs_mk_dir(NULL, "snd", NULL);
 #endif
-	if (devfs_register_chrdev(snd_major, "alsa", &snd_fops)) {
-#else
-	if (register_chrdev(snd_major, "alsa", &snd_fops)) {
 #endif
+	if (register_chrdev(snd_major, "alsa", &snd_fops)) {
 		snd_printk(KERN_ERR "unable to register native major device number %d\n", snd_major);
 #ifdef CONFIG_SND_OSSEMUL
 		snd_oss_cleanup_module();
@@ -386,11 +384,7 @@
 #ifdef CONFIG_SND_DEBUG_MEMORY
 	snd_memory_done();
 #endif
-#ifdef CONFIG_DEVFS_FS
-	if (devfs_unregister_chrdev(snd_major, "alsa") != 0)
-#else
 	if (unregister_chrdev(snd_major, "alsa") != 0)
-#endif
 		snd_printk(KERN_ERR "unable to unregister major device number %d\n", snd_major);
 #ifdef CONFIG_DEVFS_FS
 	devfs_unregister(devfs_handle);
diff -Nru a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c	Tue Jul 30 15:50:04 2002
+++ b/sound/sound_core.c	Tue Jul 30 15:50:04 2002
@@ -554,14 +554,13 @@
 {
 	/* We have nothing to really do here - we know the lists must be
 	   empty */
-	devfs_unregister_chrdev(SOUND_MAJOR, "sound");
+	unregister_chrdev(SOUND_MAJOR, "sound");
 	devfs_unregister (devfs_handle);
 }
 
 static int __init init_soundcore(void)
 {
-	if(devfs_register_chrdev(SOUND_MAJOR, "sound", &soundcore_fops)==-1)
-	{
+	if (register_chrdev(SOUND_MAJOR, "sound", &soundcore_fops)==-1) {
 		printk(KERN_ERR "soundcore: sound device already in use.\n");
 		return -EBUSY;
 	}
