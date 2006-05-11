Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWEKPhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWEKPhD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 11:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWEKPhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 11:37:03 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20182 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030267AbWEKPhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 11:37:01 -0400
Subject: [PATCH 0/4] VFS fileop cleanups by collapsing AIO and vector IO
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, pbadari@us.ibm.com
In-Reply-To: <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com>
	 <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 11 May 2006 08:38:05 -0700
Message-Id: <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Thanks to Chuck Lever and Shaggy for tracking down the latest
set of issues. Big Thanks Christoph Hellwig for all his ideas
and suggestions.

I ran various testing including LTP on this series. Andrew,
can you include these in -mm tree ?

Thanks,
Badari


