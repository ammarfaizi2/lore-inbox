Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289306AbSA3Phg>; Wed, 30 Jan 2002 10:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289301AbSA3PhT>; Wed, 30 Jan 2002 10:37:19 -0500
Received: from pop.gmx.de ([213.165.64.20]:102 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289306AbSA3Pgz>;
	Wed, 30 Jan 2002 10:36:55 -0500
Date: Wed, 30 Jan 2002 16:39:51 +0100
From: Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian.droege@gmx.de>
To: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-Id: <20020130163951.13daca94.sebastian.droege@gmx.de>
In-Reply-To: <20020130173715.B2179@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de>
	<20020130173715.B2179@namesys.com>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Jan 2002 17:37:15 +0300
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
>   Can you please feed this entire oops to a ksymoops?

Here it is (I can't use /proc/ksyms because I'm running an other kernel right now and I can't run ksymoops with 2.5.2-dj7... vmlinux and System.map are the ones from 2.5.2-dj7):

slomo:/usr/src/linux2$ ksymoops -v vmlinux -m System.map -K
ksymoops 2.4.3 on i686 2.5.2-dj6.  Options used
     -v vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.2-dj6/ (default)
     -m System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
PAP-5580: reiserfs_cut_from_item: item to convert does not exist ([58952 21828 0x1 IND]) invalid operant: 0000
CPU: 0
EIP: 0010:[<c0191005>] Not tainted
EFLAGS: 60010282
eax: 0000005b ebx: c02b9640 ecx: 00000001 edx: 00000001
esi: x15a6800 edi: c15a6800 ebp: cdd95e80 esp: cdd95c30
ds: 0018 es: 0018 ss: 0018
Process syslogd (pid: 92, stackpage=cdd950000)
Stack: c02b819a  c0351ba0  c02b9640  cdd95c54  00000000  00000000  c0198065  c15a6800
          c02b9640  cdd95e80  ceece980  00000003  ffffffff  00000001  00001000  00000000
          cdd95ed8  cdd95ed8  000028a3  cdd95c9c  cdd95c98  00000ff8  00000001 00000ff8
Call Trace: [<c0198065>] [<c0198649>] [<c01893fb>] [<c018a65b>] [<c0133574>] [<c0132378>] [<c010864b>]
Code: 0f 0b 68 a0 1b 35 c0 b8 a0 81 2b c0 8d 96 cc 00 00 00 85 fbCPU: 0
EIP: 0010:[<c0191005>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 60010282
eax: 0000005b ebx: c02b9640 ecx: 00000001 edx: 00000001
esi: x15a6800 edi: c15a6800 ebp: cdd95e80 esp: cdd95c30
ds: 0018 es: 0018 ss: 0018
Process syslogd (pid: 92, stackpage=cdd950000)
Stack: c02b819a  c0351ba0  c02b9640  cdd95c54  00000000  00000000  c0198065  c15a6800
          c02b9640  cdd95e80  ceece980  00000003  ffffffff  00000001  00001000  00000000
          cdd95ed8  cdd95ed8  000028a3  cdd95c9c  cdd95c98  00000ff8  00000001 00000ff8
Call Trace: [<c0198065>] [<c0198649>] [<c01893fb>] [<c018a65b>] [<c0133574>] [<c0132378>] [<c010864b>]

Code: 0f 0b 68 a0 1b 35 c0 b8 a0 81 2b c0 8d 96 cc 00 00 00 85 

>>EIP; c0191004 <reiserfs_panic+28/4c>   <=====
Trace; c0198064 <reiserfs_cut_from_item+1ec/468>
Trace; c0198648 <reiserfs_do_truncate+320/4ac>
Trace; c01893fa <reiserfs_truncate_file+1f2/294>
Trace; c018a65a <reiserfs_file_release+31a/340>
Trace; c0133574 <fput+4c/d0>
Trace; c0132378 <sys_close+90/a4>
Trace; c010864a <system_call+32/38>
Code;  c0191004 <reiserfs_panic+28/4c>
00000000 <_EIP>:
Code;  c0191004 <reiserfs_panic+28/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0191006 <reiserfs_panic+2a/4c>
   2:   68 a0 1b 35 c0            push   $0xc0351ba0
Code;  c019100a <reiserfs_panic+2e/4c>
   7:   b8 a0 81 2b c0            mov    $0xc02b81a0,%eax
Code;  c0191010 <reiserfs_panic+34/4c>
   c:   8d 96 cc 00 00 00         lea    0xcc(%esi),%edx
Code;  c0191016 <reiserfs_panic+3a/4c>
  12:   85 fb


>   BTW, you are running on a IDE system, right?
Yes.
I'll provide some more system informations now ;)
Pentium II 350 / 256 MB SD-RAM
MSI-6151 Mobo (Intel BX chipset)
gcc version 2.95.3 20010315 (release)
GNU binutils version 2.11.92.0.7

If you need more informations just ask

Bye
