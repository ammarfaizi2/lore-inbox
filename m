Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWFBTFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWFBTFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWFBTFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:05:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:53481 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751433AbWFBTFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:05:03 -0400
Subject: [PATCH 0/4] VFS fileop cleanups by collapsing AIO and vector IO
	(2.6.17-rc5-mm2)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, hch@lst.de, pbadari@us.ibm.com,
       Zach Brown <zach.brown@oracle.com>, cel@citi.umich.edu
Content-Type: text/plain
Date: Fri, 02 Jun 2006 12:06:33 -0700
Message-Id: <1149275193.26170.8.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Here is the updated set of patches for 2.6.17-rc5-mm2 with
autofs fixes. Ian and I verified with autofs tests and also
running on Fedora Core 5. I made the series against latest
-mm since, there are bunch of tweaks needed to suite -mm
(I didn't want to put you through the pain of doing it yourself).
If you prefer against mainline (2.6.17-rc5), let me know -
I can post that set as well.

Hopefully, 18th time is the charm :)

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

