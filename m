Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315426AbSEGMad>; Tue, 7 May 2002 08:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315427AbSEGMac>; Tue, 7 May 2002 08:30:32 -0400
Received: from [195.63.194.11] ([195.63.194.11]:48649 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315426AbSEGMaY>; Tue, 7 May 2002 08:30:24 -0400
Message-ID: <3CD7BA24.9050205@evision-ventures.com>
Date: Tue, 07 May 2002 13:27:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.14 IDE 57
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020107080802080005080800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107080802080005080800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tue May  7 02:37:49 CEST 2002 ide-clean-57

Nuke /proc/ide. For explanations why, please see the frustrated comments in the
previous change log. If one still don't see why it wasn't a good thing,
well please just take a look at the following:

Kernel size before:

/usr/src/linux# size vmlinux
    text    data     bss     dec     hex filename
1716049  403968  470252 2590269  27863d vmlinux
/usr/src/linux#

Kernel size after:

/usr/src/linux# size vmlinux
    text    data     bss     dec     hex filename
1680993  403488  470124 2554605  26faed vmlinux
/usr/src/linux#

2% of overall size! And this is not exactly an minimalistic setup.
Wow! What a waste of space!!!! Not even counting the runtime size
of this crap! And then let's take a look at the following self
flattery:

-/*
- *  Copyright (C) 1997-1998	Mark Lord
- *
- * This is the /proc/ide/ filesystem implementation.
- *
- * The major reason this exists is to provide sufficient access
- * to driver and config data, such that user-mode programs can
- * be developed to handle chipset tuning for most PCI interfaces.
- * This should provide better utilities, and less kernel bloat.
                                               ^^^^^^^^^^^^^^^^^^
Well there could only be an answer to this which would be
universally understandable in every Slavic language... but since
it's mothers day...

EOD.

--------------020107080802080005080800
Content-Type: text/plain;
 name="ide-clean-57.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-57.diff"

diff -urN linux-2.5.14/drivers/ide/aec62xx.c linux/drivers/ide/aec62xx.c
--- linux-2.5.14/drivers/ide/aec62xx.c	2002-05-06 05:37:59.000000000 +0200
+++ linux/drivers/ide/aec62xx.c	2002-05-07 03:21:35.000000000 +0200
@@ -26,7 +26,7 @@
 
 #include "ata-timing.h"
 
-#define DISPLAY_AEC62XX_TIMINGS
+#undef DISPLAY_AEC62XX_TIMINGS
 
 #ifndef HIGH_4
 #define HIGH_4(H)		((H)=(H>>4))
@@ -503,7 +503,7 @@
 		bmide_dev = dev;
 		aec62xx_display_info = &aec62xx_get_info;
 	}
-#endif /* DISPLAY_AEC62XX_TIMINGS && CONFIG_PROC_FS */
+#endif
 
 	return dev->irq;
 }
diff -urN linux-2.5.14/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.14/drivers/ide/alim15x3.c	2002-05-06 05:38:04.000000000 +0200
+++ linux/drivers/ide/alim15x3.c	2002-05-07 03:22:24.000000000 +0200
@@ -28,7 +28,7 @@
 
 #include "ata-timing.h"
 
-#define DISPLAY_ALI_TIMINGS
+#undef DISPLAY_ALI_TIMINGS
 
 #if defined(DISPLAY_ALI_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
diff -urN linux-2.5.14/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.14/drivers/ide/amd74xx.c	2002-05-06 05:38:03.000000000 +0200
+++ linux/drivers/ide/amd74xx.c	2002-05-07 03:23:35.000000000 +0200
@@ -94,7 +94,7 @@
  * AMD /proc entry.
  */
 
-#ifdef CONFIG_PROC_FS
+#if 0 && defined(CONFIG_PROC_FS)
 
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -384,7 +384,7 @@
  * Register /proc/ide/amd74xx entry
  */
 
