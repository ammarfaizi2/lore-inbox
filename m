Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264977AbUFALYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264977AbUFALYa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 07:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUFALYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 07:24:30 -0400
Received: from holomorphy.com ([207.189.100.168]:37263 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264983AbUFALY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 07:24:26 -0400
Date: Tue, 1 Jun 2004 04:24:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-ID: <20040601112418.GM2093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dominik Karall <dominik.karall@gmx.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <200406011248.16303.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406011248.16303.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 12:48:16PM +0200, Dominik Karall wrote:
>   CC      drivers/scsi/sr_ioctl.o
> drivers/scsi/sr_ioctl.c: In Funktion >>sr_read_cd<<:
> drivers/scsi/sr_ioctl.c:435: error: conflicting types for `cgc'
> drivers/scsi/sr_ioctl.c:434: error: previous declaration of `cgc'
> drivers/scsi/sr_ioctl.c:469: Warnung: Verarbeiten des Argumentes 2 von 
> >>sr_do_ioctl<< von inkompatiblem Zeigertyp
> drivers/scsi/sr_ioctl.c: In Funktion >>sr_read_sector<<:
> drivers/scsi/sr_ioctl.c:479: error: conflicting types for `cgc'
> drivers/scsi/sr_ioctl.c:478: error: previous declaration of `cgc'
> drivers/scsi/sr_ioctl.c:512: Warnung: Verarbeiten des Argumentes 2 von 
> >>sr_do_ioctl<< von inkompatiblem Zeigertyp
> make[3]: *** [drivers/scsi/sr_ioctl.o] Fehler 1
> make[2]: *** [drivers/scsi] Fehler 2
> make[1]: *** [drivers] Fehler 2

There's a plot down there I don't completely understand. Until those
who know what's going on materialize:


Index: linux-2.6.7-rc2-mm1/drivers/scsi/sr_ioctl.c
===================================================================
--- linux-2.6.7-rc2-mm1.orig/drivers/scsi/sr_ioctl.c	2004-06-01 03:25:53.000000000 -0700
+++ linux-2.6.7-rc2-mm1/drivers/scsi/sr_ioctl.c	2004-06-01 04:12:12.000000000 -0700
@@ -432,7 +432,6 @@
 static int sr_read_cd(Scsi_CD *cd, unsigned char *dest, int lba, int format, int blksize)
 {
 	struct packet_command cgc;
-	struct cdrom_generic_command cgc;
 
 #ifdef DEBUG
 	printk("%s: sr_read_cd lba=%d format=%d blksize=%d\n",
@@ -440,7 +439,6 @@
 #endif
 
 	memset(&cgc, 0, sizeof(struct packet_command));
-	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
 	cgc.cmd[0] = GPCMD_READ_CD;	/* READ_CD */
 	cgc.cmd[1] = ((format & 7) << 2);
 	cgc.cmd[2] = (unsigned char) (lba >> 24) & 0xff;
@@ -476,7 +474,6 @@
 static int sr_read_sector(Scsi_CD *cd, int lba, int blksize, unsigned char *dest)
 {
 	struct packet_command cgc;
-	struct cdrom_generic_command cgc;
 	int rc;
 
 	/* we try the READ CD command first... */
@@ -498,7 +495,6 @@
 #endif
 
 	memset(&cgc, 0, sizeof(struct packet_command));
-	memset(&cgc, 0, sizeof(struct cdrom_generic_command));
 	cgc.cmd[0] = GPCMD_READ_10;
 	cgc.cmd[2] = (unsigned char) (lba >> 24) & 0xff;
 	cgc.cmd[3] = (unsigned char) (lba >> 16) & 0xff;
