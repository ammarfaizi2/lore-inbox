Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbTAKLnU>; Sat, 11 Jan 2003 06:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbTAKLnU>; Sat, 11 Jan 2003 06:43:20 -0500
Received: from attila.bofh.it ([213.92.8.2]:44751 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id <S267190AbTAKLnT>;
	Sat, 11 Jan 2003 06:43:19 -0500
Date: Sat, 11 Jan 2003 12:51:47 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: linux-kernel@vger.kernel.org
Subject: 2.5.55 oops kobject_add and dev_ifname
Message-ID: <20030111115147.GB621@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ksymoops 2.4.8 on i686 2.5.54.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.5.55/ (specified)
     -m /boot/System.map-2.5.55 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
Jan 11 12:29:12 wonderland kernel: Call Trace:
Jan 11 12:29:12 wonderland kernel:  [<c019d5b6>] kobject_add+0x56/0x60
Jan 11 12:29:12 wonderland kernel:  [<c0231005>] dev_new_index+0x155/0x180
Jan 11 12:29:12 wonderland kernel:  [<e0869881>] ppp_create_interface+0x131/0x1f7968b0 [ppp_generic]
Jan 11 12:29:12 wonderland kernel:  [<e086a4e7>] +0x4f/0x1f795b68 [ppp_generic]
Jan 11 12:29:12 wonderland kernel:  [<e0867a0b>] ppp_unattached_ioctl+0xdb/0x1f7986d0 [ppp_generic]
Jan 11 12:29:12 wonderland kernel:  [<e086792a>] ppp_ioctl+0x5aa/0x1f798c80 [ppp_generic]
Jan 11 12:29:12 wonderland kernel:  [<c015121f>] file_ioctl+0xaf/0x210
Jan 11 12:29:12 wonderland kernel:  [<c010932b>] system_call+0x7/0xb
Jan 11 12:29:31 wonderland kernel: Unable to handle kernel paging request at virtual address 00020048
Jan 11 12:29:31 wonderland kernel: c0264761
Jan 11 12:29:31 wonderland kernel: *pde = 00000000
Jan 11 12:29:31 wonderland kernel: Oops: 0000
Jan 11 12:29:31 wonderland kernel: CPU:    0
Jan 11 12:29:31 wonderland kernel: EIP:    0060:[<c0264761>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 11 12:29:31 wonderland kernel: EFLAGS: 00010206
Jan 11 12:29:31 wonderland kernel: eax: 0002003c   ebx: 00000002   ecx: 0805ef58   edx: df6ae800
Jan 11 12:29:31 wonderland kernel: esi: 00000060   edi: df6ae800   ebp: db825ee0   esp: db825ea0
Jan 11 12:29:31 wonderland kernel: ds: 007b   es: 007b   ss: 0068
Jan 11 12:29:31 wonderland kernel: Stack: 0805ef98 db825eb4 00000020 00000000 00000000 30687465 00000000 00000000 
Jan 11 12:29:31 wonderland kernel:        00000000 00000002 0900000a 00000000 00000000 00000002 00000060 df6ae800 
Jan 11 12:29:31 wonderland kernel:        db825f10 c0230089 df6ae800 0805efb8 00001fa0 00002000 0805ef58 00002000 
Jan 11 12:29:31 wonderland kernel: Call Trace:
Jan 11 12:29:31 wonderland kernel:  [<c0230089>] dev_ifname+0x79/0xe0
Jan 11 12:29:31 wonderland kernel:  [<c0230e30>] dev_ifsioc+0x240/0x280
Jan 11 12:29:31 wonderland kernel:  [<c0140b72>] filp_open+0x1b2/0x1d0
Jan 11 12:29:31 wonderland kernel:  [<c0266a02>] inet_shutdown+0xc2/0xe0
Jan 11 12:29:31 wonderland kernel:  [<c022862f>] sock_writev+0x9f/0x1b0
Jan 11 12:29:31 wonderland kernel:  [<c015121f>] file_ioctl+0xaf/0x210
Jan 11 12:29:31 wonderland kernel:  [<c010932b>] system_call+0x7/0xb
Jan 11 12:29:31 wonderland kernel: Code: 8b 40 0c 85 c0 89 45 d0 0f 84 7f 00 00 00 90 8b 45 0c 85 c0 


Trace; c019d5b6 <kobject_register+56/60>
Trace; c0231005 <register_netdevice+155/180>
Trace; e0869881 <END_OF_CODE+204ccdbd/????>
Trace; e086a4e7 <END_OF_CODE+204cda23/????>
Trace; e0867a0b <END_OF_CODE+204caf47/????>
Trace; e086792a <END_OF_CODE+204cae66/????>
Trace; c015121f <sys_ioctl+af/210>
Trace; c010932b <syscall_call+7/b>

>>EIP; c0264761 <inet_gifconf+21/d0>   <=====

Trace; c0230089 <dev_ifconf+79/e0>
Trace; c0230e30 <dev_ioctl+240/280>
Trace; c0140b72 <dentry_open+1b2/1d0>
Trace; c0266a02 <inet_ioctl+c2/e0>
Trace; c022862f <sock_ioctl+9f/1b0>
Trace; c015121f <sys_ioctl+af/210>
Trace; c010932b <syscall_call+7/b>

Code;  c0264761 <inet_gifconf+21/d0>
00000000 <_EIP>:
Code;  c0264761 <inet_gifconf+21/d0>   <=====
   0:   8b 40 0c                  mov    0xc(%eax),%eax   <=====
Code;  c0264764 <inet_gifconf+24/d0>
   3:   85 c0                     test   %eax,%eax
Code;  c0264766 <inet_gifconf+26/d0>
   5:   89 45 d0                  mov    %eax,0xffffffd0(%ebp)
Code;  c0264769 <inet_gifconf+29/d0>
   8:   0f 84 7f 00 00 00         je     8d <_EIP+0x8d>
Code;  c026476f <inet_gifconf+2f/d0>
   e:   90                        nop    
Code;  c0264770 <inet_gifconf+30/d0>
   f:   8b 45 0c                  mov    0xc(%ebp),%eax
Code;  c0264773 <inet_gifconf+33/d0>
  12:   85 c0                     test   %eax,%eax


1 error issued.  Results may not be reliable.

-- 
ciao,
Marco
