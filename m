Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964879AbWFHQnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWFHQnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 12:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWFHQnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 12:43:01 -0400
Received: from xenotime.net ([66.160.160.81]:43178 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964879AbWFHQnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 12:43:00 -0400
Date: Thu, 8 Jun 2006 09:45:47 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Barry Scott <barry.scott@onelan.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc6 Section mismatch warnings
Message-Id: <20060608094547.efc7a10e.rdunlap@xenotime.net>
In-Reply-To: <4488057A.9090301@onelan.co.uk>
References: <4488057A.9090301@onelan.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Jun 2006 12:09:46 +0100 Barry Scott wrote:

> When I built 2.6.17-rc6 I see a lot of warnings after the MODPOST message
> about Section mismatch. What did I do wrong in building the kernel and 
> modules?

Nothing (well, I would use "make all" instead of the last 2
commands and I would use ketchup or
http://www.xenotime.net/linux/scripts/grab-kernel-rc
to optionally download and create new kernel dirs. :)

I'll look at the warnings.  Some of them are noise/bogus,
I expect...


> I used these commands to build 2.6.17-rc6 on FC4:
> $ tar xjf ~/Downloads/linux-2.6.16.tar.bz2
> $ mv linux-2.6.16  linux-2.6.17-rc6
> $ cd linux-2.6.17-rc6
> $ bzcat ~/Downloads/patch-2.6.17-rc6.bz2| patch -p1
> $ cp /boot/config-2.6.16-1.2096_FC4 
> ~/KernelBuild/obj/linux-2.6.17-rc6/.config
> $ make O=~/KernelBuild/obj/linux-2.6.17-rc6 silentoldconfig
> (took the defaults for all new config items)
> $ make O=~/KernelBuild/obj/linux-2.6.17-rc6 >make-1.log 2>&1
> $ make O=~/KernelBuild/obj/linux-2.6.17-rc6 modules >make-2.log 2>&1
> 
> Here are some of the warnings:
> 
>   MODPOST
> WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference 
> to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0x120) 
> and 'keymap_aopen_1559as'
> ...
> WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to 
> .init.text:setup_teles0 from .text between 'checkcard' (at offset 
> 0x11a5) and 'hisax_register'
> ...
> WARNING: drivers/net/3c501.o - Section mismatch: reference to 
> .init.text:el1_probe from .text between 'init_module' (at offset 0x146) 
> and 'el_reset'
> WARNING: drivers/net/3c503.o - Section mismatch: reference to 
> .init.data: from .text between 'init_module' (at offset 0x47c) and 
> 'el2_block_output'
> WARNING: drivers/net/3c503.o - Section mismatch: reference to 
> .init.data: from .text between 'init_module' (at offset 0x485) and 
> 'el2_block_output'
> ...
> WARNING: drivers/net/wd.o - Section mismatch: reference to .init.text: 
> from .text after 'init_module' (at offset 0x47d)
> WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch: 
> reference to .init.text: from .text between 'megaraid_probe_one' (at 
> offset 0x1f00) and 'megaraid_queue_command'
> WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to 
> .init.data: from .text between 'atyfb_pci_probe' (at offset 0x297f) and 
> 'atyfb_set_par'
> WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to 
> .init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at 
> offset 0x2dc1) and 'atyfb_set_par'
> WARNING: drivers/video/macmodes.o - Section mismatch: reference to 
> .init.text:mac_find_mode from __ksymtab between 
> '__ksymtab_mac_find_mode' (at offset 0x0) and 
> '__ksymtab_mac_map_monitor_sense'
> WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to 
> .init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' 
> (at offset 0x81) and 'jffs2_compressors_exit'
> WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to 
> .init.text:snd_emu8000_new from .text between 'snd_sb16_probe' (at 
> offset 0x440) and 'snd_sb16_nonpnp_remove'
> WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to 
> .init.text: from .text between 'snd_opl3sa2_pnp_cdetect' (at offset 
> 0xe61) and 'snd_opl3sa2_pnp_detect'
> WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to 
> .init.text: from .text between 'snd_opl3sa2_pnp_detect' (at offset 
> 0xf52) and 'snd_opl3sa2_put_single'


---
~Randy
