Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278095AbRJ1J6i>; Sun, 28 Oct 2001 04:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278098AbRJ1J63>; Sun, 28 Oct 2001 04:58:29 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:54798 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S278095AbRJ1J6N>;
	Sun, 28 Oct 2001 04:58:13 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.13 errors and warnings
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Oct 2001 20:58:36 +1100
Message-ID: <27909.1004263116@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doing kbuild 2.5 full build for SMP on 2.4.13 got lots of warnings and
a couple of errors.  The .config had everything built in except for:

  # I don't have the required input files to build the sound firmware.
  # If anybody has them and can test, go for it.
  CONFIG_PSS_HAVE_BOOT=n
  CONFIG_MAUI_HAVE_BOOT=n
  CONFIG_TRIX_HAVE_BOOT=n

  # _SOUND_MSNDCLAS=y and _SOUND_MSNDPIN=y insist on having firmware that
  # I don't have.
  CONFIG_SOUND_MSNDCLAS=m
  CONFIG_SOUND_MSNDPIN=m

  # Broken code, missing ioctls
  CONFIG_SCSI_CPQFCTS=n

  # Broken code, missing #include <module.h>
  CONFIG_SCSI_U14_34F=n

  # Broken code, SCSI_ABORT_PENDING undefined
  CONFIG_USB_HPUSBSCSI=n

The last three options give compile errors when they are turned on.  I
have not checked if they are fixed in 2.4.14-pre3.

The link of vmlinux had a lot of duplicate objects:

drivers/net/ppp_deflate.o(.data+0x0): multiple definition of `deflate_copyright'
fs/jffs2/jffs2.o(.data+0x20): first defined here
drivers/net/ppp_deflate.o: In function `deflateInit_':
drivers/net/ppp_deflate.o(.text+0x0): multiple definition of `deflateInit_'
fs/jffs2/jffs2.o(.text+0xc90): first defined here
drivers/net/ppp_deflate.o: In function `deflateInit2_':
... lots more zlib conflicts ...
drivers/isdn/tpam/tpam.o: In function `hdlc_decode':
drivers/isdn/tpam/tpam.o(.text+0x3f20): multiple definition of `hdlc_decode'
drivers/isdn/hisax/hisax_st5481.o(.text+0x30b0): first defined here
ld: Warning: size of symbol `hdlc_decode' changed from 832 to 603 in drivers/isdn/tpam/tpam.o
drivers/isdn/tpam/tpam.o: In function `hdlc_encode':
drivers/isdn/tpam/tpam.o(.text+0x3d00): multiple definition of `hdlc_encode'
drivers/isdn/hisax/hisax_st5481.o(.text+0x33f0): first defined here
ld: Warning: size of symbol `hdlc_encode' changed from 1345 to 529 in drivers/isdn/tpam/tpam.o
drivers/mtd/chips/jedec_probe.o: In function `jedec_probe_init':
drivers/mtd/chips/jedec_probe.o(.text.init+0x0): multiple definition of `jedec_probe_init'
drivers/mtd/chips/jedec.o(.text.init+0x0): first defined here

The warnings, using gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81):

