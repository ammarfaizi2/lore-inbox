Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUD1Vko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUD1Vko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 17:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUD1ToM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:44:12 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:55936 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264931AbUD1Q0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:26:55 -0400
Subject: Re: New warning from nfs code
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.44.0404281058490.24906-100000@math.ut.ee>
References: <Pine.GSO.4.44.0404281058490.24906-100000@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083169613.2856.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Apr 2004 12:26:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 04:01, Meelis Roos wrote:
> This is 2.6.6-rc3 on a sparc64:
> 
>   CC [M]  fs/nfs/direct.o
> fs/nfs/direct.c: In function `nfs_direct_IO':
> fs/nfs/direct.c:458: warning: int format, different type arg (arg 2)
> 
> ssize_t is long (64-bit) on sparc64 but int (32-bit) on i386 and so on.

Does this help?

Cheers,
  Trond

--- linux-2.6.6-rc3/fs/nfs/direct.c.orig	2004-04-27 22:41:02.000000000 -0400
+++ linux-2.6.6-rc3/fs/nfs/direct.c	2004-04-28 12:23:26.000000000 -0400
@@ -455,6 +455,6 @@ nfs_direct_IO(int rw, struct kiocb *iocb
 	}
 
 out:
-	dprintk("NFS: direct_IO result=%d\n", result);
+	dprintk("NFS: direct_IO result=%zd\n", result);
 	return result;
 }

