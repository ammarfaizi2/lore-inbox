Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbTJaB2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTJaB2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:28:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:32965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262574AbTJaB2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:28:08 -0500
Subject: Update AIO tests
From: Daniel McNeil <daniel@osdl.org>
To: linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1067563684.19328.43.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Oct 2003 17:28:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started updating my AIO tests to be a bit cleaner and added code
to dirty some free blocks before the test.  I also added options
to set readsize, writesize, filesize and number of async i/o.
I have update dio_sparse.c and aiodio_sparse.c, and I will be updating
the rest tomorrow.  The test also stops immediately if it see
bad (non-zero) data by the readers.

I've run dio_sparse and aiodio_sparse on test9 on ext3 on my 2-proc:

$ dio_sparse
non zero buffer at buf[0] => 0xaa,aa,aa,aa
non-zero read at offset 69533696

$ aiodio_sparse
non zero buffer at buf[0] => 0xaa,aa,aa,aa
non-zero read at offset 81854464

With slab debug on, test9 still gets

slab error in check_poison_obj(): cache `kiocb': object was modified after freeing

I'll be testing test9-mm1 tomorrow and let you know what I see.

Daniel

