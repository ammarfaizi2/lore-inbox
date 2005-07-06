Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262554AbVGFWba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262554AbVGFWba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVGFW20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:28:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262576AbVGFW01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:26:27 -0400
Date: Wed, 6 Jul 2005 15:27:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Message-Id: <20050706152724.7645dd61.akpm@osdl.org>
In-Reply-To: <a44ae5cd05070301417531fac2@mail.gmail.com>
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> wrote:
>
> mtrr: base(0xe8020000) is not aligned on a size(0x3c0000) boundary
> [drm:drm_unlock] *ERROR* Process 4470 using kernel context 0
> mtrr: 0xe8000000,0x8000000 overlaps existing 0xe8000000,0x1000000
> Unable to handle kernel paging request at virtual address 5f78735f
>  printing eip:
> c01abbf9
> *pde = 00000000
> Oops: 0002 [#1]
> PREEMPT
> Modules linked in: pcmcia container ipv6 af_packet ohci1394
> yenta_socket rsrc_nonstatic pcmcia_core ipw2200 ieee80211
> ieee80211_crypt 8139too mii snd_intel8x0 snd_ac97_codec snd_pcm_oss
> snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd
> uhci_hcd usbcore rtc nls_cp437 sbp2 scsi_mod ieee1394 psmouse ide_cd
> cdrom
> CPU:    0
> EIP:    0060:[<c01abbf9>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.13-rc1-mm1)
> EIP is at sysfs_release+0x49/0xb0
> eax: 5f78725f   ebx: 5f78725f   ecx: 00000001   edx: f7662000
> esi: c19520a4   edi: f70b8a80   ebp: f7663f3c   esp: f7663f2c
> ds: 007b   es: 007b   ss: 0068
> Process hald (pid: 4736, threadinfo=f7662000 task=f7c97a80)
> Stack: c19520a4 00000010 f70d2d80 f7703174 f7663f68 c0169a5a f7703174 f70d2d80
>        00000000 00000000 c1894180 f7715c8c f70d2d80 c1bcd900 00000000 f7663f78
>        c016985a f70d2d80 f70d2d80 f7663f94 c0167dcb f70d2d80 c1bcd900 00000010
> Call Trace:
>  [<c010415f>] show_stack+0x7f/0xa0
>  [<c0104314>] show_registers+0x164/0x1d0
>  [<c010452d>] die+0xed/0x180
>  [<c0119314>] do_page_fault+0x344/0x68d
>  [<c0103d6f>] error_code+0x4f/0x54
>  [<c0169a5a>] __fput+0x1da/0x1f0
>  [<c016985a>] fput+0x2a/0x50
>  [<c0167dcb>] filp_close+0x4b/0x80
>  [<c0167e7a>] sys_close+0x7a/0xb0
>  [<c010326b>] sysenter_past_esp+0x54/0x75

It's irritating that when some driver screws up its sysfs handling, the
trace leaves no indication which driver it was.

One thing you could do is to disable `hald' (what is that anyway?) by
renaming it and try to get the system to boot.  Then run `hald' by hand,
under strace, work out which sysfs file it was trying to close.
