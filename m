Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSHAWqj>; Thu, 1 Aug 2002 18:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHAWqj>; Thu, 1 Aug 2002 18:46:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48098 "EHLO e1.ny.us.ibm.com.")
	by vger.kernel.org with ESMTP id <S317214AbSHAWqD>;
	Thu, 1 Aug 2002 18:46:03 -0400
Message-ID: <3D49BADF.7050503@us.ibm.com>
Date: Thu, 01 Aug 2002 15:49:03 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020728
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: [BK-PATCH] Push BKL into chrdev opens
Content-Type: multipart/mixed;
 boundary="------------060408060203040607080404"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408060203040607080404
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds the BKL to each character device's open() function.
The BKL will remain in chrdev_open() until the module unload races are
fixed, but this makes it unnecessary there for any other reason.  Greg 
KH seemed to think that there are enough module races elsewhere that 
just removing it wouldn't be too upsetting to anyone, but I haven't 
done that yet.

I'm reasonably confident that I found all of the character devices'
open()s if the device used register_chrdev or devfs_register_chrdev.
I _think_ this covers them all.  I'm also reasonably confident that I
added all of the #includes correctly this time.  It is hard to say if
it compiles or not because half the kernel doesn't compile right now
anyway :(  It at least compiles for my config.

Patch attached against the latest Linus BK tree.  I hope this patch 
works, I'm just starting with BK.
Or pull from bk://linux-bkl.bkbits.net/linux-2.5-bkl
-- 
Dave Hansen
haveblue@us.ibm.com


--------------060408060203040607080404
Content-Type: text/plain;
 name="cdev-bkl-2.5.29+bk-6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cdev-bkl-2.5.29+bk-6.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.543   -> 1.545  
#	drivers/video/fbmem.c	1.25    -> 1.27   
#	drivers/sbus/audio/audio.c	1.10    -> 1.12   
#	arch/i386/kernel/cpuid.c	1.9     -> 1.10   
#	arch/cris/drivers/gpio.c	1.6     -> 1.8    
#	drivers/block/acsi_slm.c	1.5     -> 1.7    
#	drivers/usb/misc/tiglusb.c	1.8     -> 1.10   
#	   drivers/char/lp.c	1.20    -> 1.22   
#	arch/m68k/atari/joystick.c	1.5     -> 1.7    
#	drivers/net/wan/cosa.c	1.10    -> 1.12   
#	drivers/sbus/char/bpp.c	1.6     -> 1.8    
#	arch/m68k/bvme6000/rtc.c	1.5     -> 1.6    
#	drivers/char/istallion.c	1.11    -> 1.13   
#	  drivers/char/raw.c	1.18    -> 1.20   
#	drivers/telephony/phonedev.c	1.4     -> 1.6    
#	arch/cris/drivers/i2c.c	1.3     -> 1.4    
#	drivers/net/wan/hdlc_ppp.c	1.2     -> 1.3    
#	arch/cris/drivers/sync_serial.c	1.4     -> 1.6    
#	drivers/media/video/videodev.c	1.14    -> 1.16   
#	  sound/core/sound.c	1.7     -> 1.9    
#	drivers/char/drm/radeon_drv.c	1.4     -> 1.5    
#	drivers/ide/ide-tape.c	1.53    -> 1.55   
#	arch/x86_64/kernel/msr.c	1.3     -> 1.4    
#	drivers/char/stallion.c	1.11    -> 1.13   
#	drivers/ieee1394/ieee1394_core.c	1.15    -> 1.17   
#	arch/x86_64/kernel/cpuid.c	1.3     -> 1.4    
#	drivers/block/paride/pt.c	1.11    -> 1.13   
#	drivers/scsi/dpt_i2o.c	1.13    -> 1.14   
#	drivers/char/vc_screen.c	1.6     -> 1.8    
#	Documentation/filesystems/Locking	1.32    -> 1.33   
#	fs/intermezzo/psdev.c	1.8     -> 1.10   
#	arch/sparc64/solaris/socksys.c	1.8     -> 1.10   
#	drivers/isdn/i4l/isdn_common.c	1.22    -> 1.24   
#	drivers/ieee1394/pcilynx.c	1.19    -> 1.21   
#	drivers/atm/atmdev_init.c	1.4     -> 1.5    
#	arch/cris/drivers/eeprom.c	1.6     -> 1.7    
#	drivers/mtd/mtdblock.c	1.21    -> 1.23   
#	drivers/char/ftape/zftape/zftape-init.c	1.10    -> 1.12   
#	net/netlink/netlink_dev.c	1.8     -> 1.10   
#	 drivers/char/dtlk.c	1.9     -> 1.11   
#	arch/i386/kernel/msr.c	1.9     -> 1.10   
#	  sound/sound_core.c	1.11    -> 1.13   
#	drivers/char/ppdev.c	1.14    -> 1.16   
#	drivers/s390/char/tapechar.c	1.8     -> 1.10   
#	   drivers/scsi/sg.c	1.20    -> 1.22   
#	 drivers/scsi/osst.c	1.16    -> 1.18   
#	drivers/mtd/mtdblock_ro.c	1.14    -> 1.15   
#	drivers/char/tpqic02.c	1.14    -> 1.16   
#	drivers/macintosh/adb.c	1.10    -> 1.12   
#	drivers/char/dsp56k.c	1.10    -> 1.12   
#	drivers/input/input.c	1.13    -> 1.15   
#	drivers/sbus/char/vfc_dev.c	1.7     -> 1.9    
#	drivers/char/tty_io.c	1.36    -> 1.38   
#	    drivers/md/lvm.c	1.31    -> 1.33   
#	drivers/s390/char/tubfs.c	1.6     -> 1.8    
#	   drivers/scsi/st.c	1.22    -> 1.24   
#	drivers/mtd/mtdchar.c	1.9     -> 1.11   
#	drivers/sbus/char/sunkbd.c	1.7     -> 1.9    
#	drivers/sgi/char/shmiq.c	1.7     -> 1.9    
#	 drivers/pcmcia/ds.c	1.13    -> 1.14   
#	drivers/i2c/i2c-dev.c	1.12    -> 1.14   
#	drivers/char/drm/drm_stub.h	1.3     -> 1.5    
#	drivers/block/paride/pg.c	1.11    -> 1.13   
#	drivers/isdn/divert/divert_procfs.c	1.9     -> 1.10   
#	drivers/net/ppp_generic.c	1.13    -> 1.15   
#	drivers/macintosh/rtc.c	1.7     -> 1.8    
#	drivers/isdn/capi/capi.c	1.34    -> 1.36   
#	drivers/usb/core/file.c	1.4     -> 1.6    
#	drivers/char/ip2main.c	1.13    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/01	haveblue@nighthawk.sr71.net	1.524.5.10
# update documentation
# --------------------------------------------
# 02/08/01	haveblue@nighthawk.sr71.net	1.544
# Merge http://linus.bkbits.net:8080/linux-2.5
# into nighthawk.sr71.net:/home/dave/lse/linux/2.5/bk/linux-2.5
# --------------------------------------------
# 02/08/01	linux-bkl.adm@hostme.bitkeeper.com	1.543.1.1
# Merge bk://linus.bkbits.net/linux-2.5
# into hostme.bitkeeper.com:/ua/repos/l/linux-bkl/linux-2.5-bkl
# --------------------------------------------
# 02/08/01	haveblue@nighthawk.sr71.net	1.545
# Merge bk://linux-bkl.bkbits.net/linux-2.5-bkl
# into nighthawk.sr71.net:/home/dave/lse/linux/2.5/bk/linux-2.5
# --------------------------------------------
#
diff -Nru a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
--- a/Documentation/filesystems/Locking	Thu Aug  1 15:24:50 2002
+++ b/Documentation/filesystems/Locking	Thu Aug  1 15:24:50 2002
@@ -321,7 +321,9 @@
 end up in ->i_fop/->proc_fops, i.e. ones that belong to character devices
 (chrdev_open() takes lock before replacing ->f_op and calling the secondary
 method. As soon as we fix the handling of module reference counters all
-instances of ->open() will be called without the BKL.
+instances of ->open() will be called without the BKL.  BKL has been pushed 
+into each chardev ->open(), so module races are all that is keeping BKL in 
+chrdev_open()
 
 Note: ext2_release() was *the* source of contention on fs-intensive
 loads and dropping BKL on ->release() helps to get rid of that (we still
diff -Nru a/arch/cris/drivers/eeprom.c b/arch/cris/drivers/eeprom.c
--- a/arch/cris/drivers/eeprom.c	Thu Aug  1 15:24:50 2002
+++ b/arch/cris/drivers/eeprom.c	Thu Aug  1 15:24:50 2002
@@ -424,20 +424,31 @@
 
 static int eeprom_open(struct inode * inode, struct file * file)
 {
+  int ret = -EFAULT;
+  lock_kernel();	
 
   if(MINOR(inode->i_rdev) != EEPROM_MINOR_NR)
-     return -ENXIO;
+  {
+     ret = -ENXIO;
+     goto out;
+  }
   if(MAJOR(inode->i_rdev) != EEPROM_MAJOR_NR)
-     return -ENXIO;
+  {
+     ret = -ENXIO;
+     goto out;
+  }
 
   if( eeprom.size > 0 )
   {
     /* OK */
-    return 0;
+    ret = 0;
+    goto out;
   }
 
+out:
   /* No EEprom found */
-  return -EFAULT;
+  unlock_kernel();
+  return ret;
 }
 
 /* Changes the current file position. */
diff -Nru a/arch/cris/drivers/gpio.c b/arch/cris/drivers/gpio.c
--- a/arch/cris/drivers/gpio.c	Thu Aug  1 15:24:50 2002
+++ b/arch/cris/drivers/gpio.c	Thu Aug  1 15:24:50 2002
@@ -69,6 +69,7 @@
 #include <linux/string.h>
 #include <linux/poll.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 
 #include <asm/etraxgpio.h>
 #include <asm/svinto.h>
@@ -217,16 +218,23 @@
 gpio_open(struct inode *inode, struct file *filp)
 {
 	struct gpio_private *priv;
+	int ret = 0;
 	int p = minor(inode->i_rdev);
+	
+	lock_kernel();
 
-	if (p >= NUM_PORTS && p != LEDS)
-		return -EINVAL;
+	if (p >= NUM_PORTS && p != LEDS) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	priv = (struct gpio_private *)kmalloc(sizeof(struct gpio_private), 
 					      GFP_KERNEL);
 
-	if (!priv)
-		return -ENOMEM;
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	priv->minor = p;
 
@@ -250,7 +258,9 @@
 
 	filp->private_data = (void *)priv;
 
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static int
diff -Nru a/arch/cris/drivers/i2c.c b/arch/cris/drivers/i2c.c
--- a/arch/cris/drivers/i2c.c	Thu Aug  1 15:24:50 2002
+++ b/arch/cris/drivers/i2c.c	Thu Aug  1 15:24:50 2002
@@ -58,6 +58,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/config.h>
+#include <linux/smp_lock.h>
 
 #include <asm/etraxi2c.h>
 
diff -Nru a/arch/cris/drivers/sync_serial.c b/arch/cris/drivers/sync_serial.c
--- a/arch/cris/drivers/sync_serial.c	Thu Aug  1 15:24:50 2002
+++ b/arch/cris/drivers/sync_serial.c	Thu Aug  1 15:24:50 2002
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/timer.h>
+#include <linux/smp_lock.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/svinto.h>
@@ -338,20 +339,29 @@
 static int sync_serial_open(struct inode *inode, struct file *file)
 {
 	int dev = MINOR(inode->i_rdev);
+	int ret = 0;
+	
+	lock_kernel();
+
 	DEBUG(printk("Open sync serial port %d\n", dev)); 
   
 	if (dev < 0 || dev >= NUMBER_OF_PORTS || !ports[dev].enabled)
 	{
 		DEBUG(printk("Invalid minor %d\n", dev));
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 	if (ports[dev].busy)
 	{
 		DEBUG(printk("Device is busy.. \n"));
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 	ports[dev].busy = 1;
-	return 0;
+
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static int sync_serial_release(struct inode *inode, struct file *file)
diff -Nru a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
--- a/arch/i386/kernel/cpuid.c	Thu Aug  1 15:24:50 2002
+++ b/arch/i386/kernel/cpuid.c	Thu Aug  1 15:24:50 2002
@@ -133,13 +133,17 @@
 {
   int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+  int ret = 0;
+
+  lock_kernel();
 
   if ( !(cpu_online_map & (1UL << cpu)) )
-    return -ENXIO;		/* No such CPU */
-  if ( c->cpuid_level < 0 )
-    return -EIO;		/* CPUID not supported */
+    ret = -ENXIO;		/* No such CPU */
+  else if ( c->cpuid_level < 0 )
+    ret = -EIO;		/* CPUID not supported */
   
-  return 0;
+  unlock_kernel();
+  return ret;
 }
 
 /*
diff -Nru a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
--- a/arch/i386/kernel/msr.c	Thu Aug  1 15:24:50 2002
+++ b/arch/i386/kernel/msr.c	Thu Aug  1 15:24:50 2002
@@ -233,13 +233,17 @@
 {
   int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+  int ret = 0;
+
+  lock_kernel();
   
   if ( !(cpu_online_map & (1UL << cpu)) )
-    return -ENXIO;		/* No such CPU */
-  if ( !cpu_has(c, X86_FEATURE_MSR) )
-    return -EIO;		/* MSR not supported */
-  
-  return 0;
+    ret = -ENXIO;		/* No such CPU */
+  else if ( !cpu_has(c, X86_FEATURE_MSR) )
+    ret = -EIO;		/* MSR not supported */
+ 
+  unlock_kernel(); 
+  return ret;
 }
 
 /*
diff -Nru a/arch/m68k/atari/joystick.c b/arch/m68k/atari/joystick.c
--- a/arch/m68k/atari/joystick.c	Thu Aug  1 15:24:50 2002
+++ b/arch/m68k/atari/joystick.c	Thu Aug  1 15:24:50 2002
@@ -72,15 +72,24 @@
 static int open_joystick(struct inode *inode, struct file *file)
 {
     int minor = DEVICE_NR(inode->i_rdev);
+    int ret = 0;
 
-    if (!DIGITAL_JOY(inode->i_rdev) || minor > 1)
-	return -ENODEV;
-    if (joystick[minor].active)
-	return -EBUSY;
+    lock_kernel();
+
+    if (!DIGITAL_JOY(inode->i_rdev) || minor > 1) {
+	ret = -ENODEV;
+	goto out;
+    }
+    if (joystick[minor].active) {
+	ret = -EBUSY;
+	goto out;
+    }
     joystick[minor].active = 1;
     joystick[minor].ready = 0;
     ikbd_joystick_event_on();
-    return 0;
+out:
+    unlock_kernel();
+    return ret;
 }
 
 static ssize_t write_joystick(struct file *file, const char *buffer,
diff -Nru a/arch/m68k/bvme6000/rtc.c b/arch/m68k/bvme6000/rtc.c
--- a/arch/m68k/bvme6000/rtc.c	Thu Aug  1 15:24:50 2002
+++ b/arch/m68k/bvme6000/rtc.c	Thu Aug  1 15:24:50 2002
@@ -141,18 +141,15 @@
 
 static int rtc_open(struct inode *inode, struct file *file)
 {
-	if(rtc_status)
+	if(test_and_set_bit(0,&rtc_status))
 		return -EBUSY;
 
-	rtc_status = 1;
 	return 0;
 }
 
 static int rtc_release(struct inode *inode, struct file *file)
 {
-	lock_kernel();
-	rtc_status = 0;
-	unlock_kernel();
+	clear_bit(0,&rtc_status);
 	return 0;
 }
 
diff -Nru a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
--- a/arch/sparc64/solaris/socksys.c	Thu Aug  1 15:24:50 2002
+++ b/arch/sparc64/solaris/socksys.c	Thu Aug  1 15:24:50 2002
@@ -67,6 +67,8 @@
 	int (*sys_socket)(int,int,int) =
 		(int (*)(int,int,int))SUNOS(97);
         struct sol_socket_struct * sock;
+
+	lock_kernel();
 	
 	family = ((minor(inode->i_rdev) >> 4) & 0xf);
 	switch (family) {
@@ -89,8 +91,10 @@
 	}
 
 	fd = sys_socket(family, type, protocol);
-	if (fd < 0)
+	if (fd < 0) {
+		unlock_kernel();
 		return fd;
+	}
 	/*
 	 * N.B. The following operations are not legal!
 	 *
@@ -107,7 +111,10 @@
 	filp->f_op = &socksys_file_ops;
         sock = (struct sol_socket_struct*) 
         	mykmalloc(sizeof(struct sol_socket_struct), GFP_KERNEL);
-        if (!sock) return -ENOMEM;
+        if (!sock) {	
+		unlock_kernel();
+		return -ENOMEM;
+	}
 	SOLDD(("sock=%016lx(%016lx)\n", sock, filp));
         sock->magic = SOLARIS_SOCKET_MAGIC;
         sock->modcount = 0;
@@ -119,6 +126,7 @@
 
 	sys_close(fd);
 	dput(dentry);
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/arch/x86_64/kernel/cpuid.c b/arch/x86_64/kernel/cpuid.c
--- a/arch/x86_64/kernel/cpuid.c	Thu Aug  1 15:24:50 2002
+++ b/arch/x86_64/kernel/cpuid.c	Thu Aug  1 15:24:50 2002
@@ -133,12 +133,16 @@
 {
   int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
+  int ret = 0;
+
+  lock_kernel();
 
   if ( !(cpu_online_map & (1UL << cpu)) )
-    return -ENXIO;		/* No such CPU */
-  if ( c->cpuid_level < 0 )
-    return -EIO;		/* CPUID not supported */
+    ret = -ENXIO;		/* No such CPU */
+  else if ( c->cpuid_level < 0 )
+    ret = -EIO;		/* CPUID not supported */
   
+  unlock_kernel();
   return 0;
 }
 
diff -Nru a/arch/x86_64/kernel/msr.c b/arch/x86_64/kernel/msr.c
--- a/arch/x86_64/kernel/msr.c	Thu Aug  1 15:24:50 2002
+++ b/arch/x86_64/kernel/msr.c	Thu Aug  1 15:24:50 2002
@@ -234,13 +234,17 @@
 {
   int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
-  
+  int ret = 0;
+
+  lock_kernel();
+ 
   if ( !(cpu_online_map & (1UL << cpu)) )
-    return -ENXIO;		/* No such CPU */
+    ret = -ENXIO;		/* No such CPU */
   if ( !cpu_has(c, X86_FEATURE_MSR) )
-    return -EIO;		/* MSR not supported */
+    ret = -EIO;		/* MSR not supported */
   
-  return 0;
+  unlock_kernel();
+  return ret;
 }
 
 /*
diff -Nru a/drivers/atm/atmdev_init.c b/drivers/atm/atmdev_init.c
--- a/drivers/atm/atmdev_init.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/atm/atmdev_init.c	Thu Aug  1 15:24:50 2002
@@ -5,6 +5,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/smp_lock.h>
 
 
 #ifdef CONFIG_ATM_ZATM
diff -Nru a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/block/acsi_slm.c	Thu Aug  1 15:24:50 2002
@@ -774,12 +774,14 @@
 	device = MINOR(inode->i_rdev);
 	if (device >= N_SLM_Printers)
 		return( -ENXIO );
+	lock_kernel();
 	sip = &slm_info[device];
 
 	if (file->f_mode & 2) {
 		/* open for writing is exclusive */
 		if ( !atomic_dec_and_test(&sip->wr_ok) ) {
 			atomic_inc(&sip->wr_ok);	
+			unlock_kernel();
 			return( -EBUSY );
 		}
 	}
@@ -787,10 +789,12 @@
 		/* open for reading is exclusive */
                 if ( !atomic_dec_and_test(&sip->rd_ok) ) {
                         atomic_inc(&sip->rd_ok);
+			unlock_kernel();
                         return( -EBUSY );
                 }
 	}
 
+	unlock_kernel();
 	return( 0 );
 }
 
diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/block/paride/pg.c	Thu Aug  1 15:24:50 2002
@@ -169,6 +169,7 @@
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/pg.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -506,9 +507,15 @@
 
 {       int	unit = DEVICE_NR(inode->i_rdev);
 
-	if ((unit >= PG_UNITS) || (!PG.present)) return -ENODEV;
+	lock_kernel();
+
+	if ((unit >= PG_UNITS) || (!PG.present)) { 
+		unlock_kernel();
+		return -ENODEV;
+	}
 
 	if ( test_and_set_bit(0, &PG.access) ) {
+		unlock_kernel();
 		return -EBUSY;
 	}
 
@@ -524,9 +531,11 @@
 	if (PG.bufptr == NULL) {
 		clear_bit( 0, &PG.access ) ;
 		printk("%s: buffer allocation failed\n",PG.name);
+		unlock_kernel();
 		return -ENOMEM;
 	}
 
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/block/paride/pt.c	Thu Aug  1 15:24:50 2002
@@ -147,6 +147,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mtio.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -625,22 +626,29 @@
 
 {       int	unit = DEVICE_NR(inode->i_rdev);
 
-        if ((unit >= PT_UNITS) || (!PT.present)) return -ENODEV;
-
+	lock_kernel()
+	
+        if ((unit >= PT_UNITS) || (!PT.present)) {
+		unlock_kernel();
+		return -ENODEV;
+	}
 	if ( !atomic_dec_and_test(&PT.available) ) {
 		atomic_inc( &PT.available );
-		return -EBUSY;
+		unlock_kernel();
+		eturn -EBUSY;
 	}
 
 	pt_identify(unit);
 
 	if (!PT.flags & PT_MEDIA) {
 		atomic_inc( &PT.available );
+		unlock_kernel();
 		return -ENODEV;
 		}
 
 	if ((!PT.flags & PT_WRITE_OK) && (file ->f_mode & 2)) {
 		atomic_inc( &PT.available );
+		unlock_kernel();
 		return -EROFS;
 		}
 
@@ -651,9 +659,11 @@
 	if (PT.bufptr == NULL) {
 		atomic_inc( &PT.available );
 		printk("%s: buffer allocation failed\n",PT.name);
+		unlock_kernel();
 		return -ENOMEM;
 	}
 
+	unlock_kernel();
         return 0;
 }
 
diff -Nru a/drivers/char/drm/drm_stub.h b/drivers/char/drm/drm_stub.h
--- a/drivers/char/drm/drm_stub.h	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/drm/drm_stub.h	Thu Aug  1 15:24:50 2002
@@ -53,7 +53,11 @@
 	int                    err   = -ENODEV;
 	struct file_operations *old_fops;
 
-	if (!DRM(stub_list) || !DRM(stub_list)[minor].fops) return -ENODEV;
+	lock_kernel();
+
+	if (!DRM(stub_list) || !DRM(stub_list)[minor].fops) 
+		goto out;
+
 	old_fops   = filp->f_op;
 	filp->f_op = fops_get(DRM(stub_list)[minor].fops);
 	if (filp->f_op->open && (err = filp->f_op->open(inode, filp))) {
@@ -62,6 +66,8 @@
 	}
 	fops_put(old_fops);
 
+out:
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/char/drm/radeon_drv.c b/drivers/char/drm/radeon_drv.c
--- a/drivers/char/drm/radeon_drv.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/drm/radeon_drv.c	Thu Aug  1 15:24:50 2002
@@ -112,5 +112,4 @@
 #include "drm_memory.h"
 #include "drm_proc.h"
 #include "drm_vm.h"
-#include "drm_stub.h"
 #include "drm_scatter.h"
diff -Nru a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/dsp56k.c	Thu Aug  1 15:24:50 2002
@@ -443,12 +443,16 @@
 {
 	int dev = minor(inode->i_rdev) & 0x0f;
 
+	lock_kernel();
+
 	switch(dev)
 	{
 	case DSP56K_DEV_56001:
 
-		if (test_and_set_bit(0, &dsp56k.in_use))
+		if (test_and_set_bit(0, &dsp56k.in_use)) {
+			unlock_kernel();
 			return -EBUSY;
+		}
 
 		dsp56k.timeout = TIMEOUT;
 		dsp56k.maxio = MAXIO;
@@ -464,9 +468,11 @@
 		break;
 
 	default:
+		unlock_kernel();
 		return -ENODEV;
 	}
 
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/char/dtlk.c b/drivers/char/dtlk.c
--- a/drivers/char/dtlk.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/dtlk.c	Thu Aug  1 15:24:50 2002
@@ -302,17 +302,21 @@
 
 static int dtlk_open(struct inode *inode, struct file *file)
 {
+	int ret = 0;
 	TRACE_TEXT("(dtlk_open");
 
+	lock_kernel();
+
 	switch (minor(inode->i_rdev)) {
 	case DTLK_MINOR:
 		if (dtlk_busy)
-			return -EBUSY;
-		return 0;
-
+			ret = -EBUSY;
+		break;
 	default:
-		return -ENXIO;
+		ret = -ENXIO;
 	}
+	unlock_kernel();
+	return ret;
 }
 
 static int dtlk_release(struct inode *inode, struct file *file)
diff -Nru a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/ftape/zftape/zftape-init.c	Thu Aug  1 15:24:50 2002
@@ -112,14 +112,18 @@
 	int result;
 	TRACE_FUN(ft_t_flow);
 
+	lock_kernel();
+
 	TRACE(ft_t_flow, "called for minor %d", minor(ino->i_rdev));
 	if ( test_and_set_bit(0,&busy_flag) ) {
+		unlock_kernel();
 		TRACE_ABORT(-EBUSY, ft_t_warn, "failed: already busy");
 	}
 	if ((minor(ino->i_rdev) & ~(ZFT_MINOR_OP_MASK | FTAPE_NO_REWIND))
 	     > 
 	    FTAPE_SEL_D) {
 		clear_bit(0,&busy_flag);
+		unlock_kernel();
 		TRACE_ABORT(-ENXIO, ft_t_err, "failed: illegal unit nr");
 	}
 	orig_sigmask = current->blocked;
@@ -128,6 +132,7 @@
 	if (result < 0) {
 		current->blocked = orig_sigmask; /* restore mask */
 		clear_bit(0,&busy_flag);
+		unlock_kernel();
 		TRACE_ABORT(result, ft_t_err, "_ftape_open failed");
 	} else {
 		/* Mask signals that will disturb proper operation of the
@@ -135,6 +140,7 @@
 		 */
 		current->blocked = orig_sigmask;
 		sigaddsetmask (&current->blocked, _DO_BLOCK);
+		unlock_kernel();
 		TRACE_EXIT 0;
 	}
 }
diff -Nru a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/ip2main.c	Thu Aug  1 15:24:50 2002
@@ -94,6 +94,7 @@
 #include <linux/module.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
+#include <linux/smp_lock.h>
 #ifdef	CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
@@ -1579,11 +1580,15 @@
 	wait_queue_t wait;
 	int rc = 0;
 	int do_clocal = 0;
-	i2ChanStrPtr  pCh = DevTable[minor(tty->device)];
+	i2ChanStrPtr pCh;
+
+	lock_kernel();
 
+	pCh = DevTable[minor(tty->device)];
 	ip2trace (minor(tty->device), ITRC_OPEN, ITRC_ENTER, 0 );
 
 	if ( pCh == NULL ) {
+		unlock_kernel();
 		return -ENODEV;
 	}
 	/* Setup pointer links in device and tty structures */
@@ -1619,6 +1624,7 @@
 		if ( tty_hung_up_p(pFile) ) {
 			set_current_state( TASK_RUNNING );
 			remove_wait_queue(&pCh->close_wait, &wait);
+			unlock_kernel();
 			return( pCh->flags & ASYNC_HUP_NOTIFY ) ? -EAGAIN : -ERESTARTSYS;
 		}
 	}
@@ -1633,16 +1639,19 @@
 	 */
 	if ( tty->driver.subtype == SERIAL_TYPE_CALLOUT ) {
 		if ( pCh->flags & ASYNC_NORMAL_ACTIVE ) {
+			unlock_kernel();
 			return -EBUSY;
 		}
 		if ( ( pCh->flags & ASYNC_CALLOUT_ACTIVE )  &&
 		    ( pCh->flags & ASYNC_SESSION_LOCKOUT ) &&
 		    ( pCh->session != current->session ) ) {
+			unlock_kernel();
 			return -EBUSY;
 		}
 		if ( ( pCh->flags & ASYNC_CALLOUT_ACTIVE ) &&
 		    ( pCh->flags & ASYNC_PGRP_LOCKOUT )   &&
 		    ( pCh->pgrp != current->pgrp ) ) {
+			unlock_kernel();
 			return -EBUSY;
 		}
 		pCh->flags |= ASYNC_CALLOUT_ACTIVE;
@@ -1653,6 +1662,7 @@
 	 */
 	if ( (pFile->f_flags & O_NONBLOCK) || (tty->flags & (1<<TTY_IO_ERROR) )) {
 		if ( pCh->flags & ASYNC_CALLOUT_ACTIVE ) {
+			unlock_kernel();
 			return -EBUSY;
 		}
 		pCh->flags |= ASYNC_NORMAL_ACTIVE;
@@ -1691,6 +1701,7 @@
 		if ( tty_hung_up_p(pFile) ) {
 			set_current_state( TASK_RUNNING );
 			remove_wait_queue(&pCh->open_wait, &wait);
+			unlock_kernel();
 			return ( pCh->flags & ASYNC_HUP_NOTIFY ) ? -EBUSY : -ERESTARTSYS;
 		}
 		if ( !(pCh->flags & ASYNC_CALLOUT_ACTIVE) &&
@@ -1724,6 +1735,7 @@
 	ip2trace (CHANN, ITRC_OPEN, 4, 0 );
 
 	if (rc != 0 ) {
+		unlock_kernel();
 		return rc;
 	}
 	pCh->flags |= ASYNC_NORMAL_ACTIVE;
@@ -1761,6 +1773,7 @@
 
 	ip2trace (CHANN, ITRC_OPEN, ITRC_RETURN, 0 );
 
+	unlock_kernel();
 	return 0;
 }
 
@@ -3275,6 +3288,8 @@
 	i2eBordStrPtr pB;
 	i2ChanStrPtr  pCh;
 
+	lock_kernel();
+
 #ifdef IP2DEBUG_IPL
 	printk (KERN_DEBUG "IP2IPL: open\n" );
 #endif
@@ -3307,6 +3322,7 @@
 	case 3:
 		break;
 	}
+	unlock_kernel();
 	return 0;
 }
 /******************************************************************************/
diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/istallion.c	Thu Aug  1 15:24:50 2002
@@ -1022,6 +1022,8 @@
 
 /*****************************************************************************/
 
+#define returnout(x) ret=x;goto out;
+
 static int stli_open(struct tty_struct *tty, struct file *filp)
 {
 	stlibrd_t	*brdp;
@@ -1037,21 +1039,21 @@
 	minordev = minor(tty->device);
 	brdnr = MINOR2BRD(minordev);
 	if (brdnr >= stli_nrbrds)
-		return(-ENODEV);
+		returnout(-ENODEV);
 	brdp = stli_brds[brdnr];
 	if (brdp == (stlibrd_t *) NULL)
-		return(-ENODEV);
+		returnout(-ENODEV);
 	if ((brdp->state & BST_STARTED) == 0)
-		return(-ENODEV);
+		returnout(-ENODEV);
 	portnr = MINOR2PORT(minordev);
 	if ((portnr < 0) || (portnr > brdp->nrports))
-		return(-ENODEV);
+		returnout(-ENODEV);
 
 	portp = brdp->ports[portnr];
 	if (portp == (stliport_t *) NULL)
-		return(-ENODEV);
+		returnout(-ENODEV);
 	if (portp->devnr < 1)
-		return(-ENODEV);
+		returnout(-ENODEV);
 
 	MOD_INC_USE_COUNT;
 
@@ -1064,8 +1066,8 @@
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
 		if (portp->flags & ASYNC_HUP_NOTIFY)
-			return(-EAGAIN);
-		return(-ERESTARTSYS);
+			returnout(-EAGAIN);
+		returnout(-ERESTARTSYS);
 	}
 
 /*
@@ -1080,7 +1082,7 @@
 
 	while (test_bit(ST_INITIALIZING, &portp->state)) {
 		if (signal_pending(current))
-			return(-ERESTARTSYS);
+			returnout(-ERESTARTSYS);
 		interruptible_sleep_on(&portp->raw_wait);
 	}
 
@@ -1093,7 +1095,7 @@
 		clear_bit(ST_INITIALIZING, &portp->state);
 		wake_up_interruptible(&portp->raw_wait);
 		if (rc < 0)
-			return(rc);
+			returnout(rc);
 	}
 
 /*
@@ -1105,8 +1107,8 @@
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
 		if (portp->flags & ASYNC_HUP_NOTIFY)
-			return(-EAGAIN);
-		return(-ERESTARTSYS);
+			returnout(-EAGAIN);
+		returnout(-ERESTARTSYS);
 	}
 
 /*
@@ -1116,23 +1118,23 @@
  */
 	if (tty->driver.subtype == STL_DRVTYPCALLOUT) {
 		if (portp->flags & ASYNC_NORMAL_ACTIVE)
-			return(-EBUSY);
+			returnout(-EBUSY);
 		if (portp->flags & ASYNC_CALLOUT_ACTIVE) {
 			if ((portp->flags & ASYNC_SESSION_LOCKOUT) &&
 			    (portp->session != current->session))
-				return(-EBUSY);
+				returnout(-EBUSY);
 			if ((portp->flags & ASYNC_PGRP_LOCKOUT) &&
 			    (portp->pgrp != current->pgrp))
-				return(-EBUSY);
+				returnout(-EBUSY);
 		}
 		portp->flags |= ASYNC_CALLOUT_ACTIVE;
 	} else {
 		if (filp->f_flags & O_NONBLOCK) {
 			if (portp->flags & ASYNC_CALLOUT_ACTIVE)
-				return(-EBUSY);
+				returnout(-EBUSY);
 		} else {
 			if ((rc = stli_waitcarrier(brdp, portp, filp)) != 0)
-				return(rc);
+				returnout(rc);
 		}
 		portp->flags |= ASYNC_NORMAL_ACTIVE;
 	}
@@ -1147,7 +1149,9 @@
 
 	portp->session = current->session;
 	portp->pgrp = current->pgrp;
-	return(0);
+out:
+	unlock_kernel();
+	return 0;
 }
 
 /*****************************************************************************/
diff -Nru a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/lp.c	Thu Aug  1 15:24:50 2002
@@ -486,7 +486,7 @@
 static int lp_open(struct inode * inode, struct file * file)
 {
 	unsigned int minor = minor(inode->i_rdev);
-
+	int ret = 0;
 	if (minor >= LP_NO)
 		return -ENXIO;
 	if ((LP_F(minor) & LP_EXIST) == 0)
@@ -494,6 +494,8 @@
 	if (test_and_set_bit(LP_BUSY_BIT_POS, &LP_F(minor)))
 		return -EBUSY;
 
+	lock_kernel();
+
 	/* If ABORTOPEN is set and the printer is offline or out of paper,
 	   we may still want to open it to perform ioctl()s.  Therefore we
 	   have commandeered O_NONBLOCK, even though it is being used in
@@ -507,21 +509,25 @@
 		if (status & LP_POUTPA) {
 			printk(KERN_INFO "lp%d out of paper\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto out;
 		} else if (!(status & LP_PSELECD)) {
 			printk(KERN_INFO "lp%d off-line\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
-			return -EIO;
+			ret = -EIO;
+			goto out;
 		} else if (!(status & LP_PERRORP)) {
 			printk(KERN_ERR "lp%d printer error\n", minor);
 			LP_F(minor) &= ~LP_BUSY;
-			return -EIO;
+			ret = -EIO;
+			goto out;
 		}
 	}
 	lp_table[minor].lp_buffer = (char *) kmalloc(LP_BUFFER_SIZE, GFP_KERNEL);
 	if (!lp_table[minor].lp_buffer) {
 		LP_F(minor) &= ~LP_BUSY;
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 	/* Determine if the peripheral supports ECP mode */
 	lp_claim_parport_or_block (&lp_table[minor]);
@@ -537,7 +543,9 @@
 	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
 	lp_release_parport (&lp_table[minor]);
 	lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static int lp_release(struct inode * inode, struct file * file)
diff -Nru a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/ppdev.c	Thu Aug  1 15:24:50 2002
@@ -644,6 +644,8 @@
 	if (!pp)
 		return -ENOMEM;
 
+	lock_kernel();
+ 
 	pp->state.mode = IEEE1284_MODE_COMPAT;
 	pp->state.phase = init_phase (pp->state.mode);
 	pp->flags = 0;
@@ -657,6 +659,8 @@
 	 */
 	pp->pdev = NULL;
 	file->private_data = pp;
+
+	unlock_kernel();
 
 	return 0;
 }
diff -Nru a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/raw.c	Thu Aug  1 15:24:50 2002
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/raw.h>
 #include <linux/capability.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 
@@ -39,8 +40,11 @@
 	struct block_device *bdev;
 	int err;
 
+	lock_kernel();
+
 	if (minor == 0) {	/* It is the control device */
 		filp->f_op = &raw_ctl_fops;
+		unlock_kernel();
 		return 0;
 	}
 	
@@ -60,6 +64,7 @@
 		}
 	}
 	up(&raw_mutex);
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/stallion.c	Thu Aug  1 15:24:50 2002
@@ -1012,6 +1012,9 @@
 	stlbrd_t	*brdp;
 	unsigned int	minordev;
 	int		brdnr, panelnr, portnr, rc;
