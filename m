Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288597AbSATW1s>; Sun, 20 Jan 2002 17:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288657AbSATW1i>; Sun, 20 Jan 2002 17:27:38 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:63253 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S288597AbSATW13>; Sun, 20 Jan 2002 17:27:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
Organization: LISA GmbH
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [OOPS] with 2.4.18-pre4+linux-2.4.18-NFS_ALL
Date: Sun, 20 Jan 2002 23:27:22 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020120164118.D587513E3@shrek.lisa.de> <shsbsfo6gt9.fsf@charged.uio.no>
In-Reply-To: <shsbsfo6gt9.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120222722.3972B143F@shrek.lisa.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 20. January 2002 19:03, Trond Myklebust wrote:
> >>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:
>      > Hi Trond et al., I can reliably reproduce this oops on my
>      > diskless with NFS_ALL applied, but not with plain-pre4, just by
>      > quitting one of {StarOffice,VMware}.
>
> The new version should be rid of it. It was a call to get_file() which
> was missing a test for a NULL argument.

Are you sure?

Unable to handle kernel NULL pointer dereference at virtual address 0000005c
c0157a2f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[nfs_update_request+447/752]    Not tainted
EFLAGS: 00013246
eax: e75a7340   ebx: 00000000   ecx: 00000005   edx: 00000000
esi: e75a7340   edi: 00000000   ebp: e75a74f8   esp: e9243e28
ds: 0018   es: 0018   ss: 0018
Process vmware (pid: 1269, stackpage=e9243000)
Stack: e75a7340 c1988a40 00000000 00001000 c1988a40 e75a7340 00000000 
e75a7340 
       00001000 c0157362 00000000 e75a7340 c1988a40 00000000 00001000 
c1988a40 
       e75a7340 00000000 c1988a40 c01574a4 00000000 e75a7340 c1988a40 
00000000 
Call Trace: [nfs_writepage_async+34/208] [nfs_writepage+148/208] 
[nfs_writepage+0/208] [filemap_fdatasync+83/144] [nfs_notify_change+145/432] 
   [<f298e820>] [<f298c7a5>] [unix_stream_sendmsg+502/688] [<f298b51f>] 
[set_page_dirty+67/80] [notify_change+76/320] 
Code: 8b 42 5c 85 c0 74 0b 81 78 18 f0 a4 4a 0f 74 02 0f 0b 50 e8 
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; f298e820 <[vmmon].rodata.start+5a0/c1e>
Trace; f298c7a4 <[vmmon]Vmx86_ReleaseVM+7c/88>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 42 5c                  mov    0x5c(%edx),%eax
Code;  00000002 Before first symbol
   3:   85 c0                     test   %eax,%eax
Code;  00000004 Before first symbol
   5:   74 0b                     je     12 <_EIP+0x12> 00000012 Before first 
symbol
Code;  00000006 Before first symbol
   7:   81 78 18 f0 a4 4a 0f      cmpl   $0xf4aa4f0,0x18(%eax)
Code;  0000000e Before first symbol
   e:   74 02                     je     12 <_EIP+0x12> 00000012 Before first 
symbol
Code;  00000010 Before first symbol
  10:   0f 0b                     ud2a   
Code;  00000012 Before first symbol
  12:   50                        push   %eax
Code;  00000012 Before first symbol
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> 00000018 Before first 
symbol

Just verified two times. Will revert it again :(

-rw-rw-r--    1 hp       lisa       141885 Jan 20 20:08 
linux-2.4.18-NFS_ALL-1.dif

Would you mind to number up your NFS_ALL patch versions?

> Cheers,
>   Trond

Cheers,
  Hans-Peter
