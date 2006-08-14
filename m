Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbWHNAVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWHNAVt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 20:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbWHNAVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 20:21:49 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:816 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751451AbWHNAVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 20:21:48 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-netdev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2 (+ hotfixes): GPF related to skge on suspend 
In-reply-to: Your message of "Sun, 13 Aug 2006 04:53:09 -0400."
             <200608130456_MC3-1-C7EE-44C8@compuserve.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 Aug 2006 10:21:55 +1000
Message-ID: <17002.1155514915@ocs10w.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert (on Sun, 13 Aug 2006 04:53:09 -0400) wrote:
>In-Reply-To: <20060812052853.f9e5d648.akpm@osdl.org>
>
>On Sat, 12 Aug 2006 05:28:53 -0700, Andrew Morton wrote:
>
>> > Code: 44 8b 28 c7 45 d0 00 00 00 00 45 85 ed 0f 89 29 fb ff ff e9
>>
>> ksymoops says:
>> 
>> Code;  ffffffff88107287 <_end+7ac9287/7efc2000>
>> 00000000 <_EIP>:
>> Code;  ffffffff88107287 <_end+7ac9287/7efc2000>   <=====
>>    0:   44                        inc    %esp   <=====
>> Code;  ffffffff88107288 <_end+7ac9288/7efc2000>
>>    1:   8b 28                     mov    (%eax),%ebp
>
>0x44 is a REX prefix in 64-bit mode, so somehow ksymoops got it
>wrong and gave you an i386-mode decode instead of 64-bit mode.
>Did you run it on a i386 machine and it assumed i386? Maybe you
>need to use "-a x86-64"?  (I can't make it work on my setup.)
>
>So it's really "mov (%r8),%ebp" if I am reading the manual right.

ksymoops -VKLMO -t elf64-x86-64 -a i386:x86-64

ksymoops 2.4.11 on i686 2.6.16.21-0.13-smp.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -M (specified)
     -t elf64-x86-64 -a i386:x86-64

Warning (merge_maps): no symbols in merged map
Code: 44 8b 28 c7 45 d0 00 00 00 00 45 85 ed 0f 89 29 fb ff ff e9

Code;  0000000000000000 No symbols available
0000000000000000 <_RIP>:
Code;  0000000000000000 No symbols available
   0:   44 8b 28                  mov    (%rax),%r13d
Code;  0000000000000003 No symbols available
   3:   c7 45 d0 00 00 00 00      movl   $0x0,0xffffffffffffffd0(%rbp)
Code;  000000000000000a No symbols available
   a:   45 85 ed                  test   %r13d,%r13d
Code;  000000000000000d No symbols available
   d:   0f 89 29 fb ff ff         jns    fffffffffffffb3c <_RIP+0xfffffffffffffb3c>
Code;  0000000000000013 No symbols available
  13:   e9 00 00 00 00            jmpq   18 <_RIP+0x18>

