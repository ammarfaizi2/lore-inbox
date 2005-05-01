Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVEAAiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVEAAiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 20:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVEAAiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 20:38:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:1455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbVEAAiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 20:38:04 -0400
Date: Sat, 30 Apr 2005 17:37:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2
Message-Id: <20050430173724.3189c50f.akpm@osdl.org>
In-Reply-To: <40f323d0050430172775e3b4b7@mail.gmail.com>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<40f323d0050430172775e3b4b7@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot <bboissin@gmail.com> wrote:
>
> On 5/1/05, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> > 
> > - Various fixes against 2.6.12-rc3-mm1.
> > 
> This time it boots correctly, but it oops:
> 
> [   37.719238] Unable to handle kernel paging request at virtual
> address 40adb814
> [   37.719242]  printing eip:
> [   37.719244] c0120191
> [   37.719246] *pde = 00000000
> [   37.719249] Oops: 0002 [#1]
> [   37.722113] Modules linked in: acpi_cpufreq cpufreq_stats
> freq_table cpufreq_ondemand cpufreq_powersave cpufreq_userspace fan
> button thermal processor battery ac uhci_hcd ehci_hcd usbcore tg3
> ide_cd cdrom
> [   37.728547] CPU:    0
> [   37.728548] EIP:    0060:[<c0120191>]    Not tainted VLI
> [   37.728549] EFLAGS: 00010246   (2.6.12-rc3-mm2-casaverde) 
> [   37.738020] EIP is at do_proc_dointvec_conv+0x11/0x50
> [   37.741173] eax: 00000001   ebx: 00000001   ecx: 40adb814   edx: df8f2f08
> [   37.744357] esi: b7dab001   edi: df8f2eef   ebp: df8f2ec0   esp: df8f2ec0
> [   37.747592] ds: 007b   es: 007b   ss: 0068
> [   37.750861] Process sysctl (pid: 5336, threadinfo=df8f2000 task=decbf070)
> [   37.750986] Stack: df8f2f1c c012046c 00000001 00000000 00000001
> df25f6ac 00000001 40adb814
> [   37.754460]        00000001 00000001 00000000 31cf44c0 df8f000a
> c01154ec 00000001 df603f38
> [   37.758018]        00000006 df8f2ef0 00000001 00000000 b7dab000
> b7dab000 00000001 df8f2f3c
> [   37.761703] Call Trace:
> [   37.768905]  [<c0103d66>] show_stack+0xa6/0xe0
> [   37.772695]  [<c0103f1b>] show_registers+0x15b/0x1f0
> [   37.776529]  [<c010410b>] die+0xbb/0x140
> [   37.780393]  [<c0115493>] do_page_fault+0x233/0x6cc
> [   37.784313]  [<c0103993>] error_code+0x4f/0x54
> [   37.788247]  [<c012046c>] do_proc_dointvec+0x29c/0x320
> [   37.792260]  [<c012051c>] proc_dointvec+0x2c/0x40
> [   37.796289]  [<c011fea5>] do_rw_proc+0x85/0x90
> [   37.800321]  [<c011ff21>] proc_writesys+0x21/0x30
> [   37.804359]  [<c0154f58>] vfs_write+0x98/0x140
> [   37.808446]  [<c01550ad>] sys_write+0x3d/0x70
> [   37.812544]  [<c0102e8f>] sysenter_past_esp+0x54/0x75
> [   37.816651] Code: 8b 5d f4 89 c8 8b 75 f8 8b 7d fc 89 ec 5d c3 8d
> 74 26 00 8d bc 27 00 00 00 00 55 89 e5 83 7d 08 00 74 0e 8b 00 85 c0
> 75 21 8b 02 <89> 01 5d 31 c0 c3 8b 09 85 c9 78 1b c7 00 00 00 00 00 31
> c0 5d

Which /proc node is it writing to?

I guess you could send your /etc/sysctl.conf and try taking things out of
it, see which entry is causing the crash.

