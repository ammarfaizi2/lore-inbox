Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbTJSXDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 19:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJSXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 19:03:21 -0400
Received: from holomorphy.com ([66.224.33.161]:62851 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262330AbTJSXDT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 19:03:19 -0400
Date: Sun, 19 Oct 2003 16:02:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pedro Larroy <piotr@member.fsf.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-ID: <20031019230240.GE1215@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pedro Larroy <piotr@member.fsf.org>, linux-kernel@vger.kernel.org
References: <20031019205630.GA1153@81.38.200.176> <20031019210308.GC1215@holomorphy.com> <20031019222604.GA1140@81.38.200.176>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019222604.GA1140@81.38.200.176>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 12:26:04AM +0200, Pedro Larroy wrote:
> xmms          D C010E5A9     0  5975   1595                1597 (NOTLB)
> d8327ed0 00000082 cbf02560 c010e5a9 00000002 c7ea6000 c7ea6004 df8f9a2c 
>        df8e5869 0000433f 1f9dff47 00001244 d2d306a0 c16f7318 d2d306a0 00000246 
>        c16f7320 c0107f6f 00000001 d2d306a0 c011a4e5 cdfade2c c16f7320 4095b000 
> Call Trace:
>  [do_gettimeofday+25/134] do_gettimeofday+0x19/0x86
>  [__crc___ndelay+126735/403990] snd_pcm_trigger_tstamp+0x61/0x7e [snd_pcm]
>  [__down+113/188] __down+0x71/0xbc
>  [default_wake_function+0/46] default_wake_function+0x0/0x2e
>  [unmap_page_range+67/105] unmap_page_range+0x43/0x69
>  [__down_failed+8/12] __down_failed+0x8/0xc
>  [__crc___ndelay+143015/403990] .text.lock.pcm_native+0xb9/0xc8 [snd_pcm]
>  [__fput+221/239] __fput+0xdd/0xef
>  [unmap_vma+115/125] unmap_vma+0x73/0x7d
>  [unmap_vma_list+28/40] unmap_vma_list+0x1c/0x28
>  [do_munmap+301/367] do_munmap+0x12d/0x16f
>  [sys_munmap+68/100] sys_munmap+0x44/0x64
>  [syscall_call+7/11] syscall_call+0x7/0xb

Here we have .text.lock.pcm_native ...

On Mon, Oct 20, 2003 at 12:26:04AM +0200, Pedro Larroy wrote:
> mplayer       D 00000306     0  6016      1  6018    6028  1574 (NOTLB)
> cdfade18 00200082 c7f84a18 00000306 c03564f4 c1254c70 00000000 c7f8498c 
>        de7e4cc0 0001033e e7a80ee1 00001245 d5bb46a0 c16f7318 d5bb46a0 00200246 
>        c16f7320 c0107f6f 00000001 d5bb46a0 c011a4e5 c16f7320 d8327ee4 c7f84a18 
> Call Trace:
>  [__down+113/188] __down+0x71/0xbc
>  [default_wake_function+0/46] default_wake_function+0x0/0x2e
>  [__down_failed+8/12] __down_failed+0x8/0xc
>  [__crc_fs_overflowgid+311048/1150401] .text.lock.pcm_oss+0x2d/0xa1 [snd_pcm_oss]
>  [do_lookup+48/161] do_lookup+0x30/0xa1
>  [link_path_walk+1391/2011] link_path_walk+0x56f/0x7db
>  [default_wake_function+0/46] default_wake_function+0x0/0x2e
>  [vfs_follow_link+51/344] vfs_follow_link+0x33/0x158
>  [soundcore_open+195/394] soundcore_open+0xc3/0x18a
>  [soundcore_open+0/394] soundcore_open+0x0/0x18a
>  [chrdev_open+168/321] chrdev_open+0xa8/0x141
>  [devfs_open+165/189] devfs_open+0xa5/0xbd
>  [dentry_open+271/403] dentry_open+0x10f/0x193
>  [filp_open+98/100] filp_open+0x62/0x64
>  [sys_open+91/139] sys_open+0x5b/0x8b
>  [syscall_call+7/11] syscall_call+0x7/0xb

and .text.lock.pcm.oss ... you seem to have the same problem as Diego.


-- wli
