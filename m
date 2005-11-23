Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbVKWWTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbVKWWTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbVKWWTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:19:01 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:4992 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932581AbVKWWTA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:19:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bGoBm+PHBGkERW8DGqNdStvQlIDfZcv9poS4viII0f0iL/xnk+QhtWoLzFOPi8ad8JJw+rD9a1MRMO9tiYQ5jbxsoigNfxRKcW5LITwcZJN9BDA6zOYMuzs/fyo2jtLozzuYaEJr0SSMQ47weSwtlanfvzQ2IyWNCpx+re0ceD0=
Message-ID: <ef5305790511231418v6be0ff19g2af4855b890a3626@mail.gmail.com>
Date: Thu, 24 Nov 2005 11:18:59 +1300
From: Goo GGooo <googgooo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:221
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Yesterday one of our highly loaded servers suddenly started reporting
the following kernel bugs:

 kernel BUG at page_alloc.c:221!
invalid operand: 0000
CPU:    0
EIP:    0010:[rmqueue+135/576]    Not tainted
EFLAGS: 00010006
eax: 00038000   ebx: c13a1350   ecx: 00001000   edx: 55568b11
esi: c03704d0   edi: 00000000   ebp: c0370498   esp: ef4c3e50
ds: 0018   es: 0018   ss: 0018
Process cleanup-mgr (pid: 28856, stackpage=ef4c3000)
Stack: e7504f00 ea23f980 000285df 00000286 00000000 c0370498 c0370498 c0370670
       00000002 c03703c0 c01323db 0000000d f73dda20 f73dda2e 00000000 ef4c3f84
       c0370570 c0370668 00000000 000001d2 c01434d3 00104025 00000025 cfb8b180
Call Trace:    [__alloc_pages+107/640] [link_path_walk+1363/1680]
[do_anonymous_page+94/272] [handle_mm_fault+119/256]
[do_page_fault+392/1277]
  [get_empty_filp+76/288] [dentry_open+205/464] [file_ioctl+106/384]
[sys_llseek+173/192] [do_page_fault+0/1277] [error_code+52/60]

Code: 0f 0b dd 00 fb 07 32 c0 8b 53 04 89 dd 8b 03 89 50 04 89 02

 kernel BUG at page_alloc.c:221!
invalid operand: 0000
CPU:    0
EIP:    0010:[rmqueue+135/576]    Not tainted
EFLAGS: 00010006
eax: 00038000   ebx: c13a1350   ecx: 00001000   edx: 55568b11
esi: c03704d0   edi: 00000000   ebp: c0370498   esp: c6b39e50
ds: 0018   es: 0018   ss: 0018
Process cleanup-run (pid: 28887, stackpage=c6b39000)
Stack: 00000000 c0370498 000088b4 00000286 00000000 c0370498 c0370498 c0370670
       00000002 c03703c0 c01323db 0000006d f7df8890 000000f9 f73ddd00 f73dddb4
       c0370570 c0370668 00000000 000001d2 e3b212d4 00104025 00000025 f7616180
Call Trace:    [__alloc_pages+107/640] [do_anonymous_page+94/272]
[handle_mm_fault+119/256] [do_page_fault+392/1277]
[do_mmap_pgoff+1154/1440]
  [old_mmap+212/272] [do_page_fault+0/1277] [error_code+52/60]

Code: 0f 0b dd 00 fb 07 32 c0 8b 53 04 89 dd 8b 03 89 50 04 89 02

The cleanup-mgr process is invoked from cron every 5 minutes and every
time it died. I had to reboot the machine to resume its normal
operation.

As it appeared suddenly and haven't returned after reboot I'm quite
worried about hardware problem - is that possible?

And yeah, it's a custom build 2.4.26 on one of those machines that
you'd better not touch (or, God forbid, upgrade anything!) as long as
they run at least somehow.

Does anyone have any idea what could have caused this bug?

Thx Goo
