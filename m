Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261389AbSIWSab>; Mon, 23 Sep 2002 14:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261383AbSIWSaa>; Mon, 23 Sep 2002 14:30:30 -0400
Received: from packet.digeo.com ([12.110.80.53]:58504 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261389AbSIWS33>;
	Mon, 23 Sep 2002 14:29:29 -0400
Message-ID: <3D8F5DB2.A3E36E16@digeo.com>
Date: Mon, 23 Sep 2002 11:30:10 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <scole@lanl.gov>
CC: lkml <linux-kernel@vger.kernel.org>, netfilter-devel@lists.netfilter.org
Subject: Re: Sleeping function called from illegal context at slab.c:1378
References: <1032804558.28404.13.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 18:30:10.0003 (UTC) FILETIME=[3F841A30:01C2632F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's a bug in ip_fw_ctl().  It's calling convert_ipfw()
inside FWC_WRITE_LOCK_IRQ(&ip_fw_lock, flags);

But convert_ipfw() does kmalloc(GFP_KERNEL).


Steven Cole wrote:
> 
> Hi Andrew,
> 
> Are these traced warnings of any use to you?
> 
> If so, here is one.  This one was from
> 
> "Sleeping function called from illegal context at slab.c:1378"
> 
> on bootup of 2.5.38-mm2:
> 
> Trace; c0119986 <__might_sleep+56/5d>
> Trace; c0135166 <kmalloc+66/1f0>
> Trace; c0271e03 <convert_ipfw+63/130>
> Trace; c02721c0 <ip_fw_ctl+2f0/4d0>
> Trace; c026a023 <sock_fn+63/80>
> Trace; c012ff2e <find_get_page+2e/60>
> Trace; c0130db5 <filemap_nopage+115/310>
> Trace; c012d8ef <do_no_page+2ef/390>
> Trace; c012b5ba <pte_alloc_map+ea/150>
> Trace; c023471a <nf_sockopt+fa/150>
> Trace; c0234790 <nf_setsockopt+20/30>
> Trace; c0242fda <ip_setsockopt+74a/910>
> Trace; c02255de <sock_map_fd+be/120>
> Trace; c022562a <sock_map_fd+10a/120>
> Trace; c0263995 <inet_setsockopt+25/30>
> Trace; c02269d6 <sys_setsockopt+56/70>
> Trace; c0227026 <sys_socketcall+1a6/200>
> Trace; c0114ea0 <do_page_fault+0/436>
> Trace; c01099b1 <error_code+2d/38>
> Trace; c0108f6f <syscall_call+7/b>
> 
> Steven