-#ifdef CONFIG_PROC_FS
+#if 0 && defined(CONFIG_PROC_FS)
 	if (!amd74xx_proc) {
 		amd_base = pci_resource_start(dev, 4);
 		bmide_dev = dev;
diff -urN linux-2.5.14/drivers/ide/cmd64x.c linux/drivers/ide/cmd64x.c
--- linux-2.5.14/drivers/ide/cmd64x.c	2002-05-06 05:38:00.000000000 +0200
+++ linux/drivers/ide/cmd64x.c	2002-05-07 03:24:08.000000000 +0200
@@ -79,7 +79,7 @@
 #define UDIDETCR1	0x7B
 #define DTPR1		0x7C
 
-#define DISPLAY_CMD64X_TIMINGS
+#undef DISPLAY_CMD64X_TIMINGS
 
 #if defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
diff -urN linux-2.5.14/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.14/drivers/ide/cs5530.c	2002-05-06 05:38:04.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-05-07 03:24:29.000000000 +0200
@@ -29,7 +29,7 @@
 
 #include "ata-timing.h"
 
-#define DISPLAY_CS5530_TIMINGS
+#undef DISPLAY_CS5530_TIMINGS
 
 #if defined(DISPLAY_CS5530_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
diff -urN linux-2.5.14/drivers/ide/hpt366.c linux/drivers/ide/hpt366.c
--- linux-2.5.14/drivers/ide/hpt366.c	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/hpt366.c	2002-05-07 03:25:23.000000000 +0200
@@ -65,7 +65,7 @@
 
 #include "ata-timing.h"
 
-#define DISPLAY_HPT366_TIMINGS
+#undef DISPLAY_HPT366_TIMINGS
 
 /* various tuning parameters */
 #define HPT_RESET_STATE_ENGINE
diff -urN linux-2.5.14/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.14/drivers/ide/ide.c	2002-05-07 03:47:14.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-07 03:17:41.000000000 +0200
@@ -1921,12 +1921,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-ide_proc_entry_t generic_subdriver_entries[] = {
-	{ NULL, 0, NULL, NULL }
-};
-#endif
-
 void ide_unregister(struct ata_channel *ch)
 {
 	struct gendisk *gd;
@@ -1983,9 +1977,6 @@
 			}
 		}
 	}
-#ifdef CONFIG_PROC_FS
-	destroy_proc_ide_drives(ch);
-#endif
 	spin_lock_irqsave(&ide_lock, flags);
 
 	/*
@@ -2208,9 +2199,6 @@
 	if (!initializing) {
 		ideprobe_init();
 		revalidate_drives();
-#ifdef CONFIG_PROC_FS
-		create_proc_ide_interfaces();
-#endif
 		/* FIXME: Do we really have to call it second time here?! */
 		ide_driver_module();
 	}
@@ -3198,11 +3186,7 @@
 	}
 	drive->revalidate = 1;
 	drive->suspend_reset = 0;
-#ifdef CONFIG_PROC_FS
-	ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
-	if (ata_ops(drive))
-		ide_add_proc_entries(drive->proc, ata_ops(drive)->proc, drive);
-#endif
+
 	return 0;
 }
 
@@ -3233,11 +3217,6 @@
 #if defined(CONFIG_BLK_DEV_ISAPNP) && defined(CONFIG_ISAPNP) && defined(MODULE)
 	pnpide_init(0);
 #endif
-#ifdef CONFIG_PROC_FS
-	if (ata_ops(drive))
-		ide_remove_proc_entries(drive->proc, ata_ops(drive)->proc);
-	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);
-#endif
 	auto_remove_settings(drive);
 	drive->driver = NULL;
 	drive->present = 0;
@@ -3315,10 +3294,6 @@
 EXPORT_SYMBOL(ide_cmd);
 EXPORT_SYMBOL(ide_delay_50ms);
 EXPORT_SYMBOL(ide_stall_queue);
-#ifdef CONFIG_PROC_FS
-EXPORT_SYMBOL(ide_add_proc_entries);
-EXPORT_SYMBOL(ide_remove_proc_entries);
-#endif
 EXPORT_SYMBOL(ide_add_setting);
 EXPORT_SYMBOL(ide_remove_setting);
 
@@ -3484,10 +3459,6 @@
 # endif
 #endif
 
-#ifdef CONFIG_PROC_FS
-	proc_ide_create();
-#endif
-
 	/*
 	 * Initialize all device type driver modules.
 	 */
@@ -3553,9 +3524,6 @@
 		ide_unregister(&ide_hwifs[h]);
 	}
 
-# ifdef CONFIG_PROC_FS
-	proc_ide_destroy();
-# endif
 	devfs_unregister(ide_devfs_handle);
 }
 
diff -urN linux-2.5.14/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.14/drivers/ide/ide-cd.c	2002-05-06 05:38:01.000000000 +0200
+++ linux/drivers/ide/ide-cd.c	2002-05-07 03:34:22.000000000 +0200
@@ -2906,7 +2906,6 @@
 	check_media_change:	ide_cdrom_check_media_change,
 	revalidate:		ide_cdrom_revalidate,
 	capacity:		ide_cdrom_capacity,
-	proc:			NULL
 };
 
 /* options */
diff -urN linux-2.5.14/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.14/drivers/ide/ide-disk.c	2002-05-07 03:47:14.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2002-05-07 03:17:38.000000000 +0200
@@ -419,68 +419,6 @@
 	return drive->capacity - drive->sect0;
 }
 
