Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbSJWJuT>; Wed, 23 Oct 2002 05:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263958AbSJWJuT>; Wed, 23 Oct 2002 05:50:19 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:937 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S263571AbSJWJuS>;
	Wed, 23 Oct 2002 05:50:18 -0400
Date: Wed, 23 Oct 2002 11:56:01 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [miniPATCH] 2.5.44 fix compilation errors in the AFS fs
Message-ID: <20021023095601.GB12175@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo lkml,

I'm sending 2 patches to fix compilation errors in the AFS fs.

The first of them fixed union afs_dirent_t and using this union in the
fs/afs/dir.c.

The second of them fix number of parameters of calling function kleave()
in the net/rxpc/main.c.

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fs_afs_dirc.patch"

--- linux-2.5.44/fs/afs/dir.c.old	2002-10-23 11:35:12.000000000 +0200
+++ linux-2.5.44/fs/afs/dir.c	2002-10-23 11:39:57.000000000 +0200
@@ -72,7 +72,7 @@
 		u8	name[16];
 		u8	overflow[4];	/* if any char of the name (inc NUL) reaches here, consume
 					 * the next dirent too */
-	};
+	} parts;
 	u8	extended_name[32];
 } afs_dirent_t;
 
@@ -258,7 +258,7 @@
 
 		/* got a valid entry */
 		dire = &block->dirents[offset];
-		nlen = strnlen(dire->name,sizeof(*block) - offset*sizeof(afs_dirent_t));
+		nlen = strnlen(dire->parts.name,sizeof(*block) - offset*sizeof(afs_dirent_t));
 
 		_debug("ENT[%u.%u]: %s %u \"%.*s\"\n",
 		       blkoff/sizeof(afs_dir_block_t),offset,
@@ -290,11 +290,11 @@
 
 		/* found the next entry */
 		ret = filldir(cookie,
-			      dire->name,
+			      dire->parts.name,
 			      nlen,
 			      blkoff + offset * sizeof(afs_dirent_t),
-			      ntohl(dire->vnode),
-			      filldir==afs_dir_lookup_filldir ? dire->unique : DT_UNKNOWN);
+			      ntohl(dire->parts.vnode),
+			      filldir==afs_dir_lookup_filldir ? dire->parts.unique : DT_UNKNOWN);
 		if (ret<0) {
 			_leave(" = 0 [full]");
 			return 0;

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="net_rxpc_mainc.patch"

--- linux-2.5.44/net/rxrpc/main.c.old	2002-10-23 11:44:45.000000000 +0200
+++ linux-2.5.44/net/rxrpc/main.c	2002-10-23 11:45:41.000000000 +0200
@@ -123,5 +123,5 @@
 	__RXACCT(printk("Outstanding Peers      : %d\n",atomic_read(&rxrpc_peer_count)));
 	__RXACCT(printk("Outstanding Transports : %d\n",atomic_read(&rxrpc_transport_count)));
 
-	kleave();
+	kleave("");
 } /* end rxrpc_cleanup() */

--a8Wt8u1KmwUX3Y2C--
