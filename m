Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266917AbUBMK5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266918AbUBMK5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:57:38 -0500
Received: from [217.73.129.129] ([217.73.129.129]:42377 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S266917AbUBMK5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:57:35 -0500
Date: Fri, 13 Feb 2004 12:57:22 +0200
Message-Id: <200402131057.i1DAvMUO159511@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [BUG]kmalloc memory in reiserfs code failed on a dual amd64/4G linux 2.6.2 box
To: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040213031653.GA25623@lepton.goldenhope.com.cn> <20040212223139.61c3c349.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Andrew Morton <akpm@osdl.org> wrote:
>>  sort: page allocation failure. order:1, mode:0x20
AM> Nikita, why cannot get_mem_for_virtual_node() use GFP_KERNEL?

Well, I am not Nikita, but this comment appears at the place:
        /* get memory for virtual item */
        buf = reiserfs_kmalloc(size, GFP_ATOMIC, tb->tb_sb);
        if ( ! buf ) {
            /* getting memory with GFP_KERNEL priority may involve
               balancing now (due to indirect_to_direct conversion on
               dcache shrinking). So, release path and collected
               resources here */
            free_buffers_in_tb (tb);
            buf = reiserfs_kmalloc(size, GFP_NOFS, tb->tb_sb);
..

This should answer your question, I guess.

Bye,
    Oleg
