Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTKGX3B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbTKGX0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 18:26:22 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:10112 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261889AbTKGWUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 17:20:00 -0500
Mime-Version: 1.0 (Apple Message framework v606)
Content-Transfer-Encoding: 7bit
Message-Id: <8C632EB4-1170-11D8-9E6D-003065FC4496@Morris-World.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Jim Morris <Jim@Morris-World.com>
Subject: Repeated system locks and "kernel bug" messages
Date: Fri, 7 Nov 2003 16:20:09 -0600
X-Mailer: Apple Mail (2.606)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server that has been giving me fits for the past couple of 
weeks, with seemingly random lockups. The system is actually running to 
some extent, but cannot be rebooted, and things like top and ps do not 
run properly. System load will climb and climb too until the system is 
physicall rebooted.

I have gotten messages similar to the one below, each time. Todays 
crash was in a kernel call from mysqld. Other times it has been 
Courier-IMAP, or some other process. I am running a 2.4.20 kernel, as 
built by Redhat for Red Hat Linux 7.3.

Here goes:

Nov  7 12:57:31 plesk kernel: Page has mapping still set. This is a 
serious situation. Ho
wever if you
Nov  7 12:57:31 plesk kernel: are using the NVidia binary only module 
please report this
bug to
Nov  7 12:57:31 plesk kernel: NVidia and not to the linux kernel 
mailinglist.
Nov  7 12:57:31 plesk kernel: ------------[ cut here ]------------
Nov  7 12:57:31 plesk kernel: kernel BUG at page_alloc.c:114!
Nov  7 12:57:31 plesk kernel: invalid operand: 0000
Nov  7 12:57:31 plesk kernel: softdog autofs eepro100 mii ide-cd cdrom 
usb-uhci usbcore e
xt3 jbd
Nov  7 12:57:31 plesk kernel: CPU:    0
Nov  7 12:57:31 plesk kernel: EIP:    0010:[<c0135bc9>]    Not tainted
Nov  7 12:57:31 plesk kernel: EFLAGS: 00010296
Nov  7 12:57:31 plesk kernel:
Nov  7 12:57:31 plesk kernel: EIP is at __free_pages_ok [kernel] 0x69 
(2.4.20-20.7)
Nov  7 12:57:31 plesk kernel: eax: 00000033   ebx: c116c8f0   ecx: 
df286000   edx: 000000
01
Nov  7 12:57:31 plesk kernel: esi: c1054474   edi: 00000000   ebp: 
00000000   esp: ca9f5e
a8
Nov  7 12:57:31 plesk kernel: ds: 0018   es: 0018   ss: 0018
Nov  7 12:57:31 plesk kernel: Process mysqld (pid: 25690, 
stackpage=ca9f5000)
Nov  7 12:57:31 plesk kernel: Stack: c02339a0 c0233940 c02338e0 
0000001f 0000001f c02df16
8 c1038030 c02df3b4
Nov  7 12:57:31 plesk kernel:        00000202 ffffffff 00003a0e 
c116c8f0 00000040 0002100
0 06828067 c012661a
Nov  7 12:57:31 plesk kernel:        c116c8f0 00001000 de59ba34 
c0126db1 dfe44780 4140100
0 de59ba34 41400000
Nov  7 12:57:31 plesk kernel: Call Trace:   [<c012661a>] __free_pte 
[kernel] 0x4a (0xca9f
5ee4))
Nov  7 12:57:31 plesk kernel: [<c0126db1>] zap_page_range [kernel] 
0x221 (0xca9f5ef4))
Nov  7 12:57:31 plesk kernel: [<c012b680>] file_read_actor [kernel] 0x0 
(0xca9f5f34))
Nov  7 12:57:31 plesk kernel: [<c012967d>] do_munmap [kernel] 0x1dd 
(0xca9f5f64))
Nov  7 12:57:31 plesk kernel: [<c013d450>] generic_file_llseek [kernel] 
0x0 (0xca9f5f88))
Nov  7 12:57:31 plesk kernel: [<c0129732>] sys_munmap [kernel] 0x32 
(0xca9f5fa4))
Nov  7 12:57:31 plesk kernel: [<c01088c3>] system_call [kernel] 0x33 
(0xca9f5fc0))
Nov  7 12:57:31 plesk kernel:
Nov  7 12:57:31 plesk kernel:
Nov  7 12:57:31 plesk kernel: Code: 0f 0b 72 00 f6 40 23 c0 83 c4 0c 8b 
0d 30 a2 34 c0 89 d8 29



Each crash has been at this line in memory.c.  I have had the RAM 
replaced, as I thought initially that it was a hardware problem. I am 
not so sure anymore.

Any help or advice is greatly appreciated! I am supposed to have a 
production web server going live on this box Monday, so if I need to 
replace it, this weekend is the time to do it.

Thanks!
  --
Jim Morris    (Jim@Morris-World.com)

