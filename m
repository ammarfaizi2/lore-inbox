Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUGPRee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUGPRee (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266617AbUGPRee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:34:34 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:46540 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266616AbUGPRea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:34:30 -0400
Date: Fri, 16 Jul 2004 13:37:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops while shutting down (2.6.8rc1)
In-Reply-To: <200407161011.36677.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.58.0407161331090.26950@montezuma.fsmlabs.com>
References: <200407161011.36677.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004, Mark Watts wrote:

> Unable to handle kernel paging requested:
> at virtual address d0967287
> printing eip:
> *pde = 0fe43067
> *pte = 00000000
> Oops: 0000 [#1]
> PREEMPT
> Modules linked in: sg st sr_mod sd_mod scsi_mod ide_cd cdrom i830 ipv6
> i810_audio ac97_codec soundcore af_packet usbhid floppy airo_cs ds airo
> pcmcia_core d
> CPU:    0
> EIP:    0060:[<d0967287>]    Not tainted
> EFLAGS: 00010296   (2.6.8-rc1)
> EIP is at 0xd0967287
> eax: 00000000   ebx: 00375140   ecx: 00000008   edx: 00000001
> esi: c1265cf8   edi: 00374366   ebp: c1265c00   esp: c03adfb4
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c03ac000 task=c032ca40)
> Stack: 00425007 d0967167 0000007b c03a007b 00000000 c03ac000 0009fb00 c03da120
>        00425007 c01040dd 00000006 c03ae7cf c032ca40 00000000 c03d3774 00000018
>        c03ae380 c03db580 c010019f
> Call Trace:
>  [<c01040dd>] cpu_idle+0x2d/0x40
>  [<c03ae7cf>] start_kernel+0x18f/0x1d0
>  [<c03ae380>] unknown_bootoption+0x0/0x170
> Code:  Bad EIP value.
> <0>Kernel panic: Attempted to kill the idle task!
> In idle task - not syncing

One of those driver modules probably has a function in the cleanup routine
path unloaded/unmapped. Doing a cat /proc/modules before shutting down and
taking copying the output would help speed up the search.

