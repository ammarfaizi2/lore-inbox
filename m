Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbTIVNsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 09:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTIVNsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 09:48:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50646 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263149AbTIVNsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 09:48:14 -0400
Date: Mon, 22 Sep 2003 14:48:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alistair J Strachan <alistair@devzero.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm4
Message-ID: <20030922134813.GF7665@parcelfarce.linux.theplanet.co.uk>
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309221317.42273.alistair@devzero.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 01:17:42PM +0100, Alistair J Strachan wrote:
> One possible explanation is that I have devfs compiled into my kernel. I do 
> not, however, have it automatically mounting on boot. It overlays /dev (which 
> is populated with original style device nodes) after INIT has loaded.

Amazingly idiotic typo.  And yes, it gets hit only if devfs is configured.

diff -u B5-real32/init/do_mounts.h B5-current/init/do_mounts.h
--- B5-real32/init/do_mounts.h	Sun Sep 21 21:22:33 2003
+++ B5-current/init/do_mounts.h	Mon Sep 22 09:41:21 2003
@@ -53,7 +53,7 @@
 static inline u32 bstat(char *name)
 {
 	struct stat64 stat;
-	if (!sys_stat64(name, &stat) != 0)
+	if (sys_stat64(name, &stat) != 0)
 		return 0;
 	if (!S_ISBLK(stat.st_mode))
 		return 0;
@@ -65,7 +65,7 @@
 static inline u32 bstat(char *name)
 {
 	struct stat stat;
-	if (!sys_newstat(name, &stat) != 0)
+	if (sys_newstat(name, &stat) != 0)
 		return 0;
 	if (!S_ISBLK(stat.st_mode))
 		return 0;
