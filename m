Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263060AbSIUVpj>; Sat, 21 Sep 2002 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263070AbSIUVpj>; Sat, 21 Sep 2002 17:45:39 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:31393 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263060AbSIUVph> convert rfc822-to-8bit; Sat, 21 Sep 2002 17:45:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Hasch@t-online.de (Juergen Hasch)
To: linux-kernel@vger.kernel.org
Subject: Oops in 3c59x.c
Date: Sat, 21 Sep 2002 23:50:40 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209212350.40295.hasch@t-online.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was trying to load the 3c59x network driver in Linux 2.4.19-XFS
(CVS version from SGI).

Calling "modprobe 3c59x options=0x0f" gives me the following oops
(I now the options value is bogus):

ksymoops 2.4.3 on i686 2.4.19-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-xfs/ (default)
     -m /boot/System.map-2.4.19-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.19-xfs failed
Reading Oops report from the terminal
Oops: 0000
CPU:    0
EIP:    0010:[<c02cc96a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010097
eax: ffffffff   ebx: c03b6194   ecx: ffffffff   edx: fffffffe
esi: dcc19d88   edi: ffffffff   ebp: ffffffff   esp: dcc19d2c
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 1010, stackpage=dcc19000)
Stack: 00000001 00000246 df59b560 0000940a 00000007 fffffffd ffffffff 00000000
       c03b655f c011889e c03b6160 00000400 e089c850 dcc19d7c 00000001 00000009
       df59b560 0000940a e0898a50 e089c820 c15bd276 0000000f ffffffff e089c7e0
Call Trace:    [<c011889e>] [<e089c850>] [<e0898a50>] [<e089c820>] 
[<e089c7e0>]
  [<e089e440>] [<e089de04>] [<e089819c>] [<e089e0bc>] [<c0268895>] 
[<e089e0bc>]
  [<e089e440>] [<c02688f4>] [<e089e440>] [<e0898066>] [<e089bf0b>] 
[<e089e440>]
  [<c01197ad>] [<e0898060>] [<c0108a3b>]
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 44 24 10 8b 44

>>EIP; c02cc96a <vsnprintf+22a/420>   <=====
Trace; c011889e <printk+6e/140>
Trace; e089c850 <[3c59x]__module_pci_device_size+3dc/170a>
Trace; e0898a50 <[3c59x]__module_parm_desc_watchdog+490/810>
Trace; e089c820 <[3c59x]__module_pci_device_size+3ac/170a>
Trace; e089c7e0 <[3c59x]__module_pci_device_size+36c/170a>
Trace; e089e440 <[3c59x]vortex_driver+0/3e>
Trace; e089de04 <[3c59x]vortex_info_tbl+e0/210>
Trace; e089819c <[3c59x]__module_parm_compaq_device_id+4/18>
Trace; e089e0bc <[3c59x]vortex_pci_tbl+188/39c>
Trace; c0268894 <pci_match_device+b4/d0>
Trace; e089e0bc <[3c59x]vortex_pci_tbl+188/39c>
Trace; e089e440 <[3c59x]vortex_driver+0/3e>
Trace; c02688f4 <pci_register_driver+44/60>
Trace; e089e440 <[3c59x]vortex_driver+0/3e>
Trace; e0898066 <[3c59x]vortex_suspend+6/20>
Trace; e089bf0a <[3c59x]vortex_init+a/70>
Trace; e089e440 <[3c59x]vortex_driver+0/3e>
Trace; c01197ac <inter_module_put+79c/870>
Trace; e0898060 <[3c59x]vortex_suspend+0/20>
Trace; c0108a3a <__read_lock_failed+11ba/27b0>
Code;  c02cc96a <vsnprintf+22a/420>
00000000 <_EIP>:
Code;  c02cc96a <vsnprintf+22a/420>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c02cc96c <vsnprintf+22c/420>
   3:   74 07                     je     c <_EIP+0xc> c02cc976 
<vsnprintf+236/420                                   >
Code;  c02cc96e <vsnprintf+22e/420>
   5:   40                        inc    %eax
Code;  c02cc970 <vsnprintf+230/420>
   6:   4a                        dec    %edx
Code;  c02cc970 <vsnprintf+230/420>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c02cc974 <vsnprintf+234/420>
   a:   75 f4                     jne    0 <_EIP>
Code;  c02cc976 <vsnprintf+236/420>
   c:   29 c8                     sub    %ecx,%eax
Code;  c02cc978 <vsnprintf+238/420>
   e:   89 44 24 10               mov    %eax,0x10(%esp,1)
Code;  c02cc97c <vsnprintf+23c/420>
  12:   8b 44 00 00               mov    0x0(%eax,%eax,1),%eax


It looks like in line 1240 of 3c59x.c media_tbl is indexed with an
index exceeding the size of the table, because media_override is equal to 
0x0f:
		printk(KERN_INFO "%s:  Media override to transceiver type %d (%s).\n",
				print_name, vp->media_override,
				media_tbl[vp->media_override].name);

Shouldn't we limit vp->media_override to the number of entries in media_tbl ?

...Juergen

