Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbTLZRby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 12:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbTLZRby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 12:31:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:47002 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265196AbTLZRbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 12:31:31 -0500
X-Authenticated: #11556596
Date: Fri, 26 Dec 2003 23:01:34 +0530
From: Apurva Mehta <apurva@gmx.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oopses on 2.6.0
Message-ID: <20031226173134.GA14038@home.woodlands>
Mail-Followup-To: Apurva Mehta <apurva@gmx.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I am getting strange behaviour on 2.6.0 final. Here is a summary of
what happens.

   1) Occasionally (Once every 4-5 days), the system freezes
   completely so that the only thing to do is a cold reboot. The logs
   do not have any information about such freezes.

   2) More regularly (almost every day), applications like gkrellm,
   xmms and xemacs crash. When I try to restart them, I get a
   segmentation fault. The only way to restart them is to reboot the
   computer. Xemacs starts on the console. Again, the logs do not have
   any info (both the kernel log and the XFree86 log).

   3) Finally today, I got some oops messages out of the kernel (which
   I have attached below). The run down of events is as follows:

   I had left my computer idle for about 2 hours. On my return,
   I noticed that X had frozen. (The apps were still showing
   signs of life though. For example, the xmms song name was
   still scrolling). I switched to the console and did a
   `killall X' upon which I got the oops I have attached named
   oops-1.txt. There is a line in that message which reads
   `***This is where I wake it up***'. Basically all the data
   before that line got in the logs when the computer was
   idle. The oops after that line happened after I killed X.

   I then tried logging into another virtual console upon which I got
   the oops message in the file oops-2.txt. All subsequent login
   attempts also result in OOPses.

I have attached the corresponding Ksymoops outputs as well although I
have heard that they are not relevant on 2.6 anymore. 

Also, I have been using the 2.6 line since test1. I have got these
errors while using the Nvidia driver. I must mention, however, that I
have been using this same driver since test1 (4496).

Let me know if anymore information is required.

Please CC me any replies as I am not subscribed to this list. 
   
Regards,

	- Apurva

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops-1.txt"

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0124338
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0124338>]    Tainted: PF 
EFLAGS: 00010087
EIP is at flush_sigqueue+0x28/0x60
eax: c7b9d874   ebx: c7b9d874   ecx: c73ed874   edx: 00000000
esi: c7b9d2a0   edi: 0000067a   ebp: c5bf7e00   esp: c7bb3f00
ds: 007b   es: 007b   ss: 0068
Process wmaker (pid: 1655, threadinfo=c7bb2000 task=c7dc4140)
Stack: 00000000 c7b9d2a0 00000000 c011c389 c7b9d874 00000011 c7bb3f24 c7b9d2a0 
       bffff380 0000067a bffff384 c011ddde c7b9d2a0 000001f4 0000000b 00000000 
       00020f24 c7b9d350 c7b9d2a0 c7dc4140 c7dc41e8 c011e291 c7b9d2a0 bffff380 
Call Trace:
 [<c011c389>] release_task+0x69/0x200
 [<c011ddde>] wait_task_zombie+0x14e/0x1f0
 [<c011e291>] sys_wait4+0x251/0x2a0
 [<c0117e40>] default_wake_function+0x0/0x20
 [<c0117e40>] default_wake_function+0x0/0x20
 [<c0109449>] sysenter_past_esp+0x52/0x71

Code: 89 02 f6 41 0c 01 89 09 89 49 04 74 0b 8b 0b 39 d9 75 e5 83 
 <6>note: wmaker[1655] exited with preempt_count 2
Unable to handle kernel NULL pointer dereference at virtual address 00000010
 printing eip:
c0125191
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0125191>]    Tainted: PF 
EFLAGS: 00010097
EIP is at group_send_sig_info+0xc1/0x430
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7b9d2a0   edi: 00000001   ebp: c7b9bf40   esp: c7b9becc
ds: 007b   es: 007b   ss: 0068
Process xinit (pid: 1647, threadinfo=c7b9a000 task=c7b9d8c0)
Stack: 00000001 c7b9d2a0 c7b9d2a0 00000000 00000000 c0117b52 00000286 c7b9d3ac 
       fffffffd c7dc4264 c7b9bf40 c0125564 00000001 c7b9bf40 c7b9d2a0 c7b9a000 
       08048db0 00000001 c7b9a000 c01255c1 00000001 c7b9bf40 00000677 fffff989 
Call Trace:
 [<c0117b52>] schedule+0x2f2/0x590
 [<c0125564>] __kill_pg_info+0x64/0x90
 [<c01255c1>] kill_pg_info+0x31/0x60
 [<c01277bb>] sys_kill+0x5b/0x70
 [<c0167e80>] dput+0x30/0x240
 [<c0151adc>] __fput+0xbc/0x120
 [<c0150149>] filp_close+0x59/0x90
 [<c01501e2>] sys_close+0x62/0xa0
 [<c0109449>] sysenter_past_esp+0x52/0x71

Code: 0f a3 41 10 19 c0 85 c0 0f 85 c7 00 00 00 c7 44 24 14 18 00 
 <6>note: xinit[1647] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0117de6>] schedule+0x586/0x590
 [<c01412db>] unmap_page_range+0x4b/0x80
 [<c01414e6>] unmap_vmas+0x1d6/0x230
 [<c01454b8>] exit_mmap+0x78/0x190
 [<c0119815>] mmput+0x65/0xc0
 [<c011d7cb>] do_exit+0x12b/0x3c0
 [<c0109d3c>] die+0xec/0xf0
 [<c0115f19>] do_page_fault+0x1f9/0x519
 [<c02e39d3>] unix_stream_recvmsg+0x2b3/0x600
 [<c0115d20>] do_page_fault+0x0/0x519
 [<c01096a5>] error_code+0x2d/0x38
 [<c0125191>] group_send_sig_info+0xc1/0x430
 [<c0117b52>] schedule+0x2f2/0x590
 [<c0125564>] __kill_pg_info+0x64/0x90
 [<c01255c1>] kill_pg_info+0x31/0x60
 [<c01277bb>] sys_kill+0x5b/0x70
 [<c0167e80>] dput+0x30/0x240
 [<c0151adc>] __fput+0xbc/0x120
 [<c0150149>] filp_close+0x59/0x90
 [<c01501e2>] sys_close+0x62/0xa0
 [<c0109449>] sysenter_past_esp+0x52/0x71


***This is where i wake it up..***


Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c017f95b
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c017f95b>]    Tainted: PF 
EFLAGS: 00010002
EIP is at proc_pid_stat+0x4db/0x530
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7b9d2a0   edi: 00000000   ebp: c204a000   esp: c204be3c
ds: 007b   es: 007b   ss: 0068
Process killall (pid: 13748, threadinfo=c204a000 task=c7dc4760)
Stack: c7b9d2a0 3fec6414 08f58890 c0345b20 c0345b20 c0345b20 c9b904f0 c017d55e 
       c8969660 c9b904f0 0000000d c032a734 c7b9d2a0 ffffffea fffffff4 c7cbdc38 
       c7cbdbd0 c8969660 c015e73c c7cbdbd0 c8969660 c0345ac0 00000000 c204bf70 
Call Trace:
 [<c017d55e>] proc_pident_lookup+0xfe/0x230
 [<c015e73c>] real_lookup+0xcc/0xf0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71