-#ifdef CONFIG_PROC_FS
-
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-static int proc_idedisk_read_tcq
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	struct ata_device *drive = (struct ata_device *) data;
-	char		*out = page;
-	int		len, cmds, i;
-	unsigned long	flags;
-
-	if (!blk_queue_tagged(&drive->queue)) {
-		len = sprintf(out, "not configured\n");
-		PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
-	}
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	len = sprintf(out, "TCQ currently on:\t%s\n", drive->using_tcq ? "yes" : "no");
-	len += sprintf(out+len, "Max queue depth:\t%d\n",drive->queue_depth);
-	len += sprintf(out+len, "Max achieved depth:\t%d\n",drive->max_depth);
-	len += sprintf(out+len, "Max depth since last:\t%d\n",drive->max_last_depth);
-	len += sprintf(out+len, "Current depth:\t\t%d\n", ata_pending_commands(drive));
-	len += sprintf(out+len, "Active tags:\t\t[ ");
-	for (i = 0, cmds = 0; i < drive->queue_depth; i++) {
-		struct request *rq = blk_queue_tag_request(&drive->queue, i);
-
-		if (!rq)
-			continue;
-
-		len += sprintf(out+len, "%d, ", i);
-		cmds++;
-	}
-	len += sprintf(out+len, "]\n");
-
-	len += sprintf(out+len, "Queue:\t\t\treleased [ %lu ] - started [ %lu ]\n", drive->immed_rel, drive->immed_comp);
-
-	if (ata_pending_commands(drive) != cmds)
-		len += sprintf(out+len, "pending request and queue count mismatch (counted: %d)\n", cmds);
-
-	len += sprintf(out+len, "DMA status:\t\t%srunning\n", test_bit(IDE_DMA, &HWGROUP(drive)->flags) ? "" : "not ");
-
-	drive->max_last_depth = 0;
-
-	spin_unlock_irqrestore(&ide_lock, flags);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
-}
-#endif
-
-static ide_proc_entry_t idedisk_proc[] = {
-#ifdef CONFIG_BLK_DEV_IDE_TCQ
-	{ "tcq",		S_IFREG|S_IRUSR,	proc_idedisk_read_tcq,			NULL },
-#endif
-	{ NULL, 0, NULL, NULL }
-};
-
-#else
-
-# define	idedisk_proc	NULL
-
-#endif
-
 /*
  * This is tightly woven into the driver->special can not touch.
  * DON'T do it again until a total personality rewrite is committed.
@@ -1099,7 +1037,6 @@
 	check_media_change:	idedisk_check_media_change,
 	revalidate:		NULL, /* use default method */
 	capacity:		idedisk_capacity,
-	proc:			idedisk_proc
 };
 
 MODULE_DESCRIPTION("ATA DISK Driver");
@@ -1116,10 +1053,6 @@
 		}
 		/* We must remove proc entries defined in this module.
 		   Otherwise we oops while accessing these entries */
-#ifdef CONFIG_PROC_FS
-		if (drive->proc)
-			ide_remove_proc_entries(drive->proc, idedisk_proc);
-#endif
 	}
 }
 
