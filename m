Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWEaSFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWEaSFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWEaSFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:05:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750895AbWEaSFM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:05:12 -0400
Date: Wed, 31 May 2006 11:09:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060531110924.29fdf876.akpm@osdl.org>
In-Reply-To: <447DD4D3.3060205@free.fr>
References: <20060530022925.8a67b613.akpm@osdl.org>
	<447DD4D3.3060205@free.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 19:39:31 +0200
Laurent Riffard <laurent.riffard@free.fr> wrote:

> Le 30.05.2006 11:29, Andrew Morton a écrit :
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm1/
> 
> Hello, I've got this nice BUG:
> 
> pktcdvd: writer pktcdvd0 mapped to hdc
> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000084
>  printing eip:
> c01118f1
> *pde = 00000000
> Oops: 0000 [#1]
> last sysfs file: /block/pktcdvd0/removable
> Modules linked in: pktcdvd lp parport_pc parport snd_pcm_oss snd_mixer_oss snd_ens1371 gameport snd_rawmidi snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_timer snd_page_alloc snd soundcore af_packet floppy ide_cd cdrom loop aes dm_crypt nls_iso8859_1 nls_cp850 vfat fat reiser4 reiserfs via_agp agpgart video joydev ohci1394 usbhid ieee1394 uhci_hcd usbcore dm_mirror dm_mod via82cxxx
> CPU:    0
> EIP:    0060:[<c01118f1>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.17-rc5-mm1 #11) 
> EIP is at do_page_fault+0xb4/0x5bc
> eax: d6750084   ebx: d6750000   ecx: 0000007b   edx: 00000000
> esi: d6758000   edi: c011183d   ebp: d675007c   esp: d6750044
> ds: 007b   es: 007b   ss: 0068
> Process  (pid: 0, threadinfo=d674f000 task=d657c000)
> Stack: 00000000 d6750084 00000000 00000049 00000084 00000000 00001e2e 02001120 
>        00000027 00000022 00000055 d6750000 d6758000 c011183d d67500f0 c010340d 
>        d6750000 0000007b 00000000 d6758000 c011183d d67500f0 d67500f8 0000007b 
> Call Trace:
>  [<c010340d>] error_code+0x39/0x40
> Code: 00 00 c0 81 0f 84 12 02 00 00 e9 1c 05 00 00 8b 45 cc f7 40 30 00 02 02 00 74 06 e8 68 af 01 00 fb f7 43 14 ff ff ff ef 8b 55 d0 <8b> b2 84 00 00 00 0f 85 e5 01 00 00 85 f6 0f 84 dd 01 00 00 8d 
> EIP: [<c01118f1>] do_page_fault+0xb4/0x5bc SS:ESP 0068:d6750044
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  BUG: warning at kernel/panic.c:138/panic()
>  [<c0103810>] show_trace_log_lvl+0x4b/0xf4
>  [<c0103e11>] show_trace+0xd/0x10
>  [<c0103e58>] dump_stack+0x19/0x1b
>  [<c0116768>] panic+0x14d/0x161
>  [<c0103d0d>] die+0x231/0x266
>  [<c0111cc3>] do_page_fault+0x486/0x5bc
> SysRq : Emergency Sync
> SysRq : Emergency Sync
> SysRq : Emergency Remount R/O
> SysRq : Emergency Sync
> SysRq : Resetting

What a mess.

Your .config worked OK here.  There's probably not a lot of point in you
persisting with rc5-mm1.  Please test next -mm and if that has the same bug
then yes please, a bisection search would be great.
