Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbTKHLDG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 06:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbTKHLDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 06:03:06 -0500
Received: from mail.gmx.de ([213.165.64.20]:25065 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261699AbTKHLDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 06:03:01 -0500
X-Authenticated: #1226656
Date: Sat, 8 Nov 2003 12:02:59 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops on resume with APM (2.4.23-pre6)
Message-Id: <20031108120259.0b068425.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

That's the first time on which I could catch an Oops from the logfile
after a failed resume. Something like this happens also with kernels
prior to 2.4.23 (I think since 2.4.19)

greets 

Marc

ksymoops 2.4.9 on i686 2.4.23-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-pre6/ (default)
     -m /boot/System.map-2423-pre6 (specified)

Reading Oops report from the terminal
Nov  8 11:16:03 vaio kernel: c011a843
Nov  8 11:16:03 vaio kernel: Oops: 0000
Nov  8 11:16:03 vaio kernel: CPU:    0
Nov  8 11:16:04 vaio kernel: EIP:    0010:[<c011a843>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  8 11:16:04 vaio kernel: EFLAGS: 00010083
Nov  8 11:16:04 vaio kernel: eax: c0325720   ebx: c6dffe14   ecx: 00000000   edx: c0325720
Nov  8 11:16:04 vaio kernel: esi: ccc8ffb0   edi: 00000003   ebp: cbd0fee4   esp: cbd0fec8
Nov  8 11:16:04 vaio kernel: ds: 0018   es: 0018   ss: 0018
Nov  8 11:16:04 vaio kernel: Process X (pid: 15423, stackpage=cbd0f000)
Nov  8 11:16:04 vaio kernel: Stack: c6dfe000 00000000 00000001 00000282 c1314c08 c1316754 c
1316740 00000000
Nov  8 11:16:04 vaio kernel:        d0c6a7e2 cc91d000 c0253da6 c1314c00 c0253edb c1314c00 c
1316740 00000003
Nov  8 11:16:04 vaio kernel:        00000000 c0254023 c1316740 c130b2e0 c0254085 c130b460 c
012b9b2 c130b2e0
Nov  8 11:16:04 vaio kernel: Call Trace:    [<d0c6a7e2>] [<c0253da6>] [<c0253edb>] [<c02540
Nov  8 11:16:04 vaio kernel:   [<c012b9b2>] [<c012bab4>] [<c0116153>] [<c011686c>] [<c011a3
Nov  8 11:16:04 vaio kernel:   [<c010917f>]
Nov  8 11:16:04 vaio kernel: Code: 8b 01 85 c7 75 19 8b 02 89 d3 89 c2 0f 18 00 39 f3 75 ea


>>EIP; c011a843 <__wake_up+33/80>   <=====

>>eax; c0325720 <default_ldt+0/28>
>>ebx; c6dffe14 <_end+6a36c24/1080ee70>
>>edx; c0325720 <default_ldt+0/28>
>>esi; ccc8ffb0 <_end+c8c6dc0/1080ee70>
>>ebp; cbd0fee4 <_end+b946cf4/1080ee70>
>>esp; cbd0fec8 <_end+b946cd8/1080ee70>

Trace; d0c6a7e2 <[snd-ymfpci]snd_card_ymfpci_resume+12/20>
Trace; c0253da6 <pci_pm_resume_device+26/30>
Trace; c0253edb <pci_pm_resume_bus+2b/70>
Trace; c012b9b2 <pm_send+72/a0>
Trace; c012bab4 <pm_send_all+74/b0>
Trace; c0116153 <suspend+e3/120>
Trace; c011686c <do_ioctl+10c/180>
Trace; c010917f <system_call+33/38>

Code;  c011a843 <__wake_up+33/80>
00000000 <_EIP>:
Code;  c011a843 <__wake_up+33/80>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c011a845 <__wake_up+35/80>
   2:   85 c7                     test   %eax,%edi
Code;  c011a847 <__wake_up+37/80>
   4:   75 19                     jne    1f <_EIP+0x1f>
Code;  c011a849 <__wake_up+39/80>
   6:   8b 02                     mov    (%edx),%eax
Code;  c011a84b <__wake_up+3b/80>
   8:   89 d3                     mov    %edx,%ebx
Code;  c011a84d <__wake_up+3d/80>
   a:   89 c2                     mov    %eax,%edx
Code;  c011a84f <__wake_up+3f/80>
   c:   0f 18 00                  prefetchnta (%eax)
Code;  c011a852 <__wake_up+42/80>
   f:   39 f3                     cmp    %esi,%ebx
Code;  c011a854 <__wake_up+44/80>
  11:   75 ea                     jne    fffffffd <_EIP+0xfffffffd>

