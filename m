Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbTIXVgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTIXVgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:36:31 -0400
Received: from dsta-ac134.pivot.net ([66.186.182.134]:30957 "EHLO keimel.com")
	by vger.kernel.org with ESMTP id S261571AbTIXVg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:36:28 -0400
Date: Wed, 24 Sep 2003 17:36:27 -0400
To: linux-kernel@vger.kernel.org
Subject: Oops from 2.4.22-grsec
Message-ID: <20030924213627.GB11225@keimel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Fcc: /home/john/mail/sent-mail
From: john@keimel.com (John Keimel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies if this is poorly directed, but Documentation/oops-tracing.txt
said email this address ;) 

Here's my output from ksymoops. I am not running any modules, so I ran
with -K . I am running with grsec patch. 

If the formatting is poor, the text is available at
http://www.keimel.com/oops-923-output.txt . 

I assume this is going to the kernel list, of which I am not a member.
Please cc: if you can. Thanks. 



Output follows:

john@computer:~$ ksymoops -K < oops-923 
ksymoops 2.4.5 on i686 2.4.22-grsec.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-grsec/ (default)
     -m /boot/System.map-2.4.22-grsec (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000000 printing eip:
c01d1058
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01d1058>]     Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: f6dca054   ebx: d4e8a000   ecx: 00000000   edx:0000001a
esi: d8304000   edi: 00000001   ebp: f7c75fac   esp:f7c75f80
ds: 0018    es: 0018    ss:0018
Process kjournald (pid: 14650, stackpage=f7c75000)
Stack: 00000286 f7ecc468 f7ecc400 f5d839e0 00000020 00000004 f7ecc46c
00000026
       00000001 f7c74000 c011ae40 f7c75fcc c01d171e f7ecc400 f7ecc450
00000000
              f7c74000 f7ecc46c f7ecc46c 00000000 c02295a9 00000700
f7ca3de0 00000000
              Call Trace:    [<c01d171e>] [<c02295a9>] [<c02293c0>]
[<c01c4244>]
              Code: 8b 01 0f 18 00 81 f9 c0 22 10 c0 75 8c 83 7d f0 00
75 65 c6


>>EIP; c01d1058 <schedule+1f0/520>   <=====

>>eax; f6dca054 <END_OF_CODE+36a7d084/????>
>>ebx; d4e8a000 <END_OF_CODE+14b3d030/????>
>>esi; d8304000 <END_OF_CODE+17fb7030/????>
>>ebp; f7c75fac <END_OF_CODE+37928fdc/????>
>>esp; f7c75f80 <END_OF_CODE+37928fb0/????>

Trace; c01d171e <interruptible_sleep_on+4a/78>
Trace; c02295a9 <kjournald+1d9/32c>
Trace; c02293c0 <commit_timeout+0/c>
Trace; c01c4244 <arch_kernel_thread+28/38>

Code;  c01d1058 <schedule+1f0/520>
00000000 <_EIP>:
Code;  c01d1058 <schedule+1f0/520>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01d105a <schedule+1f2/520>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c01d105d <schedule+1f5/520>
   5:   81 f9 c0 22 10 c0         cmp    $0xc01022c0,%ecx
Code;  c01d1063 <schedule+1fb/520>
   b:   75 8c                     jne    ffffff99 <_EIP+0xffffff99>
c01d0ff1 <schedule+189/520>
Code;  c01d1065 <schedule+1fd/520>
   d:   83 7d f0 00               cmpl   $0x0,0xfffffff0(%ebp)
Code;  c01d1069 <schedule+201/520>
  11:   75 65                     jne    78 <_EIP+0x78> c01d10d0
<schedule+268/520>
Code;  c01d106b <schedule+203/520>
  13:   c6 00 00                  movb   $0x0,(%eax)

-- 

==================================================
+ It's simply not       | John Keimel            +
+ RFC1149 compliant!    | john@keimel.com        +
+                       | http://www.keimel.com  +
==================================================
