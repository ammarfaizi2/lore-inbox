Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWB0VTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWB0VTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWB0VTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:19:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:27275 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751752AbWB0VTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:19:19 -0500
Subject: [PATCH 0/4] map multiple blocks in get_block() and
	mpage_readpages()
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, pbadari@us.ibm.com
Content-Type: text/plain
Date: Mon, 27 Feb 2006 13:20:39 -0800
Message-Id: <1141075239.10542.19.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following patches add support to map multiple blocks in ->get_block().
This is will allow us to handle mapping of multiple disk blocks for
mpage_readpages() and mpage_writepages() etc. Instead of adding new
argument, I use "b_size" to indicate the amount of disk mapping needed
for get_block(). And also, on success get_block() actually indicates
the amount of disk mapping it did.

Now that get_block() can handle multiple blocks, there is no need
for ->get_blocks() which was added for DIO.

[PATCH 1/4] change buffer_head.b_size to size_t

[PATCH 2/4] pass b_size to ->get_block()

[PATCH 3/4] map multiple blocks for mpage_readpages()

[PATCH 4/4] remove ->get_blocks() support

I noticed decent improvements (reduced sys time) on JFS, XFS and ext3.
(on simple "dd" read tests).

         (rc3.mm1)      (rc3.mm1 + patches)
real    0m18.814s       0m18.482s
user    0m0.000s        0m0.004s
sys     0m3.240s        0m2.912s

Andrew, Could you include it in -mm tree ?

Comments ?

Thanks,
Badari


