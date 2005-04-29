Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVD2LFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVD2LFW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVD2LFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:05:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:4279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262285AbVD2LE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:04:58 -0400
Date: Fri, 29 Apr 2005 04:04:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS oops with 2.6.12-rc2-mm3
Message-Id: <20050429040415.4c49fbef.akpm@osdl.org>
In-Reply-To: <42698E24.9060005@g-house.de>
References: <42698E24.9060005@g-house.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <evil@g-house.de> wrote:
>
> upon unmounting some NFSv3 shares, the following oops happened and i could
>  not remount any nfs shares after this:
> 
>  lockd: cannot unmonitor 192.168.10.10
>  Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
>  00000000
>  *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT
>  Modules linked in: pdc202xx_old snd_ens1371 snd_rawmidi snd_ac97_codec
>  usbmouse usbkbd uhci_hcd via82cxxx via_agp agpgart usbcore autofs4
>  snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd soundcore
>  ide_cd cdrom ide_disk ide_core
>  CPU:    0
>  EIP:    0060:[<00000000>]    Not tainted VLI
>  EFLAGS: 00010286   (2.6.12-rc2-mm3)
>  EIP is at 0x0
>  eax: c1617ec0   ebx: c1617ec0   ecx: 00000000   edx: c1771a50
>  esi: 00000000   edi: c1617f34   ebp: df0fee40   esp: dec6ff2c
>  ds: 007b   es: 007b   ss: 0068
>  Process rpciod/0 (pid: 8166, threadinfo=dec6f000 task=c1771a50)
>  Stack: c03976db c1771a50 c1771b78 00000296 c1617f3c 00000293 c1617f40 c012a0ae
>         00000000 00000000 dffc6550 dec6f000 df0fee58 df0fee48 df0fee50 dec6f000
>         c1617ec0 c0397810 dec6f000 ffffffff ffffffff 00000001 00000000 c0116ac0
>  Call Trace:
>   [<c03976db>] __rpc_execute+0x14b/0x250
>   [<c012a0ae>] worker_thread+0x1ae/0x280
>   [<c0397810>] rpc_async_schedule+0x0/0x10
>   [<c0116ac0>] default_wake_function+0x0/0x10
>   [<c0116b07>] __wake_up_common+0x37/0x60
>   [<c0116ac0>] default_wake_function+0x0/0x10
>   [<c0129f00>] worker_thread+0x0/0x280
>   [<c012e3a5>] kthread+0x95/0xd0
>   [<c012e310>] kthread+0x0/0xd0
>   [<c010132d>] kernel_thread_helper+0x5/0x18
>  Code:  Bad EIP value.
> 
> 
>  i rarely use -mm kernels so i don't have much experience yet. some more
>  details are here: http://nerdbynature.de/bits/prinz/2.6.12-rc2-mm3/

If this is at all repeatable, please enable CONFIG_DEBUG_SLAB, see if we
get some more info.

