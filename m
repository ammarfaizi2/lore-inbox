Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVAXWg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVAXWg1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVAXWel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:34:41 -0500
Received: from web53810.mail.yahoo.com ([206.190.36.205]:5456 "HELO
	web53810.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261704AbVAXWbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:31:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=LlEjdnvXLb7GFA13ZapiH4RxTPMkz/ixLEYl7p3eMj8JWX74awgHehQ5R5JlflhlaoTPzD+SUgXv10wBDMXjPJ9FH3xJgUWbGCeFHfOD+hQTzaG1XH+bS0ph0e5a57ZFfNlLnRfE6TJDduS6/YRpBQc8TehtgLYFf8qq8F5it34=  ;
Message-ID: <20050124223141.18617.qmail@web53810.mail.yahoo.com>
Date: Mon, 24 Jan 2005 14:31:41 -0800 (PST)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: Further results for kmalloc from linux-tracecalls
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  It was erroneously asserted by Horst von Brand that 'linux-tracecalls'
  
    "can not find where a function could be called through a pointer"
    
  On the contrary, almost all the chains are terminated with a callback function,
somewhat fewer with an init function, and fewest of all with a syscall.

  Just for fun here is the first half of the (aggregated) list of all functions
terminating chains from our pruned results for kmalloc, marked with the number of
chains terminated by each of the 280 functions in this partial list:

(
COMMAND was
/usr/lib/cgi-bin/lnxtc.pl -file=include/linux/slab.h -func=kmalloc -nohtml=1 \
  -prune='drivers/acpi,fs/xfs,kernel/sched.c,kernel/panic.c,mm/oom_kill.c' |
perl -00lane 'print $F[0]' |
sort |
uniq -c |
sort -rn |
median.pl
)

Total chains are 59228
Number of syscalls, callbacks, init functions, etc, terminating chains is 5873
Weighted median is "37   drivers/net/pcmcia/fmvj18x_cs.c::fmvj18x_event"
Mean is 10

   2156	drivers/scsi/osst.c::osst_ioctl
    978	drivers/scsi/osst.c::os_scsi_tape_flush
    747	drivers/scsi/osst.c::osst_write
    532	fs/jffs2/dir.c::jffs2_rename
    455	drivers/scsi/osst.c::osst_read
    391	fs/jffs2/dir.c::jffs2_mknod
    391	fs/jffs2/dir.c::jffs2_mkdir
    391	fs/jffs2/dir.c::jffs2_create
    351	fs/hpfs/file.c::hpfs_truncate
    330	drivers/usb/media/ov511.c::ov51x_probe
    324	fs/hpfs/inode.c::hpfs_notify_change
    324	fs/hpfs/file.c::hpfs_file_release
    314	drivers/usb/media/ov511.c::ov51x_v4l1_ioctl_internal
    286	net/rose/rose_dev.c::rose_rebuild_header
    269	fs/jffs2/fs.c::jffs2_setattr
    269	fs/jffs2/fs.c::jffs2_dirty_inode
    268	fs/jffs2/write.c::jffs2_write_inode_range
    268	fs/jffs2/file.c::jffs2_prepare_write
    266	fs/jffs2/dir.c::jffs2_symlink
    266	fs/jffs2/dir.c::jffs2_rmdir
    266	fs/jffs2/dir.c::jffs2_link
    243	init/main.c::init
    225	fs/hpfs/super.c::hpfs_fill_super
    222	net/rose/rose_loopback.c::rose_loopback_timer
    220	drivers/usb/media/ov511.c::ov51x_v4l1_open
    210	drivers/scsi/qla2xxx/qla_init.c::qla2x00_initialize_adapter
    202	fs/hpfs/dir.c::hpfs_lookup
    188	fs/hpfs/namei.c::hpfs_mkdir
    187	fs/ntfs/super.c::ntfs_fill_super
    171	sound/usb/usbaudio.c::usb_audio_probe
    171	fs/jffs2/background.c::jffs2_garbage_collect_thread
    169	fs/jffs2/fs.c::jffs2_write_super
    169	fs/hpfs/namei.c::hpfs_symlink
    169	fs/hpfs/namei.c::hpfs_mknod
    169	fs/hpfs/namei.c::hpfs_create
    169	drivers/net/sk98lin/skge.c::SkGeIoctl
    165	net/ipv6/tcp_ipv6.c::tcp_v6_hash
    164	fs/jffs2/file.c::jffs2_fsync
    161	drivers/net/irda/smsc-ircc2.c::smsc_ircc_init
    156	net/ipv6/addrconf.c::addrconf_init
    156	fs/cifs/file.c::cifs_readdir
    156	drivers/scsi/qla2xxx/qla_init.c::qla2x00_configure_fabric
    145	net/bridge/br_ioctl.c::br_ioctl_deviceless_stub
    139	drivers/net/sk98lin/skgepnmi.c::DiagActions
    138	drivers/scsi/osst.c::os_scsi_tape_open
    136	fs/hfsplus/dir.c::hfsplus_rename
    135	fs/hfs/dir.c::hfs_rename
    134	fs/hfs/extent.c::hfs_get_block
    132	security/keys/keyctl.c::sys_keyctl
    130	net/ax25/ax25_in.c::ax25_kiss_rcv
    129	net/ipv4/udp.c::udp_setsockopt
    129	net/ipv4/raw.c::raw_setsockopt
    125	net/ipv4/af_inet.c::inet_init
    123	drivers/scsi/pcmcia/fdomain_stub.c::fdomain_event
    123	drivers/scsi/aic7xxx/aic7xxx_osm_pci.c::ahc_linux_pci_dev_probe
    122	drivers/scsi/aic7xxx/aic7770_osm.c::aic7770_eisa_dev_probe
    121	net/ipv4/af_inet.c::inet_ioctl
    121	fs/nfsd/nfs4proc.c::nfsd4_proc_compound
    117	drivers/scsi/pcmcia/qlogic_stub.c::qlogic_event
    116	drivers/scsi/aic7xxx/aic79xx_osm_pci.c::ahd_linux_pci_dev_probe
    116	drivers/net/pcmcia/smc91c92_cs.c::smc_open
    114	net/netrom/nr_loopback.c::nr_loopback_timer
    113	sound/usb/usbaudio.c::create_composite_quirk
    113	drivers/pcmcia/ds.c::ds_ioctl
    111	drivers/net/Space.c::net_olddevs_init
    107	drivers/scsi/sata_vsc.c::vsc_sata_init_one
    107	drivers/scsi/sata_svw.c::k2_sata_init_one
    107	drivers/scsi/sata_promise.c::pdc_ata_init_one
    107	drivers/scsi/sata_nv.c::nv_init_one
    107	drivers/scsi/ahci.c::ahci_init_one
    106	drivers/scsi/sata_via.c::svia_init_one
    106	drivers/scsi/sata_uli.c::uli_init_one
    106	drivers/scsi/sata_sis.c::sis_init_one
    106	drivers/scsi/ata_piix.c::piix_init_one
    105	fs/hfsplus/dir.c::hfsplus_link
    101	drivers/usb/image/microtek.c::mts_usb_probe
    101	drivers/usb/image/hpusbscsi.c::hpusbscsi_usb_probe
    101	drivers/scsi/NCR_Q720.c::NCR_Q720_probe
    101	drivers/scsi/NCR_D700.c::NCR_D700_probe
    100	drivers/scsi/sim710.c::sim710_mca_probe
    100	drivers/scsi/sim710.c::sim710_eisa_probe
    100	drivers/scsi/BusLogic.c::BusLogic_init
     99	drivers/scsi/tmscsim.c::dc390_probe_one
     99	drivers/scsi/scsi_debug.c::sdebug_driver_probe
     99	drivers/scsi/qlogicfas.c::qlogicfas_init
     99	drivers/scsi/dmx3191d.c::dmx3191d_probe_one
     98	net/ipv6/ndisc.c::pndisc_redo
     98	net/ipv6/icmp.c::icmpv6_rcv
     96	fs/hfs/super.c::hfs_fill_super
     94	sound/pci/cs46xx/cs46xx.c::snd_card_cs46xx_probe
     92	sound/pci/ymfpci/ymfpci.c::snd_card_ymfpci_probe
     88	net/decnet/af_decnet.c::decnet_init
     86	sound/pci/emu10k1/emu10k1.c::snd_card_emu10k1_probe
     85	fs/ntfs/mft.c::ntfs_mft_record_alloc
     85	drivers/pci/hotplug/pciehp_ctrl.c::event_thread
     84	fs/hfsplus/super.c::hfsplus_fill_super
     84	drivers/net/sk98lin/skgepnmi.c::OidStruct
     82	fs/hfs/dir.c::hfs_rmdir
     82	drivers/usb/storage/usb.c::usb_stor_scan_thread
     80	fs/jffs2/gc.c::jffs2_garbage_collect_live
     79	net/sctp/sm_sideeffect.c::sctp_generate_t3_rtx_event
     79	net/sctp/sm_sideeffect.c::sctp_generate_heartbeat_event
     79	fs/udf/super.c::udf_fill_super
     79	fs/hfs/dir.c::hfs_readdir
     77	net/sctp/sm_sideeffect.c::sctp_generate_t5_shutdown_guard_event
     77	net/sctp/sm_sideeffect.c::sctp_generate_t4_rto_event
     77	net/sctp/sm_sideeffect.c::sctp_generate_t2_shutdown_event
     77	net/sctp/sm_sideeffect.c::sctp_generate_t1_init_event
     77	net/sctp/sm_sideeffect.c::sctp_generate_t1_cookie_event
     77	net/sctp/sm_sideeffect.c::sctp_generate_sack_event
     77	net/sctp/sm_sideeffect.c::sctp_generate_autoclose_event
     77	net/sctp/endpointola.c::sctp_endpoint_bh_rcv
     76	sound/pci/trident/trident.c::snd_trident_probe
     75	net/ipv4/tcp_ipv4.c::tcp_v4_rcv
     75	fs/jffs2/gc.c::jffs2_garbage_collect_dnode
     75	drivers/char/pcmcia/synclink_cs.c::synclink_cs_init
     74	fs/jffs2/gc.c::jffs2_garbage_collect_metadata
     74	drivers/scsi/scsi_proc.c::proc_scsi_write
     74	drivers/net/bonding/bond_main.c::bond_netdev_event
     72	drivers/net/wireless/wl3501_cs.c::wl3501_event
     71	net/x25/x25_dev.c::x25_lapb_receive_frame
     71	fs/hpfs/file.c::hpfs_get_block
     71	drivers/scsi/scsi_sysfs.c::store_scan
     69	net/rose/af_rose.c::rose_proto_init
     69	fs/hfs/extent.c::hfs_file_truncate
     68	sound/isa/gus/interwave.c::alsa_card_interwave_init
     68	net/wanrouter/wanmain.c::wanrouter_ioctl
     68	net/netrom/af_netrom.c::nr_proto_init
     68	drivers/net/skfp/skfddi.c::skfp_interrupt
     68	drivers/net/ppp_generic.c::ppp_ioctl
     67	sound/isa/gus/gusextreme.c::snd_gusextreme_legacy_auto_probe
     67	sound/isa/gus/gusextreme.c::alsa_card_gusextreme_init
     67	net/x25/x25_dev.c::x25_llc_receive_frame
     67	net/8021q/vlan.c::vlan_ioctl_handler
     67	fs/jffs2/gc.c::jffs2_garbage_collect_deletion_dirent
     67	drivers/char/pcmcia/synclink_cs.c::synclink_cs_exit
     65	drivers/usb/gadget/ether.c::eth_bind
     65	drivers/pci/hotplug/ibmphp_core.c::enable_slot
     64	sound/isa/gus/interwave.c::snd_interwave_probe_legacy_port
     64	sound/isa/gus/interwave.c::snd_interwave_pnp_detect
     64	net/decnet/af_decnet.c::dn_ioctl
     63	sound/pci/cmipci.c::snd_cmipci_probe
     62	drivers/pci/hotplug/acpiphp_glue.c::handle_hotplug_event_func
     62	arch/i386/pci/legacy.c::pci_legacy_init
     61	sound/pci/ice1712/ice1724.c::snd_vt1724_probe
     60	sound/pci/via82xx.c::snd_via82xx_probe
     60	sound/isa/gus/gusmax.c::snd_gusmax_legacy_auto_probe
     60	sound/isa/gus/gusmax.c::alsa_card_gusmax_init
     60	net/sctp/sm_sideeffect.c::sctp_cmd_process_sack
     58	sound/pci/ice1712/ice1712.c::snd_ice1712_probe
     58	net/decnet/sysctl_net_decnet.c::dn_node_address_strategy
     58	net/decnet/sysctl_net_decnet.c::dn_node_address_handler
     58	fs/ntfs/aops.c::ntfs_readpage
     58	fs/befs/linuxvfs.c::befs_readdir
     58	drivers/usb/media/ibmcam.c::ibmcam_adjust_picture
     58	drivers/char/synclink.c::synclink_init
     57	net/irda/irlan/irlan_common.c::irlan_init
     57	drivers/usb/core/usb.c::usb_init
     56	fs/cifs/inode.c::cifs_rename
     56	drivers/usb/media/ibmcam.c::ibmcam_video_start
     56	drivers/isdn/i4l/isdn_common.c::isdn_receive_skb_callback
     55	sound/oss/gus_card.c::init_gus
     55	drivers/net/wireless/atmel_cs.c::atmel_event
     54	fs/hpfs/namei.c::hpfs_unlink
     54	fs/hpfs/namei.c::hpfs_rmdir
     54	fs/hpfs/namei.c::hpfs_rename
     54	drivers/scsi/qla2xxx/qla_init.c::qla2x00_find_all_fabric_devs
     54	drivers/net/sk98lin/skge.c::skge_remove_one
     54	drivers/net/pcmcia/com20020_cs.c::com20020_event
     53	sound/isa/wavefront/wavefront.c::alsa_card_wavefront_init
     53	drivers/char/pcmcia/synclink_cs.c::mgslpc_attach
     52	net/x25/x25_in.c::x25_backlog_rcv
     52	net/rose/rose_timer.c::rose_timer_expiry
     52	fs/hfsplus/dir.c::hfsplus_symlink
     52	fs/hfsplus/dir.c::hfsplus_mknod
     52	fs/hfsplus/dir.c::hfsplus_mkdir
     52	fs/hfsplus/dir.c::hfsplus_create
     52	drivers/serial/serial_cs.c::serial_event
     51	drivers/scsi/qla2xxx/qla_init.c::qla2x00_rescan_fcports
     51	drivers/net/pcmcia/xirc2ps_cs.c::xirc2ps_event
     51	drivers/net/bonding/bond_main.c::bond_activebackup_arp_mon
     50	sound/isa/opti9xx/opti92x-ad1848.c::alsa_card_opti9xx_init
     50	drivers/net/wireless/orinoco_cs.c::orinoco_cs_event
     50	drivers/char/pcmcia/synclink_cs.c::mgslpc_event
     49	sound/isa/wavefront/wavefront.c::snd_wavefront_pnp_detect
     49	drivers/net/wan/wanxl.c::wanxl_pci_init_one
     48	net/bridge/br_ioctl.c::br_dev_ioctl
     48	fs/hpfs/inode.c::hpfs_delete_inode
     48	drivers/usb/media/se401.c::se401_do_ioctl
     48	drivers/net/bonding/bond_main.c::bond_close
     47	sound/pci/ens1370.c::snd_audiopci_probe
     47	sound/isa/opl3sa2.c::alsa_card_opl3sa2_init
     47	net/atm/br2684.c::br2684_ioctl
     47	drivers/message/i2o/iop.c::i2o_iop_init
     46	net/packet/af_packet.c::packet_setsockopt
     46	net/ipv6/addrconf.c::addrconf_add_ifaddr
     46	net/appletalk/ddp.c::atalk_init
     46	drivers/net/wireless/prism54/islpci_hotplug.c::prism54_probe
     46	drivers/net/sis900.c::sis900_probe
     46	drivers/net/irda/irtty-sir.c::irtty_open
     45	net/ipv4/ipconfig.c::ic_dev_ioctl
     45	drivers/usb/core/hub.c::hub_thread
     45	drivers/scsi/scsi.c::init_scsi
     45	drivers/scsi/qla2xxx/qla_init.c::qla2x00_loop_resync
     45	drivers/pcmcia/cs.c::pccardd
     45	drivers/net/wireless/atmel_cs.c::atmel_cs_cleanup
     45	drivers/net/wan/pci200syn.c::pci200_pci_init_one
     45	drivers/net/wan/n2.c::n2_init
     45	drivers/net/bonding/bond_main.c::bonding_init
     44	sound/oss/trix.c::init_trix
     44	net/atm/clip.c::clip_ioctl
     44	drivers/net/wan/sealevel.c::slvl_init_module
     44	drivers/net/s2io.c::s2io_init_nic
     44	drivers/net/hamradio/yam.c::yam_init_driver
     44	drivers/net/ethertap.c::ethertap_init
     44	drivers/net/dummy.c::dummy_init_module
     43	sound/isa/opl3sa2.c::snd_opl3sa2_pnp_detect
     43	sound/core/oss/pcm_oss.c::snd_pcm_oss_plugin_clear
     43	net/sctp/sm_statefuns.c::sctp_sf_do_5_2_4_dupcook
     43	net/sched/sch_teql.c::teql_init
     43	net/bluetooth/bnep/sock.c::bnep_sock_ioctl
     43	fs/cifs/cifsfs.c::cifs_get_sb
     43	drivers/pci/hotplug/shpchp_ctrl.c::event_thread
     43	drivers/pci/hotplug/cpqphp_ctrl.c::event_thread
     43	drivers/net/wan/dlci.c::dlci_ioctl
     43	drivers/net/sundance.c::sundance_probe1
     43	drivers/net/dgrs.c::dgrs_pci_probe
     43	drivers/net/dgrs.c::dgrs_eisa_probe
     43	drivers/media/dvb/dvb-core/dvb_net.c::dvb_net_do_ioctl
     42	sound/oss/mad16.c::init_mad16
     42	sound/isa/sb/sb16.c::alsa_card_sb16_init
     42	net/sctp/sm_statefuns.c::sctp_sf_do_5_2_2_dupinit
     42	net/sctp/sm_statefuns.c::sctp_sf_do_5_2_1_siminit
     42	net/ax25/af_ax25.c::ax25_ioctl
     42	fs/hfs/btree.c::hfs_bmap_alloc
     42	drivers/usb/net/pegasus.c::pegasus_probe
     41	sound/isa/gus/gusclassic.c::snd_gusclassic_legacy_auto_probe
     41	sound/isa/gus/gusclassic.c::alsa_card_gusclassic_init
     41	sound/isa/ad1816a/ad1816a.c::snd_ad1816a_pnp_detect
     41	fs/hfs/dir.c::hfs_mkdir
     41	fs/hfs/dir.c::hfs_lookup
     41	fs/hfs/dir.c::hfs_create
     41	fs/hfs/attr.c::hfs_setxattr
     41	fs/hfs/attr.c::hfs_getxattr
     40	sound/oss/sb_card.c::sb_init
     40	sound/isa/cs423x/cs4236.c::alsa_card_cs423x_init
     40	sound/isa/azt2320.c::snd_azt2320_pnp_detect
     40	net/ipv6/addrconf.c::addrconf_del_ifaddr
     40	fs/partitions/check.c::register_disk
     40	drivers/scsi/st.c::st_ioctl
     39	sound/pci/cs4281.c::snd_cs4281_probe
     39	fs/ntfs/aops.c::ntfs_writepage
     39	drivers/usb/serial/usb-serial.c::usb_serial_init
     39	drivers/net/sk98lin/skge.c::skge_probe_one
     38	sound/oss/sb_card.c::sb_pnp_probe
     38	sound/isa/sb/sb16.c::snd_sb16_probe_legacy_port
     38	sound/isa/sb/sb16.c::snd_sb16_pnp_detect
     38	net/sctp/sm_statefuns.c::sctp_sf_do_5_1B_init
     38	fs/ntfs/lcnalloc.c::__ntfs_cluster_free
     38	fs/cifs/file.c::cifs_open
     38	fs/befs/linuxvfs.c::befs_lookup
     38	drivers/net/sk98lin/skge.c::SkGeIsrOnePort
     38	drivers/net/sk98lin/skge.c::SkGeIsr
     37	sound/isa/es18xx.c::alsa_card_es18xx_init
     37	net/ipx/af_ipx.c::ipx_ioctl
     37	fs/cifs/inode.c::cifs_mkdir
     37	fs/cifs/file.c::cifs_writepage
     37	fs/cifs/file.c::cifs_readpages
     37	fs/cifs/file.c::cifs_readpage
     37	fs/cifs/file.c::cifs_prepare_write
     37	fs/cifs/file.c::cifs_commit_write
     37	fs/cifs/dir.c::cifs_dir_open
     37	fs/cifs/cifsfs.c::cifs_write_wrapper
     37	fs/cifs/cifsfs.c::cifs_read_wrapper
     37	drivers/usb/storage/usb.c::storage_probe
     37	drivers/usb/serial/io_ti.c::edge_startup
     37	drivers/usb/net/kaweth.c::kaweth_probe
     37	drivers/pci/hotplug/cpqphp_core.c::process_SI
     37	drivers/net/wireless/wavelan_cs.c::wavelan_event
     37	drivers/net/pcmcia/fmvj18x_cs.c::fmvj18x_event
     ...


