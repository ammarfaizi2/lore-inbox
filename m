Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRE3UJF>; Wed, 30 May 2001 16:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbRE3UI4>; Wed, 30 May 2001 16:08:56 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:14313 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S261969AbRE3UIn>;
	Wed, 30 May 2001 16:08:43 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105302008.NAA07710@csl.Stanford.EDU>
Subject: [CHECKER] 2.4.5-ac4 non-init functions calling init functions
To: linux-kernel@vger.kernel.org
Date: Wed, 30 May 2001 13:08:40 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are *uninspected* 2.4.5-ac4 results of a checker that warns when a
non-__init function calls an __init function (suggested by
jlundell@lobitos.net).  There seem to be two cases:

        1. The best case: the caller should actually be an __init function
	as well.  This is a performance bug since it won't be freed.

        2. The worst case: some random post-initialization routine
        calls an __init routine which can cause the kernel to go into
        hyperspace if the __init routine's code has been deleted.

The current messages do not differentiate between these two cases.  If these
results are generally useful, I can fix up the checker, but as it now stands
there shouldn't be that many false positives.

Dawson
MC linux bug database: http://hands.stanford.edu/linux

/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:757:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/es1371.c:2898:es1371_probe: ERROR:INIT: non-init fn 'es1371_probe' calling init fn 'src_init'
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/apm.c:1475:apm: ERROR:INIT: non-init fn 'apm' calling init fn 'apm_driver_version'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/avm_pci.c:746:AVM_card_msg: ERROR:INIT: non-init fn 'AVM_card_msg' calling init fn 'inithdlc'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17836:AdvSet3550EEPConfig: ERROR:INIT: non-init fn 'AdvSet3550EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:722:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17942:AdvSet38C1600EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C1600EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/tokenring/ibmtr.c:635:ibmtr_probe1: ERROR:INIT: non-init fn 'ibmtr_probe1' using init data 'ibmtr_mem_base'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/arlan.c:1276:arlan_open: ERROR:INIT: non-init fn 'arlan_open' calling init fn 'arlan_probe_everywhere'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:565:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sonicvibes.c:2491:sv_probe: ERROR:INIT: non-init fn 'sv_probe' using init data 'sv_ddma_name'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/pcwd.c:530:get_firmware: ERROR:INIT: non-init fn 'get_firmware' calling init fn 'send_command'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/istallion.c:4784:stli_initbrds: ERROR:INIT: non-init fn 'stli_initbrds' calling init fn 'stli_brdinit'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:782:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17833:AdvSet3550EEPConfig: ERROR:INIT: non-init fn 'AdvSet3550EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/ide/hd.c:915:parse_hd_setup: ERROR:INIT: non-init fn 'parse_hd_setup' calling init fn 'hd_setup'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/stallion.c:2681:stl_initech: ERROR:INIT: non-init fn 'stl_initech' calling init fn 'stl_mapirq'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/acenic.c:542:acenic_probe: ERROR:INIT: non-init fn 'acenic_probe' using init data 'probed'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/cs4281/cs4281m.c:4421:cs4281_probe: ERROR:INIT: non-init fn 'cs4281_probe' using init data 'initvol'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17904:AdvSet38C0800EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C0800EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sscape.c:1504:cleanup_sscape: ERROR:INIT: non-init fn 'cleanup_sscape' using init data 'mss'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/cyber2000fb.c:1548:cyberpro_probe: ERROR:INIT: non-init fn 'cyberpro_probe' calling init fn 'fb_find_mode'
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/setup.c:744:parse_mem_cmdline: ERROR:INIT: non-init fn 'parse_mem_cmdline' calling init fn 'add_memory_region'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/mpu401.c:1772:cleanup_mpu401: ERROR:INIT: non-init fn 'cleanup_mpu401' using init data 'irq'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/BusLogic.c:2395:BusLogic_InitializeHostAdapter: ERROR:INIT: non-init fn 'BusLogic_InitializeHostAdapter' calling init fn 'BusLogic_Failure'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17806:AdvSet3550EEPConfig: ERROR:INIT: non-init fn 'AdvSet3550EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/pcwd.c:529:get_firmware: ERROR:INIT: non-init fn 'get_firmware' calling init fn 'send_command'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/pnp/quirks.c:139:isapnp_fixup_device: ERROR:INIT: non-init fn 'isapnp_fixup_device' using init data 'isapnp_fixups'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/media/video/cpia_pp.c:654:cpia_pp_init: ERROR:INIT: non-init fn 'cpia_pp_init' using init data 'parport_nr'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:568:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/media/video/cpia_pp.c:618:cpia_pp_attach: ERROR:INIT: non-init fn 'cpia_pp_attach' using init data 'parport_nr'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/istallion.c:4618:stli_findeisabrds: ERROR:INIT: non-init fn 'stli_findeisabrds' calling init fn 'stli_brdinit'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/riva/fbdev.c:1949:rivafb_init_one: ERROR:INIT: non-init fn 'rivafb_init_one' using init data 'nohwcursor'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/radeonfb.c:830:radeon_init_disp_var: ERROR:INIT: non-init fn 'radeon_init_disp_var' calling init fn 'fb_find_mode'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/tdfxfb.c:2085:tdfxfb_setup: ERROR:INIT: non-init fn 'tdfxfb_setup' using init data 'mode_option'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:733:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/g_NCR5380.c:250:generic_DTC3181E_setup: ERROR:INIT: non-init fn 'generic_DTC3181E_setup' calling init fn 'internal_setup'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/avm_pci.c:745:AVM_card_msg: ERROR:INIT: non-init fn 'AVM_card_msg' calling init fn 'clear_pending_hdlc_ints'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/radeonfb.c:834:radeon_init_disp_var: ERROR:INIT: non-init fn 'radeon_init_disp_var' calling init fn 'fb_find_mode'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17883:AdvSet38C0800EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C0800EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17969:AdvSet38C1600EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C1600EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/esssolo1.c:2259:setup_solo1: ERROR:INIT: non-init fn 'setup_solo1' using init data 'initvol'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17901:AdvSet38C0800EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C0800EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/es1370.c:2652:es1370_probe: ERROR:INIT: non-init fn 'es1370_probe' using init data 'initvol'
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/setup.c:754:parse_mem_cmdline: ERROR:INIT: non-init fn 'parse_mem_cmdline' calling init fn 'add_memory_region'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:756:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/hfc_pci.c:1665:hfcpci_card_msg: ERROR:INIT: non-init fn 'hfcpci_card_msg' calling init fn 'inithfcpci'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17788:AdvSet3550EEPConfig: ERROR:INIT: non-init fn 'AdvSet3550EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/riva/fbdev.c:1778:riva_init_disp: ERROR:INIT: non-init fn 'riva_init_disp' using init data 'noaccel'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17815:AdvSet3550EEPConfig: ERROR:INIT: non-init fn 'AdvSet3550EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/apic.c:773:setup_APIC_timer: ERROR:INIT: non-init fn 'setup_APIC_timer' calling init fn 'wait_8254_wraparound'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:723:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sonicvibes.c:2638:sv_probe: ERROR:INIT: non-init fn 'sv_probe' using init data 'initvol'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17920:AdvSet38C1600EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C1600EEPConfig' using init data 'ADVEEP_38C1600_Config_Field_IsChar'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17972:AdvSet38C1600EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C1600EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/nm256_audio.c:1265:nm256_probe: ERROR:INIT: non-init fn 'nm256_probe' calling init fn 'nm256_install'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/aedsp16.c:1356:cleanup_aedsp16: ERROR:INIT: non-init fn 'cleanup_aedsp16' calling init fn 'uninit_aedsp16'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:783:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/riva/fbdev.c:1757:riva_init_disp_var: ERROR:INIT: non-init fn 'riva_init_disp_var' using init data 'mode_option'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:721:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/BusLogic.c:2369:BusLogic_InitializeHostAdapter: ERROR:INIT: non-init fn 'BusLogic_InitializeHostAdapter' calling init fn 'BusLogic_Failure'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:570:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/BusLogic.c:1410:BusLogic_HardwareResetHostAdapter: ERROR:INIT: non-init fn 'BusLogic_HardwareResetHostAdapter' calling init fn 'BusLogic_Failure'
/u2/engler/mc/oses/linux/2.4.5-ac4/init/main.c:855:init: ERROR:INIT: non-init fn 'init' calling init fn 'do_basic_setup'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/radeonfb.c:828:radeon_init_disp_var: ERROR:INIT: non-init fn 'radeon_init_disp_var' using init data 'mode_option'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:781:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17951:AdvSet38C1600EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C1600EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/sb_card.c:777:sb_init: ERROR:INIT: non-init fn 'sb_init' using init data 'sb_isapnp_list'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/riva/fbdev.c:1949:rivafb_init_one: ERROR:INIT: non-init fn 'rivafb_init_one' calling init fn 'rivafb_init_cursor'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/pcwd.c:531:get_firmware: ERROR:INIT: non-init fn 'get_firmware' calling init fn 'send_command'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/istallion.c:4688:stli_initpcibrd: ERROR:INIT: non-init fn 'stli_initpcibrd' calling init fn 'stli_brdinit'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/cmpci.c:3178:initialize_chip: ERROR:INIT: non-init fn 'initialize_chip' using init data 'initvol'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/riva/fbdev.c:1894:rivafb_init_one: ERROR:INIT: non-init fn 'rivafb_init_one' using init data 'nomtrr'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/tokenring/ibmtr.c:645:ibmtr_probe1: ERROR:INIT: non-init fn 'ibmtr_probe1' using init data 'ibmtr_mem_base'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17856:AdvSet38C0800EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C0800EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/pcwd.c:528:get_firmware: ERROR:INIT: non-init fn 'get_firmware' calling init fn 'send_command'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/gazel.c:569:setup_gazelpci: ERROR:INIT: non-init fn 'setup_gazelpci' using init data 'dev_tel'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/pnp/quirks.c:141:isapnp_fixup_device: ERROR:INIT: non-init fn 'isapnp_fixup_device' using init data 'isapnp_fixups'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/acenic.c:540:acenic_probe: ERROR:INIT: non-init fn 'acenic_probe' using init data 'probed'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/lance.c:357:lance_probe: ERROR:INIT: non-init fn 'lance_probe' using init data 'lance_portlist'
/u2/engler/mc/oses/linux/2.4.5-ac4/net/ipv4/netfilter/ip_nat_standalone.c:278:init_or_cleanup: ERROR:INIT: non-init fn 'init_or_cleanup' calling init fn 'ip_nat_rule_init'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/mpu401.c:1772:cleanup_mpu401: ERROR:INIT: non-init fn 'cleanup_mpu401' using init data 'io'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/nm256_audio.c:1263:nm256_probe: ERROR:INIT: non-init fn 'nm256_probe' calling init fn 'nm256_install'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/stallion.c:2908:stl_initbrds: ERROR:INIT: non-init fn 'stl_initbrds' calling init fn 'stl_brdinit'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/g_NCR5380.c:237:generic_NCR53C400A_setup: ERROR:INIT: non-init fn 'generic_NCR53C400A_setup' calling init fn 'internal_setup'
/u2/engler/mc/oses/linux/2.4.5-ac4/arch/i386/kernel/setup.c:768:parse_mem_cmdline: ERROR:INIT: non-init fn 'parse_mem_cmdline' calling init fn 'print_memory_map'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/cs46xx.c:5074:cs_hardware_init: ERROR:INIT: non-init fn 'cs_hardware_init' calling init fn 'cs_ac97_init'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17784:AdvSet3550EEPConfig: ERROR:INIT: non-init fn 'AdvSet3550EEPConfig' using init data 'ADVEEP_3550_Config_Field_IsChar'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/es1371.c:2911:es1371_probe: ERROR:INIT: non-init fn 'es1371_probe' using init data 'initvol'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/plip.c:1335:plip_attach: ERROR:INIT: non-init fn 'plip_attach' calling init fn 'plip_init_dev'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17852:AdvSet38C0800EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C0800EEPConfig' using init data 'ADVEEP_38C0800_Config_Field_IsChar'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/hisax/w6692.c:950:w6692_card_msg: ERROR:INIT: non-init fn 'w6692_card_msg' calling init fn 'initW6692'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/stallion.c:2821:stl_initpcibrd: ERROR:INIT: non-init fn 'stl_initpcibrd' calling init fn 'stl_brdinit'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/BusLogic.c:2383:BusLogic_InitializeHostAdapter: ERROR:INIT: non-init fn 'BusLogic_InitializeHostAdapter' calling init fn 'BusLogic_Failure'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/riva/fbdev.c:1759:riva_init_disp_var: ERROR:INIT: non-init fn 'riva_init_disp_var' calling init fn 'fb_find_mode'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/video/matrox/matroxfb_base.c:1785:initMatrox2: ERROR:INIT: non-init fn 'initMatrox2' calling init fn 'fb_find_mode'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/sdla.c:1344:sdla_set_config: ERROR:INIT: non-init fn 'sdla_set_config' using init data 'valid_port'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17874:AdvSet38C0800EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C0800EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/char/stallion.c:2481:stl_initeio: ERROR:INIT: non-init fn 'stl_initeio' calling init fn 'stl_mapirq'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/scsi/advansys.c:17924:AdvSet38C1600EEPConfig: ERROR:INIT: non-init fn 'AdvSet38C1600EEPConfig' calling init fn 'AdvWaitEEPCmd'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/media/video/cpia_pp.c:633:cpia_pp_attach: ERROR:INIT: non-init fn 'cpia_pp_attach' using init data 'parport_nr'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/tokenring/ibmtr.c:637:ibmtr_probe1: ERROR:INIT: non-init fn 'ibmtr_probe1' using init data 'ibmtr_mem_base'
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/mtd/docprobe.c:195:DoC_Probe: ERROR:INIT: non-init fn 'DoC_Probe' calling init fn 'doccheck'
