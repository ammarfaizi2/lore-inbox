Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTDUQ2z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 12:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTDUQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 12:28:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:30217 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261710AbTDUQ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 12:28:54 -0400
Date: Mon, 21 Apr 2003 17:40:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68 oops booting with initrd
Message-ID: <20030421174053.A8101@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Kevin P. Fleming" <kpfleming@cox.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
References: <E197OVO-0008VR-00@gondolin.me.apana.org.au> <3EA41339.3090909@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA41339.3090909@cox.net>; from kpfleming@cox.net on Mon, Apr 21, 2003 at 08:50:17AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 08:50:17AM -0700, Kevin P. Fleming wrote:
> The patch you supplied (check disk->minors != 1 before calling 
> devfs_remove_partitions) did not apply do 2.5.68; the code in 
> fs/partitions/check.c has changed since your base version. However, 
> hand-editing to do the same check has solved the problem.
> 
> I'll Christoph supply a patch, since he's the one that's been working in 
> that whole devfs area.

And 2.5.58-bk1 is completly different again but should have fixed it.

Make sure you apply the following diff when using devfs, though:


--- 1.1/fs/partitions/devfs.c	Sat Apr 19 20:57:36 2003
+++ edited/fs/partitions/devfs.c	Mon Apr 21 17:11:33 2003
@@ -81,7 +81,7 @@
 {
 	char dirname[64], symlink[16];
 
-	if (disk->devfs_name[0] != '\0')
+	if (disk->devfs_name[0] == '\0')
 		sprintf(disk->devfs_name, "%s/disc%d", disk->disk_name,
 				disk->first_minor >> disk->minor_shift);
 