arch/i386/kernel/dmi_scan.c:194: warning: `disable_ide_dma' defined but not used

drivers/atm/ambassador.c:301:10: warning: pasting "." and "start" does not give a valid preprocessing token
drivers/atm/ambassador.c:305:10: warning: pasting "." and "regions" does not give a valid preprocessing token
drivers/atm/ambassador.c:310:10: warning: pasting "." and "data" does not give a valid preprocessing token
drivers/atm/atmtcp.c:176: warning: `out_vcc' might be used uninitialized in this function
drivers/atm/atmtcp.c: In function `atmtcp_v_send':

drivers/char/applicom.c:257:2: warning: #warning "LEAK"
drivers/char/applicom.c:521:2: warning: #warning "Je suis stupide. DW. - copy*user in cli"
drivers/char/ip2/i2ellis.c:107: warning: `iiEllisCleanup' defined but not used
drivers/char/random.c:1248: warning: comparison of distinct pointer types lacks a cast
drivers/char/random.c: In function `xfer_secondary_pool':

drivers/i2c/i2c-core.c:1333: warning: implicit declaration of function `i2c_bitlp_init'
drivers/i2c/i2c-core.c: In function `i2c_init_all':

drivers/ide/pdc202xx.c:529: warning: `drive_pci' might be used uninitialized in this function
drivers/ide/pdc202xx.c: In function `config_chipset_for_dma':
drivers/ide/pdcraid.c:284: warning: label `outerr' defined but not used
drivers/ide/pdcraid.c:550: warning: unused variable `q'
drivers/ide/pdcraid.c:588: warning: unused variable `i'
drivers/ide/pdcraid.c:99: warning: unused variable `larg'
drivers/ide/pdcraid.c: In function `pdcraid0_make_request':
drivers/ide/pdcraid.c: In function `pdcraid_init':
drivers/ide/pdcraid.c: In function `pdcraid_init_one':
drivers/ide/pdcraid.c: In function `pdcraid_ioctl':

drivers/ieee1394/pcilynx.c:775: warning: `aux_ops' defined but not used

drivers/isdn/avmb1/b1pci.c:33: warning: `b1pci_pci_tbl' defined but not used
drivers/isdn/avmb1/c4.c:41: warning: `c4_pci_tbl' defined but not used
drivers/isdn/avmb1/t1pci.c:36: warning: `t1pci_pci_tbl' defined but not used
drivers/isdn/hisax/config.c:2079: warning: `hisax_pci_tbl' defined but not used

drivers/media/radio/radio-cadet.c:638: warning: `id_table' defined but not used
drivers/media/video/cpia.c:1305: warning: `proc_cpia_destroy' defined but not used
drivers/media/video/cpia.c:3290: warning: its scope is only this definition or declaration, which is probably not what you want.
drivers/media/video/cpia.c:3290: warning: `struct video_init' declared inside parameter list
drivers/media/video/msp3400.c:1233: warning: `rev2' might be used uninitialized in this function
drivers/media/video/msp3400.c: In function `msp_attach':
drivers/media/video/w9966.c:634: warning: `w9966_rReg_i2c' defined but not used

drivers/mtd/devices/doc1000.c:87:2: warning: #warning This is definitely not SMP safe. Lock the paging mechanism.

drivers/net/acenic.c:124: warning: `acenic_pci_tbl' defined but not used
drivers/net/acenic.c:1365: warning: right shift count >= width of type
drivers/net/acenic.c: In function `ace_init':
drivers/net/aironet4500_card.c:63: warning: `aironet4500_card_pci_tbl' defined but not used
drivers/net/arlan.c:1124: warning: `arlan_find_devices' defined but not used
drivers/net/arlan.c:22: warning: `probe' defined but not used
drivers/net/dgrs.c:124: warning: `dgrs_pci_tbl' defined but not used
drivers/net/fc/iph5526.c:114: warning: `iph5526_pci_tbl' defined but not used
drivers/net/fc/iph5526.c:227: warning: `driver_template' defined but not used
drivers/net/hamradio/6pack.c:703: warning: `msg_invparm' defined but not used
drivers/net/hp100.c:289: warning: `hp100_pci_tbl' defined but not used
drivers/net/irda/ali-ircc.c:467: warning: `ali_ircc_probe_43' defined but not used
drivers/net/irda/w83977af_ir.c:276: warning: `w83977af_close' defined but not used
drivers/net/pcmcia/xirc2ps_cs.c:2086:18: warning: extra tokens at end of #undef directive
drivers/net/rrunner.c:121: warning: `rrunner_pci_tbl' defined but not used
drivers/net/rrunner.c:1241: warning: comparison of distinct pointer types lacks a cast
drivers/net/rrunner.c:1252: warning: comparison of distinct pointer types lacks a cast
drivers/net/rrunner.c: In function `rr_dump':
drivers/net/sb1000.c:140: warning: `id_table' defined but not used
drivers/net/sk98lin/skvpd.c:245: warning: `VpdWriteDWord' defined but not used
drivers/net/skfp/skfddi.c:185: warning: `skfddi_pci_tbl' defined but not used
drivers/net/tokenring/olympic.c:1725:22: warning: no newline at end of file
drivers/net/tokenring/tmsisa.c:44: warning: `portlist' defined but not used
drivers/net/tulip/tulip_core.c:1326: warning: label `early_out' defined but not used
drivers/net/tulip/tulip_core.c: In function `tulip_mwi_config':
drivers/net/via-rhine.c:1590: warning: unused variable `np'
drivers/net/via-rhine.c: In function `via_rhine_remove_one':
drivers/net/wan/comx-hw-mixcom.c:570: warning: label `err_restore_flags' defined but not used
drivers/net/wan/comx-hw-mixcom.c: In function `MIXCOM_open':
drivers/net/wan/sdladrv.c:216: warning: `sdladrv_pci_tbl' defined but not used
drivers/net/winbond-840.c:146: warning: `version' defined but not used