+	int		ret;
+
+	lock_kernel();
 
 #if DEBUG
 	printk("stl_open(tty=%x,filp=%x): device=%x\n", (int) tty,
@@ -1020,11 +1023,17 @@
 
 	minordev = minor(tty->device);
 	brdnr = MINOR2BRD(minordev);
-	if (brdnr >= stl_nrbrds)
-		return(-ENODEV);
+	if (brdnr >= stl_nrbrds) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	brdp = stl_brds[brdnr];
-	if (brdp == (stlbrd_t *) NULL)
-		return(-ENODEV);
+	if (brdp == (stlbrd_t *) NULL) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	minordev = MINOR2PORT(minordev);
 	for (portnr = -1, panelnr = 0; (panelnr < STL_MAXPANELS); panelnr++) {
 		if (brdp->panels[panelnr] == (stlpanel_t *) NULL)
@@ -1035,12 +1044,18 @@
 		}
 		minordev -= brdp->panels[panelnr]->nrports;
 	}
-	if (portnr < 0)
-		return(-ENODEV);
+	if (portnr < 0) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 
 	portp = brdp->panels[panelnr]->ports[portnr];
-	if (portp == (stlport_t *) NULL)
-		return(-ENODEV);
+	if (portp == (stlport_t *) NULL) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 
 	MOD_INC_USE_COUNT;
 
