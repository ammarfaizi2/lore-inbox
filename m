Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268201AbTBYSkv>; Tue, 25 Feb 2003 13:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268211AbTBYSkv>; Tue, 25 Feb 2003 13:40:51 -0500
Received: from p50831A1E.dip.t-dialin.net ([80.131.26.30]:37585 "EHLO
	extern.mail.waldi.eu.org") by vger.kernel.org with ESMTP
	id <S268201AbTBYSku>; Tue, 25 Feb 2003 13:40:50 -0500
Date: Tue, 25 Feb 2003 19:51:04 +0100
From: Bastian Blank <waldi@debian.org>
To: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390 - dasd with devfs
Message-ID: <20030225185104.GB30801@wavehammer.waldi.eu.org>
References: <20030225180413.GA30801@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225180413.GA30801@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 07:04:13PM +0100, Bastian Blank wrote:
> this patch fixes s390 dasd with devfs

if forgot a fix and include an updated patch

bastian

diff -ur linux-2.5.63.orig/drivers/s390/block/dasd.c linux-2.5.63/drivers/s390/block/dasd.c
--- linux-2.5.63.orig/drivers/s390/block/dasd.c	2003-02-24 20:05:31.000000000 +0100
+++ linux-2.5.63/drivers/s390/block/dasd.c	2003-02-25 18:51:34.000000000 +0100
@@ -2077,7 +2077,7 @@
 
 	DBF_EVENT(DBF_EMERG, "%s", "debug area created");
 
-	if (devfs_mk_dir(NULL, "dasd", NULL)) {
+	if (!devfs_mk_dir(NULL, "dasd", NULL)) {
 		DBF_EVENT(DBF_ALERT, "%s", "no devfs");
 		rc = -ENOSYS;
 		goto failed;
diff -ur linux-2.5.63.orig/drivers/s390/block/dasd_genhd.c linux-2.5.63/drivers/s390/block/dasd_genhd.c
--- linux-2.5.63.orig/drivers/s390/block/dasd_genhd.c	2003-02-24 20:05:39.000000000 +0100
+++ linux-2.5.63/drivers/s390/block/dasd_genhd.c	2003-02-25 19:47:27.000000000 +0100
@@ -145,6 +145,7 @@
 	gdp->major = mi->major;
 	gdp->first_minor = index << DASD_PARTN_BITS;
 	gdp->fops = &dasd_device_operations;
+	gdp->flags |= GENHD_FL_DEVFS;
 
 	/*
 	 * Set device name.
-- 
You're dead, Jim.
		-- McCoy, "The Tholian Web", stardate unknown
