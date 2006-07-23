Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWGWObF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWGWObF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 10:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWGWObF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 10:31:05 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:59152 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1751214AbWGWObE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 10:31:04 -0400
From: Ondrej Zary <linux@rainbow-software.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Debugging APM - cat /proc/apm produces oops
Date: Sun, 23 Jul 2006 16:30:53 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1945
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200607231630.53968.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
cat /proc/apm produces oops on my DTK notebook. Using "apm=broken-psr" kernel 
parameter fixes that but I lose the battery info. I'd like to have the 
battery info (and it works fine in Windows) so I want to debug it and 
(hopefully) fix.

The oops:
# cat /proc/apm
<1>BUG: unable to handle kernel paging request at virtual address 00005e88
 printing eip:
00002f9d
*pre = 00000000
Oops: 0002 [#4]
Modules linked in:
CPU:    0
EIP:    00c0:[<00002f9d>]    Not tainted VLI
EFLAGS: 00010017   (2.6.17-5-dtk #23)
EIP is at 0x2f94
eax: 00000033   ebx: 00000001   ecx: 00000000   edx: 00000000
esi: c10a1000   edi: 00000014   ebp: c4755e8a   esp: c4755e88
ds: 00c8   es: 0000   ss: 0068
Process cat (pid: 1928, threadinfo=c4754000 task=c11240b0)
Stack: 5e948001 5fc75e55 00005e94 000000c8 10000033 5ea800c0 00000001 530a0000
       00000016 00b86017 00000000 0000530a c010830f 00000060 0000530a 00000033
       0000007b 0000007b c0337368 00000000 c10a1000 00000000 00000000 00000282
Call Trace:
 <c010830f> apm_bios_call+0x68/0xba  <c0108728> apm_get_power_status+0x44/0x90
 <c01091a0> apm_get_info+0x34/0xdc  <c01617dc> proc_file_read+0xda/0x22d
 <c013b5a2> vfs_read+0x82/0x10e  <c013b873> sys_read+0x3c/0x62
 <c0102397> syscall_call+0x7/0xb
Code:  Bad EIP value.
EIP: [<00002f9d>] 0x2f9d SS:ESP 0068:c4755e88

So it looks like it dies somewhere in the APM BIOS code. But how to find 
exactly where and/or why? Maybe use GDB somehow (I've used it only for really 
simple debugging yet).
I've tried calling the APM 0x530A function from DOS (real mode, int 15h) and 
single-stepping the BIOS APM code (using good old user-friendly Turbo 
Debugger). Noticed some OUTs to 0xB1 (or something like that), then some PCI 
accesses (0xCF8 and 0xCFC) and then IP ended in area of all zeros. When I 
step over the int 15h call, it works fine - returns correct info.

-- 
Ondrej Zary