drivers/parport/parport_cs.c:109: warning: `parport_cs_ops' defined but not used

drivers/scsi/advansys.c:5555: warning: `req_cnt' might be used uninitialized in this function
drivers/scsi/advansys.c: In function `advansys_detect':
drivers/scsi/dpt_i2o.c:115: warning: `DebugFlags' defined but not used
drivers/scsi/eata_dma.c:1070: warning: `hd' might be used uninitialized in this function
drivers/scsi/eata_dma.c: In function `register_HBA':
drivers/scsi/g_NCR5380.c:963: warning: `id_table' defined but not used
drivers/scsi/NCR5380.c:795: warning: `NCR5380_print_options' defined but not used
drivers/scsi/osst.c:1385: warning: `expected' might be used uninitialized in this function
drivers/scsi/osst.c: In function `osst_reposition_and_retry':
drivers/scsi/qla1280.c:1615: warning: `qla1280_do_dpc' defined but not used
drivers/scsi/scsi_debug.c:656: warning: unused variable `size'
drivers/scsi/scsi_debug.c: In function `scsi_debug_biosparam':
drivers/scsi/scsi.h:402:27: scsi_obsolete.h: No such file or directory
drivers/scsi/sym53c416.c:613: warning: `id_table' defined but not used
drivers/scsi/tmscsim.c:280: warning: `tmscsim_pci_tbl' defined but not used
drivers/scsi/u14-34f.c:1759: parse error before string constant
drivers/scsi/u14-34f.c:1759: warning: data definition has no type or storage class
drivers/scsi/u14-34f.c:1759: warning: function declaration isn't a prototype
drivers/scsi/u14-34f.c:1759: warning: type defaults to `int' in declaration of `MODULE_LICENSE'

drivers/sound/ad1848.c:2870: warning: `id_table' defined but not used
drivers/sound/cmpci.c:1457: warning: unused variable `s'
drivers/sound/cmpci.c: In function `cm_release_mixdev':
drivers/sound/cs4281/cs4281m.c:4478: warning: initialization from incompatible pointer type
drivers/sound/cs4281/cs4281m.c:4479: warning: initialization from incompatible pointer type
drivers/sound/rme96xx.c:1218: warning: unused variable `hwp'
drivers/sound/rme96xx.c: In function `rme96xx_release':
drivers/sound/sb_card.c:531: warning: `id_table' defined but not used
drivers/sound/trident.c:3937: warning: unused variable `mask'
drivers/sound/trident.c: In function `trident_probe':

