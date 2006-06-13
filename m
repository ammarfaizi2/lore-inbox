Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWFMXaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWFMXaQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWFMXaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:30:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:39892 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932341AbWFMXaN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:30:13 -0400
Subject: [PATCH 0/4] VFS fileop cleanups by collapsing AIO and vector IO
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, pbadari@us.ibm.com
Content-Type: text/plain
Date: Tue, 13 Jun 2006 16:32:00 -0700
Message-Id: <1150241520.28414.59.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is the updated set of patches for 2.6.17-rc6-mm2 with
autofs fixes. I made the series against latest -mm since, 
there are bunch of tweaks needed to suite -mm (xfs, ecryptfs, 
reiser4 etc). If you prefer against mainline (2.6.17-rc6) and 
want to merge yourself, let me know - I can post that set as well.

===========

These series of patches clean up and streamlines generic_file_*
interfaces in filemap.c.

First (3) patches collapses all the vectored IO support into
single set of file-operation method using aio_read/aio_write.
This work was originally suggested & started by Christoph Hellwig,
when Zach Brown tried to add vectored support for AIO.

Patch 4, sets all the filesystems .read/.write/.aio_read/.aio_write
methods correctly to allow us to cleanup most generic_file_*_read/write
interfaces in filemap.c

After this patch set, we should end up with ONLY following
read/write (exported) interfaces in filemap.c:

        generic_file_aio_read() - read handler
        generic_file_aio_write() - write handler
        generic_file_aio_write_nolock() - no lock write handler

Here is the summary:

[PATCH 1/4] Vectorize aio_read/aio_write methods

[PATCH 2/4] Remove readv/writev methods and use aio_read/aio_write
instead.

[PATCH 3/4] Core aio changes to support vectored AIO.

[PATCH 4/4] Streamline generic_file_* interfaces and filemap cleanups

BTW, Chuck Lever is actually re-arranging NFS DIO, AIO code to
fit into this model.


Thanks,
Badari

