Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317953AbSGWFUn>; Tue, 23 Jul 2002 01:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317955AbSGWFUn>; Tue, 23 Jul 2002 01:20:43 -0400
Received: from DaVinci.coe.neu.edu ([129.10.32.95]:46049 "EHLO
	DaVinci.coe.neu.edu") by vger.kernel.org with ESMTP
	id <S317953AbSGWFUm>; Tue, 23 Jul 2002 01:20:42 -0400
Date: Tue, 23 Jul 2002 01:25:33 -0400 (EDT)
From: Mauricio Martinez <mauricio@coe.neu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Oops on cdu31a kernel 2.4.18
Message-ID: <Pine.GSO.4.33.0207230124090.24685-100000@Bars.coe.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get a kernel oops while trying to read a SONY CDU33A device,
connected via a SoundBlaster 16 ISA card, with kernels 2.4.19-rc3 and 2.4.18
The platform is i586 classic, gcc 2.95.3

In /etc/modules.conf I have:

 alias block-major-15 cdu31a
 options cdu31a cdu31a_port=0x0230

so the driver can be loaded as a kernel module

----------------------------------------------
Command line:

 air:~# mount /dev/sonycd /mnt -t iso9660
 mount: block device /dev/sonycd is write-protected, mounting read-only

 air:~# lsmod
 Module                  Size  Used by    Not tainted
 cdu31a                 22912   1  (autoclean)
 cdrom                  26976   0  (autoclean) [cdu31a]
 isofs                  24704   1  (autoclean)
 inflate_fs             17920   0  (autoclean) [isofs]

 air:~# cd /cdrom
 air:/cdrom# ls
 0msvideo/  302avi/  commdlg.dll*  gbut256/    ngme.ini*      setup.exe*
 101avi/    401avi/  eesc.dll*     groft.win*  ngmecl.exe*
 301avi/    501avi/  gbut16/       ngme.hlp*   openanim.avi*

 air:/cdrom# cp setup.exe ~
 Unable to handle kernel paging request at virtual address c283f020
  printing eip:
 c2837025
.. blah blah
 Code: f3 6c 8b 44 24 20 29 05 c4 a9 83 c2 01 05 70 ab 83 c2 83 3d
  Segmentation fault

----------------------------------------------
ksymoops says:

ksymoops 2.4.5 on i586 2.4.19-rc3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc3/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel paging request at virtual address c283f020
c2837025
*pde = 0106c067
Oops: 0002
CPU:    0
EIP:    0010:[<c2837025>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c193c004   ebx: 00004000   ecx: ffffc800   edx: 00000232
esi: 00000000   edi: c283f020   ebp: c193c000   esp: c1843e60
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 379, stackpage=c1843000)
Stack: 00000000 0007b095 00004000 c1843edc 00000000 c28372ab c193c000 00004000
       00000020 00000000 00000000 c1843edc 00079d08 c1843ed8 00000020 c1842000
       00000000 00004000 c283785a c193c000 00079d08 00000020 c1843edc c1843ed8
Call Trace:    [<c28372ab>] [<c283785a>] [<c0120000>] [<c016f894>] [<c011647c>]
  [<c013011e>] [<c0121060>] [<c01218cb>] [<c0121d2a>] [<c0121c00>] [<c012c696>]
  [<c01086e3>]
Code: f3 6c 8b 44 24 20 29 05 c4 a9 83 c2 01 05 70 ab 83 c2 83 3d


>>EIP; c2837025 <[cdu31a]input_data+a9/e4>   <=====

>>eax; c193c004 <_end+16e8170/25bf16c>
>>ebx; 00004000 Before first symbol
>>ecx; ffffc800 <END_OF_CODE+3d7c0e81/????>
>>edi; c283f020 <.bss.end+36a1/????>
>>ebp; c193c000 <_end+16e816c/25bf16c>
>>esp; c1843e60 <_end+15effcc/25bf16c>

Trace; c28372ab <[cdu31a]read_data_block+24b/3bc>
Trace; c283785a <[cdu31a]do_cdu31a_request+43e/5bc>
Trace; c0120000 <do_munmap+154/234>
Trace; c016f894 <generic_unplug_device+20/28>
Trace; c011647c <__run_task_queue+50/5c>
Trace; c013011e <block_sync_page+16/1c>
Trace; c0121060 <___wait_on_page+a8/d4>
Trace; c01218cb <do_generic_file_read+2cb/414>
Trace; c0121d2a <generic_file_read+7e/12c>
Trace; c0121c00 <file_read_actor+0/ac>
Trace; c012c696 <sys_read+96/f0>
Trace; c01086e3 <system_call+33/40>

Code;  c2837025 <[cdu31a]input_data+a9/e4>
00000000 <_EIP>:
Code;  c2837025 <[cdu31a]input_data+a9/e4>   <=====
   0:   f3 6c                     repz insb (%dx),%es:(%edi)   <=====
Code;  c2837027 <[cdu31a]input_data+ab/e4>
   2:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c283702b <[cdu31a]input_data+af/e4>
   6:   29 05 c4 a9 83 c2         sub    %eax,0xc283a9c4
Code;  c2837031 <[cdu31a]input_data+b5/e4>
   c:   01 05 70 ab 83 c2         add    %eax,0xc283ab70
Code;  c2837037 <[cdu31a]input_data+bb/e4>
  12:   83 3d 00 00 00 00 00      cmpl   $0x0,0x0

----------------------------------------------

Finally, from /usr/src/linux/.config
 #
 # Old CD-ROM drivers (not SCSI, not IDE)
 #
 CONFIG_CD_NO_IDESCSI=y
 # CONFIG_AZTCD is not set
 # CONFIG_GSCD is not set
 # CONFIG_SBPCD is not set
 # CONFIG_MCD is not set
 # CONFIG_MCDX is not set
 # CONFIG_OPTCD is not set
 # CONFIG_CM206 is not set
 # CONFIG_SJCD is not set
 # CONFIG_ISP16_CDI is not set
 CONFIG_CDU31A=m
 # CONFIG_CDU535 is not set

----------------------------------------------
Same behavior with CONFIG_CDU31A=y
BTW Audio CDs can be read without any problem.

Thank you.

