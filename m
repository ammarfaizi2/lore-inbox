Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265283AbTLRIig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbTLRIig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:38:36 -0500
Received: from smtp4.hy.skanova.net ([195.67.199.133]:13551 "EHLO
	smtp4.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265283AbTLRIi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:38:28 -0500
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Stack usage for functions in kernel 2.4.21 [SuSE] (worst case 2.8kB !)
Date: Thu, 18 Dec 2003 09:32:35 +0100
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200312180932.36365.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi developers,

Is your function among these? Do you really need that much stack?

(This is a follow up to my <<UPD: "do_IRQ: near stack overflow" when inserting 
CF disk>> i since than learned about the checkstack tool by Jörn Engel)

The reason for some functions to show up twice is probably due to 
kernel/external pcmcia.

/RogerL

Please cc: currently not subscribed.

vmlinux
# objdump -d vmlinux | perl scripts/checkstack.pl i386 > vmlinux.stack
0xc03282d4 sanitize_e820_map:                     sub    $0x744,%esp
0xc01053ab huft_build:                          sub    $0x590,%esp
0xc0106144 inflate_dynamic:                     sub    $0x514,%esp
0xc01fa414 ide_unregister:                     sub    $0x4b0,%esp
0xc0106002 inflate_fixed:                     sub    $0x490,%esp
0xc0334e40 root_nfs_name:                     sub    $0x404,%esp
0xc0111333 pcibios_fixup_peer_bridges:                sub    $0x324,%esp
0xc01107b8 pci_sanity_check:                     sub    $0x324,%esp
0xc019b484 semctl_main:                          sub    $0x244,%esp
0xc01654eb elf_core_dump:                     sub    $0x240,%esp
0xc01c48e4 do_kdgkb_ioctl:                     sub    $0x230,%esp
0xc02438fb ip_setsockopt:                     sub    $0x218,%esp
- - -

modules
# objdump -d `find /lib/modules/2.4.21-144-default/kernel/ -name "*.o"` | perl 
scripts/checkstack.pl i386 > modules.stack

0x     da4 i2o_proc_read_ddm_table:                sub    $0xb48,%esp
0x    2259 cdromread:                          sub    $0xa70,%esp
0x    1d63 intelfb_set_mode:                     sub    $0x960,%esp
0x      26 adm1026_detect:                     sub    $0x850,%esp
0x   295db ocfs_hash_stat:                     sub    $0x834,%esp
0x    4164 ia_ioctl:                          sub    $0x820,%esp
0x    3886 i2o_proc_read_lan_alt_addr:                sub    $0x818,%esp
0x    3136 i2o_proc_read_lan_mcast_addr:           sub    $0x818,%esp
0x    21b7 CpqTsProcessIMQEntry:                sub    $0x814,%esp
0x    11e4 i2o_proc_read_groups:                sub    $0x810,%esp
0x    7157 writerids:                          sub    $0x808,%esp
0x   28dc3 ocfs_proc_hash_stats:                sub    $0x800,%esp
0x    7003 readrids:                          sub    $0x800,%esp
0x    2014 PeekIMQEntry:                     sub    $0x800,%esp
0x    21b4 hfa384x_int_info:                     sub    $0x7d0,%esp
0x    2114 hfa384x_int_info:                     sub    $0x7d0,%esp
0x    20a4 hfa384x_int_info:                     sub    $0x7d0,%esp
0x    7df4 SendAssocRequest:                     sub    $0x78c,%esp
0x    7df4 SendAssocRequest:                     sub    $0x78c,%esp
0x    7dd4 SendAssocRequest:                     sub    $0x78c,%esp
0x    81a4 SendReAssocRequest:                     sub    $0x77c,%esp
0x    81a4 SendReAssocRequest:                     sub    $0x77c,%esp
0x    8184 SendReAssocRequest:                     sub    $0x77c,%esp
0x     114 lm85_detect:                          sub    $0x728,%esp
0x   28e69 ocfs_ioctl:                          sub    $0x710,%esp
0x    1734 UMSDOS_ioctl_dir:                     sub    $0x6c4,%esp
0x     f24 amd_flash_probe:                     sub    $0x654,%esp
0x    7a74 SendAuthRequest:                     sub    $0x61c,%esp
0x    7a74 SendAuthRequest:                     sub    $0x61c,%esp
0x    7a54 SendAuthRequest:                     sub    $0x61c,%esp
0x    3e94 SendReAssociationRequest:                sub    $0x61c,%esp
0x    3cd4 SendAssociationRequest:                sub    $0x61c,%esp
0x    3ac4 SendAuthenticationRequest:                sub    $0x61c,%esp
0x   14dce exec_external_cgi:                     sub    $0x5c4,%esp
0x    5163 em8300_ioctl_getstatus:                sub    $0x588,%esp
0x   10394 dohash:                          sub    $0x57c,%esp
0x    1be4 sc_ioctl:                          sub    $0x578,%esp
0x    53f4 huft_build:                          sub    $0x574,%esp
0x    1c04 ida_ioctl:                          sub    $0x550,%esp
0x   68f89 xfs_dm_get_allocinfo_rvp:                sub    $0x50c,%esp
0x    71d4 prism2_ioctl_giwaplist:                sub    $0x50c,%esp
0x    6ef4 ieee80211_ioctl_iwaplist:                sub    $0x50c,%esp
0x     ee8 device_new_if:                     sub    $0x504,%esp
0x    3e04 presto_ioctl:                     sub    $0x4dc,%esp
0x    5b42 inflate_trees_fixed:                     sub    $0x4c4,%esp
0x     e64 wavelan_ioctl:                     sub    $0x4a0,%esp
0x    556b sadb_msg_update_parse:                sub    $0x480,%esp
0x    1849 br_ioctl_device:                     sub    $0x480,%esp
0x   28c96 ocfs_proc_statistics:                sub    $0x474,%esp
0x       e init_blk_dev_info:                     sub    $0x468,%esp
0x     8a4 wavelan_ioctl:                     sub    $0x45c,%esp
0x    1304 sw_connect:                          sub    $0x450,%esp
0x    1d64 cdrom_ioctl_Rcd83e2a4:                sub    $0x434,%esp
0x   3d4c4 osi_AssertFailK:                     sub    $0x420,%esp
0x   14b94 handle_cgi_reply:                     sub    $0x41c,%esp
0x   17f64 ciGetLeafPrefixKey:                     sub    $0x414,%esp
0x    c514 print_request_stats:                     sub    $0x410,%esp
0x     c52 cdrom_select_disc_R0ee73c30:                sub    $0x410,%esp
0x     b07 cdrom_number_of_slots_Rd198fefc:           sub    $0x410,%esp
0x     a91 cdrom_slot_status:                     sub    $0x410,%esp
0x     88b rtime_compress:                     sub    $0x408,%esp
0x      66 ath_hal_vprintf:                     sub    $0x408,%esp
0x    2242 befs_warning:                     sub    $0x400,%esp
0x    21e2 befs_error:                          sub    $0x400,%esp
0x    1864 hex_dump:                          sub    $0x400,%esp
0x     99b rtime_decompress:                     sub    $0x400,%esp
0x    13d7 ray_dev_ioctl_R12eb3cea:                sub    $0x3fc,%esp
0x     d74 bt3c_config:                          sub    $0x3f8,%esp
0x     ca4 awc_i365_probe_once:                     sub    $0x3f8,%esp
0x     bb4 btuart_config:                     sub    $0x3f8,%esp
0x   10514 aic7xxx_detect:                     sub    $0x3f4,%esp
0x     d24 dtl1_config:                          sub    $0x3f4,%esp
0x    10e4 bluecard_config:                     sub    $0x3f0,%esp
0x     374 snd_mixart_add_ref_pipe:                sub    $0x3ec,%esp
0x   14a64 ndisc_redirect_rcv:                     sub    $0x3e4,%esp
0x    1549 wavefront_load_gus_patch:                sub    $0x3d0,%esp
0x    b5e4 Vpd:                               sub    $0x3c4,%esp
0x    9c94 prism2sta_config:                     sub    $0x3c0,%esp
0x    3926 do_zoran_ioctl:                     sub    $0x3bc,%esp
0x     3f4 mgslpc_config:                     sub    $0x3b4,%esp
0x      c4 dmascc_init:                          sub    $0x3a4,%esp
0x    13cc gdth_get_info:                     sub    $0x394,%esp
0x     234 arlan_sysctl_info:                     sub    $0x394,%esp
0x       4 com90xx_probe:                     sub    $0x394,%esp
0x    723e cs46xx_dsp_scb_and_task_init:           sub    $0x384,%esp
0x    b024 e1000_ethtool_ioctl:                     sub    $0x37c,%esp
0x    94a4 udf_add_entry:                     sub    $0x368,%esp
0x    68c4 snd_pcm_hw_params_old_user:                sub    $0x360,%esp
0x    6844 snd_pcm_hw_refine_old_user:                sub    $0x360,%esp
0x    20a4 snd_ice1712_ac97_mixer:                sub    $0x360,%esp
0x    33c4 hfsplus_readdir:                     sub    $0x348,%esp
0x    1fcb setup_card:                          sub    $0x348,%esp
0x    34c4 megadev_ioctl:                     sub    $0x340,%esp
0x    1c53 bus_structure_fixup:                     sub    $0x324,%esp
0x    85b6 cpqhp_set_irq:                     sub    $0x320,%esp
0x    3244 sym53c8xx_detect:                     sub    $0x31c,%esp
0x    8e94 sym53c8xx_detect:                     sub    $0x318,%esp
0x    1d24 sym53c8xx__detect:                     sub    $0x314,%esp
0x   10fa4 presto_journal_unlink:                sub    $0x30c,%esp
0x    50b6 sadb_msg_getspi_parse:                sub    $0x308,%esp
0x    e843 register_mimetype:                     sub    $0x304,%esp
0x    1496 log_device_info:                     sub    $0x300,%esp
0x   107e4 presto_journal_rename:                sub    $0x2fc,%esp
0x    1eb4 netdev_ethtool_ioctl:                sub    $0x2f8,%esp
0x    2f79 isapnp_config_activate:                sub    $0x2f0,%esp
0x    d844 presto_journal_setattr:                sub    $0x2ec,%esp
0x    f4b4 presto_journal_rmdir:                sub    $0x2e8,%esp
0x    fa94 presto_journal_mknod:                sub    $0x2e4,%esp
0x   11584 presto_journal_close:                sub    $0x2e0,%esp
0x   10054 presto_journal_link:                     sub    $0x2dc,%esp
0x    ef24 presto_journal_mkdir:                sub    $0x2dc,%esp
0x    e979 presto_journal_symlink:                sub    $0x2dc,%esp
0x    e3e4 presto_journal_create:                sub    $0x2dc,%esp
0x    2576 bttv_ioctl:                          sub    $0x2d0,%esp
0x    13b4 restore_mixer_state:                     sub    $0x2d0,%esp
0x    12e4 save_mixer_state:                     sub    $0x2d0,%esp
0x   28e84 ipsec6_input_check:                     sub    $0x2cc,%esp
0x    cc94 presto_write_lml_close:                sub    $0x2cc,%esp
0x    7729 cb_alloc:                          sub    $0x2c0,%esp
0x     444 mhz_mfc_config:                     sub    $0x2c0,%esp
0x    9484 SkPnmiGetStruct:                     sub    $0x2bc,%esp
0x    1d4b ibm_configure_device:                sub    $0x2b8,%esp
0x    82db cpqhp_configure_device:                sub    $0x2b4,%esp
0x    74a6 cb_scan_new_bus:                     sub    $0x2b4,%esp
0x    453b amdshpc_configure_device:                sub    $0x2b4,%esp
0x    3234 build_snapshot_maps:                     sub    $0x2b4,%esp
0x    5908 hp_AddDevice:                     sub    $0x2b0,%esp
0x    1e16 enable_device:                     sub    $0x2a8,%esp
0x     c24 ds_ioctl:                          sub    $0x2a8,%esp
0x    5d38 sadb_msg_addflow_parse:                sub    $0x2a4,%esp
0x     964 smc_setup:                          sub    $0x2a0,%esp
0x     884 smc_config:                          sub    $0x2a0,%esp
0x     841 has_ce2_string:                     sub    $0x2a0,%esp
0x     634 mhz_setup:                          sub    $0x2a0,%esp
0x   50c29 PSetVolumeStatus:                     sub    $0x29c,%esp
0x   50879 PGetVolumeStatus:                     sub    $0x29c,%esp
0x    d394 udf_load_pvoldesc:                     sub    $0x298,%esp
0x    7754 prism2mib_priv:                     sub    $0x298,%esp
0x    7754 prism2mib_priv:                     sub    $0x298,%esp
0x    7034 prism2mib_priv:                     sub    $0x298,%esp
0x    6f74 prism2mib_priv:                     sub    $0x298,%esp
0x    6f14 prism2mib_priv:                     sub    $0x298,%esp
0x    13b4 do_ida_request:                     sub    $0x298,%esp
0x    4a94 do_cciss_request:                     sub    $0x294,%esp
0x    3354 ncp_ioctl:                          sub    $0x28c,%esp
0x     854 VLDB_Same:                          sub    $0x288,%esp
0x    1d05 snd_pcm_oss_get_formats:                sub    $0x284,%esp
0x     444 axnet_config:                     sub    $0x284,%esp
0x     754 pcnet_config:                     sub    $0x280,%esp
0x   4b554 afs_syscall_call:                     sub    $0x27c,%esp
0x    2be4 UMSDOS_link:                          sub    $0x27c,%esp
0x    3bd4 snd_pcm_oss_proc_write:                sub    $0x270,%esp
0x    3196 hfsplus_lookup:                     sub    $0x270,%esp
0x    2ee4 hfsplus_rename_cat:                     sub    $0x270,%esp
0x     494 netwave_ioctl:                     sub    $0x26c,%esp
0x     ea4 port_detect:                          sub    $0x268,%esp
0x    69c3 reiserfs_rename:                     sub    $0x264,%esp
0x    3699 wv_82586_start:                     sub    $0x264,%esp
0x    2403 snd_pcm_hw_params_user:                sub    $0x260,%esp
0x    20b3 snd_pcm_hw_refine_user:                sub    $0x260,%esp
0x     b74 cpqfcTS_proc_info:                     sub    $0x25c,%esp
0x     674 hfsplus_read_super:                     sub    $0x254,%esp
0x    2844 umsdos_rename_f:                     sub    $0x250,%esp
0x    3084 orinoco_ioctl_getiwrange:                sub    $0x24c,%esp
- - -

-- 
Roger Larsson
Skellefteå
Sweden
