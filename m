Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbVA0EDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbVA0EDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 23:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVA0EDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 23:03:04 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:5846 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262433AbVA0EDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 23:03:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 27 Jan 2005 15:02:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16888.26607.936790.611539@cse.unsw.edu.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix large allocation in nfsd init
In-Reply-To: message from Anton Blanchard on Thursday January 27
References: <20050127033104.GA26367@krispykreme.ozlabs.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday January 27, anton@samba.org wrote:
> 
> Hi,
> 
> I just added an NFS mount to a ppc64 box that had been up for a while.
> This required inserting the nfsd module. Unfortunately it failed:  
> 
> modprobe: page allocation failure. order:5, mode:0xd0
> Trace:
> [c0000000000ba0f8] alloc_pages_current+0xc0/0xe4
> [c0000000000941fc] __get_free_pages+0x54/0x1e0
> [d00000000046f7d8] nfsd_cache_init+0x54/0x1a4 [nfsd]
> [d0000000004782cc] init_nfsd+0x30/0x2564 [nfsd]
> [c000000000084bec] sys_init_module+0x23c/0x5ac
> [c00000000001045c] ret_from_syscall_1+0x0/0xa4
> nfsd: cannot allocate 98304 bytes for reply cache
> 
> An order 5 allocation. Replace it with a vmalloc.

Given that the purpose of this order-5 allocation is to provide
storage for 1024 "struct svc_cacherep" structs, it would seem that a
better approach would be to just do 1024 kmallocs.

I'll try to knock a patch together in next week sometime.

Thanks,

NeilBrown
