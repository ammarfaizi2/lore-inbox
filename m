Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSDZOVF>; Fri, 26 Apr 2002 10:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSDZOVE>; Fri, 26 Apr 2002 10:21:04 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:64069 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S314052AbSDZOVD>; Fri, 26 Apr 2002 10:21:03 -0400
Date: Fri, 26 Apr 2002 16:10:52 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: linux-kernel@vger.kernel.org
Subject: repeatable 2.4.18-ac2 nfs oops
Message-Id: <20020426161052.2acc71b0.kristian.peters@korseby.net>
X-Mailer: Sylpheed version 0.7.1claws7 (GTK+ 1.2.10; i386-redhat-linux)
X-Operating-System: i686-redhat-linux 2.4.18-ac3
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I recently got this oops with 2.4.18-ac2.
Good news: This one is truely repeatable. Can someone can help me with this ?

ksymoops 2.4.3 on i686 2.4.18-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-ac2/ (default)
     -m /boot/System.map-2.4.18-ac2 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000008 
c0182904 
*pde = 00000000 
Oops: 0000 
CPU:    0 
EIP:    0010:[find_fh_dentry+352/776]    Not tainted 
EFLAGS: 00010217 
eax: 00000000   ebx: 00000000   ecx: 00000005   edx: c02b7860 
esi: 00000005   edi: 00000000   ebp: 11270000   esp: c2dc3e14 
ds: 0018   es: 0018   ss: 0018 
Process nfsd (pid: 266, stackpage=c2dc3000) 
Stack: c313d204 00000005 c3466000 11270000 c36d5f0c c363e840 c0182ca8 c36d5c00  
       c313d214 00000005 00000003 00000001 c2dc3ec0 00000004 c313d294 c313d204  
       c2dc3ea8 c313d214 c2dc3ec0 c3275080 00000040 c0183f34 c30fbe00 c313d204  
Call Trace: [fh_verify+508/988] [nfsd_open+36/480] [nfsd_read+33/600] [inet_sendmsg+58/64] [sock_sendmsg+105/136]  
Code: 8b 47 08 bb 8c ff ff ff 85 c0 0f 84 57 01 00 00 0f b7 40 32  
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 47 08                  mov    0x8(%edi),%eax
Code;  00000002 Before first symbol
   3:   bb 8c ff ff ff            mov    $0xffffff8c,%ebx
Code;  00000008 Before first symbol
   8:   85 c0                     test   %eax,%eax
Code;  0000000a Before first symbol
   a:   0f 84 57 01 00 00         je     167 <_EIP+0x167> 00000166 Before first symbol
Code;  00000010 Before first symbol
  10:   0f b7 40 32               movzwl 0x32(%eax),%eax

On this box there runs a Debian Woody from early February. I can repeat this oops easily having some traffic on a nfs-mounted vfat partition.

hdc: WDC AC22400L, ATA DISK drive
hdc: 4749696 sectors (2432 MB) w/256KiB Cache, CHS=4712/16/63, UDMA(33)

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
