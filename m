Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275212AbTHMOay (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHMOay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:30:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:405 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S275212AbTHMOax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:30:53 -0400
Date: Wed, 13 Aug 2003 15:32:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Con Kolivas <kernel@kolivas.org>
cc: Andrew Morton <akpm@osdl.org>,
       Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: 2.6.0-test3-mm2
In-Reply-To: <200308132302.26656.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.44.0308131529200.1558-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Con Kolivas wrote:
> Aug 13 22:54:58 pc kernel: kernel BUG at mm/filemap.c:1930!

akpm (have you caught a moment when he's asleep?!) already posted
the fix, saying it's a bogus BUG_ON which can be removed.

--- 2.6.0-test3-mm2/mm/filemap.c	Wed Aug 13 11:51:33 2003
+++ linux/mm/filemap.c	Wed Aug 13 15:26:36 2003
@@ -1927,8 +1927,6 @@ generic_file_aio_write_nolock(struct kio
 	ssize_t ret;
 	loff_t pos = *ppos;
 
-	BUG_ON(iocb->ki_pos != *ppos);
-
 	if (!iov->iov_base && !is_sync_kiocb(iocb)) {
 		/* nothing to transfer, may just need to sync data */
 		ret = iov->iov_len; /* vector AIO not supported yet */