Code: 8b 00 89 34 24 89 84 24 c8 00 00 00 8d 84 24 f0 00 00 00 89 
 <6>note: killall[13748] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0117de6>] schedule+0x586/0x590
 [<c01412db>] unmap_page_range+0x4b/0x80
 [<c01414e6>] unmap_vmas+0x1d6/0x230
 [<c01454b8>] exit_mmap+0x78/0x190
 [<c0119815>] mmput+0x65/0xc0
 [<c011d7cb>] do_exit+0x12b/0x3c0
 [<c0109d3c>] die+0xec/0xf0
 [<c0115f19>] do_page_fault+0x1f9/0x519
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c018ba58>] ext3_mark_iloc_dirty+0x28/0x40
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c0115d20>] do_page_fault+0x0/0x519
 [<c01096a5>] error_code+0x2d/0x38
 [<c017f95b>] proc_pid_stat+0x4db/0x530
 [<c017d55e>] proc_pident_lookup+0xfe/0x230
 [<c015e73c>] real_lookup+0xcc/0xf0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-1.txt"

ksymoops 2.4.9 on i686 2.6.0.  Options used
     -v /mnt/sources/linux-2.6.0/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0/ (default)
     -m /mnt/sources/linux-2.6.0/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0124338
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0124338>]    Tainted: PF 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c7b9d874   ebx: c7b9d874   ecx: c73ed874   edx: 00000000
esi: c7b9d2a0   edi: 0000067a   ebp: c5bf7e00   esp: c7bb3f00
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 c7b9d2a0 00000000 c011c389 c7b9d874 00000011 c7bb3f24 c7b9d2a0 
       bffff380 0000067a bffff384 c011ddde c7b9d2a0 000001f4 0000000b 00000000 
       00020f24 c7b9d350 c7b9d2a0 c7dc4140 c7dc41e8 c011e291 c7b9d2a0 bffff380 
Call Trace:
 [<c011c389>] release_task+0x69/0x200
 [<c011ddde>] wait_task_zombie+0x14e/0x1f0
 [<c011e291>] sys_wait4+0x251/0x2a0
 [<c0117e40>] default_wake_function+0x0/0x20
 [<c0117e40>] default_wake_function+0x0/0x20
 [<c0109449>] sysenter_past_esp+0x52/0x71
Code: 89 02 f6 41 0c 01 89 09 89 49 04 74 0b 8b 0b 39 d9 75 e5 83 


>>EIP; c0124338 <flush_sigqueue+28/60>   <=====

>>eax; c7b9d874 <__crc_rtnl_lock+14dc87/47703a>
>>ebx; c7b9d874 <__crc_rtnl_lock+14dc87/47703a>
>>ecx; c73ed874 <__crc_fat_add_entries+52be5/3216d2>
>>esi; c7b9d2a0 <__crc_rtnl_lock+14d6b3/47703a>
>>ebp; c5bf7e00 <__crc_xfrm_policy_get_afinfo+1a6a42/296616>
>>esp; c7bb3f00 <__crc_rtnl_lock+164313/47703a>

Trace; c011c389 <release_task+69/200>
Trace; c011ddde <wait_task_zombie+14e/1f0>
Trace; c011e291 <sys_wait4+251/2a0>
Trace; c0117e40 <default_wake_function+0/20>
Trace; c0117e40 <default_wake_function+0/20>
Trace; c0109449 <sysenter_past_esp+52/71>

Code;  c0124338 <flush_sigqueue+28/60>
00000000 <_EIP>:
Code;  c0124338 <flush_sigqueue+28/60>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012433a <flush_sigqueue+2a/60>
   2:   f6 41 0c 01               testb  $0x1,0xc(%ecx)
Code;  c012433e <flush_sigqueue+2e/60>
   6:   89 09                     mov    %ecx,(%ecx)
Code;  c0124340 <flush_sigqueue+30/60>
   8:   89 49 04                  mov    %ecx,0x4(%ecx)
Code;  c0124343 <flush_sigqueue+33/60>
   b:   74 0b                     je     18 <_EIP+0x18>
Code;  c0124345 <flush_sigqueue+35/60>
   d:   8b 0b                     mov    (%ebx),%ecx
Code;  c0124347 <flush_sigqueue+37/60>
   f:   39 d9                     cmp    %ebx,%ecx