@@ -1055,8 +1070,11 @@
 	if ((portp->flags & ASYNC_INITIALIZED) == 0) {
 		if (portp->tx.buf == (char *) NULL) {
 			portp->tx.buf = (char *) stl_memalloc(STL_TXBUFSIZE);
-			if (portp->tx.buf == (char *) NULL)
-				return(-ENOMEM);
+			if (portp->tx.buf == (char *) NULL) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			
 			portp->tx.head = portp->tx.buf;
 			portp->tx.tail = portp->tx.buf;
 		}
@@ -1077,9 +1095,13 @@
  */
 	if (portp->flags & ASYNC_CLOSING) {
 		interruptible_sleep_on(&portp->close_wait);
-		if (portp->flags & ASYNC_HUP_NOTIFY)
-			return(-EAGAIN);
-		return(-ERESTARTSYS);
+		if (portp->flags & ASYNC_HUP_NOTIFY) {
+			ret = -EAGAIN;
+			goto out;
+		}
+		
+		ret = -ERESTARTSYS;
+		goto out;
 	}
 
 /*
@@ -1088,24 +1110,39 @@
  *	then also we might have to wait for carrier.
  */
 	if (tty->driver.subtype == STL_DRVTYPCALLOUT) {
-		if (portp->flags & ASYNC_NORMAL_ACTIVE)
-			return(-EBUSY);
+		if (portp->flags & ASYNC_NORMAL_ACTIVE) {
+			ret = -EBUSY;
+			goto out;
+		}
+
 		if (portp->flags & ASYNC_CALLOUT_ACTIVE) {
 			if ((portp->flags & ASYNC_SESSION_LOCKOUT) &&
-			    (portp->session != current->session))
-				return(-EBUSY);
+			    (portp->session != current->session)) {
+				ret = -EBUSY;
+				goto out;
+			}
+			
 			if ((portp->flags & ASYNC_PGRP_LOCKOUT) &&
-			    (portp->pgrp != current->pgrp))
-				return(-EBUSY);
+			    (portp->pgrp != current->pgrp)) {
+				ret = -EBUSY;
+				goto out;
+			}
+
 		}
 		portp->flags |= ASYNC_CALLOUT_ACTIVE;
 	} else {
 		if (filp->f_flags & O_NONBLOCK) {
-			if (portp->flags & ASYNC_CALLOUT_ACTIVE)
-				return(-EBUSY);
+			if (portp->flags & ASYNC_CALLOUT_ACTIVE) {
+				ret = -EBUSY;
+				goto out;
+			}
+			
 		} else {
-			if ((rc = stl_waitcarrier(portp, filp)) != 0)
-				return(rc);
+			if ((rc = stl_waitcarrier(portp, filp)) != 0) {
+				ret = rc;
+				goto out;
+			}
+			
 		}
 		portp->flags |= ASYNC_NORMAL_ACTIVE;
 	}
