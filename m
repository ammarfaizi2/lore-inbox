Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVEaKxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVEaKxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVEaKxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:53:37 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:13550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261801AbVEaKwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:52:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=cErquIxZnuu9atA5UgzkSB6ERixPhNWfDV+VU1Y/+jojeYS7f8vKk5Gr0/d70/+5v4tTl56or+yic96zAaDD0oL+ozWKMPxE/JGy2KTF49qYDrv4bqjUMjP1LMb0Js5OKqJeVzbigGAwBYI2bw5td2a3imSH8vGnXvl/+hiDldE=
Message-ID: <81083a45050531035260ce77b0@mail.gmail.com>
Date: Tue, 31 May 2005 16:22:40 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
Reply-To: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fixes the warnings obtained with arm-elf-gcc 3.4
In-Reply-To: <81083a4505053103506aba48d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19394_9200744.1117536760017"
References: <81083a450505310337131c3e31@mail.gmail.com>
	 <81083a4505053103506aba48d5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_19394_9200744.1117536760017
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry for the repeating mails

This patch fixes the warnings obtained with arm-elf-gcc 3.4.

Files Affected -

-fs/jffs2/read.c
-fs/jffs2/nodemgmt.c
-fs/jffs2/readinode.c
-fs/jffs2/write.c
-fs/jffs2/gc.c
-fs/jffs2/erase.c
-fs/nfs/nfs2xdr.c
-fs/nfs/nfs3xdr.c
-drivers/base/dmapool.c
-drivers/char/random.c
-drivers/serial/8250_early.c
-net/core/dev.c
-net/sunrpc/xprt.c
-net/sunrpc/svc.c
-net/sunrpv/svcsock.c

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_19394_9200744.1117536760017
Content-Type: text/plain; name=pat.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pat.txt"

diff --unified -rN linux-2.6.11-patch/drivers/base/dmapool.c linux-2.6.11/drivers/base/dmapool.c
--- linux-2.6.11-patch/drivers/base/dmapool.c	2005-05-31 15:32:55.098932200 +0530
+++ linux-2.6.11/drivers/base/dmapool.c	2005-03-02 13:08:26.000000000 +0530
@@ -67,7 +67,7 @@
 		}
 
 		/* per-pool info, no real statistics yet */
