Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWFUWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWFUWBN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWFUWBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:01:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60307 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751316AbWFUWBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:01:11 -0400
Subject: [PATCH 0/3] VFS fileop cleanups by collapsing AIO and vector IO
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, pbadari@us.ibm.com
Content-Type: text/plain
Date: Wed, 21 Jun 2006 15:03:08 -0700
Message-Id: <1150927388.29759.4.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here the VFS cleanup patches to collapse vector and AIO fileop
methods + cleanups to filemap.c against 2.6.17.

These series of patches clean up and streamlines generic_file_*
interfaces in filemap.c.

BTW, I dropped adding vector-aio support (aio.c) patch for now
as it can be added later.

===
These patches collapses all the vectored IO support into 
single set of file-operation method using aio_read/aio_write.
Last patch (3) sets all thefilesystems .read/.write/.aio_read/
.aio_write methods correctly to allow us to cleanup most
generic_file_*_read/write interfaces in filemap.c

After this patch set, we should end up with ONLY following
read/write (exported) interfaces in filemap.c:

        generic_file_aio_read() - read handler
        generic_file_aio_write() - write handler
        generic_file_aio_write_nolock() - no lock write handler

Here is the summary:

[PATCH 1/3] Vectorize aio_read/aio_write fileop methods

[PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write
instead.

[PATCH 3/3] Streamline generic_file_* interfaces and filemap cleanups

Thanks,
Badari