@@ -1120,6 +1157,8 @@
 
 	portp->session = current->session;
 	portp->pgrp = current->pgrp;
+out:
+	unlock_kernel();
 	return(0);
 }
 
diff -Nru a/drivers/char/tpqic02.c b/drivers/char/tpqic02.c
--- a/drivers/char/tpqic02.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/tpqic02.c	Thu Aug  1 15:24:50 2002
@@ -2178,8 +2178,9 @@
 	static int qic02_tape_open_no_use_count(struct inode *,
 						struct file *);
 	int open_error;
-
+	lock_kernel();
 	open_error = qic02_tape_open_no_use_count(inode, filp);
+	unlock_kernel();
 	return open_error;
 }
 
diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/tty_io.c	Thu Aug  1 15:24:50 2002
@@ -1286,13 +1286,17 @@
 	unsigned short saved_flags;
 	char	buf[64];
 
+	lock_kernel();
+
 	saved_flags = filp->f_flags;
 retry_open:
 	noctty = filp->f_flags & O_NOCTTY;
 	device = inode->i_rdev;
 	if (IS_TTY_DEV(device)) {
-		if (!current->tty)
-			return -ENXIO;
+		if (!current->tty) {
+			retval = -ENXIO;
+			goto out;
+		}
 		device = current->tty->device;
 		filp->f_flags |= O_NONBLOCK; /* Don't let /dev/tty block */
 		/* noctty = 1; */
@@ -1308,8 +1312,10 @@
 		struct console *c = console_drivers;
 		while(c && !c->device)
 			c = c->next;
-		if (!c)
-                        return -ENODEV;
+		if (!c) {
+                        retval = -ENODEV;
+			goto out;
+		}
                 device = c->device(c);
 		filp->f_flags |= O_NONBLOCK; /* Don't let /dev/console block */
 		noctty = 1;
@@ -1333,7 +1339,8 @@
 				if (!init_dev(device, &tty)) goto ptmx_found; /* ok! */
 			}
 		}
-		return -EIO; /* no free ptys */
+		retval = -EIO; /* no free ptys */
+		goto out;
 	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 		minor -= driver->minor_start;
@@ -1345,14 +1352,15 @@
 
 #else   /* CONFIG_UNIX_98_PTYS */
 
-		return -ENODEV;
+		retval = -ENODEV;
+		goto out;
 
 #endif  /* CONFIG_UNIX_98_PTYS */
 	}
 
 	retval = init_dev(device, &tty);
-	if (retval)
-		return retval;
+	if (retval) 
+		goto out;
 
 #ifdef CONFIG_UNIX98_PTYS
 init_dev_done:
@@ -1383,9 +1391,9 @@
 
 		release_dev(filp);
 		if (retval != -ERESTARTSYS)
-			return retval;
+			goto out;
 		if (signal_pending(current))
-			return retval;
+			goto out;
 		schedule();
 		/*
 		 * Need to reset f_op in case a hangup happened.
@@ -1417,7 +1425,10 @@
 			nr_warns++;
 		}
 	}
-	return 0;
+	retval = 0;
+out:
+	unlock_kernel();
+	return retval;
 }
 
 static int tty_release(struct inode * inode, struct file * filp)
diff -Nru a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/char/vc_screen.c	Thu Aug  1 15:24:50 2002
@@ -458,8 +458,12 @@
 vcs_open(struct inode *inode, struct file *filp)
 {
 	unsigned int currcons = minor(inode->i_rdev) & 127;
-	if(currcons && !vc_cons_allocated(currcons-1))
+	lock_kernel();
+	if(currcons && !vc_cons_allocated(currcons-1)) {	
+		unlock_kernel();
 		return -ENXIO;
+	}
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/i2c/i2c-dev.c	Thu Aug  1 15:24:50 2002
@@ -36,6 +36,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/version.h>
+#include <linux/smp_lock.h>
 #if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
 #include <linux/smp_lock.h>
 #endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
@@ -383,19 +384,24 @@
 {
 	unsigned int minor = minor(inode->i_rdev);
 	struct i2c_client *client;
+	int ret = 0;
+	lock_kernel();
 
 	if ((minor >= I2CDEV_ADAPS_MAX) || ! (i2cdev_adaps[minor])) {
 #ifdef DEBUG
 		printk(KERN_DEBUG "i2c-dev.o: Trying to open unattached adapter i2c-%d\n",
 		       minor);
 #endif
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	/* Note that we here allocate a client for later use, but we will *not*
 	   register this client! Yes, this is safe. No, it is not very clean. */
