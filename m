Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWIDSe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWIDSe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWIDSe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 14:34:56 -0400
Received: from web52902.mail.yahoo.com ([206.190.49.12]:12896 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964973AbWIDSez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 14:34:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dfqxGUSXNgKLfroEROmRN1xPAnRjBlfcEDWVTsq7BzwnKhY2nwfrN3yxpXcvryVYFIypqyaqKNwPW19CUQKKKVGoWZYE+9Nuv80otZT1jrjb9IYhhw40rA67+cJUOtvGtXizQ6PkW4FdnuIicDsYIuGLclGi0KGfKJ/JMILN3d8=  ;
Message-ID: <20060904183454.9963.qmail@web52902.mail.yahoo.com>
Date: Mon, 4 Sep 2006 19:34:54 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [BUG] NMI lockup with Linux 2.6.17.11-SMP-PREEMPT
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I triggered this oops when I accidentally booted my kernel without its /usr/lib/dri/r200_dri.so
module available:

BUG: NMI Watchdog detected LOCKUP on CPU2, eip c01097d0, registers:
Modules linked in: radeon drm pwc eeprom pcspkr p4_clockmod speedstep_lib nfsd exportfs ipv6
autofs4 nfs lockd sunrpc af_packet binfmt_misc video thermal processor fan button ac lp parport_pc
parport nvram video1394 raw1394 eth1394 compat_ioctl32 videodev snd_usb_audio snd_usb_lib
snd_intel8x0 snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_emu10k1
snd_rawmidi snd_ac97_codec snd_ac97_bus snd_seq_dummy ohci1394 snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss ieee1394 snd_pcm ehci_hcd snd_seq_device snd_timer
snd_page_alloc snd_util_mem snd_hwdep snd soundcore uhci_hcd e1000 serio_raw psmouse ide_cd
e7xxx_edac edac_mc i2c_i801 i2c_core intel_agp agpgart cdrom usbcore ext3 jbd
CPU:    2
EIP:    0060:[<c01097d0>]    Not tainted VLI
EFLAGS: 00000046   (2.6.17.11 #1)
EIP is at ipi_handler+0x10/0x54
eax: 00000000   ebx: c22cce68   ecx: 00000000   edx: f7657000
esi: c01097c0   edi: 00000000   ebp: 00000013   esp: f7657e98
ds: 007b   es: 007b   ss: 0068
Process syslogd (pid: 1925, threadinfo=f7657000 task=f74fb030)
Stack: c22cce68 c01097c0 00000000 f7cd3600 c010c1f5 f6b820f8 f6b820c0 f7438784
       c01032fc f6b820f8 00000000 00000213 f6b820c0 f7438784 f7cd3600 f7cd3698
       0000007b 0000007b fffffffb c024e606 00000060 00000213 f881e710 00000000
Call Trace:
 <c01097c0> ipi_handler+0x0/0x54  <c010c1f5> smp_call_function_interrupt+0x36/0x51
 <c01032fc> call_function_interrupt+0x1c/0x24  <c024e606> _spin_unlock_irqrestore+0x5/0x23
 <f881e710> __log_start_commit+0x23/0x2c [jbd]  <f881968a> journal_stop+0x178/0x1cd [jbd]
 <c0166c3f> __writeback_single_inode+0x1ad/0x309  <c0136bd4> do_writepages+0x2b/0x32
 <c01329e9> __filemap_fdatawrite_range+0x65/0x70  <c0166db4> sync_inode+0x19/0x2a
 <f8849215> ext3_sync_file+0x9d/0xb0 [ext3]  <c014c3f8> do_fsync+0x51/0xa5
 <c014c469> __do_fsync+0x1d/0x2b  <c010285f> sysenter_past_esp+0x54/0x75
Code: 24 14 89 f9 89 da 89 f0 5b 5b 5e 5f e9 a9 fd ff ff b8 ea ff ff ff 5a 5b 5e 5f c3 55 57 56 53
89 c3 9c 5d fa f0 ff 08 eb 02 f3 90 <8b> 43 04 85 c0 74 f7 8b 73 10 83 fe ff 8b 3d c4 50 31 c0 74
13
console shuts up ...

This is a dual P4 Xeon machine with HT enabled, kernel compiled with gcc version 4.1.1 20060525
(Red Hat 4.1.1-1). Further information available on request.

Cheers,
Chris




		
___________________________________________________________ 
All New Yahoo! Mail – Tired of Vi@gr@! come-ons? Let our SpamGuard protect you. http://uk.docs.yahoo.com/nowyoucan.html
