Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbTIMJi7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 05:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTIMJi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 05:38:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262105AbTIMJiz (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Sat, 13 Sep 2003 05:38:55 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Linux Kernel <linux-kernel@vger.redhat.com>
Subject: Oops on 2.4.22 when mounting from broken NFS server
Date: Sat, 13 Sep 2003 19:38:40 +1000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gWuY/FPPRSMIafM"
Message-Id: <200309131938.40177.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_gWuY/FPPRSMIafM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is the output of ksymoops from an Oops when mounting from a broken 
NFS server.  I was experimenting with a new security policy for the NFS 
server and didn't grant the daemons all the access they needed.  Afterwards I 
noticed that kernel had Oops'd on a mount command (I should have suspected 
when the mount SEGV'd).

I can probably reproduce this if requested.  It's 2.4.22 client and server.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_gWuY/FPPRSMIafM
Content-Type: text/plain;
  charset="us-ascii";
  name="out"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="out"

ksymoops 2.4.5 on i586 2.4.19-cobalt.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-cobalt/ (default)
     -m /boot/System.map-2.4.19-cobalt (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000021
c0109d85
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0109d85>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: 00000240   ebx: 00000001   ecx: 0000000c   edx: c025a910
esi: 00000400   edi: c025b304   ebp: 00000005   esp: c7cade78
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 74, stackpage=c7cad000)
Stack: c7705000 c7705000 c7705160 c8820000 00000013 00000003 c8819872 0000000a 
       c881a464 04000000 c7705000 c7705000 c881a43c c881be8a c7705000 c7705000 
       00000000 00001043 00000000 c01a5a1f c7705000 c7705000 00001002 c01a6863 
Call Trace:    [<c8819872>] [<c881a464>] [<c881a43c>] [<c881be8a>] [<c01a5a1f>]
  [<c01a6863>] [<c01d0241>] [<c01d20f7>] [<c01db602>] [<c019fd46>] [<c0139986>]
  [<c01085a3>]
Code: 39 5d 1c 75 06 8b 34 39 09 34 10 8b 6d 18 85 ed 75 ee 8b 54 


>>EIP; c0109d85 <request_irq_class+1e1/208>   <=====

>>edx; c025a910 <irq_desc+10/200>
>>edi; c025b304 <irq_classes+4/180>
>>esp; c7cade78 <_end+7a2a38c/8595514>

Trace; c8819872 <[natsemi]netdev_open+32/100>
Trace; c881a464 <[natsemi]intr_handler+0/e8>
Trace; c881a43c <[natsemi]intr_mask+0/28>
Trace; c881be8a <[natsemi]__module_pci_device_size+2b6/b00>
Trace; c01a5a1f <dev_open+47/a0>
Trace; c01a6863 <dev_change_flags+4f/fc>
Trace; c01d0241 <devinet_ioctl+315/664>
Trace; c01d20f7 <inet_ioctl+133/17c>
Trace; c01db602 <bw_sock_ioctl+1a/38>
Trace; c019fd46 <sock_ioctl+1e/24>
Trace; c0139986 <sys_ioctl+16a/184>
Trace; c01085a3 <system_call+33/40>

Code;  c0109d85 <request_irq_class+1e1/208>
00000000 <_EIP>:
Code;  c0109d85 <request_irq_class+1e1/208>   <=====
   0:   39 5d 1c                  cmp    %ebx,0x1c(%ebp)   <=====
Code;  c0109d88 <request_irq_class+1e4/208>
   3:   75 06                     jne    b <_EIP+0xb>
Code;  c0109d8a <request_irq_class+1e6/208>
   5:   8b 34 39                  mov    (%ecx,%edi,1),%esi
Code;  c0109d8d <request_irq_class+1e9/208>
   8:   09 34 10                  or     %esi,(%eax,%edx,1)
Code;  c0109d90 <request_irq_class+1ec/208>
   b:   8b 6d 18                  mov    0x18(%ebp),%ebp
Code;  c0109d93 <request_irq_class+1ef/208>
   e:   85 ed                     test   %ebp,%ebp
Code;  c0109d95 <request_irq_class+1f1/208>
  10:   75 ee                     jne    0 <_EIP>
Code;  c0109d97 <request_irq_class+1f3/208>
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


1 warning issued.  Results may not be reliable.

--Boundary-00=_gWuY/FPPRSMIafM--

