Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262170AbUEFNhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbUEFNhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUEFNev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:34:51 -0400
Received: from exeter.wrl.org ([209.96.177.100]:41600 "EHLO franklin.wrl.org")
	by vger.kernel.org with ESMTP id S262176AbUEFNZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:25:03 -0400
Date: Thu, 6 May 2004 09:25:03 -0400 (EDT)
From: Brett Charbeneau <brett@wrl.org>
To: linux-kernel@vger.kernel.org
Subject: Invalid operand - eek!
Message-ID: <Pine.LNX.4.44.0405060909420.1034-100000@franklin.wrl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gentlefolk,

	I've received the following BUG on a RH 7.2 box with the staple 
2.4.20-27.7 RPM. It's got 2 GB of RAM with a swap partition that same 
size (althought the kernel doesn't have HIGHMEM compiled in).
	I run a cron job which tar's an entire filesystem on 
one SCSI drive and puts that on another - this is when the BUG popped up.
	It wasn't a completely lock up, but I couldn't get the partitions 
to unmount becuase the tar job was chewing away - or at least it thought 
it was.
	I've scoured the list archives and can't find anything relevant.
	I'd be grateful for any hints about what is going wrong!
	Many thanks in advance.

-- 

Brett Charbeneau, Network Administrator         Tel: 757-259-7750
Williamsburg Regional Library                   FAX: 757-259-7798
7770 Croaker Road                               brettNOSPAM@wrl.org
Williamsburg, VA 23188-7064                     http://www.wrl.org


------------[ cut here ]------------
kernel BUG at filemap.c:146!
invalid operand: 0000
iptable_filter ip_tables 3c59x ide-scsi ide-cd sr_mod cdrom nls_iso8859-1 
nls_cp437 vfat fat aic7xxx sd_mod scsi_mod  
CPU:    0
EIP:    0010:[<c01276a6>]    Not tainted
EFLAGS: 00010206

EIP is at add_page_to_hash_queue [kernel] 0x1e (2.4.20-27.7)
eax: 00040000   ebx: c127b674   ecx: c125a418   edx: f7f2b244
esi: 00000001   edi: 00003226   ebp: f7f2b244   esp: c42d7e94
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 31608, stackpage=c42d7000)
Stack: c125a418 c0128038 d891b388 c125a418 00003226 f7f2b244 c01280d6 
c125a418
       d891b388 00003226 f7f2b244 ec575660 ec575660 00000016 00003210 
000031f2
       c0128877 0000001f 00000020 0000b3d7 c15c0f38 00000001 f7f2b174 
c15c0f38
Call Trace:   [<c0128038>] add_to_page_cache_unique [kernel] 0x8c 
(0xc42d7e98))
[<c01280d6>] page_cache_read [kernel] 0x8a (0xc42d7eac))
[<c0128877>] generic_file_readahead [kernel] 0x113 (0xc42d7ed4))
[<c0128ada>] do_generic_file_read [kernel] 0x1c6 (0xc42d7efc))
[<c0140f04>] pipe_wait [kernel] 0x74 (0xc42d7f24))
[<c012907d>] generic_file_read [kernel] 0x9d (0xc42d7f44))
[<c0128f5c>] file_read_actor [kernel] 0x0 (0xc42d7f54))
[<c01394ad>] sys_read [kernel] 0x95 (0xc42d7f7c))
[<c01099d0>] do_IRQ [kernel] 0xb8 (0xc42d7fa0))
[<c0108583>] system_call [kernel] 0x33 (0xc42d7fc0))


Code: 0f 0b 92 00 b3 3e 23 c0 ff 05 20 1b 2e c0 5b c3 89 f6 56 53

