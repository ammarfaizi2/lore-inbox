Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUHSU4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUHSU4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 16:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUHSU4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 16:56:42 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44946 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267387AbUHSUzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 16:55:47 -0400
Date: Thu, 19 Aug 2004 13:55:19 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: umount -f /nfsmount hangs
Message-ID: <261360000.1092948919@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFS server has gone away, was mounted soft, intr:

bvrgsa.ibm.com:/gsa/bvrgsa on /bvrgsa type nfs (rw,soft,intr,nfsvers=2,tcp,rsize=8192,wsize=8192,timeo=30,addr=9.47.56.70)

but umount -f just hangs ... surely that's not the intended behaviour?
from Alt+SysRq+t:

 umount        S 7FFFFFFF     0 11303  11284                     (NOTLB)
 c30d7e64 00000082 c35782c0 7fffffff c30d6000 002f961e c292cb50 c35785bc 
        0016115b 53a40609 000279b2 c35782c0 c292cb50 c292cd00 c30d7ec0 c031f1c4 
        c35782c0 c30d7ec0 46382f09 c35784a8 c3578408 00000247 c35782c0 c02d0c21 
 Call Trace:
  [schedule_timeout+20/176] schedule_timeout+0x14/0xb0
  [release_sock+81/84] release_sock+0x51/0x54
  [inet_wait_for_connect+136/224] inet_wait_for_connect+0x88/0xe0
  [autoremove_wake_function+0/68] autoremove_wake_function+0x0/0x44
  [autoremove_wake_function+0/68] autoremove_wake_function+0x0/0x44
  [inet_stream_connect+229/384] inet_stream_connect+0xe5/0x180
  [sys_connect+99/128] sys_connect+0x63/0x80
  [do_page_fault+0/1211] do_page_fault+0x0/0x4bb
  [copy_from_user+48/88] copy_from_user+0x30/0x58
  [sys_socketcall+148/520] sys_socketcall+0x94/0x208
  [error_code+45/64] error_code+0x2d/0x40
  [syscall_call+7/11] syscall_call+0x7/0xb

