Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUEXBX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUEXBX4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 21:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUEXBX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 21:23:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14498 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263775AbUEXBXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 21:23:54 -0400
Date: Sun, 23 May 2004 18:23:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: malte.d@gmx.net
Subject: [Bug 2761] New: NFS -- kernel BUG at	include/linux/dcache.h:276
Message-ID: <323590000.1085361827@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2761

           Summary: NFS -- kernel BUG at include/linux/dcache.h:276
    Kernel Version: 2.6.6-bk7
            Status: NEW
          Severity: normal
             Owner: trond.myklebust@fys.uio.no
         Submitter: malte.d@gmx.net


Distribution: Slackware 8.0/8.1
Hardware Environment: Duron 1.2Ghz 
Software Environment: nfs server via usbnet (zaurus)
Problem Description: I changed one export in /etc/export from ro to rw, after
running /etc/rc.d/rc.nfsd restart, it hung and displayed the following error

 ------------[ cut here ]------------
kernel BUG at include/linux/dcache.h:276!
invalid operand: 0000 [#8]
PREEMPT 
Modules linked in: usbnet usb_storage sym53c8xx scsi_transport_spi tdfx
CPU:    0
EIP:    0060:[<c01bdaba>]    Not tainted
EFLAGS: 00010246   (2.6.6-bk7) 
EIP is at nfsd_acceptable+0x3a/0x100
eax: 00000000   ebx: 00000002   ecx: c7a8f63c   edx: c7a8f63c
esi: cf1dbee4   edi: c40cb894   ebp: c40cb894   esp: cf1dbc7c
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 16751, threadinfo=cf1da000 task=cf376bd0)
Stack: 00000002 cf1dbee4 c40cb894 00000002 c01bb566 c40cb894 c7a8f63c 00000002 
       cf1dbee4 cfe4ec00 00000002 00000000 00000000 00000000 c0409388 ffffff8c 
       00000000 c7a8f63c cf1dbd14 c8150680 c0311c67 cf635a40 000005fb 00000000 
Call Trace:
 [<c01bb566>] find_exported_dentry+0xa6/0x6a0
 [<c0311c67>] ip_append_data+0x2e7/0x6e0
 [<c032d886>] udp_sendmsg+0x556/0x630
 [<c02f99d5>] release_sock+0x65/0x70
 [<c032d8be>] udp_sendmsg+0x58e/0x630
 [<c0334ad1>] inet_sendmsg+0x41/0x50
 [<c02f66c3>] sock_sendmsg+0x83/0xa0
 [<c0334ad1>] inet_sendmsg+0x41/0x50
 [<c02f66c3>] sock_sendmsg+0x83/0xa0
 [<c02f9559>] sock_no_sendpage+0x89/0xa0
 [<c032da2d>] udp_sendpage+0xcd/0x120
 [<c012199b>] groups_free+0x3b/0x50
 [<c01bbe96>] export_decode_fh+0x66/0x6e
 [<c01bda80>] nfsd_acceptable+0x0/0x100
 [<c01bdf14>] fh_verify+0x394/0x550
 [<c01bda80>] nfsd_acceptable+0x0/0x100
 [<c01bcd9c>] nfsd_proc_getattr+0x6c/0x80
 [<c01bc4f1>] nfsd_dispatch+0xe1/0x1a0
 [<c035656b>] svc_process+0x37b/0x600
 [<c01bc295>] nfsd+0x1f5/0x370
 [<c01bc0a0>] nfsd+0x0/0x370
 [<c0103265>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 14 01 d9 db 38 c0 ff 02 89 d7 3b 7d 20 0f 84 91 00 00


