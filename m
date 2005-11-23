Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbVKWTj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbVKWTj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbVKWTj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:39:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56036 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932242AbVKWTj1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:39:27 -0500
Date: Wed, 23 Nov 2005 11:38:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-Id: <20051123113854.07fca702.akpm@osdl.org>
In-Reply-To: <20051123175045.GA6760@stiffy.osknowledge.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	<20051123175045.GA6760@stiffy.osknowledge.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski <marc@osknowledge.org> wrote:
>
> * Andrew Morton <akpm@osdl.org> [2005-11-23 03:35:50 -0800]:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/
> > 
> > (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.15-rc2-mm1.gz)
> > 
> > - Added git-sym2.patch to the -mm lineup: updates to the sym2 scsi driver
> >   (Matthew Wilcox).  
> > 
> > - The JSM tty driver still doesn't compile.
> > 
> > - The git-powerpc tree is included now.
> 
> Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
> persists,

You'l probably need to re-report the mouse problem if the previous report
didn't get any action.

> moreover, some stuff's now really not gonna work anymore. I logged in
> via gdm once and rebooted. 

Yes, netfilter broke.

> ...
> Nov 23 18:34:01 stiffy kernel: 0.0: ttyS3 at I/O 0xe108 (irq = 3) is a 8250
> Nov 23 18:34:01 stiffy kernel: ip_conntrack version 2.4 (4095 buckets, 32760 max) - 212 bytes per conntrack
> Nov 23 18:34:01 stiffy kernel: ip_tables: (C) 2000-2002 Netfilter core team
> Nov 23 18:34:01 stiffy kernel:  [schedule+1453/1679] schedule+0x5ad/0x68f
> Nov 23 18:34:01 stiffy kernel:  [__wake_up_common+60/94] __wake_up_common+0x3c/0x5e
> Nov 23 18:34:01 stiffy kernel:  [wait_for_completion+134/242] wait_for_completion+0x86/0xf2
> Nov 23 18:34:01 stiffy kernel:  [default_wake_function+0/18] default_wake_function+0x0/0x12
> Nov 23 18:34:01 stiffy kernel:  [call_usermodehelper_keys+175/186] call_usermodehelper_keys+0xaf/0xba
> Nov 23 18:34:01 stiffy kernel:  [__call_usermodehelper+0/110] __call_usermodehelper+0x0/0x6e
> Nov 23 18:34:01 stiffy kernel:  [request_module+175/240] request_module+0xaf/0xf0
> Nov 23 18:34:01 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
> Nov 23 18:34:01 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
> Nov 23 18:34:01 stiffy kernel:  [pg0+553595222/1069659136] translate_table+0x95f/0xbcb [ip_tables]
> Nov 23 18:34:01 stiffy kernel:  [map_vm_area+109/149] map_vm_area+0x6d/0x95
> Nov 23 18:34:01 stiffy kernel:  [__vmalloc_area_node+246/362] __vmalloc_area_node+0xf6/0x16a
> Nov 23 18:34:01 stiffy kernel:  [__vmalloc_node+79/110] __vmalloc_node+0x4f/0x6e
> Nov 23 18:34:01 stiffy kernel:  [__vmalloc+39/43] __vmalloc+0x27/0x2b
> Nov 23 18:34:01 stiffy kernel:  [pg0+553597367/1069659136] do_replace+0x145/0x6d6 [ip_tables]
> Nov 23 18:34:03 stiffy kernel:  [pg0+553596209/1069659136] copy_entries_to_user+0xaf/0x1e3 [ip_tables]
> Nov 23 18:34:04 stiffy kernel:  [pg0+553599347/1069659136] do_ipt_set_ctl+0x1e/0x62 [ip_tables]
> Nov 23 18:34:04 stiffy kernel:  [nf_sockopt+198/277] nf_sockopt+0xc6/0x115
> Nov 23 18:34:04 stiffy kernel:  [nf_setsockopt+55/59] nf_setsockopt+0x37/0x3b
> Nov 23 18:34:04 stiffy kernel:  [ip_setsockopt+219/3448] ip_setsockopt+0xdb/0xd78
> Nov 23 18:34:04 stiffy kernel:  [nf_sockopt+136/277] nf_sockopt+0x88/0x115
> Nov 23 18:34:04 stiffy kernel:  [nf_getsockopt+55/59] nf_getsockopt+0x37/0x3b
> Nov 23 18:34:04 stiffy kernel:  [ip_getsockopt+254/1764] ip_getsockopt+0xfe/0x6e4
> Nov 23 18:34:04 stiffy kernel:  [prio_tree_remove+150/191] prio_tree_remove+0x96/0xbf
> Nov 23 18:34:04 stiffy kernel:  [free_pgtables+59/167] free_pgtables+0x3b/0xa7
> Nov 23 18:34:04 stiffy kernel:  [buffered_rmqueue+241/514] buffered_rmqueue+0xf1/0x202
> Nov 23 18:34:04 stiffy kernel:  [get_page_from_freelist+136/162] get_page_from_freelist+0x88/0xa2
> ...
