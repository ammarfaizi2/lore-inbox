Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVJGGBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVJGGBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 02:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbVJGGBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 02:01:45 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:42925 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751016AbVJGGBo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 02:01:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L2soR7F8SsH6pxCirEUu7po/Mdc0gBoJBn0KmSXgjDXIPEAE4xhPo5r546jlYk9SvGiFTAmFa/0rqKI6WmxobqOQ/HGvrB2nAgQ9CAFeLq8JPpBwFrwY3vScFkanEtGi6mXrrWX9RaX8AglvB2fxDFIhmyadJW7BMLmpwoxCj2c=
Message-ID: <64c763540510062301v2ac65a47p953038b8b674cf1d@mail.gmail.com>
Date: Fri, 7 Oct 2005 11:31:43 +0530
From: Block Device <blockdevice@gmail.com>
Reply-To: Block Device <blockdevice@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Block I/O Mystery
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I am trying to write to inode blocks without using the VFS layer
(filp_open, f_op->write)
    etc.
    I could use __bread to read the inode blocks correctly. But when I'm
    trying to write a block after changing it I face a strange problem.
    My changes do not show up when I cat the file but if I use dd command on
   the block device it shows my writes.

   Steps I performed :

   a) Created a file of 8K ( 2blocks ) and filled it with 'a'.
   b) Read the blocks using __bread and print(k)ed the contents.
       This worked correctly.
   c) Called __getblk for a file block, locked the buffer, made
changes to it (memcpy),
       marked buffer dirty, unlocked it and called sync_dirty_buffer.
   d) If I try to see contents of the file ( cat or vi ) they are
shown unchanged, but if I
       use dd on the raw device or use step b) to read a block the
changes made @ c)
      are seen.

 Also, if I unmount the filesystem and mount it again the changes are
visible through cat, vi etc.

Can someone explain what exactly is going wrong ?

I'm using the 2.6.13 kernel.

Thanks & Regards
-BD
