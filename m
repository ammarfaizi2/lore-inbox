Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbTIZRHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 13:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTIZRHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 13:07:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:4545 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261566AbTIZRHG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 13:07:06 -0400
Subject: slab corruption on AIO 2.6.0-test5-mm4
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>, Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064596018.1950.10.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Sep 2003 10:06:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While testing AIO on 2.6.0-test5-mm4 using ext3 file system,
I hung my system.  Unfortunately, I did not have sysrq enabled.
I rebooted with sysrq and debug enabled.   I hit this slab corruption
message:

Slab corruption: start=cc45df20, expend=cc45dfef, problemat=cc45df58
Last user: [<c0193136>](__aio_put_req+0xa8/0x1b1)
Data: ********************************************************00 00 01
00 00 00
Next: 71 F0 2C .36 31 19 C0 00 00 00 00 00 00 00 00 00 01 10 00 00 02 20
00 00
slab error in check_poison_obj(): cache `kiocb': object was modified
after freegCall Trace:
 [<c014e1f9>] check_poison_obj+0x106/0x18f
 [<c0192c52>] __aio_get_req+0x27/0x180
 [<c0150439>] kmem_cache_alloc+0x192/0x1e4
 [<c0192c52>] __aio_get_req+0x27/0x180
 [<c01947cd>] io_submit_one+0xb7/0x2d3
 [<c0194ac6>] sys_io_submit+0xdd/0x143
 [<c03c40b3>] syscall_call+0x7/0xb

I am still testing and will send more email when I get more info.

Daniel