-	if(! (client = kmalloc(sizeof(struct i2c_client),GFP_KERNEL)))
-		return -ENOMEM;
+	if(! (client = kmalloc(sizeof(struct i2c_client),GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto out;
+	}
 	memcpy(client,&i2cdev_client_template,sizeof(struct i2c_client));
 	client->adapter = i2cdev_adaps[minor];
 	file->private_data = client;
@@ -409,7 +415,10 @@
 #ifdef DEBUG
 	printk(KERN_DEBUG "i2c-dev.o: opened i2c-%d\n",minor);
 #endif
-	return 0;
+
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static int i2cdev_release (struct inode *inode, struct file *file)
diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/ide/ide-tape.c	Thu Aug  1 15:24:50 2002
@@ -4869,17 +4869,24 @@
 	idetape_tape_t *tape;
 	struct atapi_packet_command pc;
 	unsigned int minor=minor(inode->i_rdev);
+	int ret = 0;
+
+	lock_kernel();
 
 #if IDETAPE_DEBUG_LOG
 	printk (KERN_INFO "ide-tape: Reached idetape_chrdev_open\n");
 #endif
 
-	if ((drive = get_drive_ptr (inode->i_rdev)) == NULL)
-		return -ENXIO;
+	if ((drive = get_drive_ptr (inode->i_rdev)) == NULL) {
+		ret = -ENXIO;
+		goto out;
+	}
 	tape = drive->driver_data;
 
-	if (test_and_set_bit (IDETAPE_BUSY, &tape->flags))
-		return -EBUSY;
+	if (test_and_set_bit (IDETAPE_BUSY, &tape->flags)) {
+		ret = -EBUSY;
+		goto out;
+	}
 	MOD_INC_USE_COUNT;
 	if (!tape->onstream) {	
 		idetape_read_position(drive);
@@ -4899,7 +4906,8 @@
 		clear_bit(IDETAPE_BUSY, &tape->flags);
 		printk(KERN_ERR "ide-tape: %s: drive not ready\n", tape->name);
 		MOD_DEC_USE_COUNT;
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 	idetape_read_position(drive);
 	MOD_DEC_USE_COUNT;
@@ -4918,7 +4926,9 @@
 	tape->max_frames = tape->cur_frames = tape->req_buffer_fill = 0;
 	idetape_restart_speed_control(drive);
 	tape->restart_speed_control_req = 0;
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static void idetape_write_release (struct inode *inode)
diff -Nru a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/ieee1394/ieee1394_core.c	Thu Aug  1 15:24:50 2002
@@ -19,6 +19,8 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
+
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/semaphore.h>
@@ -870,6 +872,8 @@
 	int blocknum;
 	int retval = -ENODEV;
 
+	lock_kernel();
+
 	/*
 	  Maintaining correct module reference counts is tricky here!
 
@@ -950,7 +954,7 @@
 		   the module from unloading while the file is open,
 		   and will be dropped by the VFS when the file is
 		   released. */
-		
+		unlock_kernel();
 		return 0;
 	}
 	       
@@ -960,6 +964,7 @@
 	   function returns. */
 	
 	file->f_op = &ieee1394_chardev_ops;
+	unlock_kernel();
 	return retval;
 
 #undef INCREF
diff -Nru a/drivers/ieee1394/pcilynx.c b/drivers/ieee1394/pcilynx.c
--- a/drivers/ieee1394/pcilynx.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/ieee1394/pcilynx.c	Thu Aug  1 15:24:50 2002
@@ -30,6 +30,8 @@
 #include <linux/pci.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
+#include <linux/smp_lock.h>
+
 #include <asm/byteorder.h>
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -717,32 +719,44 @@
         int cid = minor(inode->i_rdev);
         enum { t_rom, t_aux, t_ram } type;
         struct memdata *md;
-        
+        int ret = 0;
+
+	lock_kernel();
+
         if (cid < PCILYNX_MINOR_AUX_START) {
                 /* just for completeness */
-                return -ENXIO;
+                ret = -ENXIO;
+		goto out;
         } else if (cid < PCILYNX_MINOR_ROM_START) {
                 cid -= PCILYNX_MINOR_AUX_START;
-                if (cid >= num_of_cards || !cards[cid].aux_port)
-                        return -ENXIO;
+                if (cid >= num_of_cards || !cards[cid].aux_port) {
+                        ret = -ENXIO;
+			goto out;
+		}
                 type = t_aux;
         } else if (cid < PCILYNX_MINOR_RAM_START) {
                 cid -= PCILYNX_MINOR_ROM_START;
-                if (cid >= num_of_cards || !cards[cid].local_rom)
-                        return -ENXIO;
+                if (cid >= num_of_cards || !cards[cid].local_rom) {
+                        ret = -ENXIO;
+			goto out;
+		}
                 type = t_rom;
         } else {
                 /* WARNING: Know what you are doing when opening RAM.
                  * It is currently used inside the driver! */
                 cid -= PCILYNX_MINOR_RAM_START;
-                if (cid >= num_of_cards || !cards[cid].local_ram)
-                        return -ENXIO;
+                if (cid >= num_of_cards || !cards[cid].local_ram) {
+                 	ret = -ENXIO;
+			goto out;
+		}
                 type = t_ram;
         }
 
         md = (struct memdata *)kmalloc(sizeof(struct memdata), SLAB_KERNEL);
-        if (md == NULL)
-                return -ENOMEM;
+        if (md == NULL) {
+                ret = -ENOMEM;
+		goto out;
+	}
 
         md->lynx = &cards[cid];
         md->cid = cid;
@@ -763,7 +777,9 @@
 
         file->private_data = md;
 
-        return 0;
+out:
+	unlock_kernel();
+        return ret;
 }
 
 static int mem_release(struct inode *inode, struct file *file)
diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/input/input.c	Thu Aug  1 15:24:50 2002
@@ -220,12 +220,16 @@
 
 int input_open_device(struct input_handle *handle)
 {
+	int ret = 0;
+	lock_kernel();
+
 	if (handle->dev->pm_dev)
 		pm_access(handle->dev->pm_dev);
 	handle->open++;
 	if (handle->dev->open)
-		return handle->dev->open(handle->dev);
-	return 0;
+		ret = handle->dev->open(handle->dev);
+	unlock_kernel();
+	return ret;
 }
 
 int input_flush_device(struct input_handle* handle, struct file* file)
@@ -638,9 +642,13 @@
 	struct file_operations *old_fops, *new_fops = NULL;
 	int err;
 
+	lock_kernel();
+
 	/* No load-on-demand here? */
-	if (!handler || !(new_fops = fops_get(handler->fops)))
+	if (!handler || !(new_fops = fops_get(handler->fops))) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 
 	/*
 	 * That's _really_ odd. Usually NULL ->open means "nothing special",
@@ -648,6 +656,7 @@
 	 */
 	if (!new_fops->open) {
 		fops_put(new_fops);
+		unlock_kernel();
 		return -ENODEV;
 	}
 	old_fops = file->f_op;
@@ -660,6 +669,7 @@
 		file->f_op = fops_get(old_fops);
 	}
 	fops_put(old_fops);
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/isdn/capi/capi.c	Thu Aug  1 15:24:50 2002
@@ -934,13 +934,16 @@
 static int
 capi_open(struct inode *inode, struct file *file)
 {
+	int ret = 0;
+	lock_kernel();
+	
 	if (file->private_data)
-		return -EEXIST;
+		ret = -EEXIST;
+	else if ((file->private_data = capidev_alloc()) == 0)
+		ret = -ENOMEM;
 
-	if ((file->private_data = capidev_alloc()) == 0)
-		return -ENOMEM;
-
-	return 0;
+	unlock_kernel();
+	return ret;
 }
 
 static int
diff -Nru a/drivers/isdn/divert/divert_procfs.c b/drivers/isdn/divert/divert_procfs.c
--- a/drivers/isdn/divert/divert_procfs.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/isdn/divert/divert_procfs.c	Thu Aug  1 15:24:50 2002
@@ -135,6 +135,7 @@
 {
 	unsigned long flags;
 
+	lock_kernel();
 	spin_lock_irqsave( &divert_info_lock, flags );
  	if_used++;
 	if (divert_info_head)
@@ -143,6 +144,7 @@
 		(struct divert_info **) filep->private_data = &divert_info_head;
 	spin_unlock_irqrestore( &divert_info_lock, flags );
 	/*  start_divert(); */
+	unlock_kernel();
 	return (0);
 }				/* isdn_divert_open */
 
diff -Nru a/drivers/isdn/i4l/isdn_common.c b/drivers/isdn/i4l/isdn_common.c
--- a/drivers/isdn/i4l/isdn_common.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/isdn/i4l/isdn_common.c	Thu Aug  1 15:24:50 2002
@@ -970,12 +970,15 @@
 	if (!p)
 		return -ENOMEM;
 
+	lock_kernel();
+	
 	p->next = (char *) dev->infochain;
 	p->private = (char *) &(filep->private_data);
 	dev->infochain = p;
 	/* At opening we allow a single update */
 	filep->private_data = (char *) 1;
 
+	unlock_kernel();
 	return 0;
 }
 
@@ -1146,11 +1149,15 @@
 	uint minor = minor(ino->i_rdev);
 	int drvidx;
 
+	lock_kernel();
 	drvidx = isdn_minor2drv(minor - ISDN_MINOR_CTRL);
-	if (drvidx < 0)
+	if (drvidx < 0) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 
 	isdn_lock_drivers();
+	unlock_kernel();
 	return 0;
 }
 
@@ -1686,6 +1693,8 @@
 	int err = -ENODEV;
 	struct file_operations *old_fops, *new_fops = NULL;
 	
+	lock_kernel();
+	
 	if (minor >= ISDN_MINOR_CTRL && minor <= ISDN_MINOR_CTRLMAX)
 		new_fops = fops_get(&isdn_ctrl_fops);
 #ifdef CONFIG_ISDN_PPP
@@ -1711,6 +1720,7 @@
 	fops_put(old_fops);
 	
  out:
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/macintosh/adb.c	Thu Aug  1 15:24:50 2002
@@ -641,12 +641,18 @@
 static int adb_open(struct inode *inode, struct file *file)
 {
 	struct adbdev_state *state;
+	int ret = 0;
 
-	if (minor(inode->i_rdev) > 0 || adb_controller == NULL)
-		return -ENXIO;
+	lock_kernel();
+	if (minor(inode->i_rdev) > 0 || adb_controller == NULL) {
+		ret = -ENXIO;
+		goto out;
+	}
 	state = kmalloc(sizeof(struct adbdev_state), GFP_KERNEL);
-	if (state == 0)
+	if (state == 0) {
 		return -ENOMEM;
+		goto out;
+	}
 	file->private_data = state;
 	spin_lock_init(&state->lock);
 	atomic_set(&state->n_pending, 0);
@@ -654,7 +660,9 @@
 	init_waitqueue_head(&state->wait_queue);
 	state->inuse = 1;
 
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static int adb_release(struct inode *inode, struct file *file)
diff -Nru a/drivers/macintosh/rtc.c b/drivers/macintosh/rtc.c
--- a/drivers/macintosh/rtc.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/macintosh/rtc.c	Thu Aug  1 15:24:50 2002
@@ -97,11 +97,9 @@
 
 static int rtc_open(struct inode *inode, struct file *file)
 {
-	if (rtc_busy)
+	if (test_and_set_bit(0,&rtc_busy))
 		return -EBUSY;
 
-	rtc_busy = 1;
-
 	MOD_INC_USE_COUNT;
 
 	return 0;
@@ -110,7 +108,7 @@
 static int rtc_release(struct inode *inode, struct file *file)
 {
 	MOD_DEC_USE_COUNT;
-	rtc_busy = 0;
+	clear_bit(0,&rtc_busy);
 	return 0;
 }
 
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/md/lvm.c	Thu Aug  1 15:24:50 2002
@@ -511,15 +511,24 @@
 static int lvm_chr_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = minor(inode->i_rdev);
+	int ret = 0;
+
+	lock_kernel();
 
 	P_DEV("chr_open MINOR: %d  VG#: %d  mode: %s%s  lock: %d\n",
 	      minor, VG_CHR(minor), MODE_TO_STR(file->f_mode), lock);
 
 	/* super user validation */
-	if (!capable(CAP_SYS_ADMIN)) return -EACCES;
+	if (!capable(CAP_SYS_ADMIN)) {
+		ret = -EACCES;
+		goto out;
+	}
 
 	/* Group special file open */
-	if (VG_CHR(minor) > MAX_VG) return -ENXIO;
+	if (VG_CHR(minor) > MAX_VG) {
+		ret = -ENXIO;
+		goto out;
+	}
 
        spin_lock(&lvm_lock);
        if(lock == current->pid)
@@ -530,7 +539,9 @@
 
 	MOD_INC_USE_COUNT;
 
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 } /* lvm_chr_open() */
 
 
diff -Nru a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/media/video/videodev.c	Thu Aug  1 15:24:50 2002
@@ -79,6 +79,7 @@
 	
 	if(minor>=VIDEO_NUM_DEVICES)
 		return -ENODEV;
+	lock_kernel();
 	down(&videodev_lock);
 	vfl=video_device[minor];
 	if(vfl==NULL) {
@@ -91,6 +92,7 @@
 		vfl=video_device[minor];
 		if (vfl==NULL) {
 			up(&videodev_lock);
+			unlock_kernel();
 			return -ENODEV;
 		}
 	}
@@ -104,6 +106,7 @@
 	}
 	fops_put(old_fops);
 	up(&videodev_lock);
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/mtd/mtdblock.c	Thu Aug  1 15:24:50 2002
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
 