Code;  c0124349 <flush_sigqueue+39/60>
  11:   75 e5                     jne    fffffff8 <_EIP+0xfffffff8>
Code;  c012434b <flush_sigqueue+3b/60>
  13:   83 00 00                  addl   $0x0,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 00000010
c0125191
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c0125191>]    Tainted: PF 
EFLAGS: 00010097
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7b9d2a0   edi: 00000001   ebp: c7b9bf40   esp: c7b9becc
ds: 007b   es: 007b   ss: 0068
Stack: 00000001 c7b9d2a0 c7b9d2a0 00000000 00000000 c0117b52 00000286 c7b9d3ac 
       fffffffd c7dc4264 c7b9bf40 c0125564 00000001 c7b9bf40 c7b9d2a0 c7b9a000 
       08048db0 00000001 c7b9a000 c01255c1 00000001 c7b9bf40 00000677 fffff989 
Call Trace:
 [<c0117b52>] schedule+0x2f2/0x590
 [<c0125564>] __kill_pg_info+0x64/0x90
 [<c01255c1>] kill_pg_info+0x31/0x60
 [<c01277bb>] sys_kill+0x5b/0x70
 [<c0167e80>] dput+0x30/0x240
 [<c0151adc>] __fput+0xbc/0x120
 [<c0150149>] filp_close+0x59/0x90
 [<c01501e2>] sys_close+0x62/0xa0
 [<c0109449>] sysenter_past_esp+0x52/0x71
Code: 0f a3 41 10 19 c0 85 c0 0f 85 c7 00 00 00 c7 44 24 14 18 00 


>>EIP; c0125191 <group_send_sig_info+c1/430>   <=====

>>esi; c7b9d2a0 <__crc_rtnl_lock+14d6b3/47703a>
>>ebp; c7b9bf40 <__crc_rtnl_lock+14c353/47703a>
>>esp; c7b9becc <__crc_rtnl_lock+14c2df/47703a>

Trace; c0117b52 <schedule+2f2/590>
Trace; c0125564 <__kill_pg_info+64/90>
Trace; c01255c1 <kill_pg_info+31/60>
Trace; c01277bb <sys_kill+5b/70>
Trace; c0167e80 <dput+30/240>
Trace; c0151adc <__fput+bc/120>
Trace; c0150149 <filp_close+59/90>
Trace; c01501e2 <sys_close+62/a0>
Trace; c0109449 <sysenter_past_esp+52/71>

Code;  c0125191 <group_send_sig_info+c1/430>
00000000 <_EIP>:
Code;  c0125191 <group_send_sig_info+c1/430>   <=====
   0:   0f a3 41 10               bt     %eax,0x10(%ecx)   <=====
Code;  c0125195 <group_send_sig_info+c5/430>
   4:   19 c0                     sbb    %eax,%eax
Code;  c0125197 <group_send_sig_info+c7/430>
   6:   85 c0                     test   %eax,%eax
Code;  c0125199 <group_send_sig_info+c9/430>
   8:   0f 85 c7 00 00 00         jne    d5 <_EIP+0xd5>
Code;  c012519f <group_send_sig_info+cf/430>
   e:   c7 44 24 14 18 00 00      movl   $0x18,0x14(%esp,1)
Code;  c01251a6 <group_send_sig_info+d6/430>
  15:   00 

