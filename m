Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265083AbSKETHh>; Tue, 5 Nov 2002 14:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265087AbSKETHh>; Tue, 5 Nov 2002 14:07:37 -0500
Received: from pop018pub.verizon.net ([206.46.170.212]:57002 "EHLO
	pop018.verizon.net") by vger.kernel.org with ESMTP
	id <S265083AbSKETHf>; Tue, 5 Nov 2002 14:07:35 -0500
Message-ID: <3DC8187D.4090907@bellatlantic.net>
Date: Tue, 05 Nov 2002 14:14:05 -0500
From: David Shepard <daveman@bellatlantic.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020518
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at inode.c:1034!
References: <3DC74A26.7050401@bellatlantic.net> <20021105043628.GY23425@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop018.verizon.net from [151.201.13.103] at Tue, 5 Nov 2002 13:14:05 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Mon, Nov 04, 2002 at 11:33:42PM -0500, David Shepard wrote:
>  
>
>>I am running kernel 2.4.19 plain and have been doing so successfully for 
>>quite some time. In the past few days, I am seeing a repeatable BUG on 
>>reboot/shutdown. Please let me know if there is any more information I 
>>can provide.
>>    
>>
>
>Please decode this oops.
>
>
>Bill
>
>  
>
Not sure why the warning...

ksymoops 2.4.7 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at inode.c:1034!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0156d33>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c56db150   ebx: c56db040   ecx: c56db150   edx: c56db040
esi: 00000000   edi: c7f42e00   ebp: c910a620   esp: c47f3f00
ds: 0018   es: 0018   ss:0018
Process umount (pid: 7961, stackpage=c47f3000
Stack: c11660c0 c56db040 00000296 c47f3f48 00000296 c11660c0 c56d6740 
c56d6740
Stack: c0157ea4 c11660c0 c56d6740 00000001 c7f42e60 00000001 c01573ad 
c7f42e00
Stack: c7f42ec4 c7f42e34 c910a620 c910468d c56db040 c7f42e00 c7f42e40 
c0143207
Call Trace:    [<c0157ea4>] [<c01573ad>] [<c910a620>] [<c910468d>] 
[<c0143207>]
  [<c015ad05>] [<c015add1>] [<c015ae67>] [<c01074a3>]
Code: 0f 0b 0a 04 9d bb 27 c0 e9 48 fa ff ff 55 57 56 53 83 ec 14


 >>EIP; c0156d33 <iput+5d3/5e0>   <=====

 >>eax; c56db150 <_end+53b03f8/8dc0308>
 >>ebx; c56db040 <_end+53b02e8/8dc0308>
 >>ecx; c56db150 <_end+53b03f8/8dc0308>
 >>edx; c56db040 <_end+53b02e8/8dc0308>
 >>edi; c7f42e00 <_end+7c180a8/8dc0308>
 >>ebp; c910a620 <[usbcore]usbdevfs_sops+0/44>
 >>esp; c47f3f00 <_end+44c91a8/8dc0308>

Trace; c0157ea4 <dispose_list+54/90>
Trace; c01573ad <invalidate_inodes+7d/90>
Trace; c910a620 <[usbcore]usbdevfs_sops+0/44>
Trace; c910468d <[usbcore]usbdevfs_put_super+4d/60>
Trace; c0143207 <kill_super+167/190>
Trace; c015ad05 <__mntput+35/60>
Trace; c015add1 <sys_umount+81/100>
Trace; c015ae67 <sys_oldumount+17/20>
Trace; c01074a3 <system_call+33/38>

Code;  c0156d33 <iput+5d3/5e0>
00000000 <_EIP>:
Code;  c0156d33 <iput+5d3/5e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0156d35 <iput+5d5/5e0>
   2:   0a 04 9d bb 27 c0 e9      or     0xe9c027bb(,%ebx,4),%al
Code;  c0156d3c <iput+5dc/5e0>
   9:   48                        dec    %eax
Code;  c0156d3d <iput+5dd/5e0>
   a:   fa                        cli
Code;  c0156d3e <iput+5de/5e0>
   b:   ff                        (bad)
Code;  c0156d3f <iput+5df/5e0>
   c:   ff 55 57                  call   *0x57(%ebp)
Code;  c0156d42 <remove_dquot_ref+2/1a0>
   f:   56                        push   %esi
Code;  c0156d43 <remove_dquot_ref+3/1a0>
  10:   53                        push   %ebx
Code;  c0156d44 <remove_dquot_ref+4/1a0>
  11:   83 ec 14                  sub    $0x14,%esp


1 warning issued.  Results may not be reliable.

