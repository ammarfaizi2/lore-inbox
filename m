Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVBHX5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVBHX5s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 18:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVBHX5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 18:57:48 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:62940 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261684AbVBHX50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 18:57:26 -0500
Subject: 2.6.10 kprobes/jprobes panic
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: prasanna@in.ibm.com
Content-Type: text/plain
Organization: 
Message-Id: <1107907174.20053.52.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Feb 2005 15:59:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran into this while playing with jprobes in 2.6.10.

I tried to install jprobe handler on a invalid address,
I get OOPS. I was hoping for a error check and a graceful
exit rather than kernel Oops.

Thanks,
Badari


plant jprobe at 00000000c01836b0, handler addr ffffffffa0000080
Unable to handle kernel paging request at 00000000c01836b0 RIP:
<ffffffff8026e622>{__memcpy+114}
PML4 17d6cf067 PGD 0
Oops: 0000 [1] SMP
CPU 1
Modules linked in: diotest
Pid: 14225, comm: insmod Not tainted 2.6.10n
RIP: 0010:[<ffffffff8026e622>] <ffffffff8026e622>{__memcpy+114}
RSP: 0018:000001019b841d58  EFLAGS: 00010047
RAX: ffffff0000a70000 RBX: 00000101bfa44200 RCX: 0000000000000000
RDX: 000000000000000f RSI: 00000000c01836b0 RDI: ffffff0000a70000
RBP: ffffffffa00008e0 R08: 0000010180000000 R09: 0000000000000000
R10: 00000101bfa44218 R11: 0000000000000111 R12: 0000000000000216
R13: ffffffff804f1440 R14: 0000000000000020 R15: 0000000000000002
FS:  0000002a9588e6e0(0000) GS:ffffffff80628800(0000)
knlGS:0000000055970080
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000000c01836b0 CR3: 00000001a072c000 CR4: 00000000000006e0
Process insmod (pid: 14225, threadinfo 000001019b840000, task
00000101bf9394e0)
Stack: 00000101bfa44200 ffffffff8011edcc 0000000000000212
ffffffffa00008e0
       00000000ffffffef ffffffff80158542 ffffffff804f1480
ffffffffa0000940
       ffffffff804f1440 ffffffffa000005c
Call Trace:<ffffffff8011edcc>{arch_prepare_kprobe+300}
<ffffffff80158542>{register_kprobe+82}
       <ffffffffa000005c>{:diotest:init_dmods+44}
<ffffffff80150823>{sys_init_module+6387}
       <ffffffff8015e9c0>{__pagevec_free+32}
<ffffffff8016490e>{release_pages+382}
       <ffffffff8016d4e6>{do_munmap+918}
<ffffffff803ebb11>{__down_read+49}
       <ffffffff8026bc90>{__up_write+48}
<ffffffff8010e4ce>{system_call+126}
                                                                                                             
                                                                                                             
Code: 4c 8b 06 4c 89 07 48 8d 7f 08 48 8d 76 08 75 ee 89 d1 83 e1
RIP <ffffffff8026e622>{__memcpy+114} RSP <000001019b841d58>
CR2: 00000000c01836b0



