Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUBMDRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 22:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266700AbUBMDRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 22:17:39 -0500
Received: from [220.249.10.10] ([220.249.10.10]:4546 "EHLO
	mail.goldenhope.com.cn") by vger.kernel.org with ESMTP
	id S266695AbUBMDRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 22:17:34 -0500
Date: Fri, 13 Feb 2004 11:16:53 +0800
From: lepton <lepton@mail.goldenhope.com.cn>
To: linux-kernel@vger.kernel.org
Subject: [BUG]kmalloc memory in reiserfs code failed on a dual amd64/4G linux 2.6.2 box
Message-ID: <20040213031653.GA25623@lepton.goldenhope.com.cn>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seen such dmesg in mu dual amd64/4G memory box.

I am running kernel 2.6.2

This is the second time I saw some problems about __alloc_pages on this
amd 64 box...


sort: page allocation failure. order:1, mode:0x20

Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
       <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
       <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
       <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
       <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff801bd6a8>{pathrelse+40} 
       <ffffffff801a834b>{reiserfs_create+171} <ffffffff8017690c>{vfs_create+140} 
       <ffffffff80176ca8>{open_namei+424} <ffffffff801675a7>{filp_open+39} 
       <ffffffff801210a8>{sys32_open+56} <ffffffff8011e25e>{ia32_do_syscall+30} 
       
sort: page allocation failure. order:1, mode:0x20

Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
       <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
       <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
       <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
       <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff801bd6a8>{pathrelse+40} 
       <ffffffff801a834b>{reiserfs_create+171} <ffffffff8017690c>{vfs_create+140} 
       <ffffffff80176ca8>{open_namei+424} <ffffffff801675a7>{filp_open+39} 
       <ffffffff801210a8>{sys32_open+56} <ffffffff8011e25e>{ia32_do_syscall+30} 
       
sort: page allocation failure. order:1, mode:0x20

Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
       <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
       <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
       <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
       <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff801bd6a8>{pathrelse+40} 
       <ffffffff801a834b>{reiserfs_create+171} <ffffffff8017690c>{vfs_create+140} 
       <ffffffff80176ca8>{open_namei+424} <ffffffff801675a7>{filp_open+39} 
       <ffffffff801210a8>{sys32_open+56} <ffffffff8011e25e>{ia32_do_syscall+30} 
       
sort: page allocation failure. order:1, mode:0x20

Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
       <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
       <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
       <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
       <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff801bd6a8>{pathrelse+40} 
       <ffffffff801a834b>{reiserfs_create+171} <ffffffff8017690c>{vfs_create+140} 
       <ffffffff80176ca8>{open_namei+424} <ffffffff801675a7>{filp_open+39} 
       <ffffffff801210a8>{sys32_open+56} <ffffffff8011e25e>{ia32_do_syscall+30} 
       
sort: page allocation failure. order:1, mode:0x20

Call Trace:<ffffffff8014e5f0>{__alloc_pages+816} <ffffffff8014e65e>{__get_free_pages+78} 
       <ffffffff80151921>{cache_grow+177} <ffffffff80151e78>{cache_alloc_refill+440} 
       <ffffffff801521c6>{__kmalloc+102} <ffffffff801b44f6>{get_mem_for_virtual_node+102} 
       <ffffffff801b49a8>{fix_nodes+232} <ffffffff801c08c5>{reiserfs_insert_item+149} 
       <ffffffff801acf2c>{reiserfs_new_inode+892} <ffffffff8014e2a5>{buffered_rmqueue+325} 
       <ffffffff801bd6a8>{pathrelse+40} <ffffffff801a834b>{reiserfs_create+171} 
       <ffffffff8017690c>{vfs_create+140} <ffffffff80176ca8>{open_namei+424} 
       <ffffffff801675a7>{filp_open+39} <ffffffff801210a8>{sys32_open+56} 
       <ffffffff8011e25e>{ia32_do_syscall+30} 
