Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264786AbTFBBzk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 21:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbTFBBzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 21:55:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264786AbTFBBzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 21:55:39 -0400
Date: Mon, 2 Jun 2003 03:09:03 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: [FIX] Re: 2.5.70-bk[56] breaks disk partitioning with multiple IDE disks
Message-ID: <20030602020903.GA28742@parcelfarce.linux.theplanet.co.uk>
References: <20030601235333.GN9502@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0306011849050.16521-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306011849050.16521-100000@home.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 06:49:41PM -0700, Linus Torvalds wrote:
> 
> On Mon, 2 Jun 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > vi drivers/ide/ide.c -c'/drive->list.*driver->drives/s/list_add/&_tail/|x'
> 
> Mind sending me a patch? There's only so much I like doing with vi 
> scripts, and this went over my threshold.

No problem...

--- drivers/ide/ide.c	Sat May 31 15:31:08 2003
+++ /tmp/ide.c	Sun Jun  1 19:50:38 2003
@@ -2335,7 +2335,7 @@
 	setup_driver_defaults(drive);
 	spin_unlock_irqrestore(&ide_lock, flags);
 	spin_lock(&drives_lock);
-	list_add(&drive->list, &driver->drives);
+	list_add_tail(&drive->list, &driver->drives);
 	spin_unlock(&drives_lock);
 //	printk(KERN_INFO "%s: attached %s driver.\n", drive->name, driver->name);
 	if ((drive->autotune == IDE_TUNE_DEFAULT) ||