Call Trace:
 [<c0117de6>] schedule+0x586/0x590
 [<c01412db>] unmap_page_range+0x4b/0x80
 [<c01414e6>] unmap_vmas+0x1d6/0x230
 [<c01454b8>] exit_mmap+0x78/0x190
 [<c0119815>] mmput+0x65/0xc0
 [<c011d7cb>] do_exit+0x12b/0x3c0
 [<c0109d3c>] die+0xec/0xf0
 [<c0115f19>] do_page_fault+0x1f9/0x519
 [<c02e39d3>] unix_stream_recvmsg+0x2b3/0x600
 [<c0115d20>] do_page_fault+0x0/0x519
 [<c01096a5>] error_code+0x2d/0x38
 [<c0125191>] group_send_sig_info+0xc1/0x430
 [<c0117b52>] schedule+0x2f2/0x590
 [<c0125564>] __kill_pg_info+0x64/0x90
 [<c01255c1>] kill_pg_info+0x31/0x60
 [<c01277bb>] sys_kill+0x5b/0x70
 [<c0167e80>] dput+0x30/0x240
 [<c0151adc>] __fput+0xbc/0x120
 [<c0150149>] filp_close+0x59/0x90
 [<c01501e2>] sys_close+0x62/0xa0
 [<c0109449>] sysenter_past_esp+0x52/0x71
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c017f95b
*pde = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<c017f95b>]    Tainted: PF 
EFLAGS: 00010002
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7b9d2a0   edi: 00000000   ebp: c204a000   esp: c204be3c
ds: 007b   es: 007b   ss: 0068
Stack: c7b9d2a0 3fec6414 08f58890 c0345b20 c0345b20 c0345b20 c9b904f0 c017d55e 
       c8969660 c9b904f0 0000000d c032a734 c7b9d2a0 ffffffea fffffff4 c7cbdc38 
       c7cbdbd0 c8969660 c015e73c c7cbdbd0 c8969660 c0345ac0 00000000 c204bf70 
Call Trace:
 [<c017d55e>] proc_pident_lookup+0xfe/0x230
 [<c015e73c>] real_lookup+0xcc/0xf0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71
Code: 8b 00 89 34 24 89 84 24 c8 00 00 00 8d 84 24 f0 00 00 00 89 


Trace; c0117de6 <schedule+586/590>
Trace; c01412db <unmap_page_range+4b/80>
Trace; c01414e6 <unmap_vmas+1d6/230>
Trace; c01454b8 <exit_mmap+78/190>
Trace; c0119815 <mmput+65/c0>
Trace; c011d7cb <do_exit+12b/3c0>
Trace; c0109d3c <die+ec/f0>
Trace; c0115f19 <do_page_fault+1f9/519>
Trace; c02e39d3 <unix_stream_recvmsg+2b3/600>
Trace; c0115d20 <do_page_fault+0/519>
Trace; c01096a5 <error_code+2d/38>
Trace; c0125191 <group_send_sig_info+c1/430>
Trace; c0117b52 <schedule+2f2/590>
Trace; c0125564 <__kill_pg_info+64/90>
Trace; c01255c1 <kill_pg_info+31/60>
Trace; c01277bb <sys_kill+5b/70>
Trace; c0167e80 <dput+30/240>
Trace; c0151adc <__fput+bc/120>
Trace; c0150149 <filp_close+59/90>
Trace; c01501e2 <sys_close+62/a0>
Trace; c0109449 <sysenter_past_esp+52/71>

>>EIP; c017f95b <proc_pid_stat+4db/530>   <=====

>>esi; c7b9d2a0 <__crc_rtnl_lock+14d6b3/47703a>
>>ebp; c204a000 <__crc_open_exec+2139e2/7782dd>
>>esp; c204be3c <__crc_open_exec+21581e/7782dd>

Trace; c017d55e <proc_pident_lookup+fe/230>
Trace; c015e73c <real_lookup+cc/f0>
Trace; c0167e80 <dput+30/240>
Trace; c015f008 <link_path_walk+608/940>
Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c015e3d4 <vfs_permission+84/150>
Trace; c0138d7f <__alloc_pages+af/350>
Trace; c011d98c <do_exit+2ec/3c0>
Trace; c017c434 <proc_info_read+74/160>
Trace; c0150a1e <vfs_read+be/130>
Trace; c0150cc2 <sys_read+42/70>
Trace; c0109449 <sysenter_past_esp+52/71>

