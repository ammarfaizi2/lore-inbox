Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSE2PhA>; Wed, 29 May 2002 11:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSE2Pg7>; Wed, 29 May 2002 11:36:59 -0400
Received: from mta020pub.verizon.net ([206.46.170.42]:1724 "EHLO
	mta020.verizon.net") by vger.kernel.org with ESMTP
	id <S313492AbSE2Pg4>; Wed, 29 May 2002 11:36:56 -0400
Message-ID: <3CF4F560.4020408@verizon.net>
Date: Wed, 29 May 2002 11:36:00 -0400
From: "Anthony R." <russo.lutions@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020313
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: New oops in 2.4.18 causing hard reboot
In-Reply-To: <3CF2EB18.6050100@verizon.net>
Content-Type: multipart/mixed;
 boundary="------------040005070602060205080606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005070602060205080606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

[I apologize if this was sent more than once.]

Two days ago I sent in an oops and yesterday I had 2 others which forced me
to hard reboot.

Kernel: 2.4.18
Hardware: Pentium III, 500 MHz PC

Symptom: After the first oops yesterday, everything seemed fine.
Then after these 2 oops, the load started going way up, I couldn't umount
anything, and I couldn't shutdown gracefully. All 3 oops were run through
ksymoops and attached below.

The messages for each oops were:

May 27 04:07:35 manic kernel: Unable to handle kernel paging request at virtual address 032f039b
May 28 15:55:27 manic kernel: Unable to handle kernel paging request at virtual address 00048c22
May 28 16:29:06 manic kernel:  <1>Unable to handle kernel paging request at virtual address 00048c22


The ksymoops outputs are attached for each. The first oops occured in
fdatawait, then in ppp, and finally in umount.

I did not see this problem prior to 2.4.18.

Please let me know what, if anything, I can do to help you fix this.

See excerpts of yesterday's message below for additional system info.

Thank you.

-- tony



Kernel version: 2.4.18 (no custom mods or patches)

I do not know what triggers the problem as it is rather sporadic.

My environment is: PIII 500 MHz CPU on standard PC hardware
with 642MB RAM, ASUS P3B motherboard, 1 IDE drive,
2 SCSI drives, 2 ethernet boards, a soundcard, ReiserFS, etc.




--------------040005070602060205080606
Content-Type: text/plain;
 name="oops.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.txt"

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
May 27 04:07:35 manic kernel: Unable to handle kernel paging request at virtual address 032f039b
May 27 04:07:35 manic kernel: c0122db5
May 27 04:07:35 manic kernel: *pde = 00000000
May 27 04:07:35 manic kernel: Oops: 0002
May 27 04:07:35 manic kernel: CPU:    0
May 27 04:07:35 manic kernel: EIP:    0010:[<c0122db5>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
May 27 04:07:35 manic kernel: EFLAGS: 00010287
May 27 04:07:35 manic kernel: eax: 032f0397   ebx: c225fb00   ecx: e225fa40   edx: 0330039a
May 27 04:07:35 manic kernel: esi: e225faf0   edi: 00000000   ebp: e225fb00   esp: e7fe5f84
May 27 04:07:35 manic kernel: ds: 0018   es: 0018   ss: 0018
May 27 04:07:35 manic kernel: Process kupdated (pid: 6, stackpage=e7fe5000)
May 27 04:07:35 manic kernel: Stack: e225faf0 e225fa40 e225fa40 e75dcc60 c013fe06 e225faf0 e75dcc00 e7fe5fa8 
May 27 04:07:35 manic kernel:        e7fe5fa8 00000000 00000000 0d3bdbe1 e7fe4000 c01115e0 ffffffff e7fe4560 
May 27 04:07:35 manic kernel:        ffffffff fff9ffff e7fe4000 c0132355 c0132606 0008e000 e7fe4000 00010f00 
May 27 04:07:35 manic kernel: Call Trace: [<c013fe06>] [<c01115e0>] [<c0132355>] [<c0132606>] [<c0105000>] 
May 27 04:07:35 manic kernel:    [<c0105516>] [<c0132500>] 
May 27 04:07:35 manic kernel: Code: 89 50 04 89 02 8b 06 89 58 04 89 03 89 73 04 89 1e 8b 43 18 

>>EIP; c0122db5 <filemap_fdatawait+25/70>   <=====
Trace; c013fe06 <sync_unlocked_inodes+d6/170>
Trace; c01115e0 <process_timeout+0/50>
Trace; c0132355 <sync_old_buffers+5/40>
Trace; c0132606 <kupdate+106/110>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0132500 <kupdate+0/110>
Code;  c0122db5 <filemap_fdatawait+25/70>
00000000 <_EIP>:
Code;  c0122db5 <filemap_fdatawait+25/70>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0122db8 <filemap_fdatawait+28/70>
   3:   89 02                     mov    %eax,(%edx)
Code;  c0122dba <filemap_fdatawait+2a/70>
   5:   8b 06                     mov    (%esi),%eax
Code;  c0122dbc <filemap_fdatawait+2c/70>
   7:   89 58 04                  mov    %ebx,0x4(%eax)
Code;  c0122dbf <filemap_fdatawait+2f/70>
   a:   89 03                     mov    %eax,(%ebx)
Code;  c0122dc1 <filemap_fdatawait+31/70>
   c:   89 73 04                  mov    %esi,0x4(%ebx)
Code;  c0122dc4 <filemap_fdatawait+34/70>
   f:   89 1e                     mov    %ebx,(%esi)
Code;  c0122dc6 <filemap_fdatawait+36/70>
  11:   8b 43 18                  mov    0x18(%ebx),%eax


1 warning issued.  Results may not be reliable.


--------------040005070602060205080606
Content-Type: text/plain;
 name="oops2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops2.txt"

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
May 28 15:55:27 manic kernel: Unable to handle kernel paging request at virtual address 00048c22
May 28 15:55:27 manic kernel: c014050e
May 28 15:55:27 manic kernel: *pde = 00000000
May 28 15:55:27 manic kernel: Oops: 0000
May 28 15:55:27 manic kernel: CPU:    0
May 28 15:55:27 manic kernel: EIP:    0010:[<c014050e>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
May 28 15:55:27 manic kernel: EFLAGS: 00010203
May 28 15:55:27 manic kernel: eax: c078dc00   ebx: 00048c22   ecx: dc5ff820   edx: dc5ff840
May 28 15:55:27 manic kernel: esi: ca5bc840   edi: 00048c22   ebp: c4181d4c   esp: c4181d18
May 28 15:55:27 manic kernel: ds: 0018   es: 0018   ss: 0018
May 28 15:55:27 manic kernel: Process mozilla-bin (pid: 13647, stackpage=c4181000)
May 28 15:55:27 manic kernel: Stack: 00000000 00000000 c4181d4c c4181d4c c078dc00 00000001 c0140560 c027be30 
May 28 15:55:27 manic kernel:        c078dc00 c4181d4c c027be28 c078dc00 c4181d4c c4181d4c c4181d4c 00000000 
May 28 15:55:27 manic kernel:        00000282 ffffff98 00000000 eae7ed33 c078dc00 eae812c0 ffffff98 c0000000 
May 28 15:55:27 manic kernel: Call Trace: [<c0140560>] [<eae7ed33>] [<eae812c0>] [<eae7c651>] [<eae7c7a8>] 
May 28 15:55:27 manic kernel:    [<eae7c829>] [<eae7d557>] [<c0176a66>] [<c013700f>] [<c013736e>] [<c0139c52>] 
May 28 15:55:28 manic kernel:    [<c0139dc7>] [<c013fa6e>] [<c013777b>] [<c0136d5e>] [<c0137bf3>] [<c0134d24>] 
May 28 15:55:28 manic kernel:    [<c0106cfb>] 
May 28 15:55:28 manic kernel: Code: 8b 3b 3b 5c 24 1c 75 9a 8b 04 24 29 05 10 bd 2d c0 8b 44 24 

>>EIP; c014050e <invalidate_list+8e/b0>   <=====
Trace; c0140560 <invalidate_inodes+30/70>
Trace; eae7ed33 <[ppp_generic].LC16+993/1340>
Trace; eae812c0 <[ppp_synctty]ppp_sync_close+50/80>
Trace; eae7c651 <[ppp_generic]ppp_channel_push+d1/160>
Trace; eae7c7a8 <[ppp_generic]ppp_input+c8/180>
Trace; eae7c829 <[ppp_generic]ppp_input+149/180>
Trace; eae7d557 <[ppp_generic]ppp_ccp_closed+47/60>
Trace; c0176a66 <check_journal_end+1f6/230>
Trace; c013700f <real_lookup+4f/c0>
Trace; c013736e <link_path_walk+20e/710>
Trace; c0139c52 <page_getlink+22/70>
Trace; c0139dc7 <page_follow_link+d7/14f>
Trace; c013fa6e <__mark_inode_dirty+2e/80>
Trace; c013777b <link_path_walk+61b/710>
Trace; c0136d5e <getname+5e/a0>
Trace; c0137bf3 <__user_walk+33/50>
Trace; c0134d24 <sys_stat64+14/70>
Trace; c0106cfb <system_call+33/38>
Code;  c014050e <invalidate_list+8e/b0>
00000000 <_EIP>:
Code;  c014050e <invalidate_list+8e/b0>   <=====
   0:   8b 3b                     mov    (%ebx),%edi   <=====
Code;  c0140510 <invalidate_list+90/b0>
   2:   3b 5c 24 1c               cmp    0x1c(%esp,1),%ebx
Code;  c0140514 <invalidate_list+94/b0>
   6:   75 9a                     jne    ffffffa2 <_EIP+0xffffffa2> c01404b0 <invalidate_list+30/b0>
Code;  c0140516 <invalidate_list+96/b0>
   8:   8b 04 24                  mov    (%esp,1),%eax
Code;  c0140519 <invalidate_list+99/b0>
   b:   29 05 10 bd 2d c0         sub    %eax,0xc02dbd10
Code;  c014051f <invalidate_list+9f/b0>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


1 warning issued.  Results may not be reliable.


--------------040005070602060205080606
Content-Type: text/plain;
 name="oops3.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops3.txt"

ksymoops 2.4.4 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Reading Oops report from the terminal
May 28 16:29:06 manic kernel:  <1>Unable to handle kernel paging request at virtual address 00048c22
May 28 16:29:06 manic kernel: c014050e
May 28 16:29:06 manic kernel: *pde = 00000000
May 28 16:29:06 manic kernel: Oops: 0000
May 28 16:29:06 manic kernel: CPU:    0
May 28 16:29:06 manic kernel: EIP:    0010:[<c014050e>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
May 28 16:29:06 manic kernel: EFLAGS: 00013203
May 28 16:29:06 manic kernel: eax: e75dca00   ebx: 00048c22   ecx: c879bda0   edx: c2616be8
May 28 16:29:06 manic kernel: esi: ca5bc840   edi: 00048c22   ebp: cb101f38   esp: cb101f04
May 28 16:29:06 manic kernel: ds: 0018   es: 0018   ss: 0018
May 28 16:29:06 manic kernel: Process umount (pid: 16150, stackpage=cb101000)
May 28 16:29:06 manic kernel: Stack: 00000015 00000000 cb101f38 cb101f38 e75dca00 00000000 c0140560 c027be30 
May 28 16:29:06 manic kernel:        e75dca00 cb101f38 c027be28 e75dca00 cb101f38 c879bda8 d3d940a8 e75dca00 
May 28 16:29:06 manic kernel:        e73d6da0 c027e1c0 bffff7c8 c0133405 e75dca00 cb101f88 00000000 e7ffa520 
May 28 16:29:06 manic kernel: Call Trace: [<c0140560>] [<c0133405>] [<c0136f68>] [<c0142781>] [<c012e293>] 
May 28 16:29:06 manic kernel:    [<c0122142>] [<c014279c>] [<c0106cfb>] 
May 28 16:29:06 manic kernel: Code: 8b 3b 3b 5c 24 1c 75 9a 8b 04 24 29 05 10 bd 2d c0 8b 44 24 

>>EIP; c014050e <invalidate_list+8e/b0>   <=====
Trace; c0140560 <invalidate_inodes+30/70>
Trace; c0133405 <kill_super+85/e0>
Trace; c0136f68 <path_release+28/30>
Trace; c0142781 <sys_umount+b1/c0>
Trace; c012e293 <filp_close+53/60>
Trace; c0122142 <sys_munmap+32/50>
Trace; c014279c <sys_oldumount+c/10>
Trace; c0106cfb <system_call+33/38>
Code;  c014050e <invalidate_list+8e/b0>
00000000 <_EIP>:
Code;  c014050e <invalidate_list+8e/b0>   <=====
   0:   8b 3b                     mov    (%ebx),%edi   <=====
Code;  c0140510 <invalidate_list+90/b0>
   2:   3b 5c 24 1c               cmp    0x1c(%esp,1),%ebx
Code;  c0140514 <invalidate_list+94/b0>
   6:   75 9a                     jne    ffffffa2 <_EIP+0xffffffa2> c01404b0 <invalidate_list+30/b0>
Code;  c0140516 <invalidate_list+96/b0>
   8:   8b 04 24                  mov    (%esp,1),%eax
Code;  c0140519 <invalidate_list+99/b0>
   b:   29 05 10 bd 2d c0         sub    %eax,0xc02dbd10
Code;  c014051f <invalidate_list+9f/b0>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


1 warning issued.  Results may not be reliable.


--------------040005070602060205080606--

