Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSIWUBN>; Mon, 23 Sep 2002 16:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261359AbSIWUBM>; Mon, 23 Sep 2002 16:01:12 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:54663 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S261327AbSIWT7C>; Mon, 23 Sep 2002 15:59:02 -0400
Subject: Re: Sleeping function called from illegal context at slab.c:1378
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3D8F5DB2.A3E36E16@digeo.com>
References: <1032804558.28404.13.camel@spc9.esa.lanl.gov> 
	<3D8F5DB2.A3E36E16@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Sep 2002 14:00:20 -0600
Message-Id: <1032811220.28332.24.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-23 at 12:30, Andrew Morton wrote:
> That's a bug in ip_fw_ctl().  It's calling convert_ipfw()
> inside FWC_WRITE_LOCK_IRQ(&ip_fw_lock, flags);
> 
> But convert_ipfw() does kmalloc(GFP_KERNEL).
> 
> 
> Steven Cole wrote:
> > 
> > Hi Andrew,
> > 
> > Are these traced warnings of any use to you?

I guess that traced warning was of interest, so here are two 
more from 2.5.38-mm2.

( I got a total of four warnings; the first was identical to that posted
by Grega Fajdiga here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103278825525479&w=2
and the fourth slabc:1378 warning was the one referred to above.)

Here is the second slabc:1378 warning traced with ksymoops:

Trace; c0119986 <__might_sleep+56/5d>
Trace; c0135166 <kmalloc+66/1f0>
Trace; c0120048 <__request_region+18/c0>
Trace; c0215ca2 <eata2x_detect+142/d60>
Trace; c02037a4 <ahc_linux_alloc_device+14/70>
Trace; c020298c <ahc_linux_queue+16c/1a0>
Trace; c0117c71 <schedule+351/3e0>
Trace; c01f1c6a <scsi_request_fn+13a/450>
Trace; c0117fe2 <wait_for_completion+b2/110>
Trace; c01f149d <scsi_queue_next_request+5d/140>
Trace; c01ea9da <scsi_release_command+13a/150>
Trace; c013432d <kmem_slab_destroy+dd/110>
Trace; c0134f07 <free_block+b7/120>
Trace; c013533a <kmem_cache_free+4a/80>
Trace; c01c7b43 <elevator_exit+13/20>
Trace; c01f3c06 <scan_scsis+96/a0>
Trace; c01ec218 <scsi_register_host+48/340>
Trace; c01b0133 <put_bus+13/57>
Trace; c01050b1 <init+51/1d0>
Trace; c0105060 <init+0/1d0>
Trace; c01070b9 <kernel_thread_helper+5/c>

Here is the third slabc:1378 warning traced with ksymoops:

Trace; c0119986 <__might_sleep+56/5d>
Trace; c0135166 <kmalloc+66/1f0>
Trace; c0271e03 <convert_ipfw+63/130>
Trace; c027216a <ip_fw_ctl+29a/4d0>
Trace; c017ab91 <ext3_reserve_inode_write+31/b0>
Trace; c026a023 <sock_fn+63/80>
Trace; c012ff2e <find_get_page+2e/60>
Trace; c0130db5 <filemap_nopage+115/310>
Trace; c012d8ef <do_no_page+2ef/390>
Trace; c012b5ba <pte_alloc_map+ea/150>
Trace; c023471a <nf_sockopt+fa/150>
Trace; c0234790 <nf_setsockopt+20/30>
Trace; c0242fda <ip_setsockopt+74a/910>
Trace; c02255de <sock_map_fd+be/120>
Trace; c022562a <sock_map_fd+10a/120>
Trace; c0263995 <inet_setsockopt+25/30>
Trace; c02269d6 <sys_setsockopt+56/70>
Trace; c0227026 <sys_socketcall+1a6/200>
Trace; c0114ea0 <do_page_fault+0/436>
Trace; c01099b1 <error_code+2d/38>
Trace; c0108f6f <syscall_call+7/b>

Steven

