Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbREHS2k>; Tue, 8 May 2001 14:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133088AbREHS2V>; Tue, 8 May 2001 14:28:21 -0400
Received: from gardeny.udl.es ([193.144.12.130]:49413 "EHLO marraco.udl.es")
	by vger.kernel.org with ESMTP id <S132958AbREHS2M>;
	Tue, 8 May 2001 14:28:12 -0400
Date: Tue, 8 May 2001 20:28:03 +0200 (MET DST)
From: fermin@eup.udl.es (Fermin Molina)
Message-Id: <200105081828.UAA16365@eup.udl.es>
To: linux-kernel@vger.kernel.org
Subject: nfsd from kernel 2.4.4 oops
X-Sun-Charset: US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using kernel 2.4.4 cvs from SGI, with xfs. I'm getting this Oops:

kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000010
kernel:  printing eip:
kernel: c017bfd8
kernel: *pde = 00000000
kernel: Oops: 0000
kernel: CPU:    0
kernel: EIP:    0010:[nfsd_findparent+120/236]
kernel: EIP:    0010:[<c017bfd8>]
kernel: EFLAGS: 00010246
kernel: eax: 00000000   ebx: 00000000   ecx: cff8d458   edx: 00000010
kernel: esi: cb22c6a0   edi: cb22c720   ebp: cb22c720   esp: ce4c9e54
kernel: ds: 0018   es: 0018   ss: 0018
kernel: Process nfsd (pid: 592, stackpage=ce4c9000)
kernel: Stack: 00000000 1802280f c017c416 cb22c720 00000000 ce4cf814 11270000 ce4cf804
kernel:        c03c5740 cfe3b5c8 0000000e ffffff8c 00000000 c017c7c4 cfe3b400 1802280f
kernel:        00000000 00000000 00000001 ce4cf804 00000008 cb1fc77c ce4cfc00 ceb7b000
kernel: Call Trace: [find_fh_dentry+598/928] [fh_verify+612/1128] [nfsd_lookup+110/1368] [nfsd3_proc_lookup+314/332] [nfs3svc_decode_diropargs+152/268] [nfsd_dispatch+203/360] [svc_process+684/1348]
kernel: Call Trace: [<c017c416>] [<c017c7c4>] [<c017cdde>] [<c0182cbe>] [<c018498c>] [<c017a663>] [<c02df688>]


It's produced very randomly. Some people (readed in xfs list) get similar error and
tested too with a clean 2.4.4 with ext2 filesystem, and oops too. I think this is
related to nfsd code (maybe sunrpc code), and it's not related to xfs code.

Always is produced in nfsd_findparent function. I enabled kdb support and I always
see the same stack trace, same order on functions calls.

Client machines mount exports from this server (an i386 with SMP enabled, 2 processors),
and both 3 and 2 nfs protocol version are used.

Some hint? Someone else gets similar oops?

How can I enable some debugging in nfsd & sunrpc stuff to try to see what is happen?

Thanx!

/Fermin

fermin@eup.udl.es
