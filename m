Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWHYPgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWHYPgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWHYPgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:36:08 -0400
Received: from gherkin.frus.com ([192.158.254.49]:41745 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S1030258AbWHYPgF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:36:05 -0400
Subject: [BUG] 2.6.18-rc4 oops while running "find"
To: linux-kernel@vger.kernel.org
Date: Fri, 25 Aug 2006 10:36:03 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060825153603.88D61DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone care to try their luck at decoding an Alpha oops?

A bit of context might be helpful.  The oops happened during the daily
"updatedb" run by cron, and the "find" command is currently hung in an
unkillable state (ignores "kill -9").  System is a DEC Alpha PWS 433au,
and has been up for 17 days as I type this.  The 2.6.18-rc4 kernel was
built locally from the standard kernel.org sources.  Here's the "oops"
output from "dmesg":

 Linux version 2.6.18-rc4 (root@smirkin) (gcc version 4.0.4 20060507 (prerelease) (Debian 4.0.3-3)) #1 Mon Aug 7 23:15:09 CDT 2006
 (...)
 Unable to handle kernel paging request at virtual address 0000000000000010
 find(20377): Oops 0
 pc = [<fffffc0000316278>]  ra = [<fffffc000031d874>]  ps = 0007    Not tainted
 pc is at process_mcheck_info+0x58/0x330
 ra is at cia_machine_check+0x94/0xb0
 v0 = 0000000000000004  t0 = 0000000000000630  t1 = 0000000000000660
 t2 = 0000000000000000  t3 = 0000000000000000  t4 = 0000000000000010
 t5 = 000000000009097e  t6 = 0000000000000009  t7 = fffffc00081e8000
 s0 = 0000000000000000  s1 = fffffc00081ebaa0  s2 = fffffc0000b4d5f0
 s3 = fffffc0000b4d5f0  s4 = fffffc000fdccf18  s5 = fffffc00081ebca8
 s6 = fffffc000fdccfd8
 a0 = fffffc00005cb500  a1 = fffffc00005c75ba  a2 = fffffc00081ebaa0
 a3 = fffffc0000396f24  a4 = 0000000000000000  a5 = 0000000000000000
 t8 = 0000000000000000  t9 = 000002000010bd54  t10= 0000000000000080
 t11= 0000000000002000  pv = fffffc0000316220  at = 0000000000001fff
 gp = fffffc00006eb500  sp = fffffc00081eba60
 Trace:
 [<fffffc000031d874>] cia_machine_check+0x94/0xb0
 [<fffffc00003d4d9c>] ext3_lookup+0x5c/0x1a0
 [<fffffc00003161d4>] do_entInt+0x134/0x180
 [<fffffc0000311280>] ret_from_sys_call+0x0/0x10
 [<fffffc000039874c>] iget_locked+0xbc/0x190
 [<fffffc0000403b20>] dummy_inode_alloc_security+0x0/0x10
 [<fffffc0000396f24>] find_inode_fast+0x24/0x90
 [<fffffc0000398734>] iget_locked+0xa4/0x190
 [<fffffc00003d4e10>] ext3_lookup+0xd0/0x1a0
 [<fffffc000038aa34>] do_lookup+0x224/0x270
 [<fffffc000038b4b8>] __link_path_walk+0x5d8/0x8a0
 [<fffffc000038b808>] link_path_walk+0x88/0x1a0
 [<fffffc000038bdb8>] do_path_lookup+0xb8/0x2c0
 [<fffffc0000387844>] pipe_write+0x24/0x30
 [<fffffc000038cd4c>] __user_walk_fd+0x5c/0xa0
 [<fffffc000038368c>] vfs_lstat_fd+0x2c/0x80
 [<fffffc0000383b88>] sys_newlstat+0x28/0x50
 [<fffffc0000387844>] pipe_write+0x24/0x30
 [<fffffc0000311264>] entSys+0xa4/0xc0
 
 Code: 383dfa61  23de0020  6bfa8001  2ffe0000  a67200c0  261dffee <a2890010> a77dbc98 

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
