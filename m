Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbUDRDMa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 23:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUDRDMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 23:12:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:41645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263231AbUDRDM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 23:12:28 -0400
Date: Sat, 17 Apr 2004 20:12:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: chris@scary.beasts.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Nasty 2.6 sendfile() bug / regression; affects vsftpd
In-Reply-To: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.58.0404172005260.23917@ppc970.osdl.org>
References: <Pine.LNX.4.58.0404180026490.16486@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Apr 2004 chris@scary.beasts.org wrote:
> 
> Any chance you can review this and sneak into 2.6.soon?

Your patch is horribly ugly. How about this (much simpler) patch instead?

It just sets the "max" to zero if pos in NULL in the caller. That just 
seems a much better/saner approach.

Can you test that this one-liner fixes the issue for you?

		Linus

----
--- 1.37/fs/read_write.c	Mon Apr 12 10:54:20 2004
+++ edited/fs/read_write.c	Sat Apr 17 20:09:41 2004
@@ -635,7 +635,7 @@
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, MAX_NON_LFS);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0);
 }
 
 asmlinkage ssize_t sys_sendfile64(int out_fd, int in_fd, loff_t __user *offset, size_t count)
