Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTI2Hyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTI2Hyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:54:46 -0400
Received: from web20002.mail.yahoo.com ([216.136.225.47]:26781 "HELO
	web20002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262884AbTI2Hyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:54:45 -0400
Message-ID: <20030929075444.73172.qmail@web20002.mail.yahoo.com>
Date: Mon, 29 Sep 2003 00:54:44 -0700 (PDT)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: NFS partial writes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, in nfs_writepage_sync in fs/nfs/write.c I see:

  result = NFS_PROTO(inode)->write(inode, cred,
&fattr, flags,
                                   offset, wsize,
page, &verf);

  if (result < 0) {
          /* Must mark the page invalid after I/O
error */
          ClearPageUptodate(page);
          goto io_error;
  }
  if (result != wsize)
          printk("NFS: short write, wsize=%u,
result=%d\n",
          wsize, result);
  refresh = 1;
  buffer  += wsize;
  base    += wsize;
  offset  += wsize;
  written += wsize;
  count   -= wsize;


Shouldn't buffer, base, offset, written, and count be
(inc|dec)remented by result instead of wsize?

This is with the latest CVS version of 2.5, but the
identical code is in Red Hat's 2.4.20-20.9.

-Kenny


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
