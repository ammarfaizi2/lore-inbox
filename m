Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWGCMQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWGCMQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 08:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWGCMQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 08:16:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:42917 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751145AbWGCMQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 08:16:02 -0400
Message-ID: <44A90A7D.10201@fr.ibm.com>
Date: Mon, 03 Jul 2006 14:15:57 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Martin Peschke <mp3@de.ibm.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: 2.6.17-mm6
References: <20060703030355.420c7155.akpm@osdl.org>
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/

This patch fixes a minor issue between the statistic infrastructure
patchset and the inode diet patchset.

thanks,

C.



From: Cedric Le Goater <clg@fr.ibm.com>
Subject: [statistics infrastructure] replace inode u.generic_ip with i_private

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Martin Peschke <mp3@de.ibm.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>


---
 lib/statistic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: 2.6.17-mm6/lib/statistic.c
===================================================================
--- 2.6.17-mm6.orig/lib/statistic.c
+++ 2.6.17-mm6/lib/statistic.c
@@ -666,7 +666,7 @@ static int statistic_generic_open(struct
 		struct file *file, struct statistic_interface **interface,
 		struct statistic_file_private **private)
 {
-	*interface = inode->u.generic_ip;
+	*interface = inode->i_private;
 	BUG_ON(!interface);
 	*private = kzalloc(sizeof(struct statistic_file_private), GFP_KERNEL);
 	if (unlikely(!*private))
@@ -749,7 +749,7 @@ static ssize_t statistic_generic_write(s

 static int statistic_def_close(struct inode *inode, struct file *file)
 {
-	struct statistic_interface *interface = inode->u.generic_ip;
+	struct statistic_interface *interface = inode->i_private;
 	struct statistic_file_private *private = file->private_data;
 	struct sgrb_seg *seg, *seg_nl;
 	int offset;
