Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267211AbUHIUeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUHIUeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 16:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUHIUcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 16:32:13 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:55176 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266850AbUHIUQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 16:16:29 -0400
Date: Mon, 9 Aug 2004 22:15:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040809201556.GB9677@louise.pinerecords.com>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714115523.GC2269@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul-14 2004, Wed, 13:55 +0200
Pavel Machek <pavel@suse.cz> wrote:

> > >What is the status of ipw2100? Is there chance that it would be pushed
> > >into mainline?
> > >
> > >I have few problems with that:
> > >
> > >* it will not compile with gcc-2.95. Attached patch fixes one problem
> > >but more remain.
> > 
> > I've given up hope on that. Don't think it'll ever compile on 2.95. I'm 
> > using ndiswrapper and it works nicely.
> 
> No, I think that can be fixed... I'll rather fix ipw2100 than use
> ndiswrapper.

ipw2100 0.51 from ipw2100.sf.net builds using gcc-2.95.3 "out of the box."
Also make sure to use the attached patch for 2.6.8pre.

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN linux-2.6.7/drivers/net/wireless/ipw2100/ipw2100_fw.c linux-2.6.7.x/drivers/net/wireless/ipw2100/ipw2100_fw.c
--- linux-2.6.7/drivers/net/wireless/ipw2100/ipw2100_fw.c	2004-08-09 21:37:11.000000000 +0200
+++ linux-2.6.7.x/drivers/net/wireless/ipw2100/ipw2100_fw.c	2004-08-09 21:36:15.000000000 +0200
@@ -200,7 +200,7 @@
 			goto fail;
 			
 		}
-		if (read(fd, c->buf, c->len) != c->len) {
+		if (sys_read(fd, c->buf, c->len) != c->len) {
 			printk(KERN_INFO "Failed to read chunk firmware "
 			       "chunk %d.\n", i);
 			goto fail;
@@ -231,17 +231,17 @@
 	INIT_LIST_HEAD(&fw->fw.chunk_list);
 	INIT_LIST_HEAD(&fw->uc.chunk_list);
 	
-	fd = open(fn, 0, 0);
+	fd = sys_open(fn, 0, 0);
 	if (fd == -1) {
 		printk(KERN_INFO "Unable to load '%s'.\n", fn);
 		return 1;
 	}
-	l = lseek(fd, 0L, 2);
-	lseek(fd, 0L, 0);
+	l = sys_lseek(fd, 0L, 2);
+	sys_lseek(fd, 0L, 0);
 	
 	IPW2100_DEBUG_FW("Loading %ld bytes for firmware '%s'\n", l, fn);
 	
-	if (read(fd, (char *)&h, sizeof(h)) != sizeof(h)) {
+	if (sys_read(fd, (char *)&h, sizeof(h)) != sizeof(h)) {
 		printk(KERN_INFO "Failed to read '%s'.\n", fn);
 		goto fail;
 	}
@@ -262,12 +262,12 @@
 	if (ipw2100_fw_load(fd, &fw->uc, h.uc_size))
 		goto fail;
 
-	close(fd);
+	sys_close(fd);
 	return 0;
 
  fail:
 	ipw2100_fw_free(fw);
-	close(fd);
+	sys_close(fd);
 	return 1;
 }
 
