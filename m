Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271021AbTHLSFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270987AbTHLSFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:05:42 -0400
Received: from odpn1.odpn.net ([212.40.96.53]:41952 "EHLO odpn1.odpn.net")
	by vger.kernel.org with ESMTP id S271021AbTHLSFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:05:39 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@papp.hu>
Subject: Re: PPPoE Oops with 2.4.22-rc
References: <5ff3.3f388c4b.4453f@gzp1.gzp.hu> <Pine.LNX.4.44.0308121415540.10199-100000@logos.cnet>
Organization: Who, me?
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.22-rc2-gzp1 (i686))
Message-ID: <39a.3f392c6f.86e8b@gzp1.gzp.hu>
Date: Tue, 12 Aug 2003 18:05:35 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcelo Tosatti <marcelo@conectiva.com.br>:

|> EIP:    0010:[<e0ed9bce>]    Tainted: PF
| 
| Why is your kernel tainted?

As your request I have reproduced the oops without alsa and
webcam modules loaded in:

http://gzp.odpn.net/tmp/linux-pppoe-oops/dmesg-stock-2.4.22-rc2
http://gzp.odpn.net/tmp/linux-pppoe-oops/ksymoops-stock-2.4.22-rc2

ksymoops 2.4.9 on i686 2.4.22-rc2-gzp1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc2-gzp1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0002
CPU:    0
EIP:    0010:[<e095ebce>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: de1647a0   ebx: de0e13c0   ecx: c02747a8   edx: 00000000
esi: de1647a0   edi: 00000000   ebp: ddfc7ef4   esp: ddfc7ebc
ds: 0018   es: 0018   ss: 0018
Process pppd (pid: 366, stackpage=ddfc7000)
Stack: 0000a247 de1647ca ddfc7ef4 0000001e ddfcb5c0 ddfc7ef4 0000001e bffffd28 
       c01cb4cd ddfcb5c0 ddfc7ef4 0000001e 00000002 00000000 00000018 00000000 
       ecc10400 74658784 fc003168 00004015 04090000 de0c0000 08086094 00000001 
Call Trace:    [<c01cb4cd>] [<c01495bd>] [<c01cbfc5>] [<c010744f>]
Code: ff 8a e8 00 00 00 0f 94 c0 84 c0 75 24 c7 44 24 08 60 00 00 


>>EIP; e095ebce <[pppoe]pppoe_connect+1ce/220>   <=====

>>eax; de1647a0 <_end+1decf3b0/20610c70>
>>ebx; de0e13c0 <_end+1de4bfd0/20610c70>
>>ecx; c02747a8 <irq_stat+8/20>
>>esi; de1647a0 <_end+1decf3b0/20610c70>
>>ebp; ddfc7ef4 <_end+1dd32b04/20610c70>
>>esp; ddfc7ebc <_end+1dd32acc/20610c70>

Trace; c01cb4cd <sys_connect+7d/b0>
Trace; c01495bd <fcntl_setlk+8d/1d0>
Trace; c01cbfc5 <sys_socketcall+b5/270>
Trace; c010744f <system_call+33/38>

Code;  e095ebce <[pppoe]pppoe_connect+1ce/220>
00000000 <_EIP>:
Code;  e095ebce <[pppoe]pppoe_connect+1ce/220>   <=====
   0:   ff 8a e8 00 00 00         decl   0xe8(%edx)   <=====
Code;  e095ebd4 <[pppoe]pppoe_connect+1d4/220>
   6:   0f 94 c0                  sete   %al
Code;  e095ebd7 <[pppoe]pppoe_connect+1d7/220>
   9:   84 c0                     test   %al,%al
Code;  e095ebd9 <[pppoe]pppoe_connect+1d9/220>
   b:   75 24                     jne    31 <_EIP+0x31> e095ebff <[pppoe]pppoe_connect+1ff/220>
Code;  e095ebdb <[pppoe]pppoe_connect+1db/220>
   d:   c7 44 24 08 60 00 00      movl   $0x60,0x8(%esp,1)
Code;  e095ebe2 <[pppoe]pppoe_connect+1e2/220>
  14:   00 


1 warning issued.  Results may not be reliable.


