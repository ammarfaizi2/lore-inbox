Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316526AbSEPAQq>; Wed, 15 May 2002 20:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316527AbSEPAQp>; Wed, 15 May 2002 20:16:45 -0400
Received: from sol.mixi.net ([208.131.233.11]:31878 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S316526AbSEPAQn>;
	Wed, 15 May 2002 20:16:43 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15586.64093.770227.324620@rtfm.ofc.tekinteractive.com>
Date: Wed, 15 May 2002 19:16:29 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <200205150849.g4F8n6Y12694@Port.imtp.ilyichevsk.odessa.ua>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just reset after another oops.  It's similar to, but different from,
the previous one; the call stack is the same but they die in different
places.

I put the output of "gcc -E" and "gcc -S" (with the rest of the
command-line parameters) at the following URLs so you can see what the
asm turned into on my machine (gcc 2.95.3); I'm not very x86-asm
literate, so most of it's $FOREIGN_LANG to me.

    http://www.mixi.net/~eigenstr/sched.s
    http://www.mixi.net/~eigenstr/sched.e


----------------------------------------------------------------------
New one: [The "mov" that it died on appears to be at line 3998 of
          sched.s above.]

Oops: 0000
CPU:    1
EIP:    0010:[<c0115c1a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c1dacab0   ebx: 00000002   ecx: c1daca80   edx: 00000003
esi: c2802db0   edi: c2802db0   ebp: cbcd7f48   esp: cbcd7f2c
ds: 0018   es: 0018   ss: 0018
Process ld-linux.so.2 (pid: 11537, stackpage=cbcd7000)
Stack: c1525f20 c2802db0 00000000 c2802db4 00000000 00000282 00000003 00000000
       c01295fe c1525f20 00001000 c012bef0 00000000 d5a21340 ffffffea 00001000
       e7ab0dc8 00001000 00000000 00001000 00001000 00001000 00002000 00000000
Call Trace: [<c01295fe>] [<c012bef0>] [<c0136d57>] [<c010889b>]
Code: 8b 03 0f 18 00 3b 5d f0 75 81 c6 07 01 ff 75 f8 9d 90 8d 74


>>EIP; c0115c1a <__wake_up+b2/d0>   <=====

>>eax; c1dacab0 <END_OF_CODE+1a44454/????>
>>ecx; c1daca80 <END_OF_CODE+1a44424/????>
>>esi; c2802db0 <END_OF_CODE+249a754/????>
>>edi; c2802db0 <END_OF_CODE+249a754/????>
>>ebp; cbcd7f48 <END_OF_CODE+b96f8ec/????>
>>esp; cbcd7f2c <END_OF_CODE+b96f8d0/????>

Trace; c01295fe <unlock_page+62/68>
Trace; c012bef0 <generic_file_write+578/778>
Trace; c0136d57 <sys_write+8f/100>
Trace; c010889b <system_call+33/38>

Code;  c0115c1a <__wake_up+b2/d0>
00000000 <_EIP>:
Code;  c0115c1a <__wake_up+b2/d0>   <=====
   0:   8b 03                     mov    (%ebx),%eax   <=====
Code;  c0115c1c <__wake_up+b4/d0>
   2:   0f 18 00                  prefetchnta (%eax)
Code;  c0115c1f <__wake_up+b7/d0>
   5:   3b 5d f0                  cmp    0xfffffff0(%ebp),%ebx
Code;  c0115c22 <__wake_up+ba/d0>
   8:   75 81                     jne    ffffff8b <_EIP+0xffffff8b> c0115ba5 <__
wake_up+3d/d0>
Code;  c0115c24 <__wake_up+bc/d0>
   a:   c6 07 01                  movb   $0x1,(%edi)
Code;  c0115c27 <__wake_up+bf/d0>
   d:   ff 75 f8                  pushl  0xfffffff8(%ebp)
Code;  c0115c2a <__wake_up+c2/d0>
  10:   9d                        popf   
Code;  c0115c2b <__wake_up+c3/d0>
  11:   90                        nop    
Code;  c0115c2c <__wake_up+c4/d0>
  12:   8d 74 00 00               lea    0x0(%eax,%eax,1),%esi


----------------------------------------------------------------------
Previous one:



>> Oops: 0000
>> CPU:    0
>> EIP:    0010:[<c0115ba8>]    Not tainted
>> Using defaults from ksymoops -t elf32-i386 -a i386
>> EFLAGS: 00010087
>> eax: c2802db4   ebx: c2002db4   ecx: 00000000   edx: 00000003
>> esi: c2802db0   edi: c2802db0   ebp: cd2fdf48   esp: cd2fdf2c
>> ds: 0018   es: 0018   ss: 0018
>> Process ld-linux.so.2 (pid: 18110, stackpage=cd2fd000)
>> Stack: c1095000 c2802db0 00000000 c2802db4 00000000 00000282 00000003
>> 00000000 c01295fe c1095000 00001000 c012bef0 00000000 ce03f5c0 ffffffea
>> 00001000 e0855de8 00001000 00000000 00001000 00001000 00001000 00004000
>> 00000000 Call Trace: [<c01295fe>] [<c012bef0>] [<c0136d57>] [<c010889b>]
>> Code: 8b 01 85 45 fc 74 69 31 c0 9c 5e fa f0 fe 0d 80 a9 30 c0 0f
>>
>> >>EIP; c0115ba8 <__wake_up+40/d0>   <=====
>> Trace; c01295fe <unlock_page+62/68>
>> Trace; c012bef0 <generic_file_write+578/778>
>> Trace; c0136d57 <sys_write+8f/100>
>> Trace; c010889b <system_call+33/38>
>>
>> Code;  c0115ba8 <__wake_up+40/d0>
>> 00000000 <_EIP>:
>> Code;  c0115ba8 <__wake_up+40/d0>   <=====
>>    0:   8b 01                     mov    (%ecx),%eax   <=====
>>    2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
>>    5:   74 69                     je     70 <_EIP+0x70> c0115c18 <__wake_up+b0/d0>
>>    7:   31 c0                     xor    %eax,%eax
>>    9:   9c                        pushf
>>    a:   5e                        pop    %esi
>>    b:   fa                        cli
>>    c:   f0 fe 0d 80 a9 30 c0      lock decb 0xc030a980
>>   13:   0f 00 00                  sldt   (%eax)

