Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbUBMGbZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 01:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUBMGbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 01:31:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:32968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266780AbUBMGbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 01:31:24 -0500
Date: Thu, 12 Feb 2004 22:31:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: lepton <lepton@mail.goldenhope.com.cn>
Cc: linux-kernel@vger.kernel.org, Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: [BUG]kmalloc memory in reiserfs code failed on a dual amd64/4G
 linux 2.6.2 box
Message-Id: <20040212223139.61c3c349.akpm@osdl.org>
In-Reply-To: <20040213031653.GA25623@lepton.goldenhope.com.cn>
References: <20040213031653.GA25623@lepton.goldenhope.com.cn>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lepton <lepton@mail.goldenhope.com.cn> wrote:
>
>  I seen such dmesg in mu dual amd64/4G memory box.
> 
>  I am running kernel 2.6.2
> 
>  This is the second time I saw some problems about __alloc_pages on this
>  amd 64 box...
> 
> 
>  sort: page allocation failure. order:1, mode:0x20
> 
>  Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
>         <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
>         <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
>         <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
>         <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff801bd6a8>{pathrelse+40} 
>         <ffffffff801a834b>{reiserfs_create+171} <ffffffff8017690c>{vfs_create+140} 
>         <ffffffff80176ca8>{open_namei+424} <ffffffff801675a7>{filp_open+39} 
>         <ffffffff801210a8>{sys32_open+56} <ffffffff8011e25e>{ia32_do_syscall+30}

Nikita, why cannot get_mem_for_virtual_node() use GFP_KERNEL?
