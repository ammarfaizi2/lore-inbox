Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUCPXoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbUCPXoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:44:03 -0500
Received: from gatekeeper.intransa.com ([12.146.157.2]:61361 "EHLO
	E2K3-CLUS-01.intransa.com") by vger.kernel.org with ESMTP
	id S261830AbUCPXmQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:42:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: EXT3 FS Assertion failure in journal_forget_R50b6d8df() at transaction.c:1259
Date: Tue, 16 Mar 2004 15:41:10 -0800
Message-ID: <68C08EF22187944DAF11634CB353DB6804DD0C@E2K3-CLUS-01.intransa.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EXT3 FS Assertion failure in journal_forget_R50b6d8df() at transaction.c:1259
Thread-Index: AcQLrNIiMch/jCuvT2KYNe86YjTKOQAATDPXAAA0uaA=
From: "David Erickson" <david.erickson@intransa.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Running Redhat kernel 2.4.22-1.2115.nptl, I see the following for ext3 filesystems (iSCSI) on the initial mount after installing this kernel:

Assertion failure in journal_forget_R50b6d8df() at transaction.c:1259: "!jh->b_committed_data"
------------[ cut here ]------------
kernel BUG at transaction.c:1259!
invalid operand: 0000
nfs lockd sunrpc sr_mod st sd_mod iscsi_mod ide-cd cdrom i810_audio ac97_codec soundcore parport_pc lp parport autofs e1000 natsemi floppy sg scsi_mod microco
CPU:    0
EIP:    0060:[<c88107fd>]    Not tainted
EFLAGS: 00010282

EIP is at journal_forget_R50b6d8df [jbd] 0x1cd (2.4.22-1.2115.nptl)
eax: 00000062   ebx: c3931e00   ecx: 00000001   edx: c7a0a000
esi: c6c37ba0   edi: c13e57f4   ebp: c13e5780   esp: c7a0bd14
ds: 0068   es: 0068   ss: 0068
Process rm (pid: 22161, stackpage=c7a0b000)
Stack: c8817520 c8816ecd c8816d30 000004eb c8816ee6 c6511900 00008008 c664cb00 
       c7c4d240 c7c4d240 c8820767 c7c4d240 c3931e00 c0cfdc80 c880fbf4 c7c4d240 
       c6c37bd0 6746300a 00008008 00008008 c7987020 c7a0a000 c8822c59 c7c4d240 
Call Trace:   [<c8817520>] .rodata.str1.32 [jbd] 0x40 (0xc7a0bd14)
[<c8816ecd>] .rodata.str1.1 [jbd] 0x1ad (0xc7a0bd18)
[<c8816d30>] .rodata.str1.1 [jbd] 0x10 (0xc7a0bd1c)
[<c8816ee6>] .rodata.str1.1 [jbd] 0x1c6 (0xc7a0bd24)
[<c8820767>] ext3_forget [ext3] 0x67 (0xc7a0bd3c)
[<c880fbf4>] do_get_write_access [jbd] 0x2b4 (0xc7a0bd4c)
[<c8822c59>] ext3_clear_blocks [ext3] 0x119 (0xc7a0bd6c)
[<c880ff35>] journal_get_write_access_R452be5c8 [jbd] 0x55 (0xc7a0bd94)
[<c8822db7>] ext3_free_data [ext3] 0xa7 (0xc7a0bdb4)
[<c01474e9>] getblk [kernel] 0x59 (0xc7a0bde0)
[<c8823135>] ext3_free_branches [ext3] 0x275 (0xc7a0be0c)
[<c01474e9>] getblk [kernel] 0x59 (0xc7a0be24)
[<c0147790>] bread [kernel] 0x20 (0xc7a0be48)
[<c8822f83>] ext3_free_branches [ext3] 0xc3 (0xc7a0be5c)
[<c88208ec>] start_transaction [ext3] 0x8c (0xc7a0be94)
[<c8823528>] ext3_truncate [ext3] 0x3d8 (0xc7a0beac)
[<c880f23a>] start_this_handle [jbd] 0x9a (0xc7a0bec8)
[<c880f425>] journal_start_R6a1abfe6 [jbd] 0xa5 (0xc7a0bef4)
[<c88208ec>] start_transaction [ext3] 0x8c (0xc7a0bf18)
[<c8820a8f>] ext3_delete_inode [ext3] 0x10f (0xc7a0bf30)
[<c882664d>] ext3_unlink [ext3] 0x10d (0xc7a0bf38)
[<c8820980>] ext3_delete_inode [ext3] 0x0 (0xc7a0bf44)
[<c015c146>] iput [kernel] 0x116 (0xc7a0bf4c)
[<c0152851>] vfs_unlink [kernel] 0xf1 (0xc7a0bf68)
[<c0152a97>] sys_unlink [kernel] 0x117 (0xc7a0bf84)
[<c0109b9f>] system_call [kernel] 0x33 (0xc7a0bfc0)


Code: 0f 0b eb 04 30 6d 81 c8 e9 51 ff ff ff c7 44 24 10 fc 6e 81 
