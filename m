Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWGCUVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWGCUVR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWGCUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:21:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52117 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750759AbWGCUVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:21:17 -0400
Date: Mon, 3 Jul 2006 13:21:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
Message-Id: <20060703132104.9b6b85d7.akpm@osdl.org>
In-Reply-To: <44A90276.4050108@reub.net>
References: <20060703030355.420c7155.akpm@osdl.org>
	<44A8F8D2.1030101@reub.net>
	<20060703043954.0807c3f2.akpm@osdl.org>
	<44A90276.4050108@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 23:41:42 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> Allocate Port Service[0000:00:1c.0:pcie0]
> Allocate Port Service[0000:00:1c.0:pcie0]

Turns out that we have a rogue patch coming in from the powerpc tree.  This
should fix it, thanks.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/hot-fixes/git-powerpc-revert-bogus-vsnprintf-change.patch

--- a/lib/vsprintf.c~git-powerpc-revert-bogus-vsnprintf-change
+++ a/lib/vsprintf.c
@@ -283,12 +283,12 @@ int vsnprintf(char *buf, size_t size, co
 	}
 
 	str = buf;
-	end = buf + size - 1;
+	end = buf + size;
 
 	/* Make sure end is always >= buf */
-	if (end < buf - 1) {
+	if (end < buf) {
 		end = ((void *)-1);
-		size = end - buf + 1;
+		size = end - buf;
 	}
 
 	for (; *fmt ; ++fmt) {
_