drivers/telephony/ixj.h:41: warning: `ixj_h_rcsid' defined but not used

drivers/usb/hpusbscsi.c:351: (Each undeclared identifier is reported only once
drivers/usb/hpusbscsi.c:351: for each function it appears in.)
drivers/usb/hpusbscsi.c:351: `SCSI_ABORT_PENDING' undeclared (first use in this function)
drivers/usb/hpusbscsi.c:352: warning: control reaches end of non-void function
drivers/usb/hpusbscsi.c: In function `hpusbscsi_scsi_abort':

drivers/usb/serial/belkin_sa.c:106: warning: `id_table_combined' defined but not used
drivers/usb/serial/digi_acceleport.c:480: warning: `id_table_combined' defined but not used
drivers/usb/serial/ftdi_sio.c:137: warning: `id_table_combined' defined but not used
drivers/usb/serial/io_tables.h:33: warning: `id_table_combined' defined but not used
drivers/usb/serial/keyspan.h:349: warning: `keyspan_ids_combined' defined but not used
drivers/usb/serial/keyspan_pda.c:146: warning: `id_table_combined' defined but not used
drivers/usb/serial/mct_u232.c:129: warning: `id_table_combined' defined but not used
drivers/usb/serial/visor.c:171: warning: `id_table' defined but not used
drivers/usb/serial/whiteheat.c:116: warning: `id_table_combined' defined but not used

drivers/video/aty128fb.c:1616: warning: suggest parentheses around assignment used as truth value
drivers/video/aty128fb.c:216: warning: `font' defined but not used
drivers/video/aty128fb.c:217: warning: `mode' defined but not used
drivers/video/aty128fb.c:218: warning: `nomtrr' defined but not used
drivers/video/aty128fb.c: In function `aty128fb_setup':
drivers/video/aty/atyfb_base.c:2524: warning: suggest parentheses around assignment used as truth value
drivers/video/aty/atyfb_base.c: In function `atyfb_setup':
drivers/video/aty/mach64_accel.c:341:1: warning: pasting "fbcon_aty8" and "=" does not give a valid preprocessing token
drivers/video/aty/mach64_accel.c:344:1: warning: pasting "fbcon_aty16" and "=" does not give a valid preprocessing token
drivers/video/aty/mach64_accel.c:347:1: warning: pasting "fbcon_aty24" and "=" does not give a valid preprocessing token
drivers/video/aty/mach64_accel.c:350:1: warning: pasting "fbcon_aty32" and "=" does not give a valid preprocessing token
drivers/video/hgafb.c:798: warning: suggest parentheses around assignment used as truth value
drivers/video/hgafb.c: In function `hgafb_setup':
drivers/video/matrox/matroxfb_base.c:2358: warning: suggest parentheses around assignment used as truth value
drivers/video/matrox/matroxfb_base.c: In function `matroxfb_setup':
drivers/video/matrox/matroxfb_g450.c:7: warning: `matroxfb_g450_get_reg' defined but not used
drivers/video/radeonfb.c:1873: warning: `fbcon_radeon_clear' defined but not used
drivers/video/radeonfb.c:540: warning: suggest parentheses around assignment used as truth value
drivers/video/radeonfb.c: In function `radeonfb_setup':
drivers/video/riva/fbdev.c:2048: warning: suggest parentheses around assignment used as truth value
drivers/video/riva/fbdev.c: In function `rivafb_setup':
drivers/video/sis/sis_main.c:1729: warning: suggest parentheses around assignment used as truth value
drivers/video/sis/sis_main.c: In function `sisfb_setup':
drivers/video/sstfb.c:1700: warning: suggest parentheses around assignment used as truth value
drivers/video/sstfb.c: In function `sstfb_setup':
drivers/video/tdfxfb.c:2089: warning: suggest parentheses around assignment used as truth value
drivers/video/tdfxfb.c: In function `tdfxfb_setup':
drivers/video/vesafb.c:460: warning: suggest parentheses around assignment used as truth value
drivers/video/vesafb.c: In function `vesafb_setup':
drivers/video/vfb.c:385: warning: suggest parentheses around assignment used as truth value
drivers/video/vfb.c: In function `vfb_setup':
drivers/video/vga16fb.c:695: warning: suggest parentheses around assignment used as truth value
drivers/video/vga16fb.c: In function `vga16fb_setup':

fs/affs/super.c:273:2: warning: #warning

fs/ncpfs/ncplib_kernel.c:56: warning: `ncp_add_mem_fromfs' defined but not used

