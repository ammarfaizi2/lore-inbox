Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266787AbUHDFTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266787AbUHDFTl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 01:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267253AbUHDFTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 01:19:41 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:16096 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266787AbUHDFTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 01:19:39 -0400
Date: Wed, 4 Aug 2004 01:23:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MTRR driver model support broken on SMP.
In-Reply-To: <1091585241.3303.6.camel@laptop.cunninghams>
Message-ID: <Pine.LNX.4.58.0408040119270.19619@montezuma.fsmlabs.com>
References: <1091585241.3303.6.camel@laptop.cunninghams>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Nigel Cunningham wrote:

> MTRR driver support is broken on SMP because it calls smp functions with
> interrupts disabled, but interrupts should be disabled because it is
> called via device_power_up.
>
> Badness in smp_call_function at arch/i386/kernel/smp.c:565
>  [<c0107f88>] dump_stack+0x1e/0x20
>  [<c0116927>] smp_call_function+0x12b/0x137
>  [<c011063f>] set_mtrr+0x67/0x121
>  [<c0110c9b>] mtrr_restore+0x4f/0x73
>  [<c0219c0f>] sysdev_resume+0x6f/0xf0
>  [<c021d591>] device_power_up+0x8/0xf

Looking at this i'm really curious as to whether we need to bother at all,
can you remove the mtrr restore code and then compare /proc/mtrr before
and after suspending.
