Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbVKRMfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbVKRMfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 07:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbVKRMfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 07:35:37 -0500
Received: from postel.suug.ch ([195.134.158.23]:43482 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S1161105AbVKRMfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 07:35:36 -0500
Date: Fri, 18 Nov 2005 13:35:57 +0100
From: Thomas Graf <tgraf@suug.ch>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: yanzheng@21cn.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [DEBUG INFO]IPv6: sleeping function called from invalid context.
Message-ID: <20051118123557.GD20395@postel.suug.ch>
References: <437D23EB.4020204@21cn.com> <20051118.094721.49574151.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118.094721.49574151.yoshfuji@linux-ipv6.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* YOSHIFUJI Hideaki / ?$B5HF#1QL@ <yoshfuji@linux-ipv6.org> 2005-11-18 09:47
> In article <437D23EB.4020204@21cn.com> (at Fri, 18 Nov 2005 08:44:27 +0800), Yan Zheng <yanzheng@21cn.com> says:
> 
> > I get follow message when switch to single user mode and the kernel version is 2.6.15-rc1-git5.
> :
> > Nov 18 08:26:23 localhost kernel: Debug: sleeping function called from invalid context at mm/slab.c:2472
> > Nov 18 08:26:23 localhost kernel: in_atomic():1, irqs_disabled():0
> > Nov 18 08:26:23 localhost kernel:  [<c0149d5a>] kmem_cache_alloc+0x5a/0x70
> > Nov 18 08:26:23 localhost kernel:  [<e0f47336>] inet6_dump_fib+0xb6/0x110 [ipv6]
> 
> I remember someone replaced GFP_ATOMIC with GFP_KERNEL...

I did. I think it was right, why would an allocation be necessary on
the second call to inet6_dump_fib()? The walker allocated in process
context on the first call should be reused from cb->args[0].
