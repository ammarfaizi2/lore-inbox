Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272573AbTHBKtX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272574AbTHBKtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:49:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:7392 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272573AbTHBKtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:49:13 -0400
Date: Sat, 2 Aug 2003 03:50:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] writes: fix spurious fs truncate errors
Message-Id: <20030802035011.77acbf26.akpm@osdl.org>
In-Reply-To: <20030802042018.GC22824@waste.org>
References: <20030802042018.GC22824@waste.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron <oxymoron@waste.org> wrote:
>
> Get rid of newly exposed EIO errors from truncate races in filesystems
> 

One fix.

The reiserfs change looks OK from a breif scan, but I need to wake up a
resierfs developer to take a look at it.



- Missing kunmap in CIFS.

 fs/cifs/file.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/cifs/file.c~awe-fix-truncate-errors-fixes fs/cifs/file.c
--- 25/fs/cifs/file.c~awe-fix-truncate-errors-fixes	2003-08-02 03:28:02.000000000 -0700
+++ 25-akpm/fs/cifs/file.c	2003-08-02 03:28:02.000000000 -0700
@@ -456,6 +456,7 @@ cifs_partialpagewrite(struct page *page,
 
 	/* racing with truncate? */
 	if(offset > mapping->host->i_size) {
+		kunmap(page);
 		FreeXid(xid);
 		return 0; /* don't care */
 	}

_

