Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbUKYILl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbUKYILl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 03:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUKYIKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 03:10:37 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:36564 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263021AbUKYIKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 03:10:25 -0500
Date: Thu, 25 Nov 2004 08:51:22 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: unix@fi.muni.cz
Subject: AMD64: GPF in sys32_lstat64 call path
Message-ID: <20041125075122.GB3979@fi.muni.cz>
References: <20041125000203.GA30031@nymfe10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125000203.GA30031@nymfe10>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello, world!\n

	I've got the following GPF on my quad-opteron HP DL585.
The process in question was "save" from the Legato Networker
suite (i.e. 32-bit binary) doing nightly backup. The system
is pretty stock RHEL3, except that kernel has been upgraded
to 2.6.8.1. The server was almost idle at that time except for the
"save" Networker process. The server currently acts as NFS server.
Root FS is ext3, and there are three XFS volumes over LVM on an array
behind a Qlogic FC HBA. More information is available on request.

general protection fault: 0000 [1] SMP
CPU 1
Modules linked in: ide_cd cdrom
Pid: 23843, comm: save Not tainted 2.6.8.1
RIP: 0010:[<ffffffff80157d91>] <ffffffff80157d91>{cache_alloc_refill+289}
RSP: 0000:00000104d3b63cd8  EFLAGS: 00010082
RAX: 5e03d1f6c831e2ad RBX: 0000010200041280 RCX: 0000000000000006
RDX: 00000102000412a8 RSI: 00000102ffffff7f RDI: 000001015bf4d028
RBP: 00000102000412a8 R08: 0000010200034000 R09: 0000010200034010
R10: 00000102000412b8 R11: 00000102000412c8 R12: 00000000000000d0
R13: 00000104d3b63da8 R14: 00000104d3b63da8 R15: 00000104d3b63e68
FS:  00000000417ff970(0000) GS:ffffffff80542000(005b) knlGS:00000000556b7080
CR2: 0000002a9556f000 CR3: 00000000bffe0000 CR4: 00000000000006e0
Process save (pid: 23843, threadinfo 00000104d3b62000, task 000001067f43f4f0)
Stack: 000001011119c520 fffffffffffffff4 000001011119c520 ffffffff801580d6
       0000000000000212 ffffffff801892d1 00000104d3b63e68 000001011119c520
       fffffffffffffff4 000001042334cda0
Call Trace:<ffffffff801580d6>{kmem_cache_alloc+54} <ffffffff801892d1>{d_alloc+33}
       <ffffffff8017e5e9>{real_lookup+105} <ffffffff8017e929>{do_lookup+105}
       <ffffffff8017f383>{link_path_walk+2563} <ffffffff8017fc48>{path_lookup+456}
       <ffffffff8017fdfe>{__user_walk+62} <ffffffff8017a3b6>{vfs_lstat+38}
       <ffffffff80184660>{filldir64+0} <ffffffff8018bc28>{update_atime+136}
       <ffffffff8012110f>{sys32_lstat64+31} <ffffffff80120b81>{ia32_sysret+0}

Code: 48 89 50 08 48 89 02 66 83 7e 24 ff 48 c7 06 00 01 10 00 48
RIP <ffffffff80157d91>{cache_alloc_refill+289} RSP <00000104d3b63cd8>

	Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
