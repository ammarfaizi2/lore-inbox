Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbTAOTsK>; Wed, 15 Jan 2003 14:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTAOTsK>; Wed, 15 Jan 2003 14:48:10 -0500
Received: from DaVinci.coe.neu.edu ([129.10.32.95]:50327 "EHLO
	DaVinci.coe.neu.edu") by vger.kernel.org with ESMTP
	id <S266994AbTAOTsI>; Wed, 15 Jan 2003 14:48:08 -0500
Date: Wed, 15 Jan 2003 14:57:02 -0500 (EST)
From: Mauricio Martinez <mauricio@coe.neu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: [OOPS] 2.4.20 with old SONY CDROM
Message-ID: <Pine.GSO.4.33.0301151453270.1472-100000@Amps.coe.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get a kernel oops while trying to read a SONY CDU33A device,
connected via a SoundBlaster 16 ISA card, with kernel 2.4.20
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
 Unable to handle kernel paging request at virtual address c283c0c0
 printing eip:
c2834025

.. blah blah


----------------------------------------------

ksymoops says:

ksymoops 2.4.5 on i586 2.4.20.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /usr/src/linux/System.map (default)

Unable to handle kernel paging request at virtual address c283c0c0
c2834025
*pde = 01ec0067
Oops: 0002
CPU:    0
EIP:    0010:[<c2834025>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c13aa004   ebx: 00004000   ecx: ffffc800   edx: 00000232
esi: 00000000   edi: c283c0c0   ebp: c13aa000   esp: c1283e60
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 736, stackpage=c1283000)
Stack: 00000000 000118e6 00004000 c1283edc 00000000 c28342ab c13aa000 00004000
       00000020 00000000 00000000 c1283edc 00001130 c1283ed8 00000020 c1282000
       00000000 00004000 c28348c2 c13aa000 00001130 00000020 c1283edc c1283ed8
Call Trace:    [<c28342ab>] [<c28348c2>] [<c0110000>] [<c016f658>] [<c01152b4>]
  [<c012f22e>] [<c011ff30>] [<c012078b>] [<c0120c2f>] [<c0120afc>] [<c012b6f6>]
  [<c0106c23>]
Code: f3 6c 8b 44 24 20 29 05 64 7a 83 c2 01 05 10 7c 83 c2 83 3d


>>EIP; c2834025 <[cdu31a]input_data+a9/e4>   <=====

>>eax; c13aa004 <_end+1152170/25b916c>
>>ebx; 00004000 Before first symbol
>>ecx; ffffc800 <END_OF_CODE+3d7c3de1/????>
>>edi; c283c0c0 <.bss.end+36a1/????>
>>ebp; c13aa000 <_end+115216c/25b916c>
>>esp; c1283e60 <_end+102bfcc/25b916c>

Trace; c28342ab <[cdu31a]read_data_block+24b/3bc>
Trace; c28348c2 <[cdu31a]do_cdu31a_request+4a6/64c>
Trace; c0110000 <mmput+4c/60>
Trace; c016f658 <generic_unplug_device+20/2c>
Trace; c01152b4 <__run_task_queue+4c/60>
Trace; c012f22e <block_sync_page+16/1c>
Trace; c011ff30 <___wait_on_page+a8/d4>
Trace; c012078b <do_generic_file_read+2cf/418>
Trace; c0120c2f <generic_file_read+83/110>
Trace; c0120afc <file_read_actor+0/b0>
Trace; c012b6f6 <sys_read+96/f0>
Trace; c0106c23 <system_call+33/40>

Code;  c2834025 <[cdu31a]input_data+a9/e4>
00000000 <_EIP>:
Code;  c2834025 <[cdu31a]input_data+a9/e4>   <=====
   0:   f3 6c                     repz insb (%dx),%es:(%edi)   <=====
Code;  c2834027 <[cdu31a]input_data+ab/e4>
   2:   8b 44 24 20               mov    0x20(%esp,1),%eax
Code;  c283402b <[cdu31a]input_data+af/e4>
   6:   29 05 64 7a 83 c2         sub    %eax,0xc2837a64
Code;  c2834031 <[cdu31a]input_data+b5/e4>
   c:   01 05 10 7c 83 c2         add    %eax,0xc2837c10
Code;  c2834037 <[cdu31a]input_data+bb/e4>
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

Any clue? Thank you.