Code;  c017f95b <proc_pid_stat+4db/530>
00000000 <_EIP>:
Code;  c017f95b <proc_pid_stat+4db/530>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c017f95d <proc_pid_stat+4dd/530>
   2:   89 34 24                  mov    %esi,(%esp,1)
Code;  c017f960 <proc_pid_stat+4e0/530>
   5:   89 84 24 c8 00 00 00      mov    %eax,0xc8(%esp,1)
Code;  c017f967 <proc_pid_stat+4e7/530>
   c:   8d 84 24 f0 00 00 00      lea    0xf0(%esp,1),%eax
Code;  c017f96e <proc_pid_stat+4ee/530>
  13:   89 00                     mov    %eax,(%eax)

Call Trace:
 [<c0117de6>] schedule+0x586/0x590
 [<c01412db>] unmap_page_range+0x4b/0x80
 [<c01414e6>] unmap_vmas+0x1d6/0x230
 [<c01454b8>] exit_mmap+0x78/0x190
 [<c0119815>] mmput+0x65/0xc0
 [<c011d7cb>] do_exit+0x12b/0x3c0
 [<c0109d3c>] die+0xec/0xf0
 [<c0115f19>] do_page_fault+0x1f9/0x519
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c018ba58>] ext3_mark_iloc_dirty+0x28/0x40
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c0115d20>] do_page_fault+0x0/0x519
 [<c01096a5>] error_code+0x2d/0x38
 [<c017f95b>] proc_pid_stat+0x4db/0x530
 [<c017d55e>] proc_pident_lookup+0xfe/0x230
 [<c015e73c>] real_lookup+0xcc/0xf0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0117de6 <schedule+586/590>
Trace; c01412db <unmap_page_range+4b/80>
Trace; c01414e6 <unmap_vmas+1d6/230>
Trace; c01454b8 <exit_mmap+78/190>
Trace; c0119815 <mmput+65/c0>
Trace; c011d7cb <do_exit+12b/3c0>
Trace; c0109d3c <die+ec/f0>
Trace; c0115f19 <do_page_fault+1f9/519>
Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c018ba58 <ext3_mark_iloc_dirty+28/40>
Trace; c0138d7f <__alloc_pages+af/350>
Trace; c0115d20 <do_page_fault+0/519>
Trace; c01096a5 <error_code+2d/38>
Trace; c017f95b <proc_pid_stat+4db/530>
Trace; c017d55e <proc_pident_lookup+fe/230>
Trace; c015e73c <real_lookup+cc/f0>
Trace; c0167e80 <dput+30/240>
Trace; c015f008 <link_path_walk+608/940>
Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c015e3d4 <vfs_permission+84/150>
Trace; c0138d7f <__alloc_pages+af/350>
Trace; c011d98c <do_exit+2ec/3c0>
Trace; c017c434 <proc_info_read+74/160>
Trace; c0150a1e <vfs_read+be/130>
Trace; c0150cc2 <sys_read+42/70>
Trace; c0109449 <sysenter_past_esp+52/71>


1 warning and 1 error issued.  Results may not be reliable.

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops-2.txt"

Dec 26 22:25:23 home login(pam_unix)[13860]: session opened for user apurva by (uid=0)
Dec 26 22:25:23 home  -- apurva[13860]: LOGIN ON tty2 BY apurva
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c017f95b
*pde = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<c017f95b>]    Tainted: PF 
EFLAGS: 00010002
EIP is at proc_pid_stat+0x4db/0x530
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7b9d2a0   edi: 00000000   ebp: cb468000   esp: cb469e3c
ds: 007b   es: 007b   ss: 0068
Process ps (pid: 13896, threadinfo=cb468000 task=c7dc4d80)
Stack: c7b9d2a0 ffffffff c03441b4 cb468000 c03441b4 c0138c2e c10f37f0 00000000 
       cbfa4c64 cb468000 00000202 c03441b4 000001d5 00104025 c89696d0 cbfb2f64 
       cb468000 cb468000 c8969660 c9b904f0 c017d021 c7b9d2a0 c8969660 cb469f70 
