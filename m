Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWBQWra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWBQWra (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWBQWra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 17:47:30 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44299 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751472AbWBQWr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 17:47:29 -0500
Date: Fri, 17 Feb 2006 23:47:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
       Paul Bristow <paul@paulbristow.net>, mpm@selenic.com,
       B.Zolnierkiewicz@elka.pw.edu.pl, dtor_core@ameritech.net, kkeil@suse.de,
       linux-dvb-maintainer@linuxtv.org, philb@gnu.org, gregkh@suse.de,
       dwmw2@infradead.org
Subject: kbuild: Section mismatch warnings
Message-ID: <20060217224702.GA25761@mars.ravnborg.org>
References: <20060217214855.GA5563@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217214855.GA5563@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Background:
I have introduced a build-time check for section mismatch and it showed
up a great number of warnings.
Below is the result of the run on a 2.6.16-rc1 tree (which my kbuild
tree is based upon) based on a 'make allmodconfig'

159 warnings in 49 different modules

I have included the obvious candidates for the modules in to: but some
are for sure missing and some may be wrong.

Syntax:
The offset refer to the relative offset from the referenced symbol.
So
WARNING: drivers/acpi/asus_acpi.o - Section mismatch: reference to .init.text from .data between 'asus_hotk_driver' (at offset 0xc0) and 'model_conf'
should be read as:

At 0xc0 bytes after asus_hotk_driver there is a reference to a symbol
placed in the section .init.text.

I did not find a way to look up the offending symbol but maybe some elf
expert can help?

In the warning are included both symbol before and after to help when
dealing with one of the many duplicated static symbols.


Several warnings are refereces to module parameters - sound/oss/mad16.o
as the most visible one. I have not yet figured out if this is a false
positive or not. Removing __initdata on the moduleparam variable solves
it, but then this may be the wrong approach.

	Sam


WARNING: drivers/acpi/asus_acpi.o - Section mismatch: reference to .init.text from .data between 'asus_hotk_driver' (at offset 0xc0) and 'model_conf'
WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data from .text between 'acpi_processor_power_init' (at offset 0x3a) and 'acpi_processor_power_exit'
WARNING: drivers/atm/fore_200e.o - Section mismatch: reference to .init.text from .text between 'fore200e_pca_detect' (at offset 0xd3) and 'fore200e_pca_remove_one'
WARNING: drivers/block/cpqarray.o - Section mismatch: reference to .init.text from .data between 'cpqarray_pci_driver' (at offset 0x20) and 'products'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x8b) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0xaa) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0xb1) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0xbd) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0xcd) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0xf6) and 'cleanup_module'
WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x12e) and 'cleanup_module'
WARNING: drivers/char/hw_random.o - Section mismatch: reference to .init.text from .data between 'rng_vendor_ops' (at offset 0x28) and 'rng_lock.0'
WARNING: drivers/char/hw_random.o - Section mismatch: reference to .init.text from .data between 'rng_vendor_ops' (at offset 0x50) and 'rng_lock.0'
WARNING: drivers/char/hw_random.o - Section mismatch: reference to .init.text from .data between 'rng_vendor_ops' (at offset 0x78) and 'rng_lock.0'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text from .text between 'cleanup_module' (at offset 0xb9) and 'set_irq'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text from .text between 'ip2_loadmain' (at offset 0x359) and 'ip2_interrupt'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text from .text between 'ip2_loadmain' (at offset 0x4a0) and 'ip2_interrupt'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text from .text between 'ip2_loadmain' (at offset 0x7a9) and 'ip2_interrupt'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text from .text between 'ip2_ipl_ioctl' (at offset 0x26f) and 'ip2_ipl_open'
WARNING: drivers/char/ip2main.o - Section mismatch: reference to .init.text from .text between 'ip2_ipl_ioctl' (at offset 0x285) and 'ip2_ipl_open'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0xe2) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x20d) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x35b) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x3c8) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x3ea) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x40d) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x425) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x665) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x68f) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x694) and 'cleanup_module'
WARNING: drivers/ide/ide-core.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x699) and 'cleanup_module'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data from .data between '' (at offset 0x8) and '__param_str_dev3'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data from .data between '' (at offset 0x28) and '__param_str_dev3'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data from .data between '__param_arr_dev2' (at offset 0x8) and '__param_str_dev2'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data from .data between '__param_arr_dev2' (at offset 0x28) and '__param_str_dev2'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data from .data between '__param_arr_dev' (at offset 0x8) and '__param_str_dev'
WARNING: drivers/input/joystick/db9.o - Section mismatch: reference to .init.data from .data between '__param_arr_dev' (at offset 0x28) and '__param_str_dev'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data from .data between '__param_arr_map3' (at offset 0x8) and '__param_str_map3'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data from .data between '__param_arr_map3' (at offset 0x28) and '__param_str_map3'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data from .data between '__param_arr_map2' (at offset 0x8) and '__param_str_map2'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data from .data between '__param_arr_map2' (at offset 0x28) and '__param_str_map2'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data from .data between '__param_arr_map' (at offset 0x8) and '__param_str_map'
WARNING: drivers/input/joystick/gamecon.o - Section mismatch: reference to .init.data from .data between '__param_arr_map' (at offset 0x28) and '__param_str_map'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data from .data between '' (at offset 0x8) and '__param_str_map3'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data from .data between '' (at offset 0x28) and '__param_str_map3'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data from .data between '__param_arr_map2' (at offset 0x8) and '__param_str_map2'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data from .data between '__param_arr_map2' (at offset 0x28) and '__param_str_map2'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data from .data between '__param_arr_map' (at offset 0x8) and '__param_str_map'
WARNING: drivers/input/joystick/turbografx.o - Section mismatch: reference to .init.data from .data between '__param_arr_map' (at offset 0x28) and '__param_str_map'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x2ed) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x2fa) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x314) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x32e) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x348) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x352) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x366) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x370) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x37a) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x384) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x38e) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x398) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'checkcard' (at offset 0x3a2) and 'HiSax_closecard'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'Diva_card_msg' (at offset 0xd2) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'NETjet_S_card_msg' (at offset 0x4a) and 'NETjet_ReadIC'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'NETjet_U_card_msg' (at offset 0x4d) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'NETjet_U_card_msg' (at offset 0x5d) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'NETjet_U_card_msg' (at offset 0x65) and 'ph_command'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'BKM_card_msg' (at offset 0x9b) and 'jade_write_indirect'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'BKM_card_msg' (at offset 0xab) and 'jade_write_indirect'
WARNING: drivers/isdn/hisax/hisax.o - Section mismatch: reference to .init.text from .text between 'enpci_card_msg' (at offset 0xc9) and 'enpci_interrupt'
WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .init.text from .text between 'av7110_attach' (at offset 0x1240) and 'av7110_detach'
WARNING: drivers/media/dvb/ttpci/dvb-ttpci.o - Section mismatch: reference to .exit.text from .text between 'av7110_detach' (at offset 0x44) and 'av7110_irq'
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data from .text after 'acenic_probe_one' (at offset 0xa03)
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data from .text after 'acenic_probe_one' (at offset 0xa1c)
WARNING: drivers/net/acenic.o - Section mismatch: reference to .init.data from .text after 'acenic_probe_one' (at offset 0xa35)
WARNING: drivers/net/de620.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x8) and 'cleanup_module'
WARNING: drivers/net/dgrs.o - Section mismatch: reference to .init.text from .data between 'dgrs_pci_driver' (at offset 0x20) and 'dgrs_ipxnet'
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .init.text from .data between 'de_driver' (at offset 0x20) and 'de_ethtool_ops'
WARNING: drivers/net/tulip/de2104x.o - Section mismatch: reference to .exit.text from .data between 'de_driver' (at offset 0x28) and 'de_ethtool_ops'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x8) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x12) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .text between 'init_module' (at offset 0x31) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.text from .text between 'init_module' (at offset 0x4a) and 'cleanup_module'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .data between '__param_arr_mac' (at offset 0x28) and '__param_str_mac'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .data between '__param_arr_rxl' (at offset 0x28) and '__param_str_rxl'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .data between '__param_arr_baud' (at offset 0x28) and '__param_str_baud'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .data between '__param_arr_irq' (at offset 0x28) and '__param_str_irq'
WARNING: drivers/net/wan/sbni.o - Section mismatch: reference to .init.data from .data between '__param_arr_io' (at offset 0x28) and '__param_str_io'
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.data from .data between '__param_arr_io_hi' (at offset 0x28) and '__param_str_io_hi'
WARNING: drivers/parport/parport_pc.o - Section mismatch: reference to .init.data from .data between '__param_arr_io' (at offset 0x28) and '__param_str_io'
WARNING: drivers/scsi/gdth.o - Section mismatch: reference to .init.data from .data between '__param_arr_irq' (at offset 0x28) and '__param_str_irq'
WARNING: drivers/scsi/gdth.o - Section mismatch: reference to .init.text from .data between 'driver_template' (at offset 0x10) and 'async_cache_tab'
WARNING: drivers/usb/gadget/g_ether.o - Section mismatch: reference to .init.text from .data between 'eth_driver' (at offset 0x10) and 'stringtab'
WARNING: drivers/usb/gadget/g_file_storage.o - Section mismatch: reference to .init.text from .data between 'fsg_driver' (at offset 0x10) and 'stringtab'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0x50) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0x5f) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0x88) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_serial.o - Section mismatch: reference to .init.text from .text between 'gs_bind' (at offset 0xba) and '.text.lock.serial'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text from .text between 'zero_bind' (at offset 0x11) and 'zero_suspend'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text from .text between 'zero_bind' (at offset 0x20) and 'zero_suspend'
WARNING: drivers/usb/gadget/g_zero.o - Section mismatch: reference to .init.text from .text between 'zero_bind' (at offset 0x68) and 'zero_suspend'
WARNING: drivers/usb/host/isp116x-hcd.o - Section mismatch: reference to .init.text from .data between '' (at offset 0x0) and 'isp116x_hc_driver'
WARNING: drivers/video/arcfb.o - Section mismatch: reference to .init.text from .data between 'arcfb_driver' (at offset 0x0) and 'arcfb_ops'
WARNING: drivers/video/aty/aty128fb.o - Section mismatch: reference to .init.text from .data between 'aty128fb_driver' (at offset 0x20) and 'aty128fb_ops'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.data from .text between 'atyfb_pci_probe' (at offset 0xe8b) and 'atyfb_pci_remove'
WARNING: drivers/video/aty/atyfb.o - Section mismatch: reference to .init.text from .text between 'atyfb_pci_probe' (at offset 0xf24) and 'atyfb_pci_remove'
WARNING: drivers/video/geode/gx1fb.o - Section mismatch: reference to .init.text from .data between 'gx1fb_driver' (at offset 0x20) and 'gx1fb_ops'
WARNING: drivers/video/hgafb.o - Section mismatch: reference to .init.text from .data between 'hgafb_driver' (at offset 0x120) and 'hgafb_device'
WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text from __ksymtab between '' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'
WARNING: drivers/video/nvidia/nvidiafb.o - Section mismatch: reference to .exit.text from .data between 'nvidiafb_driver' (at offset 0x28) and 'nvidia_fb_ops'
WARNING: drivers/video/riva/rivafb.o - Section mismatch: reference to .exit.text from .data between 'rivafb_driver' (at offset 0x28) and 'riva_fb_ops'
WARNING: drivers/video/savage/savagefb.o - Section mismatch: reference to .init.data from .text between 'savagefb_probe' (at offset 0x584) and 'savagefb_remove'
WARNING: drivers/video/vfb.o - Section mismatch: reference to .init.text from .data between 'vfb_driver' (at offset 0x0) and 'vfb_device'
WARNING: drivers/video/vga16fb.o - Section mismatch: reference to .init.text from .data between '' (at offset 0x120) and 'vga16fb_device'
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to .init.text from .text between 'jffs2_compressors_init' (at offset 0x5) and 'jffs2_compressors_exit'
WARNING: net/decnet/decnet.o - Section mismatch: reference to .init.data from .data between '__param_arr_addr' (at offset 0x28) and '__param_str_addr'
WARNING: net/ipv4/netfilter/ip_conntrack.o - Section mismatch: reference to .init.text from .text between 'init_or_cleanup' (at offset 0x12) and 'ip_conntrack_protocol_register'
WARNING: net/ipv4/netfilter/iptable_nat.o - Section mismatch: reference to .init.text from .text after 'init_or_cleanup' (at offset 0x39)
WARNING: sound/drivers/snd-dummy.o - Section mismatch: reference to .init.text from .data between 'snd_dummy_driver' (at offset 0x0) and 'snd_card_dummy_capture_ops'
WARNING: sound/drivers/snd-mtpav.o - Section mismatch: reference to .init.text from .data between 'snd_mtpav_driver' (at offset 0x0) and 'snd_mtpav_output'
WARNING: sound/drivers/snd-serial-u16550.o - Section mismatch: reference to .init.text from .data between 'snd_serial_driver' (at offset 0x0) and 'adaptor_names'
WARNING: sound/drivers/snd-virmidi.o - Section mismatch: reference to .init.text from .data after 'snd_virmidi_driver' (at offset 0x0)
WARNING: sound/oss/cs4232.o - Section mismatch: reference to .init.text from .text between 'cs4232_pnp_probe' (at offset 0x5c) and 'cs4232_pnp_remove'
WARNING: sound/oss/forte.o - Section mismatch: reference to .init.text from .data between 'forte_pci_driver' (at offset 0x20) and 'forte_dsp_fops'
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x31)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x57)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x8b)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x94)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xb9)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xc2)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xe8)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xee)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xfe)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x121)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x137)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x17c)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x19f)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x1b6)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x1d1)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x1dc)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x1e8)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x1f7)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x247)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x24e)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x268)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x26e)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x274)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0x27a)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text from .text after 'init_mad16' (at offset 0x3d8)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text from .text after 'init_mad16' (at offset 0x404)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text from .text after 'init_mad16' (at offset 0x488)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text from .text after 'init_mad16' (at offset 0x517)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text from .text after 'init_mad16' (at offset 0x561)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.text from .text after 'init_mad16' (at offset 0x58f)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xb1d)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xb30)
WARNING: sound/oss/mad16.o - Section mismatch: reference to .init.data from .text after 'init_mad16' (at offset 0xd3d)
WARNING: sound/oss/maestro.o - Section mismatch: reference to .init.text from .data between 'maestro_pci_driver' (at offset 0x20) and 'acpi_state_mask'
WARNING: sound/oss/msnd.o - Section mismatch: reference to .init.text from __ksymtab after '__ksymtab_msnd_register' (at offset 0x0)
