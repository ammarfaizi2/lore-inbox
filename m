Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266808AbRHFFqh>; Mon, 6 Aug 2001 01:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266867AbRHFFq2>; Mon, 6 Aug 2001 01:46:28 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:26631 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266808AbRHFFqM>;
	Mon, 6 Aug 2001 01:46:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.8-pre4, lots of compile warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 15:46:11 +1000
Message-ID: <848.997076771@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of stress testing kbuild 2.5, I built a 2.4.8-pre4 ix86 kernel
with almost every option turned on, the .config is at the end.  It got
a lot of warnings, I hope that the maintainers will do something about
these.  Do not send patches to me, send them to the list or the
maintainer.

Because this is kbuild 2.5 it is possible that some of the warnings are
my fault.  If the warning does not occur using standard kernel build,
please let me know.  The warnings about modversions and EXPORT_SYMTAB
will not occur with standard kbuild but the code really is wrong, the
offending sources explicitly set EXPORT_SYMTAB and need to be fixed.

arch/i386/kernel/dmi_scan.c:163: warning: `disable_ide_dma' defined but not used

fs/ncpfs/ncplib_kernel.c:61: warning: `ncp_add_mem_fromfs' defined but not used
fs/jffs/jffs_fm.c: In function `jffs_flash_erasable_size':
fs/jffs/jffs_fm.c:634: warning: long unsigned int format, u_int32_t arg (arg 3)
fs/jffs/jffs_fm.c:638: warning: long unsigned int format, u_int32_t arg (arg 5)
fs/jffs/intrep.c:96: warning: `jffs_hexdump' defined but not used
fs/affs/super.c:273: warning: #warning

drivers/char/sx.c: In function `sx_check_modem_signals':
drivers/char/sx.c:1142: warning: implicit declaration of function `gs_got_break'
drivers/char/ip2/i2ellis.c:107: warning: `iiEllisCleanup' defined but not used
drivers/char/ip2main.c:423: warning: `clear_requested_irq' defined but not used
drivers/char/sx.c: At top level:
drivers/char/sx.c:1620: warning: `do_memtest_w' defined but not used
drivers/char/rio/riocmd.c: In function `RIOCommandRup':
drivers/char/rio/riocmd.c:484: warning: implicit declaration of function `gs_got_break'
drivers/char/joystick/cs461x.c:184: warning: `cs461x_gameport_cooked_read' defined but not used
drivers/char/drm/r128_cce.c: In function `r128_cce_packet':
drivers/char/drm/r128_cce.c:1023: warning: unused variable `size'
drivers/char/drm/r128_cce.c:1021: warning: unused variable `buffer'
drivers/char/drm/r128_cce.c:1019: warning: unused variable `dev_priv'
drivers/block/paride/bpck6.c:29:
	You got this message because you directly included linux/modversions.h
	in your own code or you explicitly defined EXPORT_SYMTAB.  That is the
	wrong thing to do, please remove all explicit references to
	linux/modversions.h and do not define EXPORT_SYMTAB yourself.
	Use the Makefile to define whether an object exports symbols.