Call Trace:
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c017d021>] pid_revalidate+0x41/0xd0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c014fbd8>] filp_open+0x68/0x70
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71

Code: 8b 00 89 34 24 89 84 24 c8 00 00 00 8d 84 24 f0 00 00 00 89 
 <6>note: ps[13896] exited with preempt_count 2
bad: scheduling while atomic!
Call Trace:
 [<c0117de6>] schedule+0x586/0x590
 [<c01412db>] unmap_page_range+0x4b/0x80
 [<c01414e6>] unmap_vmas+0x1d6/0x230
 [<c01454b8>] exit_mmap+0x78/0x190
 [<c0119815>] mmput+0x65/0xc0
 [<c011d7cb>] do_exit+0x12b/0x3c0
 [<c0109d3c>] die+0xec/0xf0
 [<c0115f19>] do_page_fault+0x1f9/0x519
 [<c0113332>] post_set+0x22/0x60
 [<c01096a5>] error_code+0x2d/0x38
 [<c0135651>] file_read_actor+0xe1/0x100
 [<c01b6d74>] vsnprintf+0x214/0x470
 [<c0115d20>] do_page_fault+0x0/0x519
 [<c01096a5>] error_code+0x2d/0x38
 [<c017f95b>] proc_pid_stat+0x4db/0x530
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c017d021>] pid_revalidate+0x41/0xd0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c014fbd8>] filp_open+0x68/0x70
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-2.txt"

ksymoops 2.4.9 on i686 2.6.0.  Options used
     -v /mnt/sources/linux-2.6.0/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0/ (default)
     -m /mnt/sources/linux-2.6.0/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c017f95b
*pde = 00000000
Oops: 0000 [#7]
CPU:    0
EIP:    0060:[<c017f95b>]    Tainted: PF 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: c7b9d2a0   edi: 00000000   ebp: cb468000   esp: cb469e3c
ds: 007b   es: 007b   ss: 0068
Stack: c7b9d2a0 ffffffff c03441b4 cb468000 c03441b4 c0138c2e c10f37f0 00000000 
       cbfa4c64 cb468000 00000202 c03441b4 000001d5 00104025 c89696d0 cbfb2f64 
       cb468000 cb468000 c8969660 c9b904f0 c017d021 c7b9d2a0 c8969660 cb469f70 
Call Trace:
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c017d021>] pid_revalidate+0x41/0xd0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c014fbd8>] filp_open+0x68/0x70
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71
Code: 8b 00 89 34 24 89 84 24 c8 00 00 00 8d 84 24 f0 00 00 00 89 


>>EIP; c017f95b <proc_pid_stat+4db/530>   <=====

>>esi; c7b9d2a0 <__crc_rtnl_lock+14d6b3/47703a>
>>ebp; cb468000 <__crc_neigh_resolve_output+29f904/3a3444>
>>esp; cb469e3c <__crc_neigh_resolve_output+2a1740/3a3444>

Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c017d021 <pid_revalidate+41/d0>
Trace; c0167e80 <dput+30/240>
Trace; c015f008 <link_path_walk+608/940>
Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c015e3d4 <vfs_permission+84/150>
Trace; c0138d7f <__alloc_pages+af/350>
Trace; c011d98c <do_exit+2ec/3c0>
Trace; c017c434 <proc_info_read+74/160>
Trace; c014fbd8 <filp_open+68/70>
Trace; c0150a1e <vfs_read+be/130>
Trace; c0150cc2 <sys_read+42/70>
Trace; c0109449 <sysenter_past_esp+52/71>

Code;  c017f95b <proc_pid_stat+4db/530>
00000000 <_EIP>:
Code;  c017f95b <proc_pid_stat+4db/530>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c017f95d <proc_pid_stat+4dd/530>
   2:   89 34 24                  mov    %esi,(%esp,1)