-		temp = scnprintf(next, size, "%-16s %4u %4u %4u %2u\n",
+		temp = scnprintf(next, size, "%-16s %4u %4Zu %4Zu %2u\n",
 				pool->name,
 				blocks, pages * pool->blocks_per_page,
 				pool->size, pages);
diff --unified -rN linux-2.6.11-patch/drivers/char/random.c linux-2.6.11/drivers/char/random.c
--- linux-2.6.11-patch/drivers/char/random.c	2005-05-31 15:34:27.737848944 +0530
+++ linux-2.6.11/drivers/char/random.c	2005-03-02 13:07:48.000000000 +0530
@@ -1435,7 +1435,7 @@
 #endif
 
 		/* Copy data to destination buffer */
-		i = min(nbytes, (size_t)HASH_BUFFER_SIZE*sizeof(__u32)/2);
+		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
 		if (flags & EXTRACT_ENTROPY_USER) {
 			i -= copy_to_user(buf, (__u8 const *)tmp, i);
 			if (!i) {
@@ -1691,7 +1691,7 @@
 	size_t c = count;
 
 	while (c > 0) {
-		bytes = min(c, (size_t)sizeof(buf));
+		bytes = min(c, sizeof(buf));
 
 		bytes -= copy_from_user(&buf, p, bytes);
 		if (!bytes) {
diff --unified -rN linux-2.6.11-patch/drivers/serial/8250_early.c linux-2.6.11/drivers/serial/8250_early.c
--- linux-2.6.11-patch/drivers/serial/8250_early.c	2005-05-31 15:35:46.000000000 +0530
+++ linux-2.6.11/drivers/serial/8250_early.c	2005-03-02 13:08:08.000000000 +0530
@@ -165,7 +165,7 @@
 	if ((options = strchr(options, ','))) {
 		options++;
 		device->baud = simple_strtoul(options, 0, 0);
-		length = min(strcspn(options, " "), (size_t)sizeof(device->options));
+		length = min(strcspn(options, " "), sizeof(device->options));
 		strncpy(device->options, options, length);
 	} else {
 		device->baud = probe_baud(port);
diff --unified -rN linux-2.6.11-patch/fs/jffs2/gc.c linux-2.6.11/fs/jffs2/gc.c
--- linux-2.6.11-patch/fs/jffs2/gc.c	2005-05-31 15:29:42.000000000 +0530
+++ linux-2.6.11/fs/jffs2/gc.c	2005-03-02 13:07:51.000000000 +0530
@@ -589,7 +589,7 @@
 	ret = jffs2_flash_write(c, phys_ofs, rawlen, &retlen, (char *)node);
 
 	if (ret || (retlen != rawlen)) {
-		printk(KERN_NOTICE "Write of %d bytes at 0x%08x failed. returned %d, retlen %d\n",
+		printk(KERN_NOTICE "Write of %d bytes at 0x%08x failed. returned %d, retlen %zd\n",
                        rawlen, phys_ofs, ret, retlen);
 		if (retlen) {
                         /* Doesn't belong to any inode */
@@ -831,7 +831,7 @@
 				continue;
 			}
 			if (retlen != rawlen) {
-				printk(KERN_WARNING "jffs2_g_c_deletion_dirent(): Short read (%d not %u) reading header from obsolete node at %08x\n",
+				printk(KERN_WARNING "jffs2_g_c_deletion_dirent(): Short read (%zd not %u) reading header from obsolete node at %08x\n",
 				       retlen, rawlen, ref_offset(raw));
 				continue;
 			}
@@ -906,7 +906,7 @@
 		   write it out again with the _same_ version as before */
 		ret = jffs2_flash_read(c, ref_offset(fn->raw), sizeof(ri), &readlen, (char *)&ri);
 		if (readlen != sizeof(ri) || ret) {
-			printk(KERN_WARNING "Node read failed in jffs2_garbage_collect_hole. Ret %d, retlen %d. Data will be lost by writing new hole node\n", ret, readlen);
+			printk(KERN_WARNING "Node read failed in jffs2_garbage_collect_hole. Ret %d, retlen %zd. Data will be lost by writing new hole node\n", ret, readlen);
 			goto fill;
 		}
 		if (je16_to_cpu(ri.nodetype) != JFFS2_NODETYPE_INODE) {
diff --unified -rN linux-2.6.11-patch/fs/jffs2/nodemgmt.c linux-2.6.11/fs/jffs2/nodemgmt.c
--- linux-2.6.11-patch/fs/jffs2/nodemgmt.c	2005-05-31 15:25:59.000000000 +0530
+++ linux-2.6.11/fs/jffs2/nodemgmt.c	2005-03-02 13:07:49.000000000 +0530
@@ -544,7 +544,7 @@
 		goto out_erase_sem;
 	}
 	if (retlen != sizeof(n)) {
-		printk(KERN_WARNING "Short read from obsoleted node at 0x%08x: %d\n", ref_offset(ref), retlen);
+		printk(KERN_WARNING "Short read from obsoleted node at 0x%08x: %zd\n", ref_offset(ref), retlen);
 		goto out_erase_sem;
 	}
 	if (PAD(je32_to_cpu(n.totlen)) != PAD(ref_totlen(c, jeb, ref))) {
@@ -563,7 +563,7 @@
 		goto out_erase_sem;
 	}
 	if (retlen != sizeof(n)) {
-		printk(KERN_WARNING "Short write in obliterating obsoleted node at 0x%08x: %d\n", ref_offset(ref), retlen);
+		printk(KERN_WARNING "Short write in obliterating obsoleted node at 0x%08x: %zd\n", ref_offset(ref), retlen);
 		goto out_erase_sem;
 	}
 
diff --unified -rN linux-2.6.11-patch/fs/jffs2/read.c linux-2.6.11/fs/jffs2/read.c
--- linux-2.6.11-patch/fs/jffs2/read.c	2005-05-31 15:24:18.000000000 +0530
+++ linux-2.6.11/fs/jffs2/read.c	2005-03-02 13:07:53.000000000 +0530
@@ -43,7 +43,7 @@
 	}
 	if (readlen != sizeof(*ri)) {
 		jffs2_free_raw_inode(ri);
-		printk(KERN_WARNING "Short read from 0x%08x: wanted 0x%zx bytes, got 0x%x\n", 
+		printk(KERN_WARNING "Short read from 0x%08x: wanted 0x%zx bytes, got 0x%zx\n", 
 		       ref_offset(fd->raw), sizeof(*ri), readlen);
 		return -EIO;
 	}
diff --unified -rN linux-2.6.11-patch/fs/jffs2/readinode.c linux-2.6.11/fs/jffs2/readinode.c
--- linux-2.6.11-patch/fs/jffs2/readinode.c	2005-05-31 15:27:01.000000000 +0530
+++ linux-2.6.11/fs/jffs2/readinode.c	2005-03-02 13:07:46.000000000 +0530
@@ -585,7 +585,7 @@
 
 	ret = jffs2_flash_read(c, ref_offset(fn->raw), sizeof(*latest_node), &retlen, (void *)latest_node);
 	if (ret || retlen != sizeof(*latest_node)) {
-		printk(KERN_NOTICE "MTD read in jffs2_do_read_inode() failed: Returned %d, %d of %zd bytes read\n",
+		printk(KERN_NOTICE "MTD read in jffs2_do_read_inode() failed: Returned %d, %zd of %zd bytes read\n",
 		       ret, retlen, sizeof(*latest_node));
 		/* FIXME: If this fails, there seems to be a memory leak. Find it. */
 		up(&f->sem);
diff --unified -rN linux-2.6.11-patch/fs/jffs2/write.c linux-2.6.11/fs/jffs2/write.c
--- linux-2.6.11-patch/fs/jffs2/write.c	2005-05-31 15:27:54.000000000 +0530
+++ linux-2.6.11/fs/jffs2/write.c	2005-03-02 13:08:08.000000000 +0530
@@ -140,7 +140,7 @@
 				 (alloc_mode==ALLOC_GC)?0:f->inocache->ino);
 
 	if (ret || (retlen != sizeof(*ri) + datalen)) {
-		printk(KERN_NOTICE "Write of %zd bytes at 0x%08x failed. returned %d, retlen %d\n", 
+		printk(KERN_NOTICE "Write of %zd bytes at 0x%08x failed. returned %d, retlen %zd\n", 
 		       sizeof(*ri)+datalen, flash_ofs, ret, retlen);
 
 		/* Mark the space as dirtied */
diff --unified -rN linux-2.6.11-patch/fs/nfs/nfs2xdr.c linux-2.6.11/fs/nfs/nfs2xdr.c
--- linux-2.6.11-patch/fs/nfs/nfs2xdr.c	2005-05-31 15:30:57.000000000 +0530
+++ linux-2.6.11/fs/nfs/nfs2xdr.c	2005-03-02 13:08:04.000000000 +0530
@@ -262,7 +262,7 @@
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
 	if (iov->iov_len < hdrlen) {
 		printk(KERN_WARNING "NFS: READ reply header overflowed:"
-				"length %d > %u\n", hdrlen, iov->iov_len);
+				"length %d > %Zu\n", hdrlen, iov->iov_len);
 		return -errno_NFSERR_IO;
 	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READ header is short. iovec will be shifted.\n");
@@ -407,7 +407,7 @@
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
 	if (iov->iov_len < hdrlen) {
 		printk(KERN_WARNING "NFS: READDIR reply header overflowed:"
-				"length %d > %u\n", hdrlen, iov->iov_len);
+				"length %d > %Zu\n", hdrlen, iov->iov_len);
 		return -errno_NFSERR_IO;
 	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READDIR header is short. iovec will be shifted.\n");
diff --unified -rN linux-2.6.11-patch/fs/nfs/nfs3xdr.c linux-2.6.11/fs/nfs/nfs3xdr.c
--- linux-2.6.11-patch/fs/nfs/nfs3xdr.c	2005-05-31 15:31:58.000000000 +0530
+++ linux-2.6.11/fs/nfs/nfs3xdr.c	2005-03-02 13:08:33.000000000 +0530
@@ -503,7 +503,7 @@
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
 	if (iov->iov_len < hdrlen) {
 		printk(KERN_WARNING "NFS: READDIR reply header overflowed:"
-				"length %d > %u\n", hdrlen, iov->iov_len);
+				"length %d > %Zu\n", hdrlen, iov->iov_len);
 		return -errno_NFSERR_IO;
 	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READDIR header is short. iovec will be shifted.\n");
@@ -737,7 +737,7 @@
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
 	if (iov->iov_len < hdrlen) {
 		printk(KERN_WARNING "NFS: READLINK reply header overflowed:"
-				"length %d > %u\n", hdrlen, iov->iov_len);
+				"length %d > %Zu\n", hdrlen, iov->iov_len);
 		return -errno_NFSERR_IO;
 	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READLINK header is short. iovec will be shifted.\n");
@@ -787,7 +787,7 @@
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
 	if (iov->iov_len < hdrlen) {
 		printk(KERN_WARNING "NFS: READ reply header overflowed:"
-				"length %d > %u\n", hdrlen, iov->iov_len);
+				"length %d > %Zu\n", hdrlen, iov->iov_len);
        		return -errno_NFSERR_IO;
 	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READ header is short. iovec will be shifted.\n");
diff --unified -rN linux-2.6.11-patch/net/core/dev.c linux-2.6.11/net/core/dev.c
--- linux-2.6.11-patch/net/core/dev.c	2005-05-31 10:32:00.000000000 +0530
+++ linux-2.6.11/net/core/dev.c	2005-03-02 13:08:09.000000000 +0530
@@ -2341,7 +2341,7 @@
 				memset(ifr->ifr_hwaddr.sa_data, 0, sizeof ifr->ifr_hwaddr.sa_data);
 			else
 				memcpy(ifr->ifr_hwaddr.sa_data, dev->dev_addr,
-				       min((size_t)sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
+				       min(sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
 			ifr->ifr_hwaddr.sa_family = dev->type;
 			return 0;
 
@@ -2362,7 +2362,7 @@
 			if (ifr->ifr_hwaddr.sa_family != dev->type)
 				return -EINVAL;
 			memcpy(dev->broadcast, ifr->ifr_hwaddr.sa_data,
-			       min((size_t)sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
+			       min(sizeof ifr->ifr_hwaddr.sa_data, (size_t) dev->addr_len));
 			notifier_call_chain(&netdev_chain,
 					    NETDEV_CHANGEADDR, dev);
 			return 0;
diff --unified -rN linux-2.6.11-patch/net/sunrpc/svc.c linux-2.6.11/net/sunrpc/svc.c
--- linux-2.6.11-patch/net/sunrpc/svc.c	2005-05-31 15:38:11.000000000 +0530
+++ linux-2.6.11/net/sunrpc/svc.c	2005-03-02 13:08:38.000000000 +0530
@@ -415,7 +415,7 @@
 
 err_short_len:
 #ifdef RPC_PARANOIA
-	printk("svc: short len %d, dropping request\n", argv->iov_len);
+	printk("svc: short len %Zd, dropping request\n", argv->iov_len);
 #endif
 	goto dropit;			/* drop request */
 
diff --unified -rN linux-2.6.11-patch/net/sunrpc/svcsock.c linux-2.6.11/net/sunrpc/svcsock.c
--- linux-2.6.11-patch/net/sunrpc/svcsock.c	2005-05-31 15:40:42.000000000 +0530
+++ linux-2.6.11/net/sunrpc/svcsock.c	2005-03-02 13:07:48.000000000 +0530
@@ -421,7 +421,7 @@
 			len += result;
 	}
 out:
-	dprintk("svc: socket %p sendto([%p %u... ], %d) = %d (addr %x)\n",
+	dprintk("svc: socket %p sendto([%p %Zu... ], %d) = %d (addr %x)\n",
 			rqstp->rq_sock, xdr->head[0].iov_base, xdr->head[0].iov_len, xdr->len, len,
 		rqstp->rq_addr.sin_addr.s_addr);
 
@@ -474,7 +474,7 @@
 	alen = sizeof(rqstp->rq_addr);
 	sock->ops->getname(sock, (struct sockaddr *)&rqstp->rq_addr, &alen, 1);
 
-	dprintk("svc: socket %p recvfrom(%p, %u) = %d\n",
+	dprintk("svc: socket %p recvfrom(%p, %Zu) = %d\n",
 		rqstp->rq_sock, iov[0].iov_base, iov[0].iov_len, len);
 
 	return len;
diff --unified -rN linux-2.6.11-patch/net/sunrpc/xprt.c linux-2.6.11/net/sunrpc/xprt.c
--- linux-2.6.11-patch/net/sunrpc/xprt.c	2005-05-31 15:37:43.000000000 +0530
+++ linux-2.6.11/net/sunrpc/xprt.c	2005-03-02 13:08:13.000000000 +0530
@@ -884,7 +884,7 @@
 	char *p;
 
 	len = sizeof(xprt->tcp_xid) - xprt->tcp_offset;
-	dprintk("RPC:      reading XID (%u bytes)\n", len);
+	dprintk("RPC:      reading XID (%Zu bytes)\n", len);
 	p = ((char *) &xprt->tcp_xid) + xprt->tcp_offset;
 	used = tcp_copy_data(desc, p, len);
 	xprt->tcp_offset += used;

------=_Part_19394_9200744.1117536760017--
