Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVA1DTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVA1DTx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 22:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVA1DTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 22:19:53 -0500
Received: from mproxy.gmail.com ([216.239.56.242]:40920 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261425AbVA1DTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 22:19:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=a+NLibNJA8s0vf6hEzO+WQrb5rG8oKsU3aIVcSn4XuR+TEEtrL59ektNfSaI6sHZd2gCGgDOVffenuuass60MZ9NVdKfeYtrNsfg7uoOrdamZTCpm6DyzwBgSsTX7vrpFLU3251dx7QVYMgw6PlcPYrTpq+L1APz3PBHz3mpNsM=
Message-ID: <21d7e99705012719198f7659d@mail.gmail.com>
Date: Fri, 28 Jan 2005 14:19:29 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: James Lamanna <jlamanna@gmail.com>
Subject: Re: Kernel OOPS with i915 DRM Driver - 2.6.10
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aa4c40ff0501271800184390d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <aa4c40ff0501271800184390d7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

your .config can't match that kernel...

all the debugging is from the i830 drm module, so somehow that is
getting loaded at some stage... if you are using X 6.8.0 you need the
i915 (like the config has...)

you might have an i830 module somewhere on your system that is getting loaded..

Dave.

> drm:i830_dma_initialize] *ERROR* can not find dma buffer map!
> [drm:i830_irq_emit] *ERROR* i830_irq_emit called without lock held
> Unable to handle kernel paging request at virtual address f000e829
>  printing eip:
> c02793c1
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in:
> CPU:    1
> EIP:    0060:[<c02793c1>]    Not tainted VLI
> EFLAGS: 00013296   (2.6.10-gentoo-r6)
> EIP is at i830_kernel_lost_context+0x11/0x70
> eax: f000e819   ebx: 00000000   ecx: 0000000c   edx: 00003282
> esi: c05a99a0   edi: 00000000   ebp: 00000000   esp: db26fecc
> ds: 007b   es: 007b   ss: 0068
> Process X (pid: 8049, threadinfo=db26f000 task=de4d3020)
> Stack: 00000000 c027b4a7 c05a99a0 00003282 c01270d7 c027bed0 c05a99a0 c027bedf
>        c05a99a0 c0274fd4 c05a99a0 c05aa0d8 c05aa0e0 00000000 00000000 00000000
>        00000000 00000001 0000000a 00000000 de4d3020 c01187e0 00000000 00000000
> Call Trace:
>  [<c027b4a7>] i830_dma_quiescent+0x17/0xb0
>  [<c01270d7>] block_all_signals+0x37/0x80
>  [<c027bed0>] i830_driver_dma_quiescent+0x0/0x20
>  [<c027bedf>] i830_driver_dma_quiescent+0xf/0x20
>  [<c0274fd4>] i830_lock+0x264/0x310
>  [<c01187e0>] default_wake_function+0x0/0x20
>  [<c01187e0>] default_wake_function+0x0/0x20
>  [<c01744a3>] dput+0x33/0x1d0
>  [<c0274cf5>] i830_ioctl+0xe5/0x160
>  [<c015d879>] fget+0x49/0x60
>  [<c016f5da>] sys_ioctl+0xca/0x230
>  [<c01031af>] syscall_call+0x7/0xb
> Code: b9 8b 53 0c 01 d0 89 43 1c e9 60 ff ff ff 8d b6 00 00 00 00 8d
> bf 00 00 00 00 53 8b 44 24 08 8b 98 34 07 00 00 8b 43 04 8d 4b 0c <8b>
> 40 10 8b 90 34 20 00 00 81 e2 fc ff 1f 00 89 51 14 8b 43 04
> 
> # CONFIG_AGP_EFFICEON is not set
> CONFIG_DRM=y
> # CONFIG_DRM_TDFX is not set
> # CONFIG_DRM_R128 is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_I810 is not set
> # CONFIG_DRM_I830 is not set
> CONFIG_DRM_I915=y