Code;  c017f960 <proc_pid_stat+4e0/530>
   5:   89 84 24 c8 00 00 00      mov    %eax,0xc8(%esp,1)
Code;  c017f967 <proc_pid_stat+4e7/530>
   c:   8d 84 24 f0 00 00 00      lea    0xf0(%esp,1),%eax
Code;  c017f96e <proc_pid_stat+4ee/530>
  13:   89 00                     mov    %eax,(%eax)

Call Trace:
 [<c0117de6>] schedule+0x586/0x590
 [<c01412db>] unmap_page_range+0x4b/0x80
 [<c01414e6>] unmap_vmas+0x1d6/0x230
 [<c01454b8>] exit_mmap+0x78/0x190
 [<c0119815>] mmput+0x65/0xc0
 [<c011d7cb>] do_exit+0x12b/0x3c0
 [<c0109d3c>] die+0xec/0xf0
 [<c0115f19>] do_page_fault+0x1f9/0x519
 [<c0113332>] post_set+0x22/0x60
 [<c01096a5>] error_code+0x2d/0x38
 [<c0135651>] file_read_actor+0xe1/0x100
 [<c01b6d74>] vsnprintf+0x214/0x470
 [<c0115d20>] do_page_fault+0x0/0x519
 [<c01096a5>] error_code+0x2d/0x38
 [<c017f95b>] proc_pid_stat+0x4db/0x530
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c017d021>] pid_revalidate+0x41/0xd0
 [<c0167e80>] dput+0x30/0x240
 [<c015f008>] link_path_walk+0x608/0x940
 [<c0138c2e>] buffered_rmqueue+0xbe/0x160
 [<c015e3d4>] vfs_permission+0x84/0x150
 [<c0138d7f>] __alloc_pages+0xaf/0x350
 [<c011d98c>] do_exit+0x2ec/0x3c0
 [<c017c434>] proc_info_read+0x74/0x160
 [<c014fbd8>] filp_open+0x68/0x70
 [<c0150a1e>] vfs_read+0xbe/0x130
 [<c0150cc2>] sys_read+0x42/0x70
 [<c0109449>] sysenter_past_esp+0x52/0x71
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c0117de6 <schedule+586/590>
Trace; c01412db <unmap_page_range+4b/80>
Trace; c01414e6 <unmap_vmas+1d6/230>
Trace; c01454b8 <exit_mmap+78/190>
Trace; c0119815 <mmput+65/c0>
Trace; c011d7cb <do_exit+12b/3c0>
Trace; c0109d3c <die+ec/f0>
Trace; c0115f19 <do_page_fault+1f9/519>
Trace; c0113332 <post_set+22/60>
Trace; c01096a5 <error_code+2d/38>
Trace; c0135651 <file_read_actor+e1/100>
Trace; c01b6d74 <vsnprintf+214/470>
Trace; c0115d20 <do_page_fault+0/519>
Trace; c01096a5 <error_code+2d/38>
Trace; c017f95b <proc_pid_stat+4db/530>
Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c017d021 <pid_revalidate+41/d0>
Trace; c0167e80 <dput+30/240>
Trace; c015f008 <link_path_walk+608/940>
Trace; c0138c2e <buffered_rmqueue+be/160>
Trace; c015e3d4 <vfs_permission+84/150>
Trace; c0138d7f <__alloc_pages+af/350>
Trace; c011d98c <do_exit+2ec/3c0>
Trace; c017c434 <proc_info_read+74/160>
Trace; c014fbd8 <filp_open+68/70>
Trace; c0150a1e <vfs_read+be/130>
Trace; c0150cc2 <sys_read+42/70>
Trace; c0109449 <sysenter_past_esp+52/71>


1 warning and 1 error issued.  Results may not be reliable.

--rwEMma7ioTxnRzrJ--
