Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSIEWZp>; Thu, 5 Sep 2002 18:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSIEWZp>; Thu, 5 Sep 2002 18:25:45 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17024 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318691AbSIEWZm>;
	Thu, 5 Sep 2002 18:25:42 -0400
Date: Fri, 6 Sep 2002 00:28:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: alan@redhat.com, kernel list <linux-kernel@vger.kernel.org>
Subject: IDE cleanup (against 2.5.33) -- who takes these?
Message-ID: <20020905222830.GA24863@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Who takes cleanup patches against 2.5.33? Alan is it you or should it
go directly to Linus?
								Pavel

--- linux-swsusp.2/drivers/ide/ide-proc.c	2002-09-05 23:30:28.000000000 +0200
+++ linux-swsusp/drivers/ide/ide-proc.c	2002-09-06 00:20:43.000000000 +0200
@@ -562,14 +562,14 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t    *driver = (ide_driver_t *) drive->driver;
+	ide_driver_t    *driver = drive->driver;
 	int		len;
 
 	if (!driver)
 		len = sprintf(page, "(none)\n");
         else
 		len = sprintf(page,"%llu\n",
-			      (unsigned long long) ((ide_driver_t *)drive->driver)->capacity(drive));
+			      (unsigned long long) drive->driver->capacity(drive));
 	PROC_IDE_READ_RETURN(page,start,off,count,eof,len);
 }
 
@@ -601,7 +601,7 @@
 	(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	ide_drive_t	*drive = (ide_drive_t *) data;
-	ide_driver_t	*driver = (ide_driver_t *) drive->driver;
+	ide_driver_t	*driver = drive->driver;
 	int		len;
 
 	if (!driver)
@@ -718,7 +718,6 @@
 	struct proc_dir_entry *ent;
 	struct proc_dir_entry *parent = hwif->proc;
 	char name[64];
-//	ide_driver_t *driver = drive->driver;
 
 	if (drive->present && !drive->proc) {
 		drive->proc = proc_mkdir(drive->name, parent);
@@ -760,7 +759,6 @@
 
 	for (d = 0; d < MAX_DRIVES; d++) {
 		ide_drive_t *drive = &hwif->drives[d];
-//		ide_driver_t *driver = drive->driver;
 
 		if (drive->proc)
 			destroy_proc_ide_device(hwif, drive);


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
