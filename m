Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWCFNfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWCFNfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 08:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWCFNfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 08:35:37 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1419 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932193AbWCFNfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 08:35:37 -0500
Subject: Re: problem mounting a jffs2 filesystem
From: David Woodhouse <dwmw2@infradead.org>
To: Miguel Blanco <mblancom@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8766c4ce0603050504h24b445c5t@mail.gmail.com>
References: <8766c4ce0603050504h24b445c5t@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-sgMlzciEkC7tLPNC008j"
Date: Mon, 06 Mar 2006 13:35:31 +0000
Message-Id: <1141652131.4110.47.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sgMlzciEkC7tLPNC008j
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2006-03-05 at 14:04 +0100, Miguel Blanco wrote:
>  divide error: 0000 [#1]
>  EIP is at jffs2_scan_medium+0xdf/0x55e [jffs2]

Can you try it with the attached patch? Or turn off
CONFIG_JFFS2_FS_WRITEBUFFER

-- 
dwmw2

--=-sgMlzciEkC7tLPNC008j
Content-Disposition: inline
Content-Description: Attached message - mtd/fs/jffs2 scan.c,1.134,1.135
Content-Type: message/rfc822

Return-path: <linux-mtd-cvs-bounces+dwmw2=infradead.org@lists.infradead.org>
Envelope-to: dwmw2@baythorne.infradead.org
Delivery-date: Thu, 09 Feb 2006 16:18:14 +0000
Received: from canuck.infradead.org ([2001:8b0:10b:4::1]) by
	baythorne.infradead.org with esmtps (Exim 4.54 #1 (Red Hat Linux)) id
	1F7EUn-0008O9-Dy for dwmw2@baythorne.infradead.org; Thu, 09 Feb 2006
	16:18:13 +0000
Received: from localhost ([127.0.0.1] helo=canuck.infradead.org) by
	canuck.infradead.org with esmtp (Exim 4.54 #1 (Red Hat Linux)) id
	1F7EUj-0000bD-0L; Thu, 09 Feb 2006 11:18:09 -0500
Received: from phoenix.infradead.org ([81.187.2.162]) by
	canuck.infradead.org with esmtps (Exim 4.54 #1 (Red Hat Linux)) id
	1F7EUf-0000b0-4k for linux-mtd-cvs@lists.infradead.org; Thu, 09 Feb 2006
	11:18:05 -0500
Received: from dwmw2 by phoenix.infradead.org with local (Exim 4.43 #1 (Red
	Hat Linux)) id 1F7EPl-0007Vk-PT for linux-mtd-cvs@lists.infradead.org; Thu,
	09 Feb 2006 16:13:01 +0000
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: linux-mtd-cvs@lists.infradead.org
X-CVS-Module: mtd
X-CVS-Directory: mtd/fs/jffs2
Precedence: first-class
Message-Id: <E1F7EPl-0007Vk-PT@phoenix.infradead.org>
From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 09 Feb 2006 16:13:01 +0000
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
	phoenix.infradead.org See http://www.infradead.org/rpr.html
Subject: mtd/fs/jffs2 scan.c,1.134,1.135
X-BeenThere: linux-mtd-cvs@lists.infradead.org
X-Mailman-Version: 2.1.5
List-Id: Linux MTD CVS commit list <linux-mtd-cvs.lists.infradead.org>
List-Unsubscribe: 	<http://lists.infradead.org/mailman/listinfo/linux-mtd-cvs>, 
	<mailto:linux-mtd-cvs-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd-cvs>
List-Post: <mailto:linux-mtd-cvs@lists.infradead.org>
List-Help: <mailto:linux-mtd-cvs-request@lists.infradead.org?subject=help>
List-Subscribe: 	<http://lists.infradead.org/mailman/listinfo/linux-mtd-cvs>,
	<mailto:linux-mtd-cvs-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-cvs-bounces@lists.infradead.org
Errors-To: 	linux-mtd-cvs-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
X-Evolution-Source: imap://dwmw2@pentafluge.infradead.org/
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Update of /home/cvs/mtd/fs/jffs2
In directory phoenix.infradead.org:/tmp/cvs-serv28853

Modified Files:
	scan.c 
Log Message:
Avoid divide-by-zero

Index: scan.c
===================================================================
RCS file: /home/cvs/mtd/fs/jffs2/scan.c,v
retrieving revision 1.134
retrieving revision 1.135
diff -u -r1.134 -r1.135
--- scan.c	13 Jan 2006 10:25:29 -0000	1.134
+++ scan.c	9 Feb 2006 16:12:59 -0000	1.135
@@ -239,7 +239,7 @@
 		c->nextblock->dirty_size = 0;
 	}
 #ifdef CONFIG_JFFS2_FS_WRITEBUFFER
-	if (!jffs2_can_mark_obsolete(c) && c->nextblock && (c->nextblock->free_size % c->wbuf_pagesize)) {
+	if (!jffs2_can_mark_obsolete(c) && c->wbuf_pagesize && c->nextblock && (c->nextblock->free_size % c->wbuf_pagesize)) {
 		/* If we're going to start writing into a block which already
 		   contains data, and the end of the data isn't page-aligned,
 		   skip a little and align it. */


__________________________________________________________
Linux-MTD CVS commit list
http://lists.infradead.org/mailman/listinfo/linux-mtd-cvs/

--=-sgMlzciEkC7tLPNC008j--

