Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbWGNJZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbWGNJZG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWGNJZG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:25:06 -0400
Received: from lama.bgc-jena.mpg.de ([195.37.229.21]:42446 "EHLO
	lama.bgc-jena.mpg.de") by vger.kernel.org with ESMTP
	id S1030432AbWGNJZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:25:03 -0400
Date: Fri, 14 Jul 2006 11:25:10 +0200
From: Johannes Weiner <jweiner@bgc-jena.mpg.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] nvram driver cleanups
Message-ID: <20060714092510.GB32229@bgc-jena.mpg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Style adjustance in the nvram driver. Nothing functional changed.

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="nvram_minor_fixes.patch"

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index a39f19c..1df5900 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -28,13 +28,15 @@
  * drivers, this is the case on the Atari.
  *
  *
- * 	1.1	Cesar Barros: SMP locking fixes
- * 		added changelog
- * 	1.2	Erik Gilling: Cobalt Networks support
- * 		Tim Hockin: general cleanup, Cobalt support
+ *	1.1	Cesar Barros: SMP locking fixes
+ *		added changelog
+ *	1.2	Erik Gilling: Cobalt Networks support
+ *		Tim Hockin: general cleanup, Cobalt support
+ *	1.3	Johannes Weiner: Minor cleanups, small
+ *		improvements, style adjustance
  */
 
-#define NVRAM_VERSION	"1.2"
+#define NVRAM_VERSION	"1.3"
 
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -45,24 +47,22 @@ #define PC		1
 #define ATARI		2
 #define COBALT		3
 
-/* select machine configuration */
+/* Select machine configuration */
 #if defined(CONFIG_ATARI)
 #  define MACH ATARI
 #elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and others?? */
-#define MACH PC
+#  define MACH PC
 #  if defined(CONFIG_COBALT)
 #    include <linux/cobalt-nvram.h>
 #    define MACH COBALT
-#  else
-#    define MACH PC
 #  endif
 #else
 #  error Cannot build nvram driver for this machine configuration.
 #endif
 
-#if MACH == PC
+/* Architecture related definitions */
+#if (MACH == PC)
 
-/* RTC in a PC */
 #define CHECK_DRIVER_INIT()	1
 
 /* On PCs, the checksum is built only over bytes 2..31 */
@@ -75,9 +75,7 @@ #define mach_check_checksum	pc_check_che
 #define mach_set_checksum	pc_set_checksum
 #define mach_proc_infos		pc_proc_infos
 
-#endif
-
-#if MACH == COBALT
+#elif (MACH == COBALT)
 
 #define CHECK_DRIVER_INIT()     1
 
@@ -87,9 +85,7 @@ #define mach_check_checksum	cobalt_check
 #define mach_set_checksum	cobalt_set_checksum
 #define mach_proc_infos		cobalt_proc_infos
 
-#endif
-
-#if MACH == ATARI
+#elif (MACH == ATARI)
 
 /* Special parameters for RTC in Atari machines */
 #include <asm/atarihw.h>
@@ -153,7 +149,7 @@ #endif
  *
  * It is worth noting that these functions all access bytes of general
  * purpose memory in the NVRAM - that is to say, they all add the
- * NVRAM_FIRST_BYTE offset.  Pass them offsets into NVRAM as if you did not 
+ * NVRAM_FIRST_BYTE offset.  Pass them offsets into NVRAM as if you did not
  * know about the RTC cruft.
  */
 
@@ -216,18 +212,6 @@ __nvram_set_checksum(void)
 	mach_set_checksum();
 }
 
-#if 0
-void
-nvram_set_checksum(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	__nvram_set_checksum();
-	spin_unlock_irqrestore(&rtc_lock, flags);
-}
-#endif  /*  0  */
-
 /*
  * The are the file operation function for user access to /dev/nvram
  */
@@ -274,7 +258,7 @@ nvram_read(struct file *file, char __use
 
 	return tmp - contents;
 
-      checksum_err:
+checksum_err:
 	spin_unlock_irq(&rtc_lock);
 	return -EIO;
 }
@@ -307,7 +291,7 @@ nvram_write(struct file *file, const cha
 
 	return tmp - contents;
 
-      checksum_err:
+checksum_err:
 	spin_unlock_irq(&rtc_lock);
 	return -EIO;
 }
