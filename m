Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUCIWh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUCIWh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:37:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:43444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262187AbUCIWh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:37:26 -0500
Date: Tue, 9 Mar 2004 14:39:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: MalteSch@gmx.de
Cc: Malte.Schroeder@hanse.net, linux-kernel@vger.kernel.org,
       Jaroslav Kysela <perex@suse.cz>
Subject: Re: [BUG] in generic.c, unloading alsa [Re: 2.6.4-rc2-mm1]
Message-Id: <20040309143922.567c05d3.akpm@osdl.org>
In-Reply-To: <200403092107.09881.Malte.Schroeder@hanse.net>
References: <20040307223221.0f2db02e.akpm@osdl.org>
	<200403092107.09881.Malte.Schroeder@hanse.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Malte Schröder <Malte.Schroeder@hanse.net> wrote:
>
> Hi, by trying to unload alsa (emu10k1) I get the following:
> 
> ------------[ cut here ]------------
> kernel BUG at fs/proc/generic.c:664!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c0187be9>]    Not tainted VLI
> EFLAGS: 00010286
> EIP is at remove_proc_entry+0xe9/0x140
> eax: f3209cc0   ebx: f3fb85f0   ecx: f63d2140   edx: f7fece00
> esi: 00000005   edi: f375a140   ebp: 00000000   esp: f42ffe70
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1835, threadinfo=f42fe000 task=f23b7150)
> Stack: f375a140 f375a188 f375a140 f3209dc0 f375a188 f9ada470 f375a240 00000080
>        f9acfa7b f375a188 f3fb85c0 f74abe00 f74abe00 f9acf5b1 f375a240 f3fb85c0
>        f42fe000 f9acddcf f74abe00 00000002 f22989c0 c0171bde f7ff7b2c f22989c0
> Call Trace:
>  [<f9acfa7b>] snd_info_unregister+0x3b/0x70 [snd]
>  [<f9acf5b1>] snd_info_card_free+0x31/0x60 [snd]
>  [<f9acddcf>] snd_card_free+0xef/0x230 [snd]
>  [<c0171bde>] destroy_inode+0x4e/0x50
>  [<c016fca2>] dput+0x22/0x270
>  [<f9b5e3a9>] snd_card_emu10k1_remove+0x19/0x30 [snd_emu10k1]
>  [<c01f1f8b>] pci_device_remove+0x3b/0x40

This means that the driver deleted a /proc directory while it still has
live subdirectories.  Arjan says this has been observed to lead to memory
corruption later on.