diff -urN linux-2.5.14/drivers/ide/ide-proc.c linux/drivers/ide/ide-proc.c
--- linux-2.5.14/drivers/ide/ide-proc.c	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/ide-proc.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,477 +0,0 @@
-/*
- *  Copyright (C) 1997-1998	Mark Lord
- *
- * This is the /proc/ide/ filesystem implementation.
- *
- * The major reason this exists is to provide sufficient access
- * to driver and config data, such that user-mode programs can
- * be developed to handle chipset tuning for most PCI interfaces.
- * This should provide better utilities, and less kernel bloat.
- *
- * The entire pci config space for a PCI interface chipset can be
- * retrieved by just reading it.  e.g.    "cat /proc/ide3/config"
- *
- * To modify registers *safely*, do something like:
- *   echo "P40:88" >/proc/ide/ide3/config
- * That expression writes 0x88 to pci config register 0x40
- * on the chip which controls ide3.  Multiple tuples can be issued,
- * and the writes will be completed as an atomic set:
- *   echo "P40:88 P41:35 P42:00 P43:00" >/proc/ide/ide3/config
- *
- * All numbers must be specified using pairs of ascii hex digits.
- * It is important to note that these writes will be performed
- * after waiting for the IDE controller (both interfaces)
- * to be completely idle, to ensure no corruption of I/O in progress.
- *
- * Non-PCI registers can also be written, using "R" in place of "P"
- * in the above examples.  The size of the port transfer is determined
- * by the number of pairs of hex digits given for the data.  If a two
- * digit value is given, the write will be a byte operation; if four
- * digits are used, the write will be performed as a 16-bit operation;
- * and if eight digits are specified, a 32-bit "dword" write will be
- * performed.  Odd numbers of digits are not permitted.
- *
- * If there is an error *anywhere* in the string of registers/data
- * then *none* of the writes will be performed.
- *
- * Drive/Driver settings can be retrieved by reading the drive's
- * "settings" files.  e.g.    "cat /proc/ide0/hda/settings"
- * To write a new value "val" into a specific setting "name", use:
- *   echo "name:val" >/proc/ide/ide0/hda/settings
- */
-
-#include <linux/config.h>
-#include <asm/uaccess.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/proc_fs.h>
-#include <linux/stat.h>
-#include <linux/mm.h>
-#include <linux/pci.h>
-#include <linux/ctype.h>
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-
-#include <asm/io.h>
-
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
-#ifdef CONFIG_BLK_DEV_AEC62XX
-extern byte aec62xx_proc;
-int (*aec62xx_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_AEC62XX */
-#ifdef CONFIG_BLK_DEV_ALI15X3
-extern byte ali_proc;
-int (*ali_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_ALI15X3 */
-#ifdef CONFIG_BLK_DEV_AMD74XX
-extern byte amd74xx_proc;
-int (*amd74xx_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_AMD74XX */
-#ifdef CONFIG_BLK_DEV_CMD64X
-extern byte cmd64x_proc;
-int (*cmd64x_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_CMD64X */
-#ifdef CONFIG_BLK_DEV_CS5530
-extern byte cs5530_proc;
-int (*cs5530_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_CS5530 */
-#ifdef CONFIG_BLK_DEV_HPT34X
-extern byte hpt34x_proc;
-int (*hpt34x_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_HPT34X */
-#ifdef CONFIG_BLK_DEV_HPT366
-extern byte hpt366_proc;
-int (*hpt366_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_HPT366 */
-#ifdef CONFIG_BLK_DEV_PDC202XX
-extern byte pdc202xx_proc;
-int (*pdc202xx_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_PDC202XX */
-#ifdef CONFIG_BLK_DEV_PIIX
-extern byte piix_proc;
-int (*piix_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_PIIX */
-#ifdef CONFIG_BLK_DEV_SVWKS
-extern byte svwks_proc;
-int (*svwks_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_SVWKS */
-#ifdef CONFIG_BLK_DEV_SIS5513
-extern byte sis_proc;
-int (*sis_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_SIS5513 */
-#ifdef CONFIG_BLK_DEV_VIA82CXXX
-extern byte via_proc;
-int (*via_display_info)(char *, char **, off_t, int) = NULL;
-#endif /* CONFIG_BLK_DEV_VIA82CXXX */
-
-static struct proc_dir_entry * proc_ide_root = NULL;
-
-static int ide_getdigit(char c)
-{
-	int digit;
-	if (isdigit(c))
-		digit = c - '0';
-	else
-		digit = -1;
-	return digit;
-}
-
-static int proc_ide_read_settings
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	ide_drive_t	*drive = data;
-	ide_settings_t	*setting = drive->settings;
-	char		*out = page;
-	int		len, rc, mul_factor, div_factor;
-
-	out += sprintf(out, "name\t\t\tvalue\t\tmin\t\tmax\t\tmode\n");
-	out += sprintf(out, "----\t\t\t-----\t\t---\t\t---\t\t----\n");
-	while(setting) {
-		mul_factor = setting->mul_factor;
-		div_factor = setting->div_factor;
-		out += sprintf(out, "%-24s", setting->name);
-		if ((rc = ide_read_setting(drive, setting)) >= 0)
-			out += sprintf(out, "%-16d", rc * mul_factor / div_factor);
-		else
-			out += sprintf(out, "%-16s", "write-only");
-		out += sprintf(out, "%-16d%-16d", (setting->min * mul_factor + div_factor - 1) / div_factor, setting->max * mul_factor / div_factor);
-		if (setting->rw & SETTING_READ)
-			out += sprintf(out, "r");
-		if (setting->rw & SETTING_WRITE)
-			out += sprintf(out, "w");
-		out += sprintf(out, "\n");
-		setting = setting->next;
-	}
-	len = out - page;
-	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
-}
-
-#define MAX_LEN	30
-
-static int proc_ide_write_settings
-	(struct file *file, const char *buffer, unsigned long count, void *data)
-{
-	ide_drive_t	*drive = data;
-	char		name[MAX_LEN + 1];
-	int		for_real = 0, len;
-	unsigned long	n;
-	const char	*start = NULL;
-	ide_settings_t	*setting;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	/*
-	 * Skip over leading whitespace
-	 */
-	while (count && isspace(*buffer)) {
-		--count;
-		++buffer;
-	}
-	/*
-	 * Do one full pass to verify all parameters,
-	 * then do another to actually write the new settings.
-	 */
-	do {
-		const char *p;
-		p = buffer;
-		n = count;
-		while (n > 0) {
-			int d, digits;
-			unsigned int val = 0;
-			start = p;
-
-			while (n > 0 && *p != ':') {
-				--n;
-				p++;
-			}
-			if (*p != ':')
-				goto parse_error;
-			len = min(p - start, MAX_LEN);
-			strncpy(name, start, min(len, MAX_LEN));
-			name[len] = 0;
-
-			if (n > 0) {
-				--n;
-				p++;
-			} else
-				goto parse_error;
-
-			digits = 0;
-			while (n > 0 && (d = ide_getdigit(*p)) >= 0) {
-				val = (val * 10) + d;
-				--n;
-				++p;
-				++digits;
-			}
-			if (n > 0 && !isspace(*p))
-				goto parse_error;
-			while (n > 0 && isspace(*p)) {
-				--n;
-				++p;
-			}
-
-			/* Find setting by name */
-			setting = drive->settings;
-
-			while (setting) {
-			    if (strcmp(setting->name, name) == 0)
-				break;
-			    setting = setting->next;
-			}
-			if (!setting)
-				goto parse_error;
-
-			if (for_real)
-				ide_write_setting(drive, setting, val * setting->div_factor / setting->mul_factor);
-		}
-	} while (!for_real++);
-	return count;
-parse_error:
-	printk("proc_ide_write_settings(): parse error\n");
-	return -EINVAL;
-}
-
-static ide_proc_entry_t generic_drive_entries[] = {
-	{ "settings",	S_IFREG|S_IRUSR|S_IWUSR,proc_ide_read_settings,	proc_ide_write_settings },
-	{ NULL,	0, NULL, NULL }
-};
-
-void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p, void *data)
-{
-	struct proc_dir_entry *ent;
-
-	if (!dir || !p)
-		return;
-	while (p->name != NULL) {
-		ent = create_proc_entry(p->name, p->mode, dir);
-		if (!ent) return;
-		ent->nlink = 1;
-		ent->data = data;
-		ent->read_proc = p->read_proc;
-		ent->write_proc = p->write_proc;
-		p++;
-	}
-}
-
-void ide_remove_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p)
-{
-	if (!dir || !p)
-		return;
-	while (p->name != NULL) {
-		remove_proc_entry(p->name, dir);
-		p++;
-	}
-}
-
-/* FIXME: we should iterate over the hwifs here as everywhere else.
- */
-static void create_proc_ide_drives(struct ata_channel *hwif)
-{
-	int	d;
-	struct proc_dir_entry *parent = hwif->proc;
-	char name[64];
-
-	for (d = 0; d < MAX_DRIVES; d++) {
-		ide_drive_t *drive = &hwif->drives[d];
-		struct ata_operations *driver = drive->driver;
-
-		if (!drive->present)
-			continue;
-		if (drive->proc)
-			continue;
-
-		drive->proc = proc_mkdir(drive->name, parent);
-		if (drive->proc) {
-			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-			if (driver) {
-				ide_add_proc_entries(drive->proc, generic_subdriver_entries, drive);
-				ide_add_proc_entries(drive->proc, driver->proc, drive);
-			}
-		}
-		sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2, drive->name);
-	}
-}
-
-static void destroy_proc_ide_device(struct ata_channel *hwif, ide_drive_t *drive)
-{
-	struct ata_operations *driver = drive->driver;
-
-	if (drive->proc) {
-		if (driver)
-			ide_remove_proc_entries(drive->proc, driver->proc);
-		ide_remove_proc_entries(drive->proc, generic_drive_entries);
-		remove_proc_entry(drive->name, proc_ide_root);
-		remove_proc_entry(drive->name, hwif->proc);
-		drive->proc = NULL;
-	}
-}
-
-void destroy_proc_ide_drives(struct ata_channel *hwif)
-{
-	int	d;
-
-	for (d = 0; d < MAX_DRIVES; d++) {
-		ide_drive_t *drive = &hwif->drives[d];
-
-		if (drive->proc)
-			destroy_proc_ide_device(hwif, drive);
-	}
-}
-
-void create_proc_ide_interfaces(void)
-{
-	int	h;
-
-	for (h = 0; h < MAX_HWIFS; h++) {
-		struct ata_channel *hwif = &ide_hwifs[h];
-
-		if (!hwif->present)
-			continue;
-		if (!hwif->proc) {
-			hwif->proc = proc_mkdir(hwif->name, proc_ide_root);
-			if (!hwif->proc)
-				return;
-		}
-		create_proc_ide_drives(hwif);
-	}
-}
-
-static void destroy_proc_ide_interfaces(void)
-{
-	int	h;
-
-	for (h = 0; h < MAX_HWIFS; h++) {
-		struct ata_channel *hwif = &ide_hwifs[h];
-		int exist = (hwif->proc != NULL);
-#if 0
-		if (!hwif->present)
-			continue;
-#endif
-		if (exist) {
-			destroy_proc_ide_drives(hwif);
-			remove_proc_entry(hwif->name, proc_ide_root);
-			hwif->proc = NULL;
-		} else
-			continue;
-	}
-}
-
-void proc_ide_create(void)
-{
-	proc_ide_root = proc_mkdir("ide", 0);
-	if (!proc_ide_root) return;
-
-	create_proc_ide_interfaces();
-
-#ifdef CONFIG_BLK_DEV_AEC62XX
-	if ((aec62xx_display_info) && (aec62xx_proc))
-		create_proc_info_entry("aec62xx", 0, proc_ide_root, aec62xx_display_info);
-#endif /* CONFIG_BLK_DEV_AEC62XX */
-#ifdef CONFIG_BLK_DEV_ALI15X3
-	if ((ali_display_info) && (ali_proc))
-		create_proc_info_entry("ali", 0, proc_ide_root, ali_display_info);
-#endif /* CONFIG_BLK_DEV_ALI15X3 */
-#ifdef CONFIG_BLK_DEV_AMD74XX
-	if ((amd74xx_display_info) && (amd74xx_proc))
-		create_proc_info_entry("amd74xx", 0, proc_ide_root, amd74xx_display_info);
-#endif /* CONFIG_BLK_DEV_AMD74XX */
-#ifdef CONFIG_BLK_DEV_CMD64X
-	if ((cmd64x_display_info) && (cmd64x_proc))
-		create_proc_info_entry("cmd64x", 0, proc_ide_root, cmd64x_display_info);
-#endif /* CONFIG_BLK_DEV_CMD64X */
-#ifdef CONFIG_BLK_DEV_CS5530
-	if ((cs5530_display_info) && (cs5530_proc))
-		create_proc_info_entry("cs5530", 0, proc_ide_root, cs5530_display_info);
-#endif /* CONFIG_BLK_DEV_CS5530 */
-#ifdef CONFIG_BLK_DEV_HPT34X
-	if ((hpt34x_display_info) && (hpt34x_proc))
-		create_proc_info_entry("hpt34x", 0, proc_ide_root, hpt34x_display_info);
-#endif /* CONFIG_BLK_DEV_HPT34X */
-#ifdef CONFIG_BLK_DEV_HPT366
-	if ((hpt366_display_info) && (hpt366_proc))
-		create_proc_info_entry("hpt366", 0, proc_ide_root, hpt366_display_info);
-#endif /* CONFIG_BLK_DEV_HPT366 */
-#ifdef CONFIG_BLK_DEV_SVWKS
-	if ((svwks_display_info) && (svwks_proc))
-		create_proc_info_entry("svwks", 0, proc_ide_root, svwks_display_info);
-#endif /* CONFIG_BLK_DEV_SVWKS */
-#ifdef CONFIG_BLK_DEV_PDC202XX
-	if ((pdc202xx_display_info) && (pdc202xx_proc))
-		create_proc_info_entry("pdc202xx", 0, proc_ide_root, pdc202xx_display_info);
-#endif /* CONFIG_BLK_DEV_PDC202XX */
-#ifdef CONFIG_BLK_DEV_PIIX
-	if ((piix_display_info) && (piix_proc))
-		create_proc_info_entry("piix", 0, proc_ide_root, piix_display_info);
-#endif /* CONFIG_BLK_DEV_PIIX */
-#ifdef CONFIG_BLK_DEV_SIS5513
-	if ((sis_display_info) && (sis_proc))
-		create_proc_info_entry("sis", 0, proc_ide_root, sis_display_info);
-#endif /* CONFIG_BLK_DEV_SIS5513 */
-#ifdef CONFIG_BLK_DEV_VIA82CXXX
-	if ((via_display_info) && (via_proc))
-		create_proc_info_entry("via", 0, proc_ide_root, via_display_info);
-#endif /* CONFIG_BLK_DEV_VIA82CXXX */
-}
-
-void proc_ide_destroy(void)
-{
-	/*
-	 * Mmmm.. does this free up all resources,
-	 * or do we need to do a more proper cleanup here ??
-	 */
-#ifdef CONFIG_BLK_DEV_AEC62XX
-	if ((aec62xx_display_info) && (aec62xx_proc))
-		remove_proc_entry("ide/aec62xx",0);
-#endif /* CONFIG_BLK_DEV_AEC62XX */
-#ifdef CONFIG_BLK_DEV_ALI15X3
-	if ((ali_display_info) && (ali_proc))
-		remove_proc_entry("ide/ali",0);
-#endif /* CONFIG_BLK_DEV_ALI15X3 */
-#ifdef CONFIG_BLK_DEV_AMD74XX
-	if ((amd74xx_display_info) && (amd74xx_proc))
-		remove_proc_entry("ide/amd74xx",0);
-#endif /* CONFIG_BLK_DEV_AMD74XX */
-#ifdef CONFIG_BLK_DEV_CMD64X
-	if ((cmd64x_display_info) && (cmd64x_proc))
-		remove_proc_entry("ide/cmd64x",0);
-#endif /* CONFIG_BLK_DEV_CMD64X */
-#ifdef CONFIG_BLK_DEV_CS5530
-	if ((cs5530_display_info) && (cs5530_proc))
-		remove_proc_entry("ide/cs5530",0);
-#endif /* CONFIG_BLK_DEV_CS5530 */
-#ifdef CONFIG_BLK_DEV_HPT34X
-	if ((hpt34x_display_info) && (hpt34x_proc))
-		remove_proc_entry("ide/hpt34x",0);
-#endif /* CONFIG_BLK_DEV_HPT34X */
-#ifdef CONFIG_BLK_DEV_HPT366
-	if ((hpt366_display_info) && (hpt366_proc))
-		remove_proc_entry("ide/hpt366",0);
-#endif /* CONFIG_BLK_DEV_HPT366 */
-#ifdef CONFIG_BLK_DEV_PDC202XX
-	if ((pdc202xx_display_info) && (pdc202xx_proc))
-		remove_proc_entry("ide/pdc202xx",0);
-#endif /* CONFIG_BLK_DEV_PDC202XX */
-#ifdef CONFIG_BLK_DEV_PIIX
-	if ((piix_display_info) && (piix_proc))
-		remove_proc_entry("ide/piix",0);
-#endif /* CONFIG_BLK_DEV_PIIX */
-#ifdef CONFIG_BLK_DEV_SVWKS
-	if ((svwks_display_info) && (svwks_proc))
-		remove_proc_entry("ide/svwks",0);
-#endif /* CONFIG_BLK_DEV_SVWKS */
-#ifdef CONFIG_BLK_DEV_SIS5513
-	if ((sis_display_info) && (sis_proc))
-		remove_proc_entry("ide/sis", 0);
-#endif /* CONFIG_BLK_DEV_SIS5513 */
-#ifdef CONFIG_BLK_DEV_VIA82CXXX
-	if ((via_display_info) && (via_proc))
-		remove_proc_entry("ide/via",0);
-#endif /* CONFIG_BLK_DEV_VIA82CXXX */
-
-	remove_proc_entry("ide/drivers", 0);
-	destroy_proc_ide_interfaces();
-	remove_proc_entry("ide", 0);
-}
diff -urN linux-2.5.14/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.14/drivers/ide/ide-tape.c	2002-05-07 03:47:14.000000000 +0200
+++ linux/drivers/ide/ide-tape.c	2002-05-07 03:36:01.000000000 +0200
@@ -6108,31 +6108,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-
-static int proc_idetape_read_name
-	(char *page, char **start, off_t off, int count, int *eof, void *data)
-{
-	ide_drive_t	*drive = (ide_drive_t *) data;
-	idetape_tape_t	*tape = drive->driver_data;
-	char		*out = page;
-	int		len;
-
-	len = sprintf(out, "%s\n", tape->name);
-	PROC_IDE_READ_RETURN(page, start, off, count, eof, len);
-}
-
-static ide_proc_entry_t idetape_proc[] = {
-	{ "name",	S_IFREG|S_IRUGO,	proc_idetape_read_name,	NULL },
-	{ NULL, 0, NULL, NULL }
-};
-
-#else
-
-#define	idetape_proc	NULL
-
-#endif
-
 static void idetape_revalidate(ide_drive_t *_dummy)
 {
 	/* We don't have to handle any partition information here, which is the
@@ -6154,7 +6129,6 @@
 	release:		idetape_blkdev_release,
 	check_media_change:	NULL,
 	revalidate:		idetape_revalidate,
-	proc:			idetape_proc
 };
 
 /*
diff -urN linux-2.5.14/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.14/drivers/ide/Makefile	2002-05-07 02:36:37.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-05-07 03:31:30.000000000 +0200
@@ -72,8 +72,6 @@
 obj-$(CONFIG_BLK_DEV_ATARAID_PDC)	+= pdcraid.o
 obj-$(CONFIG_BLK_DEV_ATARAID_HPT)	+= hptraid.o
 
-ide-obj-$(CONFIG_PROC_FS)		+= ide-proc.o
-
 ide-mod-objs		:= ide-taskfile.o ide.o ide-probe.o ide-geometry.o ide-features.o ata-timing.o $(ide-obj-y)
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.14/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.14/drivers/ide/pdc202xx.c	2002-05-06 05:38:06.000000000 +0200
+++ linux/drivers/ide/pdc202xx.c	2002-05-07 03:25:51.000000000 +0200
@@ -51,7 +51,7 @@
 #define PDC202XX_DEBUG_DRIVE_INFO		0
 #define PDC202XX_DECODE_REGISTER_INFO		0
 
-#define DISPLAY_PDC202XX_TIMINGS
+#undef DISPLAY_PDC202XX_TIMINGS
 
 #ifndef SPLIT_BYTE
 #define SPLIT_BYTE(B,H,L)	((H)=(B>>4), (L)=(B-((B>>4)<<4)))
diff -urN linux-2.5.14/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.14/drivers/ide/piix.c	2002-05-06 05:38:00.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-05-07 03:26:49.000000000 +0200
@@ -110,7 +110,7 @@
  * PIIX/ICH /proc entry.
  */
 
-#ifdef CONFIG_PROC_FS
+#if 0 && defined(CONFIG_PROC_FS)
 
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -520,7 +520,7 @@
  * Register /proc/ide/piix entry
  */
 
-#ifdef CONFIG_PROC_FS
+#if 0 && defined(CONFIG_PROC_FS)
 	if (!piix_proc) {
 		piix_base = pci_resource_start(dev, 4);
 		bmide_dev = dev;
diff -urN linux-2.5.14/drivers/ide/serverworks.c linux/drivers/ide/serverworks.c
--- linux-2.5.14/drivers/ide/serverworks.c	2002-05-06 05:38:03.000000000 +0200
+++ linux/drivers/ide/serverworks.c	2002-05-07 03:29:32.000000000 +0200
@@ -93,15 +93,16 @@
 
 #include "ata-timing.h"
 
-#define DISPLAY_SVWKS_TIMINGS	1
+#undef DISPLAY_SVWKS_TIMINGS
 #undef SVWKS_DEBUG_DRIVE_INFO
 
+static u8 svwks_revision = 0;
+
 #if defined(DISPLAY_SVWKS_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
 static struct pci_dev *bmide_dev;
-static byte svwks_revision = 0;
 
 static int svwks_get_info(char *, char **, off_t, int);
 extern int (*svwks_display_info)(char *, char **, off_t, int); /* ide-proc.c */
diff -urN linux-2.5.14/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.14/drivers/ide/sis5513.c	2002-05-06 05:38:00.000000000 +0200
+++ linux/drivers/ide/sis5513.c	2002-05-07 03:27:49.000000000 +0200
@@ -58,7 +58,7 @@
 /* When BROKEN_LEVEL is defined it limits the DMA mode
    at boot time to its value */
 // #define BROKEN_LEVEL XFER_SW_DMA_0
-#define DISPLAY_SIS_TIMINGS
+#undef DISPLAY_SIS_TIMINGS
 
 /* Miscellaneaous flags */
 #define SIS5513_LATENCY		0x01
diff -urN linux-2.5.14/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.14/drivers/ide/via82cxxx.c	2002-05-06 05:37:58.000000000 +0200
+++ linux/drivers/ide/via82cxxx.c	2002-05-07 03:28:40.000000000 +0200
@@ -136,7 +136,7 @@
  * VIA /proc entry.
  */
 
-#ifdef CONFIG_PROC_FS
+#if 0 && defined(CONFIG_PROC_FS)
 
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -497,7 +497,7 @@
  * Setup /proc/ide/via entry.
  */
 
-#ifdef CONFIG_PROC_FS
+#if 0 && defined(CONFIG_PROC_FS)
 	if (!via_proc) {
 		via_base = pci_resource_start(dev, 4);
 		bmide_dev = dev;
diff -urN linux-2.5.14/drivers/scsi/ide-scsi.c linux/drivers/scsi/ide-scsi.c
--- linux-2.5.14/drivers/scsi/ide-scsi.c	2002-05-06 05:37:53.000000000 +0200
+++ linux/drivers/scsi/ide-scsi.c	2002-05-07 03:37:28.000000000 +0200
@@ -557,7 +557,6 @@
 	check_media_change:	NULL,
 	revalidate:		idescsi_revalidate,
 	capacity:		NULL,
-	proc:			NULL
 };
 
 /*
diff -urN linux-2.5.14/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.14/include/linux/ide.h	2002-05-07 03:47:14.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-07 03:17:40.000000000 +0200
@@ -379,8 +379,7 @@
 
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
-	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
-	struct ide_settings_s *settings;    /* /proc/ide/ drive settings */
+	struct ide_settings_s *settings;    /* ioctl entires */
 	char		driver_req[10];	/* requests specific driver */
 
 	int		last_lun;	/* last logical unit */
@@ -612,43 +611,7 @@
 extern int ide_write_setting(struct ata_device *, ide_settings_t *, int);
 extern void ide_add_generic_settings(struct ata_device *);
 
-/*
- * /proc/ide interface
- */
-typedef struct {
-	const char	*name;
-	mode_t		mode;
-	read_proc_t	*read_proc;
-	write_proc_t	*write_proc;
-} ide_proc_entry_t;
-
-#ifdef CONFIG_PROC_FS
-void proc_ide_create(void);
-void proc_ide_destroy(void);
-void destroy_proc_ide_drives(struct ata_channel *);
-void create_proc_ide_interfaces(void);
-void ide_add_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p, void *data);
-void ide_remove_proc_entries(struct proc_dir_entry *dir, ide_proc_entry_t *p);
-read_proc_t proc_ide_read_geometry;
-
-/*
- * Standard exit stuff:
- */
-#define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) \
-{					\
-	len -= off;			\
-	if (len < count) {		\
-		*eof = 1;		\
-		if (len <= 0)		\
-			return 0;	\
-	} else				\
-		len = count;		\
-	*start = page + off;		\
-	return len;			\
-}
-#else
-# define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
-#endif
+#define PROC_IDE_READ_RETURN(page,start,off,count,eof,len) return 0;
 
 /*
  * This structure describes the operations possible on a particular device type
@@ -671,8 +634,6 @@
 	void (*revalidate)(struct ata_device *);
 
 	sector_t (*capacity)(struct ata_device *);
-
-	ide_proc_entry_t *proc;
 };
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
@@ -863,7 +824,6 @@
 void ide_init_subdrivers (void);
 
 extern struct block_device_operations ide_fops[];
-extern ide_proc_entry_t generic_subdriver_entries[];
 
 #ifdef CONFIG_BLK_DEV_IDE
 /* Probe for devices attached to the systems host controllers.

--------------020107080802080005080800--

