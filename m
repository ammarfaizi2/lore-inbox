Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbTDXQwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbTDXQwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:52:30 -0400
Received: from verein.lst.de ([212.34.181.86]:37381 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263770AbTDXQw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:52:28 -0400
Date: Thu, 24 Apr 2003 19:04:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Roskin <proski@gnu.org>, torvalds@transmeta.com
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
       viro@www.linux.org.uk
Subject: Re: 2.5.68-bk1 renames IDE disks, /dev/hda is directory
Message-ID: <20030424190431.A29056@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Pavel Roskin <proski@gnu.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, viro@www.linux.org.uk
References: <Pine.LNX.4.55.0304211157430.14766@marabou.research.att.com> <20030421183935.A27811@lst.de> <Pine.LNX.4.55.0304241257520.2855@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0304241257520.2855@marabou.research.att.com>; from proski@gnu.org on Thu, Apr 24, 2003 at 01:01:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 01:01:32PM -0400, Pavel Roskin wrote:
> Somebody please apply this patch:
> 
> http://hypermail.idiosynkrasia.net/linux-kernel/latestweek/0150.html
> 
> It's still not in 2.5.68-bk5.  It's a major headache for everybody who
> tries to use devfs with the current kernel.

Sorry, I sent this to Linus two times but he hasn't applied it yet :P

Linus, could you please apply this patch so all thos poor devfs
users get their disks back?


--- 1.1/fs/partitions/devfs.c	Sat Apr 19 20:57:36 2003
+++ edited/fs/partitions/devfs.c	Mon Apr 21 17:20:54 2003
@@ -81,10 +81,6 @@
 {
 	char dirname[64], symlink[16];
 
-	if (disk->devfs_name[0] != '\0')
-		sprintf(disk->devfs_name, "%s/disc%d", disk->disk_name,
-				disk->first_minor >> disk->minor_shift);
-
 	devfs_mk_dir(disk->devfs_name);
 	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor),
 			S_IFBLK|S_IRUSR|S_IWUSR,