@@ -274,11 +275,16 @@
 	if (dev >= MAX_MTD_DEVICES)
 		return -EINVAL;
 
+	lock_kernel();
+
 	mtd = get_mtd_device(NULL, dev);
-	if (!mtd)
+	if (!mtd) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 	if (MTD_ABSENT == mtd->type) {
 		put_mtd_device(mtd);
+		unlock_kernel();
 		return -ENODEV;
 	}
 	
@@ -288,6 +294,7 @@
 	if (mtdblks[dev]) {
 		mtdblks[dev]->count++;
 		spin_unlock(&mtdblks_lock);
+		unlock_kernel();
 		return 0;
 	}
 	
@@ -301,6 +308,7 @@
 	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
 	if (!mtdblk) {
 		put_mtd_device(mtd);
+		unlock_kernel();
 		return -ENOMEM;
 	}
 	memset(mtdblk, 0, sizeof(*mtdblk));
@@ -316,6 +324,7 @@
 		if (!mtdblk->cache_data) {
 			put_mtd_device(mtdblk->mtd);
 			kfree(mtdblk);
+			unlock_kernel();
 			return -ENOMEM;
 		}
 	}
@@ -331,6 +340,7 @@
 		put_mtd_device(mtdblk->mtd);
 		vfree(mtdblk->cache_data);
 		kfree(mtdblk);
+		unlock_kernel();
 		return 0;
 	}
 
@@ -339,9 +349,9 @@
 	set_device_ro (inode->i_rdev, !(mtdblk->mtd->flags & MTD_WRITEABLE));
 	
 	spin_unlock(&mtdblks_lock);
+	unlock_kernel();
 	
 	DEBUG(MTD_DEBUG_LEVEL1, "ok\n");
-
 	return 0;
 }
 
diff -Nru a/drivers/mtd/mtdblock_ro.c b/drivers/mtd/mtdblock_ro.c
--- a/drivers/mtd/mtdblock_ro.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/mtd/mtdblock_ro.c	Thu Aug  1 15:24:50 2002
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/smp_lock.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
@@ -43,26 +44,32 @@
 	struct mtd_info *mtd = NULL;
 
 	int dev;
+	int ret=0;
 
 	DEBUG(1,"mtdblock_open\n");
 	
 	if (inode == 0)
 		return -EINVAL;
 	
+	lock_kernel();
 	dev = minor(inode->i_rdev);
 	
 	mtd = get_mtd_device(NULL, dev);
-	if (!mtd)
-		return -EINVAL;
+	if (!mtd) {
+		ret = -EINVAL;
+		goto out;
+	}
 	if (MTD_ABSENT == mtd->type) {
 		put_mtd_device(mtd);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	mtd_sizes[dev] = mtd->size>>9;
 
 	DEBUG(1, "ok\n");
-
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/mtd/mtdchar.c	Thu Aug  1 15:24:50 2002
@@ -67,24 +67,34 @@
 	int minor = minor(inode->i_rdev);
 	int devnum = minor >> 1;
 	struct mtd_info *mtd;
+	int ret = 0;
+	
+	lock_kernel();
 
 	DEBUG(MTD_DEBUG_LEVEL0, "MTD_open\n");
 
-	if (devnum >= MAX_MTD_DEVICES)
-		return -ENODEV;
+	if (devnum >= MAX_MTD_DEVICES) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	/* You can't open the RO devices RW */
-	if ((file->f_mode & 2) && (minor & 1))
-		return -EACCES;
+	if ((file->f_mode & 2) && (minor & 1)) {
+		ret = -EACCES;
+		goto out;
+	}
 
 	mtd = get_mtd_device(NULL, devnum);
 	
-	if (!mtd)
-		return -ENODEV;
+	if (!mtd) {
+		ret = -ENODEV;
+		goto out;
+	}
 	
 	if (MTD_ABSENT == mtd->type) {
 		put_mtd_device(mtd);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out;
 	}
 
 	file->private_data = mtd;
@@ -92,10 +102,13 @@
 	/* You can't open it RW if it's not a writeable device */
 	if ((file->f_mode & 2) && !(mtd->flags & MTD_WRITEABLE)) {
 		put_mtd_device(mtd);
-		return -EACCES;
+		ret = -EACCES;
+		goto out;
 	}
 		
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 } /* mtd_open */
 
 /*====================================================================*/
diff -Nru a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/net/ppp_generic.c	Thu Aug  1 15:24:50 2002
@@ -339,12 +339,15 @@
  */
 static int ppp_open(struct inode *inode, struct file *file)
 {
+	int ret=0;
 	/*
 	 * This could (should?) be enforced by the permissions on /dev/ppp.
 	 */
+	lock_kernel();
 	if (!capable(CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
+		ret = -EPERM;
+	unlock_kernel();
+	return ret;
 }
 
 static int ppp_release(struct inode *inode, struct file *file)
diff -Nru a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/net/wan/cosa.c	Thu Aug  1 15:24:50 2002
@@ -611,19 +611,22 @@
 static int cosa_sppp_open(struct net_device *d)
 {
 	struct channel_data *chan = d->priv;
-	int err, flags;
+	int err=0, flags;
+	lock_kernel();
 
 	if (!(chan->cosa->firmware_status & COSA_FW_START)) {
 		printk(KERN_NOTICE "%s: start the firmware first (status %d)\n",
 			chan->cosa->name, chan->cosa->firmware_status);
-		return -EPERM;
+		err = -EPERM;
+		goto out;
 	}
 	spin_lock_irqsave(&chan->cosa->lock, flags);
 	if (chan->usage != 0) {
 		printk(KERN_WARNING "%s: sppp_open called with usage count %d\n",
 			chan->name, chan->usage);
 		spin_unlock_irqrestore(&chan->cosa->lock, flags);
-		return -EBUSY;
+		err = -EBUSY;
+		goto out;
 	}
 	chan->setup_rx = sppp_setup_rx;
 	chan->tx_done = sppp_tx_done;
@@ -641,12 +644,14 @@
 		MOD_DEC_USE_COUNT;
 		
 		spin_unlock_irqrestore(&chan->cosa->lock, flags);
-		return err;
+		goto out;
 	}
 
 	netif_start_queue(d);
 	cosa_enable_rx(chan);
-	return 0;
+out:
+	unlock_kernel();
+	return err;
 }
 
 static int cosa_sppp_tx(struct sk_buff *skb, struct net_device *dev)
@@ -932,15 +937,22 @@
 	struct channel_data *chan;
 	unsigned long flags;
 	int n;
+	int ret = 0;
+
+	lock_kernel();
 
 	if ((n=minor(file->f_dentry->d_inode->i_rdev)>>CARD_MINOR_BITS)
-		>= nr_cards)
-		return -ENODEV;
+		>= nr_cards) {
+		ret = -ENODEV;
+		goto out;
+	}
 	cosa = cosa_cards+n;
 
 	if ((n=minor(file->f_dentry->d_inode->i_rdev)
-		& ((1<<CARD_MINOR_BITS)-1)) >= cosa->nchannels)
-		return -ENODEV;
+		& ((1<<CARD_MINOR_BITS)-1)) >= cosa->nchannels) {
+		ret = -ENODEV;
+		goto out;
+	}
 	chan = cosa->chan + n;
 	
 	file->private_data = chan;
@@ -949,7 +961,8 @@
 
 	if (chan->usage < 0) { /* in netdev mode */
 		spin_unlock_irqrestore(&cosa->lock, flags);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 	cosa->usage++;
 	chan->usage++;
@@ -958,6 +971,8 @@
 	chan->setup_rx = chrdev_setup_rx;
 	chan->rx_done = chrdev_rx_done;
 	spin_unlock_irqrestore(&cosa->lock, flags);
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/net/wan/hdlc_ppp.c b/drivers/net/wan/hdlc_ppp.c
--- a/drivers/net/wan/hdlc_ppp.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/net/wan/hdlc_ppp.c	Thu Aug  1 15:24:50 2002
@@ -25,6 +25,7 @@
 #include <linux/lapb.h>
 #include <linux/rtnetlink.h>
 #include <linux/hdlc.h>
+#include <linux/smp_lock.h>
 
 
 static int ppp_open(hdlc_device *hdlc)
@@ -33,6 +34,8 @@
 	void *old_ioctl;
 	int result;
 
+	lock_kernel();
+
 	dev->priv = &hdlc->state.ppp.syncppp_ptr;
 	hdlc->state.ppp.syncppp_ptr = &hdlc->state.ppp.pppdev;
 	hdlc->state.ppp.pppdev.dev = dev;
@@ -47,10 +50,10 @@
 	result = sppp_open(dev);
 	if (result) {
 		sppp_detach(dev);
-		return result;
 	}
 
-	return 0;
+	unlock_kernel();
+	return result;
 }
 
 
diff -Nru a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
--- a/drivers/pcmcia/ds.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/pcmcia/ds.c	Thu Aug  1 15:24:50 2002
@@ -561,20 +561,30 @@
     socket_t i = minor(inode->i_rdev);
     socket_info_t *s;
     user_info_t *user;
+    int ret = 0;
+
+    lock_kernel();
 
     DEBUG(0, "ds_open(socket %d)\n", i);
-    if ((i >= sockets) || (sockets == 0))
-	return -ENODEV;
+    if ((i >= sockets) || (sockets == 0)) {
+	ret = -ENODEV;
+	goto out;
+    }
     s = &socket_table[i];
     if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
-	if (s->state & SOCKET_BUSY)
-	    return -EBUSY;
+	if (s->state & SOCKET_BUSY) {
+	    ret = -EBUSY;
+	    goto out;
+	}
 	else
 	    s->state |= SOCKET_BUSY;
     }
     
     user = kmalloc(sizeof(user_info_t), GFP_KERNEL);
-    if (!user) return -ENOMEM;
+    if (!user) {
+	ret = -ENOMEM;
+	goto out;
+    }
     user->event_tail = user->event_head = 0;
     user->next = s->user;
     user->user_magic = USER_MAGIC;
@@ -583,7 +593,9 @@
     
     if (s->state & SOCKET_PRESENT)
 	queue_event(user, CS_EVENT_CARD_INSERTION);
-    return 0;
+out:
+    unlock_kernel();
+    return ret;
 } /* ds_open */
 
 /*====================================================================*/
diff -Nru a/drivers/s390/char/tapechar.c b/drivers/s390/char/tapechar.c
--- a/drivers/s390/char/tapechar.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/s390/char/tapechar.c	Thu Aug  1 15:24:50 2002
@@ -18,6 +18,7 @@
 #include <linux/version.h>
 #include <linux/types.h>
 #include <linux/proc_fs.h>