@@ -335,7 +319,7 @@ nvram_ioctl(struct inode *inode, struct 
 		return 0;
 
 	case NVRAM_SETCKS:
-		/* just set checksum, contents unchanged (maybe useful after 
+		/* just set checksum, contents unchanged (maybe useful after
 		 * checksum garbaged somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
@@ -357,14 +341,14 @@ nvram_open(struct inode *inode, struct f
 
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
 	    (nvram_open_mode & NVRAM_EXCL) ||
-	    ((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE))) {
+	    ((file->f_mode & S_IWOTH) && (nvram_open_mode & NVRAM_WRITE))) {
 		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
 	}
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
-	if (file->f_mode & 2)
+	if (file->f_mode & S_IWOTH)
 		nvram_open_mode |= NVRAM_WRITE;
 	nvram_open_cnt++;
 
@@ -383,7 +367,7 @@ nvram_release(struct inode *inode, struc
 	/* if only one instance is open, clear the EXCL bit */
 	if (nvram_open_mode & NVRAM_EXCL)
 		nvram_open_mode &= ~NVRAM_EXCL;
-	if (file->f_mode & 2)
+	if (file->f_mode & S_IWOTH)
 		nvram_open_mode &= ~NVRAM_WRITE;
 
 	spin_unlock(&nvram_state_lock);
@@ -448,9 +432,9 @@ static const struct file_operations nvra
 };
 
 static struct miscdevice nvram_dev = {
-	NVRAM_MINOR,
-	"nvram",
-	&nvram_fops
+	.minor		= NVRAM_MINOR,
+	.name		= "nvram",
+	.fops		= &nvram_fops
 };
 
 static int __init
@@ -464,23 +448,23 @@ nvram_init(void)
 
 	ret = misc_register(&nvram_dev);
 	if (ret) {
-		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n",
-		    NVRAM_MINOR);
+		printk(KERN_ERR "nvram: can't misc_register "
+				"on minor=%d\n", NVRAM_MINOR);
 		goto out;
 	}
-	if (!create_proc_read_entry("driver/nvram", 0, NULL, nvram_read_proc,
-		NULL)) {
+	if (!create_proc_read_entry("driver/nvram", 0, NULL,
+					nvram_read_proc, NULL)) {
 		printk(KERN_ERR "nvram: can't create /proc/driver/nvram\n");
 		ret = -ENOMEM;
 		goto outmisc;
 	}
 	ret = 0;
 	printk(KERN_INFO "Non-volatile memory driver v" NVRAM_VERSION "\n");
-      out:
-	return ret;
-      outmisc:
+
+outmisc:
 	misc_deregister(&nvram_dev);
-	goto out;
+out:
+	return ret;
 }
 
 static void __exit
@@ -497,7 +481,7 @@ module_exit(nvram_cleanup_module);
  * Machine specific functions
  */
 
-#if MACH == PC
+#if (MACH == PC)
 
 static int
 pc_check_checksum(void)
@@ -508,8 +492,10 @@ pc_check_checksum(void)
 
 	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
 		sum += __nvram_read_byte(i);
+
 	expect = __nvram_read_byte(PC_CKS_LOC)<<8 |
-	    __nvram_read_byte(PC_CKS_LOC+1);
+		__nvram_read_byte(PC_CKS_LOC+1);
+
 	return ((sum & 0xffff) == expect);
 }
 
@@ -521,6 +507,7 @@ pc_set_checksum(void)
 
 	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
 		sum += __nvram_read_byte(i);
+
 	__nvram_write_byte(sum >> 8, PC_CKS_LOC);
 	__nvram_write_byte(sum & 0xff, PC_CKS_LOC + 1);
 }
