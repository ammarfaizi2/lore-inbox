Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317491AbSGON5n>; Mon, 15 Jul 2002 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317494AbSGON5m>; Mon, 15 Jul 2002 09:57:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:63727 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317491AbSGON5m>; Mon, 15 Jul 2002 09:57:42 -0400
Date: Mon, 15 Jul 2002 14:54:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
       Simon Trimmer <simon@veritas.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs double kunmap
Message-ID: <Pine.LNX.4.21.0207151449001.1346-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found by Simon Trimmer <simon@veritas.com>: shmem_file_write
failure path duplicates kunmap, causing oops holding kmap_lock.

Patch against 2.4.19-rc1, applies at offset to 2.4.19-rc1-ac3,
applies at offset to 2.5.25 but I'll send Linus and Dave later.

--- 2.4.19-rc1/mm/shmem.c	Mon Jun 24 19:14:58 2002
+++ linux/mm/shmem.c	Mon Jul 15 12:28:47 2002
@@ -906,7 +906,6 @@
 fail_write:
 	status = -EFAULT;
 	ClearPageUptodate(page);
-	kunmap(page);
 	goto unlock;
 }
 

