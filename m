Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVA0ViY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVA0ViY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVA0ViY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:38:24 -0500
Received: from agminet02.oracle.com ([141.146.126.229]:21172 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S261230AbVA0Vh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:37:57 -0500
Message-ID: <41F95F32.8000103@oracle.com>
Date: Thu, 27 Jan 2005 13:37:54 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: __getblk() spinning when size != bdev->...i_blkbits
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recently I debugged something that was spinning in the for(;;) in
__getblk_slow().  It turned out it was calling __getblk() with a size
argument that didn't match the bdev's inode's i_blkbits.

grow_buffers() would add a page at the index calculated from the 4k size
argument but when __getblk_slow() got back around to looking for the
instantiated page __find_get_block_slow() would look at the index
calculated from the 1k i_blkbits and not find the new page.  Round and
round she goes.

If the different size inputs are intentional, would a simple BUG_ON() be
acceptible so that we can tell straight away if the caller messed up?

- z