@@ -582,30 +569,28 @@ pc_proc_infos(unsigned char *nvram, char
 		PRINT_PROC("none\n");
 
 	PRINT_PROC("HD type 48 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-	    nvram[18] | (nvram[19] << 8),
-	    nvram[20], nvram[25],
-	    nvram[21] | (nvram[22] << 8), nvram[23] | (nvram[24] << 8));
+		nvram[18] | (nvram[19] << 8),
+		nvram[20], nvram[25],
+		nvram[21] | (nvram[22] << 8), nvram[23] | (nvram[24] << 8));
 	PRINT_PROC("HD type 49 data: %d/%d/%d C/H/S, precomp %d, lz %d\n",
-	    nvram[39] | (nvram[40] << 8),
-	    nvram[41], nvram[46],
-	    nvram[42] | (nvram[43] << 8), nvram[44] | (nvram[45] << 8));
+		nvram[39] | (nvram[40] << 8),
+		nvram[41], nvram[46],
+		nvram[42] | (nvram[43] << 8), nvram[44] | (nvram[45] << 8));
 
 	PRINT_PROC("DOS base memory: %d kB\n", nvram[7] | (nvram[8] << 8));
 	PRINT_PROC("Extended memory: %d kB (configured), %d kB (tested)\n",
-	    nvram[9] | (nvram[10] << 8), nvram[34] | (nvram[35] << 8));
+		nvram[9] | (nvram[10] << 8), nvram[34] | (nvram[35] << 8));
 
 	PRINT_PROC("Gfx adapter    : %s\n", gfx_types[(nvram[6] >> 4) & 3]);
 
 	PRINT_PROC("FPU            : %sinstalled\n",
-	    (nvram[6] & 2) ? "" : "not ");
+		(nvram[6] & 2) ? "" : "not ");
 
 	return 1;
 }
 #endif
 
-#endif /* MACH == PC */
-
-#if MACH == COBALT
+#elif (MACH == COBALT)
 
 /* the cobalt CMOS has a wider range of its checksum */
 static int cobalt_check_checksum(void)
@@ -620,8 +605,10 @@ static int cobalt_check_checksum(void)
 
 		sum += __nvram_read_byte(i);
 	}
+
 	expect = __nvram_read_byte(COBT_CMOS_CHECKSUM) << 8 |
-	    __nvram_read_byte(COBT_CMOS_CHECKSUM+1);
+		__nvram_read_byte(COBT_CMOS_CHECKSUM+1);
+
 	return ((sum & 0xffff) == expect);
 }
 
