Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWEUMDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWEUMDi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWEUMDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:03:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWEUMDh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:03:37 -0400
Date: Sun, 21 May 2006 05:03:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Haar =?ISO-8859-1?B?SuFub3M=?= <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Message-Id: <20060521050326.3bbbdf3a.akpm@osdl.org>
In-Reply-To: <00e901c67cad$fe9a9d90$1800a8c0@dcccs>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haar János <djani22@netcenter.hu> wrote:
>
> I seriously gets this, and dont know why.
>  This server have 2GB ram, and ~1.1G always free!
>  Anybody have an idea?
> 
>  Thanks,
>  Janos
> 
>  May 21 09:05:35 st-0003 kernel: swapper: page allocation failure. order:0,
>  mode:0x20
>  May 21 09:05:35 st-0003 kernel:  <c013c6ac> __alloc_pages+0x274/0x286
>  <c014af1d> cache_alloc_refill+0x2a6/0x45c
>  May 21 09:05:35 st-0003 kernel:  <c014b12b> __kmalloc+0x58/0x61   <c03d5bfc>
>  __alloc_skb+0x49/0xf5
>  May 21 09:05:35 st-0003 kernel:  <f88336b1>
>  e1000_alloc_rx_buffers+0x5c/0x2e5 [e1000]   <f88315de>

e1000 gobbled up all your lowmem memory from interrupt context.

Increasing /proc/sys/vm/min_free_kbytes will help.
