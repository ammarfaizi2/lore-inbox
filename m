Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289749AbSAJWjj>; Thu, 10 Jan 2002 17:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289752AbSAJWjc>; Thu, 10 Jan 2002 17:39:32 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:785 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S289749AbSAJWjT>; Thu, 10 Jan 2002 17:39:19 -0500
Date: Thu, 10 Jan 2002 23:36:27 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
        kernel list <linux-kernel@vger.kernel.org>, davej@suse.de,
        torvalds@transmeta.com
Subject: Small cleanup in ide
Message-ID: <20020110223627.GA3444@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This cleans ide a tiny bit. Please apply.
									Pavel

--- clean/include/linux/ide.h	Wed Dec 19 22:38:14 2001
+++ linux-dm/include/linux/ide.h	Thu Jan 10 23:14:30 2002
@@ -382,12 +383,12 @@
 	unsigned int	cyl;		/* "real" number of cyls */
 	unsigned long	capacity;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
-	void		  *hwif;	/* actually (ide_hwif_t *) */
+	struct ide_hwif_s *hwif;	/* actually (ide_hwif_t *) */
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 	struct hd_driveid *id;		/* drive model identification info */
 	struct hd_struct  *part;	/* drive partition table */
 	char		name[4];	/* drive name, such as "hda" */
-	void 		*driver;	/* (ide_driver_t *) */
+	struct ide_driver_s *driver;	/* (ide_driver_t *) */
 	void		*driver_data;	/* extra driver data */
 	devfs_handle_t	de;		/* directory for device */
 	struct proc_dir_entry *proc;	/* /proc/ide/ directory entry */
--- clean/drivers/ide/ide-proc.c	Wed Dec 19 22:38:12 2001
+++ linux-dm/drivers/ide/ide-proc.c	Thu Jan 10 23:35:13 2002
@@ -582,13 +582,13 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
+	ide_driver_t    *driver = drive->driver;
 	int		len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
-		len = sprintf(page,"%li\n", ((ide_driver_t *)drive->driver)->capacity(drive));
+		len = sprintf(page,"%li\n", drive->driver->capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -620,7 +620,7 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
