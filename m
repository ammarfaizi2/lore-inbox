Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWBBQLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWBBQLu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWBBQLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:11:50 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:47797 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932096AbWBBQLt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:11:49 -0500
Subject: [PATCH 0/3] VFS changes to collapse all the vectored and AIO
	support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       Zach Brown <zach.brown@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, pbadari@us.ibm.com
Content-Type: text/plain
Date: Thu, 02 Feb 2006 08:12:38 -0800
Message-Id: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This work was originally suggested & started by Christoph Hellwig, 
when Zack Brown tried to add vectored support for AIO. These series
of changes collapses all the vectored IO support into single
file-operation method using aio_read/aio_write. 

Christoph & Zack, comments/suggestions ? If you are happy with the
work, can you add your Sign-off or Ack ?

Here is the summary:

[PATCH 1/3] Vectorize aio_read/aio_write methods

[PATCH 2/3] Remove readv/writev methods and use aio_read/aio_write
instead.

[PATCH 3/3] Zack's core aio changes to support vectored AIO.

To Do/Issues:

1) Since aio_read/aio_write are vectorized now, need to modify
nfs AIO+DIO and usb/gadget to handle vectors. Is it needed ?
For now, it handles only single vector. Christoph, should I
loop over all the vectors ?

2) AIO changes need careful review & could be cleaned up further.
Zack, can you take a look at those ?

3) Ben's suggestion of kernel iovec to hold precomputed information
(like total iolen) instead of computing every time.

Thanks,
Badari

