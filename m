Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275356AbTHGOE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275359AbTHGOE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:04:59 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:1238 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S275356AbTHGOEJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:04:09 -0400
From: Bernd Schubert <bernd.schubert@pci.uni-heidelberg.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.21]: nbd ksymoops-report
Date: Thu, 7 Aug 2003 16:04:05 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308071604.06015.bernd.schubert@pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

every time when nbd-client disconnects a nbd-device the decoded oops 
from below will happen. 
This only happens after we upgraded from 2.4.20 to 2.4.21, 
so I guess the backported update from 2.5.50 causes this. 
Since the changelog for 2.4.22-rc1 doesn't describe any updates to nbd, 
I think this will be also valid for this kernel version. I will check this 
later on this evening.

ksymoops 2.4.8 on i686 2.4.21-tc2.  Options used
     -v /usr/src/System.maps/vmlinux__2.4.21-tc2 (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-tc2/ (default)
     -m /usr/src/System.maps/System.map__2.4.21-tc2 (specified)

Aug  6 17:24:31 goedel kernel: d89e2be7
Aug  6 17:24:31 goedel kernel: Oops: 0000
Aug  6 17:24:31 goedel kernel: CPU:    0
Aug  6 17:24:31 goedel kernel: EIP:    1010:[<d89e2be7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  6 17:24:31 goedel kernel: EFLAGS: 00010282
Aug  6 17:24:31 goedel kernel: eax: 00000000   ebx: d89e43c4   ecx: 00000001   edx: 00000001
Aug  6 17:24:31 goedel kernel: esi: 00000000   edi: d89e43a0   ebp: 00000000   esp: d61a5f14
Aug  6 17:24:31 goedel kernel: ds: 1018   es: 1018   ss: 1018
Aug  6 17:24:31 goedel kernel: Process nbd-client (pid: 650, stackpage=d61a5000)
Aug  6 17:24:31 goedel kernel: Stack: d89e367c d4cd56e0 00000400 0000ab03 ffffffe7 00000000 d61a4000 d7fe44fc
Aug  6 17:24:31 goedel kernel:        d61a4000 00098c93 00098c94 00030002 00098c96 00098c97 00098d55 00098d56 
Aug  6 17:24:31 goedel kernel:        00098d57 00098d58 00098d59 00098d5a 00098d5b 00098d5c 00098d5d 00098e1b
Aug  6 17:24:31 goedel kernel: Call Trace:    [<d89e367c>] [<c0143f94>] [<c014c157>] [<c010a013>]
Aug  6 17:24:31 goedel kernel: Code: 8b 50 08 6a 03 50 8b 42 28 ff d0 c7 86 ac 43 9e d8 00 00 00


>>EIP; d89e2be7 <[nbd]nbd_ioctl+353/480>   <=====

>>ebx; d89e43c4 <[nbd].data.end+a4d/96e9>
>>edi; d89e43a0 <[nbd].data.end+a29/96e9>
>>esp; d61a5f14 <_end+15e07790/185558dc>

Trace; d89e367c <[nbd]__module_license+5db/78b>
Trace; c0143f94 <blkdev_ioctl+28/34>
Trace; c014c157 <sys_ioctl+1bb/1f7>
Trace; c010a013 <system_call+33/40>

Code;  d89e2be7 <[nbd]nbd_ioctl+353/480>
00000000 <_EIP>:
Code;  d89e2be7 <[nbd]nbd_ioctl+353/480>   <=====
   0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
Code;  d89e2bea <[nbd]nbd_ioctl+356/480>
   3:   6a 03                     push   $0x3
Code;  d89e2bec <[nbd]nbd_ioctl+358/480>
   5:   50                        push   %eax
Code;  d89e2bed <[nbd]nbd_ioctl+359/480>
   6:   8b 42 28                  mov    0x28(%edx),%eax
Code;  d89e2bf0 <[nbd]nbd_ioctl+35c/480>
   9:   ff d0                     call   *%eax
Code;  d89e2bf2 <[nbd]nbd_ioctl+35e/480>
   b:   c7 86 ac 43 9e d8 00      movl   $0x0,0xd89e43ac(%esi)
Code;  d89e2bf9 <[nbd]nbd_ioctl+365/480>
  12:   00 00 00



-- 
Bernd Schubert
Physikalisch Chemisches Institut / Theoretische Chemie
Universität Heidelberg
INF 229
69120 Heidelberg
e-mail: bernd.schubert@pci.uni-heidelberg.de
