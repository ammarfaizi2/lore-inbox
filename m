Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWDBQZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWDBQZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 12:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWDBQZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 12:25:11 -0400
Received: from mail.charite.de ([160.45.207.131]:49564 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932384AbWDBQZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 12:25:09 -0400
Date: Sun, 2 Apr 2006 18:25:04 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: EIP when unloading powernow_k8 on 2.6.16-git18
Message-ID: <20060402162504.GA14747@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got an EIP today when unloading powernow_k8 on 2.6.16-git18:

% rmmod powernow_k8 

resulted in:

Apr  2 12:34:06 knarzkiste kernel: BUG: unable to handle kernel NULL pointer dereference at virtual address 0000002c
Apr  2 12:34:06 knarzkiste kernel:  printing eip:
Apr  2 12:34:06 knarzkiste kernel: dee75b09
Apr  2 12:34:06 knarzkiste kernel: *pde = 00000000
Apr  2 12:34:06 knarzkiste kernel: Oops: 0000 [#1]
Apr  2 12:34:06 knarzkiste kernel: PREEMPT
Apr  2 12:34:06 knarzkiste kernel: Modules linked in: rt2500 tun thermal fan button ac battery af_packet ide_scsi sata_sil libata scsi_mod eeprom powernow_k8 freq_table processor saa7134_dvb mt352 video_buf_dvb dvb_core nxt200x dvb_pll tda1004x usbhid usbmouse tda9887 tuner saa7134 video_buf compat_ioctl32 v4l2_common v4l1_compat ir_kbd_i2c ir_common videodev pcmcia firmware_class tsdev 8139too 8250_pci 8250 serial_core evdev psmouse yenta_socket rsrc_nonstatic pcmcia_core ehci_hcd ohci_hcd ide_cd usbcore snd_atiixp_modem snd_atiixp snd_ac97_codec snd_ac97_bus ati_agp agpgart snd_pcm snd_timer snd soundcore snd_page_alloc cdrom unix
Apr  2 12:34:06 knarzkiste kernel: CPU:    0
Apr  2 12:34:06 knarzkiste kernel: EIP:    0060:[pg0+514472713/1069728768]    Not tainted VLI
Apr  2 12:34:06 knarzkiste kernel: EFLAGS: 00010286   (2.6.16-git18 #1)
Apr  2 12:34:06 knarzkiste kernel: EIP is at acpi_processor_unregister_performance+0x1e/0x3e [processor]
Apr  2 12:34:06 knarzkiste kernel: eax: 00000000   ebx: ddbd2800   ecx: 00000001   edx: 00000000
Apr  2 12:34:06 knarzkiste kernel: esi: dd0d08c0   edi: 00000286   ebp: dd0d094c   esp: c39c9f1c
Apr  2 12:34:06 knarzkiste kernel: ds: 007b   es: 007b   ss: 0068
Apr  2 12:34:06 knarzkiste kernel: Process rmmod (pid: 12796, threadinfo=c39c9000 task=c0475a70)
Apr  2 12:34:06 knarzkiste kernel: Stack: <0>dcd53b40 ded3a4d6 dd0d08c0 dd0d08e8 c0295102 c03abf88 c034a7b0 c03482dc
Apr  2 12:34:06 knarzkiste kernel:        c03482c0 c02769c7 00000880 ded3c100 00000000 c39c9000 c0293f75 c01364e6
Apr  2 12:34:06 knarzkiste kernel:        65776f70 776f6e72 00386b5f c4c24d2c c0149c09 b7fe7000 dd9e5e40 c014b038
Apr  2 12:34:06 knarzkiste kernel: Call Trace:
Apr  2 12:34:06 knarzkiste kernel:  <ded3a4d6> powernowk8_cpu_exit+0x26/0x50 [powernow_k8]   <c0295102> cpufreq_remove_dev+0xb2/0x120
Apr  2 12:34:06 knarzkiste kernel:  <c02769c7> sysdev_driver_unregister+0x67/0x80   <c0293f75> cpufreq_unregister_driver+0x25/0x60
Apr  2 12:34:06 knarzkiste kernel:  <c01364e6> sys_delete_module+0x146/0x1c0   <c0149c09> remove_vma+0x39/0x50
Apr  2 12:34:06 knarzkiste kernel:  <c014b038> do_munmap+0x198/0x1f0   <c0102e93> sysenter_past_esp+0x54/0x75
Apr  2 12:34:06 knarzkiste kernel: Code: 01 00 00 31 c0 83 c4 2c 5b 5e 5f 5d c3 53 ff 0d d8 80 e7 de 0f 88 f8 01 00 00 8b 1c 95 8c 82 e7 de 85 db 74 18 8b 83 6c 02 00 00 <8b> 40 2c e8 8f 02 2e e1 c7 83 6c 02 00 00 00 00 00 00 ff 05 d8

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 36
model name      : AMD Turion(tm) 64 Mobile Technology ML-30
stepping        : 2
cpu MHz         : 1592.270
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext
fxsr_opt lm 3dnowext 3dnow up pni lahf_lm ts fid vid ttp tm stc
bogomips        : 3188.99


-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
