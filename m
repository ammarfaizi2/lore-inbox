Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWFHLJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWFHLJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWFHLJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:09:49 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:60175 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S932233AbWFHLJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:09:48 -0400
Message-ID: <4488057A.9090301@onelan.co.uk>
Date: Thu, 08 Jun 2006 12:09:46 +0100
From: Barry Scott <barry.scott@onelan.co.uk>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc6 Section mismatch warnings
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I built 2.6.17-rc6 I see a lot of warnings after the MODPOST message
about Section mismatch. What did I do wrong in building the kernel and 
modules?

I used these commands to build 2.6.17-rc6 on FC4:
$ tar xjf ~/Downloads/linux-2.6.16.tar.bz2
$ mv linux-2.6.16  linux-2.6.17-rc6
$ cd linux-2.6.17-rc6
$ bzcat ~/Downloads/patch-2.6.17-rc6.bz2| patch -p1
$ cp /boot/config-2.6.16-1.2096_FC4 
~/KernelBuild/obj/linux-2.6.17-rc6/.config
$ make O=~/KernelBuild/obj/linux-2.6.17-rc6 silentoldconfig
(took the defaults for all new config items)
$ make O=~/KernelBuild/obj/linux-2.6.17-rc6 >make-1.log 2>&1
$ make O=~/KernelBuild/obj/linux-2.6.17-rc6 modules >make-2.log 2>&1

Here are some of the warnings:

  MODPOST
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch: reference 
to .init.text:dmi_matched from .data between 'dmi_ids' (at offset 0x120) 
and 'keymap_aopen_1559as'
...
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to 
.init.text:setup_teles0 from .text between 'checkcard' (at offset 
0x11a5) and 'hisax_register'
...
WARNING: drivers/net/3c501.o - Section mismatch: reference to 
.init.text:el1_probe from .text between 'init_module' (at offset 0x146) 
and 'el_reset'
WARNING: drivers/net/3c503.o - Section mismatch: reference to 
.init.data: from .text between 'init_module' (at offset 0x47c) and 
'el2_block_output'
WARNING: drivers/net/3c503.o - Section mismatch: reference to 
.init.data: from .text between 'init_module' (at offset 0x485) and 
'el2_block_output'
...
WARNING: drivers/net/wd.o - Section mismatch: reference to .init.text: 
from .text after 'init_module' (at offset 0x47d)
WARNING: drivers/scsi/megaraid/megaraid_mbox.o - Section mismatch: 
reference to .init.text: from .text between 'megaraid_probe_one' (at 
offset 0x1f00) and 'megaraid_queue_command'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to 
.init.data: from .text between 'atyfb_pci_probe' (at offset 0x297f) and 
'atyfb_set_par'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to 
.init.text:aty_init_cursor from .text between 'atyfb_pci_probe' (at 
offset 0x2dc1) and 'atyfb_set_par'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to 
.init.text:mac_find_mode from __ksymtab between 
'__ksymtab_mac_find_mode' (at offset 0x0) and 
'__ksymtab_mac_map_monitor_sense'
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to 
.init.text:jffs2_zlib_init from .text between 'jffs2_compressors_init' 
(at offset 0x81) and 'jffs2_compressors_exit'
WARNING: sound/isa/sb/snd-sbawe.o - Section mismatch: reference to 
.init.text:snd_emu8000_new from .text between 'snd_sb16_probe' (at 
offset 0x440) and 'snd_sb16_nonpnp_remove'
WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to 
.init.text: from .text between 'snd_opl3sa2_pnp_cdetect' (at offset 
0xe61) and 'snd_opl3sa2_pnp_detect'
WARNING: sound/isa/snd-opl3sa2.o - Section mismatch: reference to 
.init.text: from .text between 'snd_opl3sa2_pnp_detect' (at offset 
0xf52) and 'snd_opl3sa2_put_single'

Barry

