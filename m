Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbTIQMA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTIQMAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:00:25 -0400
Received: from mta07ps.bigpond.com ([144.135.25.132]:22745 "EHLO
	mta07ps.bigpond.com") by vger.kernel.org with ESMTP id S262737AbTIQMAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:00:24 -0400
Date: Wed, 17 Sep 2003 22:02:03 +1000
From: Srihari Vijayaraghavan <harisri@bigpond.com>
Subject: [PROBLEM] Ext3 error messages on 2.4.23-pre4
To: lkml <linux-kernel@vger.kernel.org>
Message-id: <200309172202.03577.harisri@bigpond.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just after remounting /tmp as read-only, this error message appeared in the 
kernel log:
Sep 17 20:59:32 laptop kernel: EXT3-fs error (device ide0(3,10)) in 
start_transaction: Readonly filesystem
Sep 17 20:59:32 laptop kernel: EXT3-fs error (device ide0(3,10)) in 
ext3_delete_inode: Readonly filesystem

When I tried to mount it read-write a little later, this error message 
appeared:
Sep 17 21:08:18 laptop kernel: EXT3-fs warning: mounting fs with errors, 
running e2fsck is recommended
Sep 17 21:08:18 laptop kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,10), internal journal

I ran e2fsck on /dev/hda10 (the /tmp fs), it found some problem (inode fixed?) 
and fixed it.

It's like EXT3 forgotten to write some data back to the file system when I 
mounted it read-only :-), but remembered about it straight after mounting the 
file system read-only.

I'm still trying to reproduce the error messages, but I had no luck so far 
(both in 2.4.22-aa1 and in 2.4.23-pre4).

The file system is mounted with these options: noatime,defaults

Thank you
Hari
harisri@bigpond.com

