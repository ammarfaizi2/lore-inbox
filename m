Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263354AbRFFEdZ>; Wed, 6 Jun 2001 00:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263479AbRFFEdQ>; Wed, 6 Jun 2001 00:33:16 -0400
Received: from james.kalifornia.com ([208.179.59.2]:22311 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S263354AbRFFEdC>; Wed, 6 Jun 2001 00:33:02 -0400
Message-ID: <3B1DB270.6070603@blue-labs.org>
Date: Tue, 05 Jun 2001 21:32:48 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9+) Gecko/20010602
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <laughing@shared-source.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
In-Reply-To: <20010605234928.A28971@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5-ac8 has a brokenness about it.

sshd stalled in [down] with the following, subsequent sshd attempts 
which needed a tty resulted in D state the same as the first:

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01269f9>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001b   ebx: c13bf768   ecx: c0345060   edx: 00002c76
esi: c0a54000   edi: c0a549aa   ebp: c0a549aa   esp: c57afe54
ds: 0018   es: 0018   ss: 0018
Process sshd (pid: 3627, stackpage=c57af000)
Stack: c02cab45 000004dc 00000000 0000800a c03dc900 c03dc900 00001000 
00000246
       c01b1021 00000c3c 00000007 c03dc900 c01b1c43 0000000a c03dc900 
c03dc900
       00000000 c13c9e50 0000000a 00000000 00000000 00000000 00000000 
c13c9e50
Call Trace: [<c01b1021>] [<c01b1c43>] [<c01b2643>] [<c0137fc0>] 
[<c0138871>]
   [<c0167ccb>] [<c012e389>] [<c012e2c2>] [<c012e5b0>] [<c0106a93>]
Code: 0f 0b 83 c4 08 89 f6 f6 43 11 04 74 51 b8 a5 c2 0f 17 87 06

 >>EIP; c01269f9 <proc_getdata+4d/154>   <=====
Trace; c01b1021 <read_eeprom+131/1a8>
Trace; c01b1c43 <rtl8139_tx_timeout+143/148>
Trace; c01b2643 <rtl8139_interrupt+5f/170>
Trace; c0137fc0 <__emul_lookup_dentry+a4/fc>
Trace; c0138871 <open_namei+4d1/560>
Trace; c0167ccb <leaf_define_dest_src_infos+1a7/1ac>
Trace; c012e389 <do_readv_writev+15d/228>
Trace; c012e2c2 <do_readv_writev+96/228>
Trace; c012e5b0 <sys_pread+bc/d0>
Trace; c0106a93 <system_call+23/40>
Code;  c01269f9 <proc_getdata+4d/154>
00000000 <_EIP>:
Code;  c01269f9 <proc_getdata+4d/154>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01269fb <proc_getdata+4f/154>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c01269fe <proc_getdata+52/154>
   5:   89 f6                     mov    %esi,%esi
Code;  c0126a00 <proc_getdata+54/154>
   7:   f6 43 11 04               testb  $0x4,0x11(%ebx)
Code;  c0126a04 <proc_getdata+58/154>
   b:   74 51                     je     5e <_EIP+0x5e> c0126a57 
<proc_getdata+ab/154>
Code;  c0126a06 <proc_getdata+5a/154>
   d:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
Code;  c0126a0b <proc_getdata+5f/154>
  12:   87 06                     xchg   %eax,(%esi)


Alan Cox wrote:

>	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
>
>		 Intermediate diffs are available from
>			http://www.bzimage.org
>
>In terms of going through the code audit almost all the sound drivers still 
>need fixing to lock against format changes during a read/write. Poll creating 
>and starting a buffer as write does and also mmap during write, write during
>an mmap.
>
>2.4.5-ac9
>


