Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTDUQ1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 12:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbTDUQ1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 12:27:38 -0400
Received: from verein.lst.de ([212.34.181.86]:57359 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261702AbTDUQ1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 12:27:37 -0400
Date: Mon, 21 Apr 2003 18:39:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: 2.5.68-bk1 renames IDE disks, /dev/hda is directory
Message-ID: <20030421183935.A27811@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org,
	andre@linux-ide.org
References: <Pine.LNX.4.55.0304211157430.14766@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304211157430.14766@marabou.research.att.com>; from proski@gnu.org on Mon, Apr 21, 2003 at 12:08:11PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 12:08:11PM -0400, Pavel Roskin wrote:
> Hello!
> 
> After upgrading from 2.5.67-bk9 to 2.5.68-bk1 I have found that the devfs
> names for IDE disks have changed.  Instead of the traditional
> 2.4-compatible /dev/ide/host0/bus0/target0/lun0/part1, /dev/hda1 has now
> become /dev/hda/disc0/part1.
> 
> What's really weird is that /dev/hda is now a directory.  That's going to
> break a lot of software!

Hey, that wasn't intentation.  In fact it's a stupid brown-paperbag bug
only hidden by mount-by-label :)

Here's the fix:


--- 1.1/fs/partitions/devfs.c	Sat Apr 19 20:57:36 2003
+++ edited/fs/partitions/devfs.c	Mon Apr 21 17:11:33 2003
@@ -81,7 +81,7 @@
 {
 	char dirname[64], symlink[16];
 
-	if (disk->devfs_name[0] != '\0')
+	if (disk->devfs_name[0] == '\0')
 		sprintf(disk->devfs_name, "%s/disc%d", disk->disk_name,
 				disk->first_minor >> disk->minor_shift);
 