+#include <linux/smp_lock.h>
 #include <asm/s390dyn.h>
 #include <linux/mtio.h>
 #include <asm/uaccess.h>
@@ -548,6 +549,8 @@
 	int  rc = 0;
 	long lockflags;
 
+	lock_kernel();
+
 	MOD_INC_USE_COUNT;
 
 	tape_sprintf_event (tape_dbf_area,6,"c:open: %x\n",td->first_minor); 
@@ -584,6 +587,8 @@
 		if (td!=NULL)
 			tape_put_device(td);
 	}
+
+	unlock_kernel();
 	return rc;
 
 }
diff -Nru a/drivers/s390/char/tubfs.c b/drivers/s390/char/tubfs.c
--- a/drivers/s390/char/tubfs.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/s390/char/tubfs.c	Thu Aug  1 15:24:50 2002
@@ -10,6 +10,7 @@
  *  Author:  Richard Hitt
  */
 #include "tubio.h"
+#include <linux/smp_lock.h>
 
 int fs3270_major = -1;			/* init to impossible -1 */
 
@@ -108,23 +109,26 @@
 	}
 }
 
-/*
- * fs3270_open
- */
 static int
 fs3270_open(struct inode *ip, struct file *fp)
 {
 	tub_t *tubp;
 	long flags;
+	int ret = 0;
+
+	lock_kernel();
 
 	/* See INODE2TUB(ip) for handling of "/dev/3270/tub" */
-	if ((tubp = INODE2TUB(ip)) == NULL)
-		return -ENOENT;
+	if ((tubp = INODE2TUB(ip)) == NULL) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	TUBLOCK(tubp->irq, flags);
 	if (tubp->mode == TBM_FS || tubp->mode == TBM_FSLN) {
 		TUBUNLOCK(tubp->irq, flags);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
 	tub_inc_use_count();
@@ -135,7 +139,10 @@
 	tubp->fs_pid = current->pid;
 	tubp->fsopen = 1;
 	TUBUNLOCK(tubp->irq, flags);
-	return 0;
+	
+out:
+	unlock_kernel();
+	return ret;
 }
 
 /*
diff -Nru a/drivers/sbus/audio/audio.c b/drivers/sbus/audio/audio.c
--- a/drivers/sbus/audio/audio.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/sbus/audio/audio.c	Thu Aug  1 15:24:50 2002
@@ -1702,13 +1702,17 @@
 static int sparcaudio_open(struct inode * inode, struct file * file)
 {
         int minor = minor(inode->i_rdev);
-	struct sparcaudio_driver *drv = 
-                drivers[(minor >> SPARCAUDIO_DEVICE_SHIFT)];
-	int err;
+	struct sparcaudio_driver *drv; 
+	int err = 0;
+
+	lock_kernel();
 
 	/* A low-level audio driver must exist. */
-	if (!drv)
-		return -ENODEV;
+        drv = drivers[(minor >> SPARCAUDIO_DEVICE_SHIFT)];
+	if (!drv) {
+		err = -ENODEV;
+		goto out;
+	}
 
 #ifdef S_ZERO_WR
         /* This is how 2.0 ended up dealing with 0 len writes */
@@ -1725,27 +1729,35 @@
                 /* If the driver is busy, then wait to get through. */
         retry_open:
         	if (file->f_mode & FMODE_READ && drv->flags & SDF_OPEN_READ) {
-                        if (file->f_flags & O_NONBLOCK)
-                                return -EBUSY;
+                        if (file->f_flags & O_NONBLOCK) {
+                                err = -EBUSY;
+				goto out;
+			}
 
                         /* If something is now waiting, signal control device */
                         kill_procs(drv->sd_siglist,SIGPOLL,S_MSG);
 
                         interruptible_sleep_on(&drv->open_wait);
-                        if (signal_pending(current))
-                                return -EINTR;
+                        if (signal_pending(current)) {
+                                err = -EINTR;
+				goto out;
+			}
                         goto retry_open;
                 }
                 if (file->f_mode & FMODE_WRITE && drv->flags & SDF_OPEN_WRITE) {
-                        if (file->f_flags & O_NONBLOCK)
-                                return -EBUSY;
+                        if (file->f_flags & O_NONBLOCK) {
+                                err = -EBUSY;
+				goto out;	
+			}
 	    
                         /* If something is now waiting, signal control device */
                         kill_procs(drv->sd_siglist,SIGPOLL,S_MSG);
 
                         interruptible_sleep_on(&drv->open_wait);
-                        if (signal_pending(current))
-                                return -EINTR;
+                        if (signal_pending(current)) {
+                                err = -EINTR;
+				goto out;
+			}
                         goto retry_open;
                 }
 
@@ -1753,7 +1765,7 @@
                 if (drv->ops->open) {
                         err = drv->ops->open(inode,file,drv);
                         if (err < 0)
-                                return err;
+                                goto out;
                 }
 
                 /* Mark the driver as locked for read and/or write. */
@@ -1796,7 +1808,8 @@
                 break;
 
 	default:
-                return -ENXIO;
+                err = -ENXIO;
+		goto out;
 	};
 
         /* From the dbri driver:
@@ -1829,8 +1842,9 @@
                 }          
         }
 
-	/* Success! */
-	return 0;
+out:
+	unlock_kernel();
+	return err;
 }
 
 static int sparcaudio_release(struct inode * inode, struct file * file)
diff -Nru a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/sbus/char/bpp.c	Thu Aug  1 15:24:50 2002
@@ -442,6 +442,7 @@
       unsigned minor = MINOR(inode->i_rdev);
       int ret;
 
+      lock_kernel();
       spin_lock(&bpp_open_lock);
       ret = 0;
       if (minor >= BPP_NO) {
@@ -457,7 +458,7 @@
 	      }
       }
       spin_unlock(&bpp_open_lock);
-
+      unlock_kernel();
       return ret;
 }
 
diff -Nru a/drivers/sbus/char/sunkbd.c b/drivers/sbus/char/sunkbd.c
--- a/drivers/sbus/char/sunkbd.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/sbus/char/sunkbd.c	Thu Aug  1 15:24:50 2002
@@ -1514,6 +1514,7 @@
 static int
 kbd_open (struct inode *i, struct file *f)
 {
+	lock_kernel();
 	spin_lock_irq(&kbd_queue_lock);
 	kbd_active++;
 
@@ -1526,7 +1527,7 @@
 
  out:
 	spin_unlock_irq(&kbd_queue_lock);
-
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
--- a/drivers/sbus/char/vfc_dev.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/sbus/char/vfc_dev.c	Thu Aug  1 15:24:50 2002
@@ -188,14 +188,17 @@
 {
 	struct vfc_dev *dev;
 
+	lock_kernel();
 	spin_lock(&vfc_dev_lock);
 	dev = vfc_get_dev_ptr(MINOR(inode->i_rdev));
 	if (dev == NULL) {
 		spin_unlock(&vfc_dev_lock);
+		unlock_kernel();
 		return -ENODEV;
 	}
 	if (dev->busy) {
 		spin_unlock(&vfc_dev_lock);
+		unlock_kernel();
 		return -EBUSY;
 	}
 
@@ -212,6 +215,7 @@
 	vfc_captstat_reset(dev);
 	
 	vfc_unlock_device(dev);
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
--- a/drivers/scsi/dpt_i2o.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/scsi/dpt_i2o.c	Thu Aug  1 15:24:50 2002
@@ -1556,10 +1556,13 @@
 	int minor;
 	adpt_hba* pHba;
 
+	lock_kernel();
+
 	//TODO check for root access
 	//
 	minor = minor(inode->i_rdev);
 	if (minor >= hba_count) {
+		unlock_kernel();
 		return -ENXIO;
 	}
 	down(&adpt_configuration_lock);
@@ -1570,17 +1573,20 @@
 	}
 	if (pHba == NULL) {
 		up(&adpt_configuration_lock);
+		unlock_kernel();
 		return -ENXIO;
 	}
 
 //	if(pHba->in_use){
-	//	up(&adpt_configuration_lock);
+//		up(&adpt_configuration_lock);
+//		unlock_kernel();
 //		return -EBUSY;
 //	}
 
 	pHba->in_use = 1;
 	up(&adpt_configuration_lock);
 
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/scsi/osst.c	Thu Aug  1 15:24:50 2002
@@ -46,6 +46,7 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/version.h>
+#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/dma.h>
 #include <asm/system.h>
@@ -4162,18 +4163,24 @@
 	int dev = TAPE_NR(inode->i_rdev);
 	int mode = TAPE_MODE(inode->i_rdev);
 
-	if (dev >= osst_template.dev_max || (STp = os_scsi_tapes[dev]) == NULL || !STp->device)
-		return (-ENXIO);
+	lock_kernel();
+
+	if (dev >= osst_template.dev_max || (STp = os_scsi_tapes[dev]) == NULL || !STp->device) {
+		retval = (-ENXIO);
+		goto out;
+	}
 
 	if( !scsi_block_when_processing_errors(STp->device) ) {
-		return -ENXIO;
+		retval = -ENXIO;
+		goto out;
 	}
 
 	if (STp->in_use) {
 #if DEBUG
 		printk(OSST_DEB_MSG "osst%d:D: Device already in use.\n", dev);
 #endif
-		return (-EBUSY);
+		retval = (-EBUSY);
+		goto out;
 	}
 	STp->in_use       = 1;
 	STp->rew_at_close = (minor(inode->i_rdev) & 0x80) == 0;
@@ -4346,7 +4353,8 @@
 			STp->buffer->buffer_blocks = OS_DATA_SIZE / STp->block_size;
 			STp->fast_open = TRUE;
 			scsi_release_request(SRpnt);
-			return 0;
+			retval = 0;
+			goto out;
 		}
 #if DEBUG
 		if (i != STp->first_frame_position)
@@ -4430,7 +4438,8 @@
 		STp->ps[0].drv_file = STp->ps[0].drv_block = (-1);
 		STp->partition = STp->new_partition = 0;
 		STp->door_locked = ST_UNLOCKED;
-		return 0;
+		retval = 0;
+		goto out;
 	}
 
 	osst_configure_onstream(STp, &SRpnt);
@@ -4509,7 +4518,8 @@
 	scsi_release_request(SRpnt);
 	SRpnt = NULL;
 
-	return 0;
+	retval = 0;
+	goto out;
 
 err_out:
 	if (SRpnt != NULL)
@@ -4526,7 +4536,8 @@
 	    __MOD_DEC_USE_COUNT(STp->device->host->hostt->module);
 	if (osst_template.module)
 	    __MOD_DEC_USE_COUNT(osst_template.module);
-
+out:
+	unlock_kernel();
 	return retval;
 }
 
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/scsi/sg.c	Thu Aug  1 15:24:50 2002
@@ -268,12 +268,18 @@
     int res;
     int retval = -EBUSY;
 
+    lock_kernel();
+
     SCSI_LOG_TIMEOUT(3, printk("sg_open: dev=%d, flags=0x%x\n", dev, flags));
     sdp = sg_get_dev(dev);
-    if ((! sdp) || (! sdp->device))
-        return -ENXIO;
-    if (sdp->detached)
-    	return -ENODEV;
+    if ((! sdp) || (! sdp->device)) {
+        retval = -ENXIO;
+	goto out;
+    }
+    if (sdp->detached) {
+    	retval = -ENODEV;
+	goto out;
+    }
 
      /* This driver's module count bumped by fops_get in <linux/fs.h> */
      /* Prevent the device driver from vanishing while we sleep */
@@ -329,12 +335,15 @@
         retval = -ENOMEM;
 	goto error_out;
     }
-    return 0;
+    retval = 0;
+    goto out;
 
 error_out:
     sdp->device->access_count--;
     if ((! sdp->detached) && sdp->device->host->hostt->module)
         __MOD_DEC_USE_COUNT(sdp->device->host->hostt->module);
