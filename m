Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264469AbTCXRie>; Mon, 24 Mar 2003 12:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264470AbTCXRie>; Mon, 24 Mar 2003 12:38:34 -0500
Received: from franka.aracnet.com ([216.99.193.44]:41644 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264469AbTCXRib>; Mon, 24 Mar 2003 12:38:31 -0500
Date: Mon, 24 Mar 2003 09:49:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 484] New: Oops in packet_read_proc
Message-ID: <94400000.1048528176@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=484

           Summary: Oops in packet_read_proc
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: acme@conectiva.com.br
         Submitter: dave.beckett@bristol.ac.uk


Distribution: Debian unstable/sid
Hardware Environment: AMD XP1700, VIA VT8366, RTL-8139, HPT372A, MGA G550
Software Environment: XFree86 4.2.1-6
Problem Description: Oops in packet_read_proc

Repeatably happens when I log out of X and the kdm is shutting down and
restarting the X server - the process that dies is 'cat' so it must
be somewhere in the guts of the logout/reset.

Steps to reproduce:
> From kdm, log into X, log out.

===================================================================

Output of scripts/ver_linux:

Linux foo 2.5.65 #1 Tue Mar 18 08:55:44 GMT 2003 i686 unknown unknown
GNU/Linux  
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
module-init-tools      0.9.10
e2fsprogs              1.32
jfsutils               1.1.1
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.10
Modules Loaded         parport_pc lp parport snd_pcm_oss snd_mixer_oss
snd_ens1371 snd_rawmidi snd_pcm snd_timer snd_ac97_codec snd iptable_mangle
iptable_filter ipt_MASQUERADE ip_nat_ftp iptable_nat ip_conntrack_ftp
ip_conntrack 8139too natsemi crc32 uhci_hcd usbcore raid1 es1371 ac97_codec

===================================================================

ksymoops 2.4.8 on i686 2.5.65.  Options used
     -v /usr/src/linux-2.5.65/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.65/ (default)
     -m /boot/System.map-2.5.65 (default)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0002
CPU:    0
EIP:    0060:[<c02bc327>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: 00000000   ebx: 00000059   ecx: 00000059   edx: 0804c091
esi: 0804c038   edi: 00015002   ebp: d3d11f1c   esp: d3d11f0c
ds: 007b   es: 007b   ss: 0068
Stack: 00000053 00000059 d8389580 00000059 d3d11f70 c0156058 00015002
0804c038         00000059 00000059 00000000 d7fff280 d3d10000 d3d10000
00015002 d3d10000         d83895e8 00000001 00000059 00000000 0804d000
0804e000 d7fc6cc0 00000000  Call Trace:
 [<c0156058>] pipe_write+0x278/0x2c0
 [<c014a896>] vfs_write+0xb6/0x190
 [<c014a9fc>] sys_write+0x3c/0x50
 [<c010ae5b>] syscall_call+0x7/0xb
Code: f3 aa 58 59 e9 16 a2 f1 ff 66 c7 05 b1 66 1d c0 eb 1a e9 8f 


>> EIP; c02bc327 <packet_read_proc+c27/131f>   <=====

>> ebp; d3d11f1c <_end+1395b508/3fc494f0>
>> esp; d3d11f0c <_end+1395b4f8/3fc494f0>

Trace; c0156058 <pipe_write+278/2c0>
Trace; c014a896 <vfs_write+b6/190>
Trace; c014a9fc <sys_write+3c/50>
Trace; c010ae5b <syscall_call+7/b>

Code;  c02bc327 <packet_read_proc+c27/131f>
00000000 <_EIP>:
Code;  c02bc327 <packet_read_proc+c27/131f>   <=====
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=====
Code;  c02bc329 <packet_read_proc+c29/131f>
   2:   58                        pop    %eax
Code;  c02bc32a <packet_read_proc+c2a/131f>
   3:   59                        pop    %ecx
Code;  c02bc32b <packet_read_proc+c2b/131f>
   4:   e9 16 a2 f1 ff            jmp    fff1a21f <_EIP+0xfff1a21f>
Code;  c02bc330 <packet_read_proc+c30/131f>
   9:   66 c7 05 b1 66 1d c0      movw   $0x1aeb,0xc01d66b1
Code;  c02bc337 <packet_read_proc+c37/131f>
  10:   eb 1a 
Code;  c02bc339 <packet_read_proc+c39/131f>
  12:   e9 8f 00 00 00            jmp    a6 <_EIP+0xa6>


1 error issued.  Results may not be reliable.


