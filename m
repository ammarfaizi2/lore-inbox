Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263477AbTDPCtD (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 22:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264212AbTDPCtD 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 22:49:03 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:25826 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263477AbTDPCtC (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 22:49:02 -0400
Date: Tue, 15 Apr 2003 23:00:54 -0400
To: LKML <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com
Subject: Re: [Bug 583] New: Enabling Coda with Devfs causes Kernel Panic
Message-ID: <20030416030054.GA19950@delft.aura.cs.cmu.edu>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	torvalds@transmeta.com
References: <18760000.1050377643@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18760000.1050377643@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 08:34:03PM -0700, Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=583
> [<c01a4a62>] devfs_mk_dir+0x22/0xd0 
> [<c01360d1>] kmalloc+0x81/0x99 
> [<c0150e47>] register_chrdev_region+0x17/0x120 

Part of the backtrace doesn't make much sense, but the problem is caused
by the devfs_mk_dir simplification that went in a couple of weeks ago.

Jan

--- linux-2.5.67/fs/coda/psdev.c.orig	2002-12-17 21:09:56.000000000 -0500
+++ linux-2.5.67/fs/coda/psdev.c	2003-04-15 23:05:04.000000000 -0400
@@ -371,7 +371,7 @@
 		     CODA_PSDEV_MAJOR);
               return -EIO;
 	}
-	devfs_mk_dir (NULL, "coda", NULL);
+	devfs_mk_dir ("coda");
 	for (i = 0; i < MAX_CODADEVS; i++) {
 		char name[16];
 		sprintf(name, "coda/%d", i);

