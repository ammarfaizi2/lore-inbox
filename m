Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750959AbWBOUBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWBOUBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWBOUBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:01:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750959AbWBOUBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:01:32 -0500
Date: Wed, 15 Feb 2006 12:00:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060215120021.565a47fb.akpm@osdl.org>
In-Reply-To: <m2lkwckaen.fsf@vador.mandriva.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<20060212190520.244fcaec.akpm@osdl.org>
	<s5hk6bz4gca.wl%tiwai@suse.de>
	<m2zmkuqcs5.fsf@vador.mandriva.com>
	<20060214225154.2e82dfd2.akpm@osdl.org>
	<m2lkwckaen.fsf@vador.mandriva.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Vignaud <tvignaud@mandriva.com> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
>  > >  > It's not a "regression".  PM didn't work with ens1370 at all in
>  > >  > the eralier version.
>  > > 
>  > >  btw, PM support in snd-intel8x0 is broken (at least regarding
>  > >  suspending) in 2.6.16-rc2-mm1 on a nforce2 chipset
>  > 
>  > Can you identify when this breakage occurred?
> 
>  i'll try to compile a few older kernels (and/or just older
>  alsa-kernel) if you want but i'm not sure it's a regression (i'll
>  check if it has ever worked before).

OK, thanks.

>  i've tried unloading/reloading sound modules after resuming (maybe
>  would it work if unloaded before suspending but of course full PM
>  support would be nicer).
> 
>  not sure if it can help but while resuming, the snd-intel8x0 printed
>  quite a lot of warnings (due to preempting[1] i guess?) such as:
>  BUG: scheduling while atomic: zsh/0x00000001/2196
>   <c028b93f> schedule+0x43/0x54e   <c028c6bf> schedule_timeout+0x7a/0x95
>   <c011c755> process_timeout+0x0/0x5   <d4938e56> snd_intel8x0_chip_init+0x110/0x39e [snd_intel8x0]
>   <d4939142> intel8x0_resume+0x5e/0x1ba [snd_intel8x0]   <c01b6dee> pci_device_resume+0x16/0x43
>   <c02025d9> resume_device+0x7d/0x96   <c02026a7> dpm_resume+0x58/0x80
>   <c02026dc> device_resume+0xd/0x16   <c012db1f> pm_suspend_disk+0xbf/0xc8
>   <c012cb95> enter_state+0x50/0x16f   <c012cd37> state_store+0x83/0x8f
>   <c012ccb4> state_store+0x0/0x8f   <c0173492> subsys_attr_store+0x1e/0x22
>   <c0173a1b> sysfs_write_file+0x92/0xb9   <c0173989> sysfs_write_file+0x0/0xb9
>   <c01491ca> vfs_write+0x83/0x122   <c01499df> sys_write+0x3c/0x63
>   <c0102973> sysenter_past_esp+0x54/0x75  
> 
>  dmesg after resuming (only look at the beginning, the end is only ehci
>  garbage b/c ehci is bugging for monthes (rejecting mass media after
>  writing a few Mo)):

That's odd.  I don't see what could have elevated preempt_count() on that
path.  What does `grep PREEMPT .config' say?