@@ -659,8 +646,8 @@ static int cobalt_proc_infos(unsigned ch
 
 	PRINT_PROC("Checksum status: %svalid\n", checksum ? "" : "not ");
 
-	flags = nvram[COBT_CMOS_FLAG_BYTE_0] << 8 
-	    | nvram[COBT_CMOS_FLAG_BYTE_1];
+	flags = nvram[COBT_CMOS_FLAG_BYTE_0] << 8 |
+		nvram[COBT_CMOS_FLAG_BYTE_1];
 
 	PRINT_PROC("Console: %s\n",
 		flags & COBT_CMOS_CONSOLE_FLAG ?  "on": "off");
@@ -731,15 +718,13 @@ static int cobalt_proc_infos(unsigned ch
 		nvram[COBT_CMOS_BOOTCOUNT_3]);
 
 	/* 13 bytes of serial num */
-	for (i=0 ; i<13 ; i++) {
+	for (i=0 ; i<13 ; i++)
 		sernum[i] = nvram[COBT_CMOS_SYS_SERNUM_0 + i];
-	}
 	sernum[13] = '\0';
 
 	checksum = 0;
-	for (i=0 ; i<13 ; i++) {
+	for (i=0 ; i<13 ; i++)
 		checksum += sernum[i] ^ key[i];
-	}
 	checksum = ((checksum & 0x7f) ^ (0xd6)) & 0xff;
 
 	PRINT_PROC("Serial Number: %s", sernum);
@@ -761,8 +746,8 @@ static int cobalt_proc_infos(unsigned ch
 	}
 	PRINT_PROC("\n");
 
-	if (flags & COBT_CMOS_VERSION_FLAG
-	 && nvram[COBT_CMOS_VERSION] >= COBT_CMOS_VER_BTOCODE) {
+	if (flags & COBT_CMOS_VERSION_FLAG &&
+	    nvram[COBT_CMOS_VERSION] >= COBT_CMOS_VER_BTOCODE) {
 		PRINT_PROC("BTO Code: 0x%x\n",
 			nvram[COBT_CMOS_BTO_CODE_0] << 24 |
 			nvram[COBT_CMOS_BTO_CODE_1] << 16 |
@@ -774,9 +759,7 @@ static int cobalt_proc_infos(unsigned ch
 }
 #endif /* CONFIG_PROC_FS */
 
-#endif /* MACH == COBALT */
-
-#if MACH == ATARI
+#elif (MACH == ATARI)
 
 static int
 atari_check_checksum(void)
@@ -786,8 +769,9 @@ atari_check_checksum(void)
 
 	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
 		sum += __nvram_read_byte(i);
+
 	return (__nvram_read_byte(ATARI_CKS_LOC) == (~sum & 0xff) &&
-	    __nvram_read_byte(ATARI_CKS_LOC + 1) == (sum & 0xff));
+		__nvram_read_byte(ATARI_CKS_LOC + 1) == (sum & 0xff));
 }
 
 static void
@@ -798,6 +782,7 @@ atari_set_checksum(void)
 
 	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
 		sum += __nvram_read_byte(i);
+
 	__nvram_write_byte(~sum, ATARI_CKS_LOC);
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
@@ -853,17 +838,17 @@ atari_proc_infos(unsigned char *nvram, c
 	PRINT_PROC("Checksum status  : %svalid\n", checksum ? "" : "not ");
 
 	PRINT_PROC("Boot preference  : ");
-	for (i = ARRAY_SIZE(boot_prefs) - 1; i >= 0; --i) {
+	for (i = ARRAY_SIZE(boot_prefs) - 1; i >= 0; --i)
 		if (nvram[1] == boot_prefs[i].val) {
 			PRINT_PROC("%s\n", boot_prefs[i].name);
 			break;
 		}
-	}
+
 	if (i < 0)
 		PRINT_PROC("0x%02x (undefined)\n", nvram[1]);
 
 	PRINT_PROC("SCSI arbitration : %s\n",
-	    (nvram[16] & 0x80) ? "on" : "off");
+		(nvram[16] & 0x80) ? "on" : "off");
 	PRINT_PROC("SCSI host ID     : ");
 	if (nvram[16] & 0x80)
 		PRINT_PROC("%d\n", nvram[16] & 7);
@@ -886,31 +871,31 @@ atari_proc_infos(unsigned char *nvram, c
 		PRINT_PROC("%u (undefined)\n", nvram[7]);
 	PRINT_PROC("Date format      : ");
 	PRINT_PROC(dateformat[nvram[8] & 7],
-	    nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/');
+		nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/');
 	PRINT_PROC(", %dh clock\n", nvram[8] & 16 ? 24 : 12);
 	PRINT_PROC("Boot delay       : ");
 	if (nvram[10] == 0)
 		PRINT_PROC("default");
 	else
 		PRINT_PROC("%ds%s\n", nvram[10],
-		    nvram[10] < 8 ? ", no memory test" : "");
+			nvram[10] < 8 ? ", no memory test" : "");
 
 	vmode = (nvram[14] << 8) || nvram[15];
 	PRINT_PROC("Video mode       : %s colors, %d columns, %s %s monitor\n",
-	    colors[vmode & 7],
-	    vmode & 8 ? 80 : 40,
-	    vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
+		colors[vmode & 7],
+		vmode & 8 ? 80 : 40,
+		vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
 	PRINT_PROC("                   %soverscan, compat. mode %s%s\n",
-	    vmode & 64 ? "" : "no ",
-	    vmode & 128 ? "on" : "off",
-	    vmode & 256 ?
-	    (vmode & 16 ? ", line doubling" : ", half screen") : "");
+		vmode & 64 ? "" : "no ",
+		vmode & 128 ? "on" : "off",
+		vmode & 256 ?
+		(vmode & 16 ? ", line doubling" : ", half screen") : "");
 
 	return 1;
 }
 #endif
 
-#endif /* MACH == ATARI */
+#endif /* Architecture specifics */
 
 MODULE_LICENSE("GPL");
 
@@ -920,4 +905,5 @@ EXPORT_SYMBOL(__nvram_write_byte);
 EXPORT_SYMBOL(nvram_write_byte);
 EXPORT_SYMBOL(__nvram_check_checksum);
 EXPORT_SYMBOL(nvram_check_checksum);
+
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);

--yNb1oOkm5a9FJOVX--