drivers/block/paride/ppc6lnx.c: In function `ppc6_rd_data_byte':
drivers/block/paride/ppc6lnx.c:307: warning: `data' might be used uninitialized in this function
drivers/block/paride/ppc6lnx.c: At top level:
drivers/block/paride/ppc6lnx.c:397: warning: `ppc6_rd_reg' defined but not used
drivers/block/paride/ppc6lnx.c:406: warning: `ppc6_wr_reg' defined but not used
drivers/block/paride/ppc6lnx.c:415: warning: `ppc6_version' defined but not used
drivers/block/paride/ppc6lnx.c:712: warning: `ppc6_rd_port16' defined but not used
drivers/block/paride/ppc6lnx.c:733: warning: `ppc6_wr_port16' defined but not used
drivers/block/paride/ppc6lnx.c:788: warning: `ppc6_eeprom_start' defined but not used
drivers/block/paride/ppc6lnx.c:795: warning: `ppc6_eeprom_end' defined but not used
drivers/block/paride/ppc6lnx.c:828: warning: `ppc6_eeprom_ready_wait' defined but not used
drivers/block/paride/ppc6lnx.c:863: warning: `ppc6_eeprom_read' defined but not used
drivers/block/paride/ppc6lnx.c:894: warning: `ppc6_irq_test' defined but not used
drivers/block/paride/ppc6lnx.c:903: warning: `ppc6_rd_extout' defined but not used

drivers/net/tulip/tulip_core.c: In function `tulip_mwi_config':
drivers/net/tulip/tulip_core.c:1324: warning: label `early_out' defined but not used
drivers/net/tulip/tulip_core.c:1258: warning: `csr0' might be used uninitialized in this function
drivers/net/wan/comx-hw-mixcom.c: In function `MIXCOM_open':
drivers/net/wan/comx-hw-mixcom.c:568: warning: label `err_restore_flags' defined but not used
drivers/net/wan/sdladrv.c:217: warning: `sdladrv_pci_tbl' defined but not used
drivers/net/wan/sbni.c:1543: warning: initialization from incompatible pointer type
drivers/net/rrunner.c:121: warning: `rrunner_pci_tbl' defined but not used
drivers/net/sungem.c: In function `gem_get_device_address':
drivers/net/sungem.c:1580: warning: unused variable `pdev'
drivers/net/sungem.c:1579: warning: unused variable `dev'
drivers/net/dgrs.c:124: warning: `dgrs_pci_tbl' defined but not used
drivers/net/skfp/skfddi.c:185: warning: `skfddi_pci_tbl' defined but not used
drivers/net/acenic.c:124: warning: `acenic_pci_tbl' defined but not used
drivers/net/winbond-840.c:146: warning: `version' defined but not used
drivers/net/hp100.c:282: warning: `hp100_pci_tbl' defined but not used
drivers/net/sb1000.c:140: warning: `id_table' defined but not used
drivers/net/arlan.c:22: warning: `probe' defined but not used
drivers/net/arlan.c:1124: warning: `arlan_find_devices' defined but not used
drivers/net/fc/iph5526.c:114: warning: `iph5526_pci_tbl' defined but not used
drivers/net/fc/iph5526.c:225: warning: `driver_template' defined but not used
drivers/net/irda/irda-usb.c:47: warning: `min_turn_times' defined but not used
drivers/net/irda/irda-usb.c:259: warning: `irda_usb_dump_class_desc' defined but not used
drivers/net/irda/toshoboe.c: In function `toshoboe_probe':
drivers/net/irda/toshoboe.c:698: warning: unused variable `pmdev'
drivers/net/irda/w83977af_ir.c:276: warning: `w83977af_close' defined but not used
drivers/net/irda/ali-ircc.c:467: warning: `ali_ircc_probe_43' defined but not used
drivers/net/pcmcia/xirc2ps_cs.c: In function `setup_xirc2ps_cs':
drivers/net/pcmcia/xirc2ps_cs.c:2087: warning: control reaches end of non-void function
drivers/net/tokenring/tmsisa.c:44: warning: `portlist' defined but not used

drivers/media/video/w9966.c:632: warning: `w9966_rReg_i2c' defined but not used
drivers/media/video/cpia.c:1305: warning: `proc_cpia_destroy' defined but not used
drivers/media/radio/radio-cadet.c:636: warning: `id_table' defined but not used

drivers/isdn/hisax/config.c:1720: warning: `hisax_pci_tbl' defined but not used
drivers/isdn/avmb1/b1pci.c:31: warning: `b1pci_pci_tbl' defined but not used
drivers/isdn/avmb1/t1pci.c:34: warning: `t1pci_pci_tbl' defined but not used
drivers/isdn/avmb1/c4.c:39: warning: `c4_pci_tbl' defined but not used

drivers/atm/fore200e.o: objcopy: Warning: Output file cannot represent architecture UNKNOWN!

drivers/scsi/g_NCR5380.c:963: warning: `id_table' defined but not used
drivers/scsi/sym53c416.c:613: warning: `id_table' defined but not used
drivers/scsi/NCR5380.c:795: warning: `NCR5380_print_options' defined but not used
drivers/scsi/qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used
drivers/scsi/tmscsim.c:280: warning: `tmscsim_pci_tbl' defined but not used
drivers/scsi/scsi_debug.c: In function `scsi_debug_biosparam':
drivers/scsi/scsi_debug.c:665: warning: unused variable `size'
drivers/scsi/osst.c: In function `osst_reposition_and_retry':
drivers/scsi/osst.c:1383: warning: `expected' might be used uninitialized in this function

