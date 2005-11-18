Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbVKRU5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbVKRU5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161219AbVKRU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:57:43 -0500
Received: from web34113.mail.mud.yahoo.com ([66.163.178.111]:38781 "HELO
	web34113.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161217AbVKRU5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:57:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4oRaszlqLLy//C6R7PybFGcZ/ry43RFnwZy1pYnFYXq+oNMeDrqtab1Iuj76kl24FJ9+6FgvhIWOmqwAI2ZQapF0Wvlty4UpD10+rtCWSJeTCU7E6pIYacr+J6Lo0Sn4BnlxVlrAbvWrYtA6JOkVeBuLoV0jn0cUkC6CcbCo14I=  ;
Message-ID: <20051118205741.97473.qmail@web34113.mail.mud.yahoo.com>
Date: Fri, 18 Nov 2005 12:57:41 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: re: 2.6.15-rc1-mm2 - strace unhappy
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

strace causes the kernel to croak:

cd /tmp
strace ls
*BOOM*

Nov 18 15:44:31 tux6127 kernel: [  221.522945] c0126b5b
Nov 18 15:44:31 tux6127 kernel: [  221.523069] PREEMPT SMP DEBUG_PAGEALLOC
Nov 18 15:44:31 tux6127 kernel: [  221.523268] Modules linked in: autofs4 parport_pc parport
floppy rtc i2c_i801 i2c_core generic usbhid uhci_hcd tg3 snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd usbcore mousedev
e1000 bcm5700 unix
Nov 18 15:44:31 tux6127 kernel: [  221.524392] CPU:    0
Nov 18 15:44:31 tux6127 kernel: [  221.524393] EIP:    0060:[<c0126b5b>]    Not tainted VLI
Nov 18 15:44:31 tux6127 kernel: [  221.524394] EFLAGS: 00010202   (2.6.15-rc1-mm2) 
Nov 18 15:44:31 tux6127 kernel: [  221.524525] EIP is at ptrace_check_attach+0x24/0xc4
Nov 18 15:44:31 tux6127 kernel: [  221.524570] eax: 00000001   ebx: 00000000   ecx: 00000001  
edx: c0561e00
Nov 18 15:44:31 tux6127 kernel: [  221.524617] esi: fffffffd   edi: 00000000   ebp: f4edbf90  
esp: f4edbf80
Nov 18 15:44:31 tux6127 kernel: [  221.524663] ds: 007b   es: 007b   ss: 0068
Nov 18 15:44:31 tux6127 kernel: [  221.524707] Process strace (pid: 3895, threadinfo=f4edb000
task=f6a6d9d0)
Nov 18 15:44:31 tux6127 kernel: [  221.524753] Stack: c01273cc 00000000 00000000 00000018 f4edbfb4
c0127430 00000000 00000000 
Nov 18 15:44:31 tux6127 kernel: [  221.525159]        00005007 00000000 00000018 00000000 b7fbc138
f4edb000 c0102e6f 00000018 
Nov 18 15:44:31 tux6127 kernel: [  221.525564]        00000f38 00000001 00000000 b7fbc138 bfce55d8
0000001a 0000007b c010007b 
Nov 18 15:44:31 tux6127 kernel: [  221.525970] Call Trace:
Nov 18 15:44:31 tux6127 kernel: [  221.526065]  [<c0103dbc>] show_stack+0x80/0x96
Nov 18 15:44:31 tux6127 kernel: [  221.526195]  [<c0103f55>] show_registers+0x161/0x1c5
Nov 18 15:44:31 tux6127 kernel: [  221.526324]  [<c0104173>] die+0x12e/0x1b6
Nov 18 15:44:31 tux6127 kernel: [  221.526451]  [<c042bf0b>] do_page_fault+0x300/0x608
Nov 18 15:44:31 tux6127 kernel: [  221.526583]  [<c0103a67>] error_code+0x4f/0x54
Nov 18 15:44:31 tux6127 kernel: [  221.526712]  [<c0127430>] sys_ptrace+0x52/0xd2
Nov 18 15:44:31 tux6127 kernel: [  221.526840]  [<c0102e6f>] sysenter_past_esp+0x54/0x75
Nov 18 15:44:31 tux6127 kernel: [  221.526969] ---------------------------
Nov 18 15:44:31 tux6127 kernel: [  221.527021] | preempt count: 00000002 ]
Nov 18 15:44:31 tux6127 kernel: [  221.527072] | 2 level deep critical section nesting:
Nov 18 15:44:31 tux6127 kernel: [  221.527125] ----------------------------------------
Nov 18 15:44:31 tux6127 kernel: [  221.527178] .. [<c042b1ec>] .... _read_lock+0x18/0x8e
Nov 18 15:44:31 tux6127 kernel: [  221.527270] .....[<c0126b5b>] ..   ( <=
ptrace_check_attach+0x24/0xc4)
Nov 18 15:44:31 tux6127 kernel: [  221.527363] .. [<c042b12e>] .... _spin_lock_irqsave+0x1b/0x9d
Nov 18 15:44:31 tux6127 kernel: [  221.527456] .....[<c0104089>] ..   ( <= die+0x44/0x1b6)
Nov 18 15:44:31 tux6127 kernel: [  221.527548] 
Nov 18 15:44:31 tux6127 kernel: [  221.527597] Code: 43 7c e9 69 ff ff ff 55 b8 00 1e 56 c0 89 e5
83 ec 10 89 5d f4 89 75 f8 89 7d fc 8b 5d 08 8b 7d 0c be fd ff ff ff e8 79 46 30 00 <8b> 53 10 f6
c2 01 74 11 8b 8b c4 00 00 00 b8 00 f0 ff ff 21 e0 
Nov 18 15:44:31 tux6127 kernel: [  221.530117]  <3>Debug: sleeping function called from invalid
context at include/linux/rwsem.h:43
Nov 18 15:44:31 tux6127 kernel: [  221.530254] in_atomic():1, irqs_disabled():0
Nov 18 15:44:31 tux6127 kernel: [  221.530312]  [<c0103df0>] dump_stack+0x1e/0x22
Nov 18 15:44:31 tux6127 kernel: [  221.530454]  [<c011b38e>] __might_sleep+0xa7/0xaf
Nov 18 15:44:31 tux6127 kernel: [  221.530602]  [<c011ee22>] profile_task_exit+0x22/0x60
Nov 18 15:44:31 tux6127 kernel: [  221.530752]  [<c0120e09>] do_exit+0x1d/0x4aa
Nov 18 15:44:31 tux6127 kernel: [  221.530896]  [<c01041fb>] do_divide_error+0x0/0xc3
Nov 18 15:44:31 tux6127 kernel: [  221.531040]  [<c042bf0b>] do_page_fault+0x300/0x608
Nov 18 15:44:31 tux6127 kernel: [  221.531178]  [<c0103a67>] error_code+0x4f/0x54
Nov 18 15:44:31 tux6127 kernel: [  221.531307]  [<c0127430>] sys_ptrace+0x52/0xd2
Nov 18 15:44:31 tux6127 kernel: [  221.531435]  [<c0102e6f>] sysenter_past_esp+0x54/0x75
Nov 18 15:44:31 tux6127 kernel: [  221.531575] ---------------------------
Nov 18 15:44:31 tux6127 kernel: [  221.531629] | preempt count: 00000001 ]
Nov 18 15:44:31 tux6127 kernel: [  221.531698] | 1 level deep critical section nesting:
Nov 18 15:44:31 tux6127 kernel: [  221.531760] ----------------------------------------
Nov 18 15:44:31 tux6127 kernel: [  221.531818] .. [<c042b1ec>] .... _read_lock+0x18/0x8e
Nov 18 15:44:31 tux6127 kernel: [  221.531916] .....[<c0126b5b>] ..   ( <=
ptrace_check_attach+0x24/0xc4)
Nov 18 15:44:31 tux6127 kernel: [  221.532016] 
Nov 18 15:44:31 tux6127 kernel: [  221.532130] ---------------------------
Nov 18 15:44:31 tux6127 kernel: [  221.532184] | preempt count: 00000001 ]
Nov 18 15:44:31 tux6127 kernel: [  221.532239] | 1 level deep critical section nesting:
Nov 18 15:44:31 tux6127 kernel: [  221.532295] ----------------------------------------
Nov 18 15:44:31 tux6127 kernel: [  221.532351] .. [<c042b1ec>] .... _read_lock+0x18/0x8e
Nov 18 15:44:31 tux6127 kernel: [  221.532450] .....[<c0126b5b>] ..   ( <=
ptrace_check_attach+0x24/0xc4)
Nov 18 15:44:31 tux6127 kernel: [  221.532557] 
Nov 18 15:44:41 tux6127 kernel: [  231.047393] 
Nov 18 15:44:41 tux6127 kernel: [  231.047446] Pid: 3895, comm:               strace
Nov 18 15:44:41 tux6127 kernel: [  231.047501] EIP: 0060:[<c042b429>] CPU: 0
Nov 18 15:44:41 tux6127 kernel: [  231.047559] EIP is at _write_lock_irqsave+0x78/0x9d
Nov 18 15:44:41 tux6127 kernel: [  231.047614]  EFLAGS: 00000202    Not tainted  (2.6.15-rc1-mm2)
Nov 18 15:44:41 tux6127 kernel: [  231.047670] EAX: 00000001 EBX: 00000286 ECX: c0561e00 EDX:
00000001
Nov 18 15:44:41 tux6127 kernel: [  231.047727] ESI: c0561e00 EDI: f4edb000 EBP: f4edbe30 DS: 007b
ES: 007b
Nov 18 15:44:41 tux6127 kernel: [  231.047823] CR0: 8005003b CR2: 00000010 CR3: 005aa000 CR4:
00000640
Nov 18 15:44:41 tux6127 kernel: [  231.047881] ---------------------------
Nov 18 15:44:41 tux6127 kernel: [  231.047935] | preempt count: 00010001 ]
Nov 18 15:44:41 tux6127 kernel: [  231.047988] | 1 level deep critical section nesting:
Nov 18 15:44:41 tux6127 kernel: [  231.048041] ----------------------------------------
Nov 18 15:44:41 tux6127 kernel: [  231.048096] .. [<c042b1ec>] .... _read_lock+0x18/0x8e
Nov 18 15:44:41 tux6127 kernel: [  231.048191] .....[<c0126b5b>] ..   ( <=
ptrace_check_attach+0x24/0xc4)
Nov 18 15:44:41 tux6127 kernel: [  231.048289] 


-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