+out:
+    unlock_kernel();
     return retval;
 }
 
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/scsi/st.c	Thu Aug  1 15:24:50 2002
@@ -909,16 +909,20 @@
 	ST_partstat *STps;
 	int dev = TAPE_NR(inode->i_rdev);
 
+	lock_kernel();
+
 	write_lock(&st_dev_arr_lock);
 	if (dev >= st_template.dev_max || scsi_tapes == NULL ||
 	    ((STp = scsi_tapes[dev]) == NULL)) {
 		write_unlock(&st_dev_arr_lock);
+		unlock_kernel();
 		return (-ENXIO);
 	}
 
 	if (STp->in_use) {
 		write_unlock(&st_dev_arr_lock);
 		DEB( printk(ST_DEB_MSG "st%d: Device already in use.\n", dev); )
+		unlock_kernel();
 		return (-EBUSY);
 	}
 	STp->in_use = 1;
@@ -962,6 +966,7 @@
 		retval = (-EIO);
 		goto err_out;
 	}
+	unlock_kernel();
 	return 0;
 
  err_out:
@@ -970,6 +975,7 @@
 	STp->device->access_count--;
 	if (STp->device->host->hostt->module)
 	    __MOD_DEC_USE_COUNT(STp->device->host->hostt->module);
+	unlock_kernel();
 	return retval;
 
 }
diff -Nru a/drivers/sgi/char/shmiq.c b/drivers/sgi/char/shmiq.c
--- a/drivers/sgi/char/shmiq.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/sgi/char/shmiq.c	Thu Aug  1 15:24:50 2002
@@ -386,25 +386,35 @@
 shmiq_qcntl_open (struct inode *inode, struct file *filp)
 {
 	int minor = MINOR (inode->i_rdev);
+	int ret = 0;
 
-	if (minor == 0)
-		return 0;
+	lock_kernel();
+
+	if (minor == 0) {
+		ret = 0;
+		goto out;
+	}
 
 	minor--;
-	if (minor > MAX_SHMI_QUEUES)
-		return -EINVAL;
+	if (minor > MAX_SHMI_QUEUES) {
+		ret = -EINVAL;
+		goto out;
+	}
 	spin_lock( &shmiqs [minor].shmiq_lock );
 	if (shmiqs [minor].opened)
 	{
 		spin_unlock( &shmiqs [minor].shmiq_lock );
-		return -EBUSY;
+		goto out;
+		ret = -EBUSY;
 	}
 
 	shmiqs [minor].opened      = 1;
 	shmiqs [minor].shmiq_vaddr = 0;
 	spin_unlock( &shmiqs [minor].shmiq_lock );
 
-	return 0;
+out:
+	unlock_kernel();
+	return ret;
 }
 
 static int
diff -Nru a/drivers/telephony/phonedev.c b/drivers/telephony/phonedev.c
--- a/drivers/telephony/phonedev.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/telephony/phonedev.c	Thu Aug  1 15:24:50 2002
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
+#include <linux/smp_lock.h>
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/errno.h>
@@ -51,8 +52,12 @@
 	struct phone_device *p;
 	struct file_operations *old_fops, *new_fops = NULL;
 
-	if (minor >= PHONE_NUM_DEVICES)
-		return -ENODEV;
+	lock_kernel();
+
+	if (minor >= PHONE_NUM_DEVICES) {
+		err = -ENODEV;
+		goto out;
+	}
 
 	down(&phone_lock);
 	p = phone_device[minor];
@@ -83,6 +88,8 @@
 	fops_put(old_fops);
 end:
 	up(&phone_lock);
+out:
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/usb/core/file.c	Thu Aug  1 15:24:50 2002
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
+#include <linux/smp_lock.h>
 #include <linux/errno.h>
 
 #ifdef CONFIG_USB_DEBUG
@@ -42,11 +43,14 @@
 	int err = -ENODEV;
 	struct file_operations *old_fops, *new_fops = NULL;
 
+	lock_kernel();
+	
 	spin_lock (&minor_lock);
 	c = usb_minors[minor];
 
 	if (!c || !(new_fops = fops_get(c))) {
 		spin_unlock(&minor_lock);
+		lock_kernel();
 		return err;
 	}
 	spin_unlock(&minor_lock);
@@ -61,6 +65,7 @@
 		file->f_op = fops_get(old_fops);
 	}
 	fops_put(old_fops);
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/drivers/usb/misc/tiglusb.c b/drivers/usb/misc/tiglusb.c
--- a/drivers/usb/misc/tiglusb.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/usb/misc/tiglusb.c	Thu Aug  1 15:24:50 2002
@@ -106,31 +106,38 @@
 {
 	int devnum = minor (inode->i_rdev);
 	ptiglusb_t s;
+	int ret = 0;
 
 	if (devnum < TIUSB_MINOR || devnum >= (TIUSB_MINOR + MAXTIGL))
 		return -EIO;
 
+	lock_kernel();
+
 	s = &tiglusb[devnum - TIUSB_MINOR];
 
 	if (down_interruptible (&s->mutex)) {
-		return -ERESTARTSYS;
+		ret = -ERESTARTSYS;
+		goto out;
 	}
 
 	while (!s->dev || s->opened) {
 		up (&s->mutex);
 
 		if (filp->f_flags & O_NONBLOCK) {
-			return -EBUSY;
+			ret = -EBUSY;
+			goto out;
 		}
 
 		schedule_timeout (HZ / 2);
 
 		if (signal_pending (current)) {
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto out;
 		}
 
 		if (down_interruptible (&s->mutex)) {
-			return -ERESTARTSYS;
+			ret = -ERESTARTSYS;
+			goto out;
 		}
 	}
 
@@ -139,7 +146,8 @@
 
 	filp->f_pos = 0;
 	filp->private_data = s;
-
+out:
+	unlock_kernel();
 	return 0;
 }
 
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Thu Aug  1 15:24:50 2002
+++ b/drivers/video/fbmem.c	Thu Aug  1 15:24:50 2002
@@ -689,12 +689,16 @@
 	struct fb_info *info;
 	int res = 0;
 
+	lock_kernel();
+
 #ifdef CONFIG_KMOD
 	if (!(info = registered_fb[fbidx]))
 		try_to_load(fbidx);
 #endif /* CONFIG_KMOD */
-	if (!(info = registered_fb[fbidx]))
-		return -ENODEV;
+	if (!(info = registered_fb[fbidx])) {
+		res = -ENODEV;
+		goto out;
+	}
 	if (info->fbops->owner)
 		__MOD_INC_USE_COUNT(info->fbops->owner);
 	if (info->fbops->fb_open) {
@@ -702,6 +706,8 @@
 		if (res && info->fbops->owner)
 			__MOD_DEC_USE_COUNT(info->fbops->owner);
 	}
+out:
+	unlock_kernel();
 	return res;
 }
 
diff -Nru a/fs/intermezzo/psdev.c b/fs/intermezzo/psdev.c
--- a/fs/intermezzo/psdev.c	Thu Aug  1 15:24:50 2002
+++ b/fs/intermezzo/psdev.c	Thu Aug  1 15:24:50 2002
@@ -35,6 +35,7 @@
 #include <linux/time.h>
 #include <linux/lp.h>
 #include <linux/slab.h>
+#include <linux/smp_lock.h>
 #include <asm/ioctls.h>
 #include <linux/ioport.h>
 #include <linux/fcntl.h>
@@ -1229,11 +1230,14 @@
          struct upc_comm *upccom;
          ENTRY;
 
+         lock_kernel();
+
          if ( ! (upccom = presto_psdev_f2u(file)) ) {
                  kdev_t dev = file->f_dentry->d_inode->i_rdev;
                  printk("InterMezzo: %s, bad device %s\n",
                         __FUNCTION__, kdevname(dev));
                  EXIT;
+                 unlock_kernel();
                  return -EINVAL;
          }
 
@@ -1241,6 +1245,8 @@
 
         CDEBUG(D_PSDEV, "Psdev_open: uc_pid: %d, caller: %d, flags: %d\n",
                upccom->uc_pid, current->pid, file->f_flags);
+
+        unlock_kernel();
 
         EXIT;
         return 0;
diff -Nru a/net/netlink/netlink_dev.c b/net/netlink/netlink_dev.c
--- a/net/netlink/netlink_dev.c	Thu Aug  1 15:24:50 2002
+++ b/net/netlink/netlink_dev.c	Thu Aug  1 15:24:50 2002
@@ -105,28 +105,37 @@
 	struct sockaddr_nl nladdr;
 	int err;
 
-	if (minor>=MAX_LINKS)
-		return -ENODEV;
-	if (test_and_set_bit(minor, &open_map))
-		return -EBUSY;
+	lock_kernel();
+
+	if (minor>=MAX_LINKS) {
+		err = -ENODEV;
+		goto out;
+	}
+	if (test_and_set_bit(minor, &open_map)) {
+		err = -EBUSY;
+		goto out;
+	}
 
 	err = sock_create(PF_NETLINK, SOCK_RAW, minor, &sock);
 	if (err < 0)
-		goto out;
+		goto clearout;
 
 	memset(&nladdr, 0, sizeof(nladdr));
 	nladdr.nl_family = AF_NETLINK;
 	nladdr.nl_groups = ~0;
 	if ((err = sock->ops->bind(sock, (struct sockaddr*)&nladdr, sizeof(nladdr))) < 0) {
 		sock_release(sock);
-		goto out;
+		goto clearout;
 	}
 
 	netlink_user[minor] = sock;
-	return 0;
+	err = 0;
+	goto out;
 
-out:
+clearout:
 	clear_bit(minor, &open_map);
+out:
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c	Thu Aug  1 15:24:50 2002
+++ b/sound/core/sound.c	Thu Aug  1 15:24:50 2002
@@ -30,6 +30,7 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 #include <linux/kmod.h>
+#include <linux/smp_lock.h>
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
 #endif
@@ -123,12 +124,15 @@
 	struct file_operations *old_fops;
 	int err = 0;
 
+	lock_kernel();
+
 	if (dev != SNDRV_MINOR_SEQUENCER) {
 		if (snd_cards[card] == NULL) {
 #ifdef CONFIG_KMOD
 			snd_request_card(card);
 			if (snd_cards[card] == NULL)
 #endif
+				unlock_kernel();
 				return -ENODEV;
 		}
 	} else {
@@ -137,8 +141,10 @@
 			snd_request_other(minor);
 #endif
 	}
-	if (mptr == NULL && (mptr = snd_minor_search(minor)) == NULL)
+	if (mptr == NULL && (mptr = snd_minor_search(minor)) == NULL) {
+		unlock_kernel();
 		return -ENODEV;
+	}
 	old_fops = file->f_op;
 	file->f_op = fops_get(mptr->f_ops);
 	if (file->f_op->open)
@@ -148,6 +154,7 @@
 		file->f_op = fops_get(old_fops);
 	}
 	fops_put(old_fops);
+	unlock_kernel();
 	return err;
 }
 
diff -Nru a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c	Thu Aug  1 15:24:50 2002
+++ b/sound/sound_core.c	Thu Aug  1 15:24:50 2002
@@ -44,6 +44,7 @@
 #include <linux/sound.h>
 #include <linux/major.h>
 #include <linux/kmod.h>
+#include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 
 #define SOUND_STEP 16
@@ -485,6 +486,8 @@
 	struct sound_unit *s;
 	struct file_operations *new_fops = NULL;
 
+	lock_kernel();
+
 	chain=unit&0x0F;
 	if(chain==4 || chain==5)	/* dsp/audio/dsp16 */
 	{
@@ -536,9 +539,11 @@
 			file->f_op = fops_get(old_fops);
 		}
 		fops_put(old_fops);
+		unlock_kernel();
 		return err;
 	}
 	spin_unlock(&sound_loader_lock);
+	unlock_kernel();
 	return -ENODEV;
 }
 

--------------060408060203040607080404--

