Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbVKCWDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbVKCWDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbVKCWDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:03:48 -0500
Received: from pat.uio.no ([129.240.130.16]:15820 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751190AbVKCWDr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:03:47 -0500
Subject: Re: Failure: ARM clps7500
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20051103095840.GA28038@flint.arm.linux.org.uk>
References: <20051103095840.GA28038@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 17:03:39 -0500
Message-Id: <1131055419.14985.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.707, required 12,
	autolearn=disabled, AWL 1.29, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 09:58 +0000, Russell King wrote:
> This default configuration (arch/arm/configs/clps7500_defconfig) fails
> to build:
> 
>   LD      .tmp_vmlinux1
> net/built-in.o: In function `xs_bindresvport':
> stats.c:(.text+0x54654): undefined reference to `xprt_min_resvport'
> stats.c:(.text+0x54658): undefined reference to `xprt_max_resvport'
> net/built-in.o: In function `xs_setup_tcp':
> stats.c:(.text+0x54bcc): undefined reference to `xprt_tcp_slot_table_entries'
> stats.c:(.text+0x54bd0): undefined reference to `xprt_max_resvport'
> net/built-in.o: In function `xs_setup_udp':
> stats.c:(.text+0x54d34): undefined reference to `xprt_udp_slot_table_entries'
> stats.c:(.text+0x54d38): undefined reference to `xprt_max_resvport'
> make: *** [.tmp_vmlinux1] Error 1
> 
> Maybe related to CONFIG_SYSCTL=n ?

The following patch should fix it:

http://client.linux-nfs.org/Linux-2.6.x/2.6.14/linux-2.6.14-96-fix_rpc_nosysctl.dif

and this one ought to get rid of all those "unused variable" warnings:

http://client.linux-nfs.org/Linux-2.6.x/2.6.14/linux-2.6.14-97-fix_printk_nosysctl.dif

Cheers,
  Trond

