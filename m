Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754651AbWKMNyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbWKMNyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 08:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754653AbWKMNyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 08:54:19 -0500
Received: from mail.gmx.de ([213.165.64.20]:14255 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1754651AbWKMNyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 08:54:18 -0500
X-Authenticated: #14349625
Subject: Re: paging request BUG in 2.6.19-rc5 on resume - X60s
From: Mike Galbraith <efault@gmx.de>
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
In-Reply-To: <20061113081147.GB5289@gimli>
References: <20061113081147.GB5289@gimli>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 14:55:18 +0100
Message-Id: <1163426119.5871.26.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 09:11 +0100, Martin Lorenz wrote:
> Hallo again,
> 
> here is another one:
> 
> I reported a black screen on resume with my latest kernel build earlyer. But
> this was not reproducible. Only occured once.
> 
> BUT I suspended with the ipw3945 module loaded once again now and got a BUG
> report in the log instead of a black screen.
> 
> I only see this when ipw3945 is loaded.

Interesting oops... another one trying to dereference "Genu".

Repeatable?  Repeatable without vmware modules ever having been loaded?

> [226156.057000] BUG: unable to handle kernel paging request at virtual
> address 756e6567
> [226156.057000]  printing eip:
> [226156.057000] c016ffb7
> [226156.057000] *pde = 00000000
> [226156.057000] Oops: 0000 [#1]
> [226156.057000] SMP
> [226156.057000] Modules linked in: tun ipw3945 ieee80211 ieee80211_crypt
> nls_iso8859_1 nls_cp437 vfat fat usb_storage snd_hda_intel snd_hda_codec
> snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
> vmnet(P) vmmon(P) i915 binfmt_misc nfs nfsd exportfs lockd nfs_acl sunrpc
> cpufreq_ondemand container video thermal i2c_ec fan dock button battery ac
> mmc_block speedstep_centrino freq_table processor ibm_acpi sbp2 nvram
> eth1394 irtty_sir sir_dev pcmcia ehci_hcd uhci_hcd firmware_class nsc_ircc
> generic usbcore psmouse irda ohci1394 ieee1394 sdhci ide_core yenta_socket
> rsrc_nonstatic pcmcia_core serio_raw crc_ccitt pcspkr mmc_core evdev
> [226156.058000] CPU:    1
> [226156.058000] EIP:    0060:[<c016ffb7>]    Tainted: P      VLI
> [226156.058000] EFLAGS: 00010282
> (2.6.19-rc5+ieee80211+e1000-45.3+1909-g6a4abeae-dirty #1)
> [226156.058000] EIP is at iput+0xd/0x66
> [226156.058000] eax: 756e6547   ebx: c0416e10   ecx: c016ee14   edx:
> c55c7114
> [226156.058000] esi: c046f1c0   edi: c046f21c   ebp: f7feb800   esp:
> dcfbfde4
> [226156.058000] ds: 007b   es: 007b   ss: 0068
> [226156.058000] Process mount (pid: 22076, ti=dcfbe000 task=f7df1550
> task.ti=dcfbe000)
> [226156.058000] Stack: c046f21c c016ef85 c046f244 c046f1c0 c016f2e0 fffffff3
> 00000000 f7feb800
> [226156.058000]        c8b73000 c01619bb 00000000 f7feb83c 00000000 f7feb800
> 00000000 c0172f49
> [226156.058000]        00000000 c8b73000 00000000 e613a000 dcfb0000 00000444
> 00000020 0cf68720
> [226156.058000] Call Trace:
> [226156.058000]  [<c016ef85>] prune_one_dentry+0x53/0x74
> [226156.058000]  [<c016f2e0>] shrink_dcache_sb+0x8f/0xb3
> [226156.058000]  [<c01619bb>] do_remount_sb+0x40/0x120
> [226156.058000]  [<c0172f49>] do_mount+0x1b0/0x66c
> [226156.058000]  [<c017347c>] sys_mount+0x77/0xb3
> [226156.058000]  [<c0102dc7>] syscall_call+0x7/0xb
> [226156.058000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> [226156.058000]
> [226156.058000] Leftover inexact backtrace:
> [226156.058000]
> [226156.058000]  =======================
> [226156.058000] Code: ba 03 00 00 00 e9 ee fc fb ff 83 a0 2c 01 00 00 b7 e9
> e0 ff ff ff e8 d1 3e 17 00 31 c0 c3 53 89 c3 85 c0 74 5d 8b 80 98 00 00 00
> <8b> 40 20 83 bb 2c 01 00 00 20 75 08 0f 0b 5d 04 dc 61 30 c0 85

Per ksymoops, that code is:
   0:   ba 03 00 00 00            mov    $0x3,%edx
   5:   e9 ee fc fb ff            jmp    fffbfcf8 <_EIP+0xfffbfcf8>
   a:   83 a0 2c 01 00 00 b7      andl   $0xffffffb7,0x12c(%eax)
  11:   e9 00 00 00 00            jmp    16 <_EIP+0x16>

There is no such andl with an offset of 0x12c and that mask (I_LOCK|
I_NEW?) anywhere in my kernel or modules.  How about yours?

	-Mike

