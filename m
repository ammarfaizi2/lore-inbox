Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbSLRUlu>; Wed, 18 Dec 2002 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267352AbSLRUlu>; Wed, 18 Dec 2002 15:41:50 -0500
Received: from [213.171.53.133] ([213.171.53.133]:14603 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S267351AbSLRUlt>;
	Wed, 18 Dec 2002 15:41:49 -0500
Date: Wed, 18 Dec 2002 23:49:45 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Richard A Nelson <cowboy@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52 PNP failure
In-Reply-To: <Pine.LNX.4.51.0212171730020.7058@nqynaqf.yrkvatgba.voz.pbz>
Message-ID: <Pine.BSF.4.05.10212182341570.25928-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Richard A Nelson wrote:

> 
> Hand transcribed, so probably missing something important ...
> 
> Oops: 0000
> Eip:  0060:[<c01cdbf3>] Not tainted
> EIP is at compare_pnp_id+0x4f/0x78
> Call Trace:
> [<c01cfa43>] pnp_name_device+0x23/0x58
> [<c01cd9af>] __pnp_add_device+0xf/0xc8
> [<c01cdab4>] pnp_add_device+0x4c/0x54
> [<c010509b>] init+0x33/0x188
> [<c0105068>] init+0x0/0x188
> [<c0109211>] kernel_thread_helper+0x5/0xc
> 
> <0>Kernel panic: Attempted to kill init!
> 
Try this small patch. I think it'll help.
--- drivers/pnp/driver.c~       2002-12-20 02:15:30.000000000 +0300
+++ drivers/pnp/driver.c        2002-12-20 02:24:53.000000000 +0300
@@ -165,6 +165,7 @@
        if (!dev)
                return -EINVAL;
        ptr = dev->id;
+       id->next = NULL;
        while (ptr && ptr->next)
                ptr = ptr->next;
        if (ptr)
--
			Ruslan.

