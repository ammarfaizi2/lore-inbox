Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSHYKEE>; Sun, 25 Aug 2002 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSHYKEE>; Sun, 25 Aug 2002 06:04:04 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:39933 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S317091AbSHYKED>; Sun, 25 Aug 2002 06:04:03 -0400
Subject: OOPS: USB and/or devicefs
From: Nicholas Miell <nmiell@attbi.com>
To: linux-kernel@vger.kernel.org
Cc: johannes@erdfelt.com, greg@kroah.com, mochel@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Aug 2002 03:08:12 -0700
Message-Id: <1030270093.1531.8.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what caused this exactly -- I unplugged a USB hub and then
did a ls in the hub's directory in the devicefs. The ls died (in D
state), and I found this in my logs.

ksymoops 2.4.4 on i586 2.5.31.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.31/ (default)
     -m /boot/System.map-2.5.31 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 25 02:44:59 entropy kernel: Unable to handle kernel NULL pointer dereference at virtual address 0000005c
Aug 25 02:44:59 entropy kernel: c015b40f
Aug 25 02:44:59 entropy kernel: *pde = 00000000
Aug 25 02:44:59 entropy kernel: Oops: 0002
Aug 25 02:44:59 entropy kernel: CPU:    0
Aug 25 02:44:59 entropy kernel: EIP:    0060:[<c015b40f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 25 02:44:59 entropy kernel: EFLAGS: 00010206
Aug 25 02:44:59 entropy kernel: eax: c49537d4   ebx: 0000005c   ecx: 0000005c   edx: 00000000
Aug 25 02:44:59 entropy kernel: esi: c39c2688   edi: 00000000   ebp: c056dd48   esp: c4841ef4
Aug 25 02:44:59 entropy kernel: ds: 0068   es: 0068   ss: 0068
Aug 25 02:44:59 entropy kernel: Stack: c39c2688 c056de28 c056dd20 c015bbff c49537d4 c39c2688 c33eb0d0 c33eb210 
Aug 25 02:44:59 entropy kernel:        ffffffff c33eb000 c016d910 c33eb168 c33eb0d0 c33eb0d0 c33eb000 c581616a 
Aug 25 02:44:59 entropy kernel:        c33eb0d0 c33eb000 000000d8 00000100 c3b27400 00000002 00000001 c5817edf 
Aug 25 02:44:59 entropy kernel: Call Trace: [<c015bbff>] [<c016d910>] [<c581616a>] [<c5817edf>] [<c58181df>] 
Aug 25 02:44:59 entropy kernel:    [<c58233ee>] [<c5818360>] [<c581838b>] [<c5818360>] [<c0110820>] [<c01055a5>] 
Aug 25 02:44:59 entropy kernel: Code: ff 4f 5c 0f 88 39 08 00 00 8b 46 08 66 ff 48 24 56 e8 fb ab 

>>EIP; c015b40f <driverfs_unlink+f/40>   <=====
Trace; c015bbff <driverfs_remove_dir+4f/a1>
Trace; c016d910 <put_device+80/b0>
Trace; c581616a <[usbcore]usb_disconnect+ea/110>
Trace; c5817edf <[usbcore]usb_hub_port_connect_change+4f/250>
Trace; c58181df <[usbcore]usb_hub_events+ff/280>
Trace; c58233ee <[usbcore].rodata.end+3673/8125>
Trace; c5818360 <[usbcore]usb_hub_thread+0/e0>
Trace; c581838b <[usbcore]usb_hub_thread+2b/e0>
Trace; c5818360 <[usbcore]usb_hub_thread+0/e0>
Trace; c0110820 <default_wake_function+0/40>
Trace; c01055a5 <kernel_thread_helper+5/10>
Code;  c015b40f <driverfs_unlink+f/40>
00000000 <_EIP>:
Code;  c015b40f <driverfs_unlink+f/40>   <=====
   0:   ff 4f 5c                  decl   0x5c(%edi)   <=====
Code;  c015b412 <driverfs_unlink+12/40>
   3:   0f 88 39 08 00 00         js     842 <_EIP+0x842> c015bc51 <.text.lock.inode+0/bf>
Code;  c015b418 <driverfs_unlink+18/40>
   9:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c015b41b <driverfs_unlink+1b/40>
   c:   66 ff 48 24               decw   0x24(%eax)
Code;  c015b41f <driverfs_unlink+1f/40>
  10:   56                        push   %esi
Code;  c015b420 <driverfs_unlink+20/40>
  11:   e8 fb ab 00 00            call   ac11 <_EIP+0xac11> c0166020 <sys_shmctl+170/880>


1 warning issued.  Results may not be reliable.

