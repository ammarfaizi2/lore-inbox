Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273570AbRIQLh7>; Mon, 17 Sep 2001 07:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273572AbRIQLhv>; Mon, 17 Sep 2001 07:37:51 -0400
Received: from smtp-rt-9.wanadoo.fr ([193.252.19.55]:39110 "EHLO
	alisier.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S273570AbRIQLhl>; Mon, 17 Sep 2001 07:37:41 -0400
Date: Mon, 17 Sep 2001 13:36:18 +0200
From: pascal.lengard@wanadoo.fr
Message-Id: <200109171136.f8HBaIb16694@h2o.chezmoi.fr>
To: linux-kernel@vger.kernel.org
Subject: 2.4.9 Oops - no more sockets
Cc: pascal.lengard@wanadoo.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is my first Oops posting so I hope I included enough information.
I checked on archives and did not find any reference to similar problem.
As you will see, english is a foreign language for me ...

The linux box is an old IBM Pentium 166 with 128Mb of ram and IDE disks.
It is based on redhat 7.1 (with LOTS of things uninstalled) and has been 
running fine for months with the same functionnality (squid, named and 
vrrpd daemon)... and for 14 days since kernel upgrade to 2.4.9.

The Kernel is a 2.4.9 from kernel.org, home compiled with minimum options
and no module support on a redhat 7.0 box. I included the result of 
'grep "=y" /usr/src/linux/.config' at the end of this mail.
QoS is compiled in to limit the impact of web surf (through  squid) on our 
Internet link.

The oops happened at 4:07:31 am, while no one was using the box (but
cron.daily jobs start at 4:00. All redhat ordinary jobs are running plus
one I added to do incremental backups of system files)

Since /var/log/messages says "kernel: socket: no more sockets" before the
Oops, I had a look in /var/log/sa/sa16 for socket and file use near the 
Oops time, but nothing seems wrong with the stats reported:
03:51:00    dentunusd   file-sz  %file-sz  inode-sz  super-sz %super-sz  dquot-sz %dquot-sz  rtsig-sz %rtsig-sz
04:01:00        38758       542      6,62     36304         0      0,00         0      0,00         1      0,10
Moyenne:        38758       539      6,58     36306         0      0,00         0      0,00         1      0,10

03:51:00       totsck    tcpsck    udpsck    rawsck   ip-frag
04:01:00           41        16        12         2         0
Moyenne:           43        17        12         2         0


You will find below:
     -relevant part of /var/log/messages
     -result of ksymoops
     -list of things compiled in the kernel
     -result of cat /proc/pci and cat /proc/version in case of interest
Please CC me directly since I am not subscribed to this list.
Pascal Lengard
pascal.lengard@wanadoo.fr

--------begining of verbose information -------

Here is what was in /var/log/messages:
--------------------------------------
Sep 16 04:07:31 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:32 proxyvrrp1 last message repeated 8 times
Sep 16 04:07:32 proxyvrrp1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 16 04:07:32 proxyvrrp1 kernel:  printing eip:
Sep 16 04:07:32 proxyvrrp1 kernel: c013ecd6
Sep 16 04:07:32 proxyvrrp1 kernel: *pde = 00000000
Sep 16 04:07:32 proxyvrrp1 kernel: Oops: 0002
Sep 16 04:07:32 proxyvrrp1 kernel: CPU:    0
Sep 16 04:07:32 proxyvrrp1 squid[510]: Squid Parent: child process 511 exited due to signal 11
Sep 16 04:07:32 proxyvrrp1 kernel: EIP:    0010:[d_instantiate+54/80]
Sep 16 04:07:32 proxyvrrp1 kernel: EIP:    0010:[<c013ecd6>]
Sep 16 04:07:32 proxyvrrp1 kernel: EFLAGS: 00010282
Sep 16 04:07:32 proxyvrrp1 kernel: eax: 00000000   ebx: c200c4f0   ecx: c1229120   edx: c2416c90
Sep 16 04:07:32 proxyvrrp1 kernel: esi: c2416c80   edi: c200c4c0   ebp: 00000012   esp: c6cc3e84
Sep 16 04:07:32 proxyvrrp1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 04:07:32 proxyvrrp1 kernel: Process squid (pid: 511, stackpage=c6cc3000)
Sep 16 04:07:32 proxyvrrp1 kernel: Stack: c200c4c0 c61ef680 c1229120 c01a4708 c200c4c0 c2416c80 c1226570 c5a6c840 
Sep 16 04:07:32 proxyvrrp1 kernel:        c0290848 c01cf4a4 3530335b 36363838 0000005d c2416d8c c6cc3ef8 00000010 
Sep 16 04:07:32 proxyvrrp1 kernel:        c66df56c c6cc3efc c6cc3eac 00000009 002eacb2 00000010 c2416d8c c66df56c 
sep 16 04:07:33 proxyvrrp1 pinger: Changement etat: OK
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [sock_map_fd+232/384] [tcp_accept+212/448] [sys_accept+187/240] [sock_poll+31/48] [do_pollfd+90/144] 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [<c01a4708>] [<c01cf4a4>] [<c01a544b>] [<c01a4d7f>] [<c013b68a>] 
Sep 16 04:07:33 proxyvrrp1 kernel:    [do_poll+139/240] [sys_socketcall+188/528] [system_call+51/64] 
Sep 16 04:07:33 proxyvrrp1 kernel:    [<c013b74b>] [<c01a5e5c>] [<c0106cf3>] 
Sep 16 04:07:33 proxyvrrp1 kernel: 
Sep 16 04:07:33 proxyvrrp1 kernel: Code: 89 58 04 89 47 30 89 53 04 89 5e 10 89 77 08 5b 5e 5f c3 8d 
Sep 16 04:07:33 proxyvrrp1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 16 04:07:33 proxyvrrp1 kernel:  printing eip:
Sep 16 04:07:33 proxyvrrp1 kernel: c01257c5
Sep 16 04:07:33 proxyvrrp1 kernel: *pde = 00000000
Sep 16 04:07:33 proxyvrrp1 kernel: Oops: 0002
Sep 16 04:07:33 proxyvrrp1 kernel: CPU:    0
Sep 16 04:07:33 proxyvrrp1 kernel: EIP:    0010:[kmem_cache_free+117/176]
Sep 16 04:07:33 proxyvrrp1 kernel: EIP:    0010:[<c01257c5>]
Sep 16 04:07:33 proxyvrrp1 kernel: EFLAGS: 00010002
Sep 16 04:07:33 proxyvrrp1 kernel: eax: 00000000   ebx: c2416040   ecx: c66cf0a0   edx: c2fc0060
Sep 16 04:07:33 proxyvrrp1 kernel: esi: c1227e6c   edi: 00000246   ebp: 00000b40   esp: c6cc3c9c
Sep 16 04:07:33 proxyvrrp1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 04:07:33 proxyvrrp1 kernel: Process squid (pid: 511, stackpage=c6cc3000)
Sep 16 04:07:33 proxyvrrp1 kernel: Stack: c66cfc20 c66cfc20 c66cfc20 c66cfc20 c684d6e0 c013f4f0 c1227e6c c66cfc20 
Sep 16 04:07:33 proxyvrrp1 kernel:        c66cfc20 c01409dc c66cfc20 c684d6e0 c66cfc20 c013e56d c66cfc20 c66cfd2c 
Sep 16 04:07:33 proxyvrrp1 kernel:        ffffffff c7d887a0 00000000 c7d887a0 c1225160 c012dab9 c684d6e0 c7643bfc 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [destroy_inode+48/64] [iput+396/400] [dput+237/336] [fput+121/208] [filp_close+83/96] 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [<c013f4f0>] [<c01409dc>] [<c013e56d>] [<c012dab9>] [<c012cb43>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [put_files_struct+76/208] [do_exit+199/512] [ret_from_intr+0/7] [d_instantiate+54/80] [do_page_fault+0/1200] [die+69/80] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c011380c>] [<c0113e07>] [<c0106d90>] [<c013ecd6>] [<c010fbd0>] [<c0107265>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [d_instantiate+54/80] [do_page_fault+0/1200] [do_page_fault+919/1200] [ipt_hook+32/48] [tcp_v4_send_check+119/192] [vsnprintf+663/1072] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c013ecd6>] [<c010fbd0>] [<c010ff67>] [<c01eee40>] [<c01db5b7>] [<c01fa387>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [do_page_fault+0/1200] [error_code+52/64] [d_instantiate+54/80] [sock_map_fd+232/384] [tcp_accept+212/448] [sys_accept+187/240] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c010fbd0>] [<c0106e04>] [<c013ecd6>] [<c01a4708>] [<c01cf4a4>] [<c01a544b>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [sock_poll+31/48] [do_pollfd+90/144] [do_poll+139/240] [sys_socketcall+188/528] [system_call+51/64] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c01a4d7f>] [<c013b68a>] [<c013b74b>] [<c01a5e5c>] [<c0106cf3>] 
Sep 16 04:07:34 proxyvrrp1 kernel: 
Sep 16 04:07:34 proxyvrrp1 kernel: Code: 89 08 eb 2e 8d b4 26 00 00 00 00 8b 46 08 8b 51 04 8b 58 04 
Sep 16 04:07:34 proxyvrrp1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 16 04:07:34 proxyvrrp1 kernel:  printing eip:
Sep 16 04:07:34 proxyvrrp1 kernel: c013ecd6
Sep 16 04:07:34 proxyvrrp1 kernel: *pde = 00000000
Sep 16 04:07:34 proxyvrrp1 kernel: Oops: 0002
Sep 16 04:07:34 proxyvrrp1 kernel: CPU:    0
Sep 16 04:07:34 proxyvrrp1 kernel: EIP:    0010:[d_instantiate+54/80]
Sep 16 04:07:34 proxyvrrp1 kernel: EIP:    0010:[<c013ecd6>]
Sep 16 04:07:34 proxyvrrp1 kernel: EFLAGS: 00010282
Sep 16 04:07:34 proxyvrrp1 kernel: eax: 00000000   ebx: c200c570   ecx: c1229120   edx: c2416150
Sep 16 04:07:34 proxyvrrp1 kernel: esi: c2416140   edi: c200c540   ebp: 00000003   esp: c3059f14
Sep 16 04:07:34 proxyvrrp1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 04:07:34 proxyvrrp1 kernel: Process pinger (pid: 15204, stackpage=c3059000)
Sep 16 04:07:34 proxyvrrp1 kernel: Stack: c200c540 c7d88500 c1229120 c01a4708 c200c540 c2416140 c01f3517 c02b2a60 
Sep 16 04:07:34 proxyvrrp1 kernel:        c2286060 c6ca16e0 3530335b 30373838 0000005d c241624c c01f357c c241624c 
Sep 16 04:07:34 proxyvrrp1 kernel:        c01a5113 c241624c c3059f3c 00000009 002eacb6 bffff8c2 00000000 bffff608 
Sep 16 04:07:34 proxyvrrp1 kernel: Call Trace: [sock_map_fd+232/384] [unix_create1+247/256] [unix_create+92/112] [sock_create+179/224] [sys_socket+43/80] 
Sep 16 04:07:34 proxyvrrp1 kernel: Call Trace: [<c01a4708>] [<c01f3517>] [<c01f357c>] [<c01a5113>] [<c01a516b>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [sys_socketcall+108/528] [do_page_fault+0/1200] [error_code+52/64] [system_call+51/64] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c01a5e0c>] [<c010fbd0>] [<c0106e04>] [<c0106cf3>] 
Sep 16 04:07:34 proxyvrrp1 kernel: 
Sep 16 04:07:34 proxyvrrp1 kernel: Code: 89 58 04 89 47 30 89 53 04 89 5e 10 89 77 08 5b 5e 5f c3 8d 
Sep 16 04:07:36 proxyvrrp1 squid[510]: Squid Parent: child process 15209 started
Sep 16 04:07:36 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:36 proxyvrrp1 squid[510]: Squid Parent: child process 15209 exited with status 127
Sep 16 04:07:37 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:38 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:39 proxyvrrp1 squid[510]: Squid Parent: child process 15211 started
Sep 16 04:07:39 proxyvrrp1 squid[510]: Squid Parent: child process 15211 exited with status 127
Sep 16 04:07:39 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:41 proxyvrrp1 last message repeated 2 times
Sep 16 04:07:42 proxyvrrp1 squid[510]: Squid Parent: child process 15212 started
Sep 16 04:07:42 proxyvrrp1 squid[510]: Squid Parent: child process 15212 exited with status 127
Sep 16 04:07:42 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:44 proxyvrrp1 last message repeated 2 times
Sep 16 04:07:45 proxyvrrp1 squid[510]: Squid Parent: child process 15215 started
Sep 16 04:07:45 proxyvrrp1 squid[510]: Squid Parent: child process 15215 exited with status 127
Sep 16 04:07:45 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:07:47 proxyvrrp1 last message repeated 2 times
Sep 16 04:07:48 proxyvrrp1 squid[510]: Squid Parent: child process 15218 started
Sep 16 04:07:48 proxyvrrp1 squid[510]: Squid Parent: child process 15218 exited with status 127
Sep 16 04:07:48 proxyvrrp1 squid[510]: Exiting due to repeated, frequent failures
Sep 16 04:07:48 proxyvrrp1 kernel: socket: no more sockets
Sep 16 04:08:19 proxyvrrp1 last message repeated 31 times
Sep 16 04:09:20 proxyvrrp1 last message repeated 60 times
Sep 16 04:10:21 proxyvrrp1 last message repeated 60 times
Sep 16 04:11:04 proxyvrrp1 last message repeated 41 times
Then it goes on with "no more sockets" for hours until I rebooted the box.


Result of ksymoops:
-------------------
ksymoops 2.4.0 on i586 2.4.9.  Options used
     -v /root/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.4.9 (specified)

Sep 16 04:07:32 proxyvrrp1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 16 04:07:32 proxyvrrp1 kernel: c013ecd6
Sep 16 04:07:32 proxyvrrp1 kernel: *pde = 00000000
Sep 16 04:07:32 proxyvrrp1 kernel: Oops: 0002
Sep 16 04:07:32 proxyvrrp1 kernel: CPU:    0
Sep 16 04:07:32 proxyvrrp1 kernel: EIP:    0010:[d_instantiate+54/80]
Sep 16 04:07:32 proxyvrrp1 kernel: EIP:    0010:[<c013ecd6>]
Using defaults from ksymoops -t elf32-i386 -a i386
Sep 16 04:07:32 proxyvrrp1 kernel: EFLAGS: 00010282
Sep 16 04:07:32 proxyvrrp1 kernel: eax: 00000000   ebx: c200c4f0   ecx: c1229120   edx: c2416c90
Sep 16 04:07:32 proxyvrrp1 kernel: esi: c2416c80   edi: c200c4c0   ebp: 00000012   esp: c6cc3e84
Sep 16 04:07:32 proxyvrrp1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 04:07:32 proxyvrrp1 kernel: Process squid (pid: 511, stackpage=c6cc3000)
Sep 16 04:07:32 proxyvrrp1 kernel: Stack: c200c4c0 c61ef680 c1229120 c01a4708 c200c4c0 c2416c80 c1226570 c5a6c840 
Sep 16 04:07:32 proxyvrrp1 kernel:        c0290848 c01cf4a4 3530335b 36363838 0000005d c2416d8c c6cc3ef8 00000010 
Sep 16 04:07:32 proxyvrrp1 kernel:        c66df56c c6cc3efc c6cc3eac 00000009 002eacb2 00000010 c2416d8c c66df56c 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [sock_map_fd+232/384] [tcp_accept+212/448] [sys_accept+187/240] [sock_poll+31/48] [do_pollfd+90/144] 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [<c01a4708>] [<c01cf4a4>] [<c01a544b>] [<c01a4d7f>] [<c013b68a>] 
Sep 16 04:07:33 proxyvrrp1 kernel:    [<c013b74b>] [<c01a5e5c>] [<c0106cf3>] 
Sep 16 04:07:33 proxyvrrp1 kernel: Code: 89 58 04 89 47 30 89 53 04 89 5e 10 89 77 08 5b 5e 5f c3 8d 

>>EIP; c013ecd6 <d_instantiate+36/50>   <=====
Trace; c01a4708 <sock_map_fd+e8/180>
Trace; c01cf4a4 <tcp_accept+d4/1c0>
Trace; c01a544b <sys_accept+bb/f0>
Trace; c01a4d7f <sock_poll+1f/30>
Trace; c013b68a <do_pollfd+5a/90>
Trace; c013b74b <do_poll+8b/f0>
Trace; c01a5e5c <sys_socketcall+bc/210>
Trace; c0106cf3 <system_call+33/40>
Code;  c013ecd6 <d_instantiate+36/50>
00000000 <_EIP>:
Code;  c013ecd6 <d_instantiate+36/50>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c013ecd9 <d_instantiate+39/50>
   3:   89 47 30                  mov    %eax,0x30(%edi)
Code;  c013ecdc <d_instantiate+3c/50>
   6:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c013ecdf <d_instantiate+3f/50>
   9:   89 5e 10                  mov    %ebx,0x10(%esi)
Code;  c013ece2 <d_instantiate+42/50>
   c:   89 77 08                  mov    %esi,0x8(%edi)
Code;  c013ece5 <d_instantiate+45/50>
   f:   5b                        pop    %ebx
Code;  c013ece6 <d_instantiate+46/50>
  10:   5e                        pop    %esi
Code;  c013ece7 <d_instantiate+47/50>
  11:   5f                        pop    %edi
Code;  c013ece8 <d_instantiate+48/50>
  12:   c3                        ret    
Code;  c013ece9 <d_instantiate+49/50>
  13:   8d 00                     lea    (%eax),%eax

Sep 16 04:07:33 proxyvrrp1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Sep 16 04:07:33 proxyvrrp1 kernel: c01257c5
Sep 16 04:07:33 proxyvrrp1 kernel: *pde = 00000000
Sep 16 04:07:33 proxyvrrp1 kernel: Oops: 0002
Sep 16 04:07:33 proxyvrrp1 kernel: CPU:    0
Sep 16 04:07:33 proxyvrrp1 kernel: EIP:    0010:[kmem_cache_free+117/176]
Sep 16 04:07:33 proxyvrrp1 kernel: EIP:    0010:[<c01257c5>]
Sep 16 04:07:33 proxyvrrp1 kernel: EFLAGS: 00010002
Sep 16 04:07:33 proxyvrrp1 kernel: eax: 00000000   ebx: c2416040   ecx: c66cf0a0   edx: c2fc0060
Sep 16 04:07:33 proxyvrrp1 kernel: esi: c1227e6c   edi: 00000246   ebp: 00000b40   esp: c6cc3c9c
Sep 16 04:07:33 proxyvrrp1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 04:07:33 proxyvrrp1 kernel: Process squid (pid: 511, stackpage=c6cc3000)
Sep 16 04:07:33 proxyvrrp1 kernel: Stack: c66cfc20 c66cfc20 c66cfc20 c66cfc20 c684d6e0 c013f4f0 c1227e6c c66cfc20 
Sep 16 04:07:33 proxyvrrp1 kernel:        c66cfc20 c01409dc c66cfc20 c684d6e0 c66cfc20 c013e56d c66cfc20 c66cfd2c 
Sep 16 04:07:33 proxyvrrp1 kernel:        ffffffff c7d887a0 00000000 c7d887a0 c1225160 c012dab9 c684d6e0 c7643bfc 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [destroy_inode+48/64] [iput+396/400] [dput+237/336] [fput+121/208] [filp_close+83/96] 
Sep 16 04:07:33 proxyvrrp1 kernel: Call Trace: [<c013f4f0>] [<c01409dc>] [<c013e56d>] [<c012dab9>] [<c012cb43>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c011380c>] [<c0113e07>] [<c0106d90>] [<c013ecd6>] [<c010fbd0>] [<c0107265>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c013ecd6>] [<c010fbd0>] [<c010ff67>] [<c01eee40>] [<c01db5b7>] [<c01fa387>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c010fbd0>] [<c0106e04>] [<c013ecd6>] [<c01a4708>] [<c01cf4a4>] [<c01a544b>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c01a4d7f>] [<c013b68a>] [<c013b74b>] [<c01a5e5c>] [<c0106cf3>] 
Sep 16 04:07:34 proxyvrrp1 kernel: Code: 89 08 eb 2e 8d b4 26 00 00 00 00 8b 46 08 8b 51 04 8b 58 04 

>>EIP; c01257c5 <kmem_cache_free+75/b0>   <=====
Trace; c013f4f0 <destroy_inode+30/40>
Trace; c01409dc <iput+18c/190>
Trace; c013e56d <dput+ed/150>
Trace; c012dab9 <fput+79/d0>
Trace; c012cb43 <filp_close+53/60>
Trace; c011380c <put_files_struct+4c/d0>
Trace; c0113e07 <do_exit+c7/200>
Trace; c0106d90 <ret_from_intr+0/7>
Trace; c013ecd6 <d_instantiate+36/50>
Trace; c010fbd0 <do_page_fault+0/4b0>
Trace; c0107265 <die+45/50>
Trace; c013ecd6 <d_instantiate+36/50>
Trace; c010fbd0 <do_page_fault+0/4b0>
Trace; c010ff67 <do_page_fault+397/4b0>
Trace; c01eee40 <ipt_hook+20/30>
Trace; c01db5b7 <tcp_v4_send_check+77/c0>
Trace; c01fa387 <vsnprintf+297/430>
Trace; c010fbd0 <do_page_fault+0/4b0>
Trace; c0106e04 <error_code+34/40>
Trace; c013ecd6 <d_instantiate+36/50>
Trace; c01a4708 <sock_map_fd+e8/180>
Trace; c01cf4a4 <tcp_accept+d4/1c0>
Trace; c01a544b <sys_accept+bb/f0>
Trace; c01a4d7f <sock_poll+1f/30>
Trace; c013b68a <do_pollfd+5a/90>
Trace; c013b74b <do_poll+8b/f0>
Trace; c01a5e5c <sys_socketcall+bc/210>
Trace; c0106cf3 <system_call+33/40>
Code;  c01257c5 <kmem_cache_free+75/b0>
00000000 <_EIP>:
Code;  c01257c5 <kmem_cache_free+75/b0>   <=====
   0:   89 08                     mov    %ecx,(%eax)   <=====
Code;  c01257c7 <kmem_cache_free+77/b0>
   2:   eb 2e                     jmp    32 <_EIP+0x32> c01257f7 <kmem_cache_free+a7/b0>
Code;  c01257c9 <kmem_cache_free+79/b0>
   4:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01257d0 <kmem_cache_free+80/b0>
   b:   8b 46 08                  mov    0x8(%esi),%eax
Code;  c01257d3 <kmem_cache_free+83/b0>
   e:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c01257d6 <kmem_cache_free+86/b0>
  11:   8b 58 04                  mov    0x4(%eax),%ebx

Sep 16 04:07:34 proxyvrrp1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Sep 16 04:07:34 proxyvrrp1 kernel: c013ecd6
Sep 16 04:07:34 proxyvrrp1 kernel: *pde = 00000000
Sep 16 04:07:34 proxyvrrp1 kernel: Oops: 0002
Sep 16 04:07:34 proxyvrrp1 kernel: CPU:    0
Sep 16 04:07:34 proxyvrrp1 kernel: EIP:    0010:[d_instantiate+54/80]
Sep 16 04:07:34 proxyvrrp1 kernel: EIP:    0010:[<c013ecd6>]
Sep 16 04:07:34 proxyvrrp1 kernel: EFLAGS: 00010282
Sep 16 04:07:34 proxyvrrp1 kernel: eax: 00000000   ebx: c200c570   ecx: c1229120   edx: c2416150
Sep 16 04:07:34 proxyvrrp1 kernel: esi: c2416140   edi: c200c540   ebp: 00000003   esp: c3059f14
Sep 16 04:07:34 proxyvrrp1 kernel: ds: 0018   es: 0018   ss: 0018
Sep 16 04:07:34 proxyvrrp1 kernel: Process pinger (pid: 15204, stackpage=c3059000)
Sep 16 04:07:34 proxyvrrp1 kernel: Stack: c200c540 c7d88500 c1229120 c01a4708 c200c540 c2416140 c01f3517 c02b2a60 
Sep 16 04:07:34 proxyvrrp1 kernel:        c2286060 c6ca16e0 3530335b 30373838 0000005d c241624c c01f357c c241624c 
Sep 16 04:07:34 proxyvrrp1 kernel:        c01a5113 c241624c c3059f3c 00000009 002eacb6 bffff8c2 00000000 bffff608 
Sep 16 04:07:34 proxyvrrp1 kernel: Call Trace: [sock_map_fd+232/384] [unix_create1+247/256] [unix_create+92/112] [sock_create+179/224] [sys_socket+43/80] 
Sep 16 04:07:34 proxyvrrp1 kernel: Call Trace: [<c01a4708>] [<c01f3517>] [<c01f357c>] [<c01a5113>] [<c01a516b>] 
Sep 16 04:07:34 proxyvrrp1 kernel:    [<c01a5e0c>] [<c010fbd0>] [<c0106e04>] [<c0106cf3>] 
Sep 16 04:07:34 proxyvrrp1 kernel: Code: 89 58 04 89 47 30 89 53 04 89 5e 10 89 77 08 5b 5e 5f c3 8d 

>>EIP; c013ecd6 <d_instantiate+36/50>   <=====
Trace; c01a4708 <sock_map_fd+e8/180>
Trace; c01f3517 <unix_create1+f7/100>
Trace; c01f357c <unix_create+5c/70>
Trace; c01a5113 <sock_create+b3/e0>
Trace; c01a516b <sys_socket+2b/50>
Trace; c01a5e0c <sys_socketcall+6c/210>
Trace; c010fbd0 <do_page_fault+0/4b0>
Trace; c0106e04 <error_code+34/40>
Trace; c0106cf3 <system_call+33/40>
Code;  c013ecd6 <d_instantiate+36/50>
00000000 <_EIP>:
Code;  c013ecd6 <d_instantiate+36/50>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c013ecd9 <d_instantiate+39/50>
   3:   89 47 30                  mov    %eax,0x30(%edi)
Code;  c013ecdc <d_instantiate+3c/50>
   6:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c013ecdf <d_instantiate+3f/50>
   9:   89 5e 10                  mov    %ebx,0x10(%esi)
Code;  c013ece2 <d_instantiate+42/50>
   c:   89 77 08                  mov    %esi,0x8(%edi)
Code;  c013ece5 <d_instantiate+45/50>
   f:   5b                        pop    %ebx
Code;  c013ece6 <d_instantiate+46/50>
  10:   5e                        pop    %esi
Code;  c013ece7 <d_instantiate+47/50>
  11:   5f                        pop    %edi
Code;  c013ece8 <d_instantiate+48/50>
  12:   c3                        ret    
Code;  c013ece9 <d_instantiate+49/50>
  13:   8d 00                     lea    (%eax),%eax

Here is what is compiled in my kernel (no modules):
---------------------------------------------------
grep "=y" /usr/src/linux/.config
	CONFIG_X86=y
	CONFIG_ISA=y
	CONFIG_UID16=y
	CONFIG_M586TSC=y
	CONFIG_X86_WP_WORKS_OK=y
	CONFIG_X86_INVLPG=y
	CONFIG_X86_CMPXCHG=y
	CONFIG_X86_XADD=y
	CONFIG_X86_BSWAP=y
	CONFIG_X86_POPAD_OK=y
	CONFIG_RWSEM_XCHGADD_ALGORITHM=y
	CONFIG_X86_USE_STRING_486=y
	CONFIG_X86_ALIGNMENT_16=y
	CONFIG_X86_TSC=y
	CONFIG_NOHIGHMEM=y
	CONFIG_MTRR=y
	CONFIG_NET=y
	CONFIG_PCI=y
	CONFIG_PCI_GOANY=y
	CONFIG_PCI_BIOS=y
	CONFIG_PCI_DIRECT=y
	CONFIG_PCI_NAMES=y
	CONFIG_SYSVIPC=y
	CONFIG_BSD_PROCESS_ACCT=y
	CONFIG_SYSCTL=y
	CONFIG_KCORE_ELF=y
	CONFIG_BINFMT_ELF=y
	CONFIG_PNP=y
	CONFIG_BLK_DEV_FD=y
	CONFIG_PACKET=y
	CONFIG_PACKET_MMAP=y
	CONFIG_NETLINK=y
	CONFIG_RTNETLINK=y
	CONFIG_NETFILTER=y
	CONFIG_UNIX=y
	CONFIG_INET=y
	CONFIG_SYN_COOKIES=y
	CONFIG_IP_NF_CONNTRACK=y
	CONFIG_IP_NF_FTP=y
	CONFIG_IP_NF_IPTABLES=y
	CONFIG_IP_NF_MATCH_LIMIT=y
	CONFIG_IP_NF_MATCH_MAC=y
	CONFIG_IP_NF_MATCH_MARK=y
	CONFIG_IP_NF_MATCH_STATE=y
	CONFIG_IP_NF_FILTER=y
	CONFIG_IP_NF_TARGET_REJECT=y
	CONFIG_IP_NF_NAT=y
	CONFIG_IP_NF_NAT_NEEDED=y
	CONFIG_IP_NF_TARGET_MASQUERADE=y
	CONFIG_IP_NF_TARGET_REDIRECT=y
	CONFIG_IP_NF_NAT_FTP=y
	CONFIG_IP_NF_MANGLE=y
	CONFIG_IP_NF_TARGET_TOS=y
	CONFIG_IP_NF_TARGET_MARK=y
	CONFIG_IP_NF_TARGET_LOG=y
	CONFIG_NET_SCHED=y
	CONFIG_NETLINK=y
	CONFIG_RTNETLINK=y
	CONFIG_NET_SCH_CBQ=y
	CONFIG_NET_SCH_CSZ=y
	CONFIG_NET_SCH_PRIO=y
	CONFIG_NET_SCH_RED=y
	CONFIG_NET_SCH_SFQ=y
	CONFIG_NET_SCH_TEQL=y
	CONFIG_NET_SCH_TBF=y
	CONFIG_NET_SCH_GRED=y
	CONFIG_NET_SCH_DSMARK=y
	CONFIG_NET_SCH_INGRESS=y
	CONFIG_NET_QOS=y
	CONFIG_NET_ESTIMATOR=y
	CONFIG_NET_CLS=y
	CONFIG_NET_CLS_TCINDEX=y
	CONFIG_NET_CLS_ROUTE4=y
	CONFIG_NET_CLS_ROUTE=y
	CONFIG_NET_CLS_FW=y
	CONFIG_NET_CLS_U32=y
	CONFIG_NET_CLS_RSVP=y
	CONFIG_NET_CLS_RSVP6=y
	CONFIG_NET_CLS_POLICE=y
	CONFIG_IDE=y
	CONFIG_BLK_DEV_IDE=y
	CONFIG_BLK_DEV_IDEDISK=y
	CONFIG_BLK_DEV_IDECD=y
	CONFIG_BLK_DEV_CMD640=y
	CONFIG_BLK_DEV_CMD640_ENHANCED=y
	CONFIG_BLK_DEV_RZ1000=y
	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	CONFIG_BLK_DEV_ADMA=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_BLK_DEV_IDEDMA=y
	CONFIG_BLK_DEV_AEC62XX=y
	CONFIG_AEC62XX_TUNING=y
	CONFIG_BLK_DEV_ALI15X3=y
	CONFIG_WDC_ALI15X3=y
	CONFIG_BLK_DEV_AMD74XX=y
	CONFIG_BLK_DEV_CMD64X=y
	CONFIG_BLK_DEV_CY82C693=y
	CONFIG_BLK_DEV_CS5530=y
	CONFIG_BLK_DEV_HPT34X=y
	CONFIG_BLK_DEV_HPT366=y
	CONFIG_BLK_DEV_PIIX=y
	CONFIG_PIIX_TUNING=y
	CONFIG_BLK_DEV_NS87415=y
	CONFIG_BLK_DEV_PDC202XX=y
	CONFIG_PDC202XX_BURST=y
	CONFIG_PDC202XX_FORCE=y
	CONFIG_BLK_DEV_SVWKS=y
	CONFIG_BLK_DEV_SIS5513=y
	CONFIG_BLK_DEV_SLC90E66=y
	CONFIG_BLK_DEV_TRM290=y
	CONFIG_BLK_DEV_VIA82CXXX=y
	CONFIG_IDE_CHIPSETS=y
	CONFIG_IDEDMA_AUTO=y
	CONFIG_BLK_DEV_IDE_MODES=y
	CONFIG_NETDEVICES=y
	CONFIG_DUMMY=y
	CONFIG_NET_ETHERNET=y
	CONFIG_NET_VENDOR_3COM=y
	CONFIG_VORTEX=y
	CONFIG_NET_PCI=y
	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y
	CONFIG_SERIAL=y
	CONFIG_UNIX98_PTYS=y
	CONFIG_FAT_FS=y
	CONFIG_MSDOS_FS=y
	CONFIG_VFAT_FS=y
	CONFIG_ISO9660_FS=y
	CONFIG_JOLIET=y
	CONFIG_PROC_FS=y
	CONFIG_DEVPTS_FS=y
	CONFIG_EXT2_FS=y
	CONFIG_MSDOS_PARTITION=y
	CONFIG_NLS=y
	CONFIG_NLS_CODEPAGE_437=y
	CONFIG_NLS_CODEPAGE_850=y
	CONFIG_NLS_ISO8859_1=y
	CONFIG_VGA_CONSOLE=y

cat /proc/pci:
--------------
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Silicon Integrated Systems [SiS] 5511/5512 (rev 0).
  Bus  0, device   1, function  0:
    ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 1).
  Bus  0, device   1, function  1:
    IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev 8).
      I/O at 0x1000 [0x100f].
  Bus  0, device  14, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 116).
      IRQ 11.
      Master Capable.  Latency=80.  Min Gnt=10.Max Lat=10.
      I/O at 0x4000 [0x407f].
      Non-prefetchable 32 bit memory at 0x60000000 [0x6000007f].
  Bus  0, device  20, function  0:
    VGA compatible controller: Cirrus Logic GD 5436 [Alpine] (rev 0).
      Non-prefetchable 32 bit memory at 0x40000000 [0x40ffffff].

cat /proc/version:
------------------
Linux version 2.4.9 (root@syslogdmz) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #1 lun sep 3 15:14:14 CEST 2001

