Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUIUGCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUIUGCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 02:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIUGCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 02:02:47 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:51351 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267319AbUIUGCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 02:02:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux1394-devel@lists.sourceforge.net
Subject: [OOPS] 2.6.9-rc2-bk: Firewire died while writingto a DVD+R
Date: Tue, 21 Sep 2004 01:02:39 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409210102.39930.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the last night pull from Linus' tree got the following trace while
writing to a DVD+R daisy chained to a hard drive. Happened only once and
after rebooting and repeating write (thankfully it was a RW media) burn
finished successfully.

The kernel is tainted with binary NVidia module so feel free to disregard.
  
-- 
Dmitry

ieee1394: sbp2: aborting sbp2 command
Write (10) 00 00 0a 3f d0 00 00 10 00
ieee1394: Node changed: 0-02:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-01:1023]  GUID[0030e001e0ac0f63]
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0030e00150ac0103]
ieee1394: sbp2: aborting sbp2 command
Write (10) 00 00 0d 19 f0 00 00 10 00
Unable to handle kernel paging request at virtual address 00001de9
 printing eip:
e0f05307
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: sr_mod sd_mod sbp2 scsi_mod floppy snd_pcm_oss snd_mixer_oss vmnet vmmon usbhi
d wacom nvidia 8250 serial_core parport_pc lp parport ipt_REJECT ipt_conntrack ipt_pkttype ipt_mu
ltiport ipt_ULOG ipt_state ipt_length ipt_owner ipt_MARK ipt_TOS iptable_mangle ipt_MASQUERADE ip
table_nat cls_fw sch_tbf sch_prio sch_sfq sch_htb atmel_cs atmel firmware_class crc32 3c59x bondi
ng iptable_filter snd_maestro3 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore uhci
_hcd usbcore mousedev psmouse
CPU:    0
EIP:    0060:[<e0f05307>]    Tainted: P   VLI
EFLAGS: 00010003   (2.6.9-rc2)
EIP is at sbp2util_find_command_for_SCpnt+0x27/0x90 [sbp2]
eax: 00001de9   ebx: 00001de9   ecx: d728b6e8   edx: c757a000
esi: 00000086   edi: c9987040   ebp: c757af58   esp: c757af4c
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_1 (pid: 6396, threadinfo=c757a000 task=daa8baa0)
Stack: c9987040 d728b660 c757afb0 c757af6c e0f07aba e0f08b60 c757a000 00000206
       c757af80 e0f23294 c9987040 c757afb0 c757afb0 c757af98 e0f233b7 c757afa8
       dff8b630 c757a000 00000286 c757afc4 e0f23f2b c757afb0 dff8b600 c757afa8
Call Trace:
 [<c01056aa>] show_stack+0x7a/0x90
 [<c010582a>] show_registers+0x14a/0x1c0
 [<c0105a1b>] die+0xdb/0x170
 [<c01140da>] do_page_fault+0x23a/0x590
 [<c0105295>] error_code+0x2d/0x38
 [<e0f07aba>] sbp2scsi_abort+0x3a/0x90 [sbp2]
 [<e0f23294>] scsi_try_to_abort_cmd+0x64/0x80 [scsi_mod]
 [<e0f233b7>] scsi_eh_abort_cmds+0x47/0x80 [scsi_mod]
 [<e0f23f2b>] scsi_unjam_host+0x9b/0xc0 [scsi_mod]
 [<e0f23fec>] scsi_error_handler+0x9c/0xc0 [scsi_mod]
 [<c01032d5>] kernel_thread_helper+0x5/0x10
Code: 8d 74 26 00 55 89 e5 57 89 d7 56 53 9c 5e fa ba 00 f0 ff ff 21 e2 ff 42 14 8d 88 88 00 00 0
0 8b 80 88 00 00 00 39 c8 74 2c 89 c3 <8b> 00 0f 18 00 90 39 cb 74 20 eb 0d 90 90 90 90 90 90 90
90 90
<6>note: scsi_eh_1[6396] exited with preempt_count 2
bad: scheduling while atomic!
 [<c01056d7>] dump_stack+0x17/0x20
 [<c02e46e0>] schedule+0x4c0/0x4d0
 [<c0135cc9>] generic_file_buffered_write+0x3e9/0x610
 [<c0136146>] generic_file_aio_write_nolock+0x256/0x450
 [<c0136447>] generic_file_aio_write+0x67/0xd0
 [<c018647d>] ext3_file_write+0x2d/0xd0
 [<c015077f>] do_sync_write+0x8f/0xd0
 [<c013342c>] do_acct_process+0x33c/0x370
 [<c01334a3>] acct_process+0x43/0x8a
 [<c011b1f1>] do_exit+0x81/0x3e0
 [<c0105aad>] die+0x16d/0x170
 [<c01140da>] do_page_fault+0x23a/0x590
 [<c0105295>] error_code+0x2d/0x38
 [<e0f07aba>] sbp2scsi_abort+0x3a/0x90 [sbp2]
 [<e0f23294>] scsi_try_to_abort_cmd+0x64/0x80 [scsi_mod]
 [<e0f233b7>] scsi_eh_abort_cmds+0x47/0x80 [scsi_mod]
 [<e0f23f2b>] scsi_unjam_host+0x9b/0xc0 [scsi_mod]
 [<e0f23fec>] scsi_error_handler+0x9c/0xc0 [scsi_mod]
 [<c01032d5>] kernel_thread_helper+0x5/0x10
