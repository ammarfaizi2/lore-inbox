Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSJLNoc>; Sat, 12 Oct 2002 09:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSJLNoc>; Sat, 12 Oct 2002 09:44:32 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:64765 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261205AbSJLNob>; Sat, 12 Oct 2002 09:44:31 -0400
Date: Sat, 12 Oct 2002 09:50:19 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>,
       Stig Brautaset <stig@brautaset.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2.5.42: unresolved symbols ext2
Message-ID: <20021012095019.A18204@redhat.com>
References: <fa.j2ck6sv.162gurn@ifi.uio.no> <20021012104504.GA18928@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021012104504.GA18928@arwen.brautaset.org>; from stig@brautaset.org on Sat, Oct 12, 2002 at 11:45:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 11:45:04AM +0100, Stig Brautaset wrote:
> Oops, that was compiled with the debian make-kpkg tool. Here's the
> output from vanilla make modules_install:

Whoops, looks like I missed a couple of exports.  Please apply the patch 
below that adds exports for generic_file_aio_{read,write}.

		-ben

diff -urN v2.5.42/mm/filemap.c v2.5.42-syms/mm/filemap.c
--- v2.5.42/mm/filemap.c	Sat Oct 12 09:42:35 2002
+++ v2.5.42-syms/mm/filemap.c	Sat Oct 12 09:44:23 2002
@@ -893,6 +893,8 @@
 	return __generic_file_aio_read(iocb, &local_iov, 1, &iocb->ki_pos);
 }
 
+EXPORT_SYMBOL(generic_file_aio_read);
+
 ssize_t
 generic_file_read(struct file *filp, char *buf, size_t count, loff_t *ppos)
 {
@@ -1652,6 +1654,8 @@
 	return generic_file_write(iocb->ki_filp, buf, count, &iocb->ki_pos);
 }
 
+EXPORT_SYMBOL(generic_file_aio_write);
+
 ssize_t generic_file_write(struct file *file, const char *buf,
 			   size_t count, loff_t *ppos)
 {
