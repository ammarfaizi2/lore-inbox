Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316892AbSE3VlF>; Thu, 30 May 2002 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSE3VlE>; Thu, 30 May 2002 17:41:04 -0400
Received: from dialin-145-254-129-043.arcor-ip.net ([145.254.129.43]:33540
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S316892AbSE3VlD>;
	Thu, 30 May 2002 17:41:03 -0400
Date: Thu, 30 May 2002 23:40:03 +0200
From: Alex Riesen <fork0@users.sourceforge.net>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: oops: 2.5.19, unloading sound modules (snd-ens1371)
Message-ID: <20020530214003.GA347@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

works perfect besides the oops :)


That's not the plain 2.5.19, but the bitkeeper sources
(cset 1.594 of linux.bkbits.net/linux-2.5).

Hardware:

00:0f.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128

Decoded oops from syslog:

May 30 23:25:38 steel kernel: Unable to handle kernel paging request at virtual address ffffffd4

ksymoops 2.4.5 on i686 2.5.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.19/ (default)
     -m /root/mnt/System.map-2.5.19 (specified)

Unable to handle kernel paging request at virtual address ffffffd4
c017924d
*pde = 00001063
Oops: 0002
CPU:    0
EIP:    0010:[<c017924d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c021fecc   edx: c12891c0
esi: dc8fa8e0   edi: ffffffa0   ebp: ffffffe8   esp: db6dbf78
ds: 0018   es: 0018   ss: 0018
Stack: dc8f8000 fffffff0 c164f000 dc8f8000 dc8fa02e dc8fa8e0 c0118357 dc8f8000 
       fffffff0 c164f000 bfffeaec c01175d9 dc8f8000 00000000 db6da000 00000001 
       bfffeaec bfffeaec c0106bff bffffc93 bffffb94 bfffeaec 00000001 bfffeaec 
Call Trace: [<dc8fa02e>] [<dc8fa8e0>] [<c0118357>] [<c01175d9>] [<c0106bff>] 
Code: c7 43 d4 00 00 00 00 c7 85 ac 00 00 00 00 00 00 00 8b 53 04 


>>EIP; c017924d <pci_unregister_driver+25/60>   <=====

>>ecx; c021fecc <contig_page_data+cc/340>
>>edx; c12891c0 <_end+ff0e94/1c5a6cd4>
>>esi; dc8fa8e0 <END_OF_CODE+23781/????>
>>edi; ffffffa0 <END_OF_CODE+23728e41/????>
>>ebp; ffffffe8 <END_OF_CODE+23728e89/????>
>>esp; db6dbf78 <_end+1b443c4c/1c5a6cd4>

Trace; dc8fa02e <END_OF_CODE+22ecf/????>
Trace; dc8fa8e0 <END_OF_CODE+23781/????>
Trace; c0118357 <free_module+17/c0>
Trace; c01175d9 <sys_delete_module+12d/27c>
Trace; c0106bff <syscall_call+7/b>

Code;  c017924d <pci_unregister_driver+25/60>
00000000 <_EIP>:
Code;  c017924d <pci_unregister_driver+25/60>   <=====
   0:   c7 43 d4 00 00 00 00      movl   $0x0,0xffffffd4(%ebx)   <=====
Code;  c0179254 <pci_unregister_driver+2c/60>
   7:   c7 85 ac 00 00 00 00      movl   $0x0,0xac(%ebp)
Code;  c017925b <pci_unregister_driver+33/60>
   e:   00 00 00 
Code;  c017925e <pci_unregister_driver+36/60>
  11:   8b 53 04                  mov    0x4(%ebx),%edx

May 30 23:25:38 steel kernel:  <6>note: rmmod[330] exited with preempt_count 1