drivers/ieee1394/pcilynx.c:61: warning: `pcilynx_pci_tbl' defined but not used
drivers/ieee1394/video1394.c: In function `video1394_ioctl':
drivers/ieee1394/video1394.c:810: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1037: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1043: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1046: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1050: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1053: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1199: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1206: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1209: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1213: warning: `ohci' might be used uninitialized in this function
drivers/ieee1394/video1394.c:1217: warning: `ohci' might be used uninitialized in this function

drivers/cdrom/cm206.c:218: warning: `cm206' defined but not used

drivers/sound/opl3sa2.c:813: warning: initialization makes integer from pointer without a cast
drivers/sound/sb_card.c:512: warning: `id_table' defined but not used
drivers/sound/cmpci.c:90:
	You got this message because you directly included linux/modversions.h
	in your own code or you explicitly defined EXPORT_SYMTAB.  That is the
	wrong thing to do, please remove all explicit references to
	linux/modversions.h and do not define EXPORT_SYMTAB yourself.
	Use the Makefile to define whether an object exports symbols.
drivers/sound/cmpci.c: In function `cm_release_mixdev':
drivers/sound/cmpci.c:1594: warning: unused variable `s'
drivers/sound/esssolo1.c:2455: warning: initialization from incompatible pointer type
drivers/sound/esssolo1.c:2457: warning: initialization from incompatible pointer type
drivers/sound/trident.c: In function `trident_probe':
drivers/sound/trident.c:3640: warning: unused variable `mask'
drivers/sound/cs4281/cs4281m.c:4486: warning: initialization from incompatible pointer type
drivers/sound/cs4281/cs4281m.c:4487: warning: initialization from incompatible pointer type

drivers/video/aty128fb.c:216: warning: `font' defined but not used
drivers/video/aty128fb.c:217: warning: `mode' defined but not used
drivers/video/aty128fb.c:218: warning: `nomtrr' defined but not used
drivers/video/sis/sis_main.c:15:
	You got this message because you directly included linux/modversions.h
	in your own code or you explicitly defined EXPORT_SYMTAB.  That is the
	wrong thing to do, please remove all explicit references to
	linux/modversions.h and do not define EXPORT_SYMTAB yourself.
	Use the Makefile to define whether an object exports symbols.
drivers/video/matrox/matroxfb_g450.c:7: warning: `matroxfb_g450_get_reg' defined but not used

drivers/usb/serial/visor.c:156: warning: `id_table' defined but not used
drivers/usb/serial/ftdi_sio.c:137: warning: `id_table_combined' defined but not used
drivers/usb/serial/whiteheat.c:116: warning: `id_table_combined' defined but not used
drivers/usb/serial/belkin_sa.c:106: warning: `id_table_combined' defined but not used
drivers/usb/serial/mct_u232.c:129: warning: `id_table_combined' defined but not used
drivers/usb/serial/keyspan.h:305: warning: `keyspan_ids_combined' defined but not used
drivers/usb/serial/digi_acceleport.c:485: warning: `id_table_combined' defined but not used
drivers/usb/storage/scsiglue.c: In function `bus_reset':
drivers/usb/storage/scsiglue.c:270: warning: assignment discards `const' from pointer target type
drivers/usb/serial/io_tables.h:33: warning: `id_table_combined' defined but not used
drivers/usb/serial/io_edgeport.c:623: warning: `get_string_desc' defined but not used
drivers/usb/storage/dpcm.c: In function `dpcm_transport':
drivers/usb/storage/dpcm.c:46: warning: unused variable `ret'

drivers/i2c/i2c-elv.c:119: warning: `bit_elv_exit' defined but not used
drivers/i2c/i2c-velleman.c:107: warning: `bit_velle_exit' defined but not used
drivers/i2c/i2c-elektor.c:174: warning: `pcf_isa_exit' defined but not used

net/wanrouter/af_wanpipe.c:62:
include/linux/sdla_x25.h:112: warning: `X25_INTERRUPT' redefined
include/net/x25.h:35: warning: this is the location of the previous definition

begin 644 .config.gz
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
+?_M_^(P;W>6)````
`
end

