Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbTF3TM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 15:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbTF3TM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 15:12:26 -0400
Received: from web10910.mail.yahoo.com ([216.136.131.219]:13973 "HELO
	web10910.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265851AbTF3TMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 15:12:09 -0400
Message-ID: <20030630192630.79255.qmail@web10910.mail.yahoo.com>
Date: Mon, 30 Jun 2003 12:26:30 -0700 (PDT)
From: Ned Ren <nedren@yahoo.com>
Subject: Re: HELP! Mysterious oops around PIPE code, kernel 2.4.18 
To: linux-kernel@vger.kernel.org
Cc: nedren@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, even with these modules removed it still would crash.

One mistake, my gcc version is actually 3.2.2:
gcc (GCC) 3.2.2 20030222 (Red Hat Linux 3.2.2-5)
Copyright (C) 2002 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There
is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.

I'm really suspecting the code it has compiled, objdump -S gives
almost no dissasembly line in pipe_wait, and with only -d, it gives
lots nop at the end of the function. see below:

pipe.o:     file format elf32-i386

Disassembly of section .text:

00000000 <pipe_wait>:
   0: 55                    push   %ebp
   1: 57                    push   %edi
   2: 56                    push   %esi
   3: be 00 e0 ff ff        mov    $0xffffe000,%esi
   8: 53                    push   %ebx
   9: 21 e6                 and    %esp,%esi
   b: 83 ec 20              sub    $0x20,%esp
   e: 8b 7c 24 34           mov    0x34(%esp,1),%edi
  12: c7 04 24 00 00 00 00  movl   $0x0,(%esp,1)
  19: c7 44 24 04 00 00 00  movl   $0x0,0x4(%esp,1)
  20: 00 
  21: c7 44 24 08 00 00 00  movl   $0x0,0x8(%esp,1)
  28: 00 
  29: c7 44 24 0c 00 00 00  movl   $0x0,0xc(%esp,1)
  30: 00 
  31: 89 74 24 04           mov    %esi,0x4(%esp,1)
  35: 89 74 24 14           mov    %esi,0x14(%esp,1)
  39: c7 44 24 10 00 00 00  movl   $0x0,0x10(%esp,1)
  40: 00 
  41: c7 44 24 18 00 00 00  movl   $0x0,0x18(%esp,1)
  48: 00 
  49: c7 44 24 1c 00 00 00  movl   $0x0,0x1c(%esp,1)
  50: 00 
  51: 8d 6c 24 10           lea    0x10(%esp,1),%ebp
  55: c7 06 01 00 00 00     movl   $0x1,(%esi)
  5b: 8b 87 e8 00 00 00     mov    0xe8(%edi),%eax
  61: 89 ea                 mov    %ebp,%edx
  63: 8d 5f 6c              lea    0x6c(%edi),%ebx
  66: e8 fc ff ff ff        call   67 <pipe_wait+0x67>
  6b: 89 d9                 mov    %ebx,%ecx
  6d: ff 47 6c              incl   0x6c(%edi)
  70: 0f 8e e3 0b 00 00     jle    c59 <.text.lock.pipe>
  76: e8 fc ff ff ff        call   77 <pipe_wait+0x77>
  7b: 89 ea                 mov    %ebp,%edx
  7d: 8b 87 e8 00 00 00     mov    0xe8(%edi),%eax
  83: e8 fc ff ff ff        call   84 <pipe_wait+0x84>
  88: 89 d9                 mov    %ebx,%ecx
  8a: c7 06 00 00 00 00     movl   $0x0,(%esi)
  90: ff 4f 6c              decl   0x6c(%edi)
  93: 0f 88 ca 0b 00 00     js     c63 <.text.lock.pipe+0xa>
  99: 83 c4 20              add    $0x20,%esp
  9c: 5b                    pop    %ebx
  9d: 5e                    pop    %esi
  9e: 5f                    pop    %edi
  9f: 5d                    pop    %ebp
  a0: c3                    ret    
  a1: eb 0d                 jmp    b0 <pipe_read>
  a3: 90                    nop    
  a4: 90                    nop    
  a5: 90                    nop    
  a6: 90                    nop    
  a7: 90                    nop    
  a8: 90                    nop    
  a9: 90                    nop    
  aa: 90                    nop    
  ab: 90                    nop    
  ac: 90                    nop    
  ad: 90                    nop    
  ae: 90                    nop    
  af: 90                    nop    

000000b0 <pipe_read>:
  b0: 55                    push   %ebp
  b1: 57                    push   %edi
  b2: 56                    push   %esi
  b3: be e3 ff ff ff        mov    $0xffffffe3,%esi
  b8: 53                    push   %ebx
  b9: 83 ec 0c              sub    $0xc,%esp
  bc: 8b 54 24 20           mov    0x20(%esp,1),%edx
  c0: 8b 6c 24 28           mov    0x28(%esp,1),%ebp
  c4: 8b 42 08              mov    0x8(%edx),%eax
  c7: 8b 58 08              mov    0x8(%eax),%ebx
  ca: 89 d0                 mov    %edx,%eax
  cc: 83 c0 20              add    $0x20,%eax
  cf: c7 44 24 08 00 00 00  movl   $0x0,0x8(%esp,1)
  d6: 00 
  d7: 39 44 24 2c           cmp    %eax,0x2c(%esp,1)
  db: 74 23                 je     100 <pipe_read+0x50>
  dd: 8b 44 24 08           mov    0x8(%esp,1),%eax
  e1: 85 c0                 test   %eax,%eax
  e3: 74 04                 je     e9 <pipe_read+0x39>
  e5: 8b 74 24 08           mov    0x8(%esp,1),%esi
  e9: 53                    push   %ebx
  ea: e8 fc ff ff ff        call   eb <pipe_read+0x3b>
  ef: 83 c4 10              add    $0x10,%esp
  f2: 5b                    pop    %ebx
  f3: 89 f0                 mov    %esi,%eax
  f5: 5e                    pop    %esi
  f6: 5f                    pop    %edi
  f7: 5d                    pop    %ebp
  f8: c3                    ret    
  f9: 8d b4 26 00 00 00 00  lea    0x0(%esi,1),%esi
 100: 31 f6                 xor    %esi,%esi
 102: 85 ed                 test   %ebp,%ebp
 104: 74 d7                 je     dd <pipe_read+0x2d>
 106: 8d 4b 6c              lea    0x6c(%ebx),%ecx
 109: be 00 fe ff ff        mov    $0xfffffe00,%esi
 10e: 89 4c 24 04           mov    %ecx,0x4(%esp,1)
 112: ff 4b 6c              decl   0x6c(%ebx)
 115: 0f 88 52 0b 00 00     js     c6d <.text.lock.pipe+0x14>
 11b: 31 c0                 xor    %eax,%eax
 11d: 85 c0                 test   %eax,%eax
 11f: 75 bc                 jne    dd <pipe_read+0x2d>
 121: 8b bb e8 00 00 00     mov    0xe8(%ebx),%edi
 127: 8b 47 0c              mov    0xc(%edi),%eax
 12a: 85 c0                 test   %eax,%eax
 12c: 75 74                 jne    1a2 <pipe_read+0xf2>
 12e: 8b 47 18              mov    0x18(%edi),%eax
 131: 31 f6                 xor    %esi,%esi
 133: 85 c0                 test   %eax,%eax
 135: 74 59                 je     190 <pipe_read+0xe0>
 137: 8b 44 24 20           mov    0x20(%esp,1),%eax
 13b: be f5 ff ff ff        mov    $0xfffffff5,%esi
 140: f6 40 19 08           testb  $0x8,0x19(%eax)
 144: 75 4a                 jne    190 <pipe_read+0xe0>
 146: ba 00 e0 ff ff        mov    $0xffffe000,%edx
 14b: 21 e2                 and    %esp,%edx
 14d: 89 14 24              mov    %edx,(%esp,1)
 150: 8b 4f 1c              mov    0x1c(%edi),%ecx
 153: be 00 fe ff ff        mov    $0xfffffe00,%esi
 158: 41                    inc    %ecx
 159: 89 4f 1c              mov    %ecx,0x1c(%edi)
 15c: 53                    push   %ebx
 15d: e8 fc ff ff ff        call   15e <pipe_read+0xae>
 162: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 168: 8b 50 1c              mov    0x1c(%eax),%edx
 16b: 4a                    dec    %edx
 16c: 89 50 1c              mov    %edx,0x1c(%eax)
 16f: 58                    pop    %eax
 170: 8b 0c 24              mov    (%esp,1),%ecx
 173: 8b 41 08              mov    0x8(%ecx),%eax
 176: 85 c0                 test   %eax,%eax
 178: 75 16                 jne    190 <pipe_read+0xe0>
 17a: 8b bb e8 00 00 00     mov    0xe8(%ebx),%edi
 180: 31 f6                 xor    %esi,%esi
 182: 8b 47 0c              mov    0xc(%edi),%eax
 185: 85 c0                 test   %eax,%eax
 187: 75 19                 jne    1a2 <pipe_read+0xf2>
 189: 8b 47 18              mov    0x18(%edi),%eax
 18c: 85 c0                 test   %eax,%eax
 18e: 75 c0                 jne    150 <pipe_read+0xa0>
 190: 8b 4c 24 04           mov    0x4(%esp,1),%ecx
 194: ff 43 6c              incl   0x6c(%ebx)
 197: 0f 8e da 0a 00 00     jle    c77 <.text.lock.pipe+0x1e>
 19d: e9 3b ff ff ff        jmp    dd <pipe_read+0x2d>
 1a2: be f2 ff ff ff        mov    $0xfffffff2,%esi
 1a7: 85 ed                 test   %ebp,%ebp
 1a9: 0f 84 94 00 00 00     je     243 <pipe_read+0x193>
 1af: 8b 57 0c              mov    0xc(%edi),%edx
 1b2: 85 d2                 test   %edx,%edx
 1b4: 0f 84 89 00 00 00     je     243 <pipe_read+0x193>
 1ba: 8b 47 10              mov    0x10(%edi),%eax
 1bd: 8b 4f 08              mov    0x8(%edi),%ecx
 1c0: bf 00 10 00 00        mov    $0x1000,%edi
 1c5: 01 c1                 add    %eax,%ecx
 1c7: 29 c7                 sub    %eax,%edi
 1c9: 39 ef                 cmp    %ebp,%edi
 1cb: 76 02                 jbe    1cf <pipe_read+0x11f>
 1cd: 89 ef                 mov    %ebp,%edi
 1cf: 39 d7                 cmp    %edx,%edi
 1d1: 7e 02                 jle    1d5 <pipe_read+0x125>
 1d3: 89 d7                 mov    %edx,%edi
 1d5: 57                    push   %edi
 1d6: 51                    push   %ecx
 1d7: 8b 44 24 2c           mov    0x2c(%esp,1),%eax
 1db: 50                    push   %eax
 1dc: e8 fc ff ff ff        call   1dd <pipe_read+0x12d>
 1e1: 83 c4 0c              add    $0xc,%esp
 1e4: 85 c0                 test   %eax,%eax
 1e6: 75 a8                 jne    190 <pipe_read+0xe0>
 1e8: 8b 4c 24 08           mov    0x8(%esp,1),%ecx
 1ec: 01 f9                 add    %edi,%ecx
 1ee: 89 4c 24 08           mov    %ecx,0x8(%esp,1)
 1f2: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 1f8: 8b 50 10              mov    0x10(%eax),%edx
 1fb: 01 fa                 add    %edi,%edx
 1fd: 89 50 10              mov    %edx,0x10(%eax)
 200: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 206: 8b 48 10              mov    0x10(%eax),%ecx
 209: 81 e1 ff 0f 00 00     and    $0xfff,%ecx
 20f: 89 48 10              mov    %ecx,0x10(%eax)
 212: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 218: 8b 50 0c              mov    0xc(%eax),%edx
 21b: 29 fa                 sub    %edi,%edx
 21d: 89 50 0c              mov    %edx,0xc(%eax)
 220: 8b 44 24 24           mov    0x24(%esp,1),%eax
 224: 01 f8                 add    %edi,%eax
 226: 29 fd                 sub    %edi,%ebp
 228: 89 44 24 24           mov    %eax,0x24(%esp,1)
 22c: 0f 84 83 00 00 00     je     2b5 <pipe_read+0x205>
 232: 8b bb e8 00 00 00     mov    0xe8(%ebx),%edi
 238: 8b 57 0c              mov    0xc(%edi),%edx
 23b: 85 d2                 test   %edx,%edx
 23d: 0f 85 77 ff ff ff     jne    1ba <pipe_read+0x10a>
 243: 8b 77 0c              mov    0xc(%edi),%esi
 246: 85 f6                 test   %esi,%esi
 248: 75 0d                 jne    257 <pipe_read+0x1a7>
 24a: c7 47 10 00 00 00 00  movl   $0x0,0x10(%edi)
 251: 8b bb e8 00 00 00     mov    0xe8(%ebx),%edi
 257: 85 ed                 test   %ebp,%ebp
 259: 74 11                 je     26c <pipe_read+0x1bc>
 25b: 8b 4f 20              mov    0x20(%edi),%ecx
 25e: 85 c9                 test   %ecx,%ecx
 260: 74 0a                 je     26c <pipe_read+0x1bc>
 262: 8b 44 24 20           mov    0x20(%esp,1),%eax
 266: f6 40 19 08           testb  $0x8,0x19(%eax)
 26a: 74 1a                 je     286 <pipe_read+0x1d6>
 26c: b9 01 00 00 00        mov    $0x1,%ecx
 271: ba 01 00 00 00        mov    $0x1,%edx
 276: 89 f8                 mov    %edi,%eax
 278: e8 fc ff ff ff        call   279 <pipe_read+0x1c9>
 27d: 8b 74 24 08           mov    0x8(%esp,1),%esi
 281: e9 0a ff ff ff        jmp    190 <pipe_read+0xe0>
 286: ba 01 00 00 00        mov    $0x1,%edx
 28b: 89 f8                 mov    %edi,%eax
 28d: b9 01 00 00 00        mov    $0x1,%ecx
 292: e8 fc ff ff ff        call   293 <pipe_read+0x1e3>
 297: 8b bb e8 00 00 00     mov    0xe8(%ebx),%edi
 29d: 8b 57 0c              mov    0xc(%edi),%edx
 2a0: 85 d2                 test   %edx,%edx
 2a2: 0f 84 86 fe ff ff     je     12e <pipe_read+0x7e>
 2a8: 0f 0b                 ud2a   
 2aa: 78 00                 js     2ac <pipe_read+0x1fc>
 2ac: 00 00                 add    %al,(%eax)
 2ae: 00 00                 add    %al,(%eax)
 2b0: e9 79 fe ff ff        jmp    12e <pipe_read+0x7e>
 2b5: 8b bb e8 00 00 00     mov    0xe8(%ebx),%edi
 2bb: eb 86                 jmp    243 <pipe_read+0x193>
 2bd: 8d 76 00              lea    0x0(%esi),%esi

000002c0 <pipe_write>:
 2c0: 55                    push   %ebp
 2c1: 57                    push   %edi
 2c2: bf e3 ff ff ff        mov    $0xffffffe3,%edi
 2c7: 56                    push   %esi
 2c8: 53                    push   %ebx
 2c9: 83 ec 1c              sub    $0x1c,%esp
 2cc: 8b 54 24 30           mov    0x30(%esp,1),%edx
 2d0: 8b 6c 24 38           mov    0x38(%esp,1),%ebp
 2d4: 8b 42 08              mov    0x8(%edx),%eax
 2d7: 8b 58 08              mov    0x8(%eax),%ebx
 2da: 89 d0                 mov    %edx,%eax
 2dc: 83 c0 20              add    $0x20,%eax
 2df: c7 44 24 14 00 00 00  movl   $0x0,0x14(%esp,1)
 2e6: 00 
 2e7: 39 44 24 3c           cmp    %eax,0x3c(%esp,1)
 2eb: 74 16                 je     303 <pipe_write+0x43>
 2ed: 8b 44 24 14           mov    0x14(%esp,1),%eax
 2f1: 85 c0                 test   %eax,%eax
 2f3: 74 04                 je     2f9 <pipe_write+0x39>
 2f5: 8b 7c 24 14           mov    0x14(%esp,1),%edi
 2f9: 89 f8                 mov    %edi,%eax
 2fb: 83 c4 1c              add    $0x1c,%esp
 2fe: 5b                    pop    %ebx
 2ff: 5e                    pop    %esi
 300: 5f                    pop    %edi
 301: 5d                    pop    %ebp
 302: c3                    ret    
 303: 31 ff                 xor    %edi,%edi
 305: 85 ed                 test   %ebp,%ebp
 307: 74 e4                 je     2ed <pipe_write+0x2d>
 309: 8d 4b 6c              lea    0x6c(%ebx),%ecx
 30c: bf 00 fe ff ff        mov    $0xfffffe00,%edi
 311: 89 4c 24 10           mov    %ecx,0x10(%esp,1)
 315: ff 4b 6c              decl   0x6c(%ebx)
 318: 0f 88 63 09 00 00     js     c81 <.text.lock.pipe+0x28>
 31e: 31 c0                 xor    %eax,%eax
 320: 85 c0                 test   %eax,%eax
 322: 75 c9                 jne    2ed <pipe_write+0x2d>
 324: 8b b3 e8 00 00 00     mov    0xe8(%ebx),%esi
 32a: 89 f2                 mov    %esi,%edx
 32c: 8b 46 14              mov    0x14(%esi),%eax
 32f: 85 c0                 test   %eax,%eax
 331: 0f 84 8d 01 00 00     je     4c4 <pipe_write+0x204>
 337: 89 6c 24 18           mov    %ebp,0x18(%esp,1)
 33b: 81 fd 00 10 00 00     cmp    $0x1000,%ebp
 341: 76 08                 jbe    34b <pipe_write+0x8b>
 343: c7 44 24 18 01 00 00  movl   $0x1,0x18(%esp,1)
 34a: 00 
 34b: 8b 44 24 30           mov    0x30(%esp,1),%eax
 34f: f6 40 19 08           testb  $0x8,0x19(%eax)
 353: 0f 84 a2 01 00 00     je     4fb <pipe_write+0x23b>
 359: b8 00 10 00 00        mov    $0x1000,%eax
 35e: 8b 4a 0c              mov    0xc(%edx),%ecx
 361: 29 c8                 sub    %ecx,%eax
 363: bf f5 ff ff ff        mov    $0xfffffff5,%edi
 368: 3b 44 24 18           cmp    0x18(%esp,1),%eax
 36c: 73 12                 jae    380 <pipe_write+0xc0>
 36e: 8b 4c 24 10           mov    0x10(%esp,1),%ecx
 372: ff 43 6c              incl   0x6c(%ebx)
 375: 0f 8e 10 09 00 00     jle    c8b <.text.lock.pipe+0x32>
 37b: e9 6d ff ff ff        jmp    2ed <pipe_write+0x2d>
 380: bf f2 ff ff ff        mov    $0xfffffff2,%edi
 385: 85 ed                 test   %ebp,%ebp
 387: 0f 84 94 00 00 00     je     421 <pipe_write+0x161>
 38d: 8b 4e 0c              mov    0xc(%esi),%ecx
 390: 8b 56 10              mov    0x10(%esi),%edx
 393: 01 ca                 add    %ecx,%edx
 395: 8b 46 08              mov    0x8(%esi),%eax
 398: 81 e2 ff 0f 00 00     and    $0xfff,%edx
 39e: 01 d0                 add    %edx,%eax
 3a0: 89 44 24 08           mov    %eax,0x8(%esp,1)
 3a4: b8 00 10 00 00        mov    $0x1000,%eax
 3a9: 29 d0                 sub    %edx,%eax
 3ab: 89 44 24 04           mov    %eax,0x4(%esp,1)
 3af: b8 00 10 00 00        mov    $0x1000,%eax
 3b4: 29 c8                 sub    %ecx,%eax
 3b6: 0f 84 90 00 00 00     je     44c <pipe_write+0x18c>
 3bc: 39 6c 24 04           cmp    %ebp,0x4(%esp,1)
 3c0: 76 04                 jbe    3c6 <pipe_write+0x106>
 3c2: 89 6c 24 04           mov    %ebp,0x4(%esp,1)
 3c6: 39 44 24 04           cmp    %eax,0x4(%esp,1)
 3ca: 7e 04                 jle    3d0 <pipe_write+0x110>
 3cc: 89 44 24 04           mov    %eax,0x4(%esp,1)
 3d0: 8b 44 24 04           mov    0x4(%esp,1),%eax
 3d4: 50                    push   %eax
 3d5: 8b 44 24 38           mov    0x38(%esp,1),%eax
 3d9: 50                    push   %eax
 3da: 8b 44 24 10           mov    0x10(%esp,1),%eax
 3de: 50                    push   %eax
 3df: e8 fc ff ff ff        call   3e0 <pipe_write+0x120>
 3e4: 83 c4 0c              add    $0xc,%esp
 3e7: 85 c0                 test   %eax,%eax
 3e9: 75 83                 jne    36e <pipe_write+0xae>
 3eb: 8b 54 24 04           mov    0x4(%esp,1),%edx
 3ef: 8b 74 24 14           mov    0x14(%esp,1),%esi
 3f3: 01 d6                 add    %edx,%esi
 3f5: 29 d5                 sub    %edx,%ebp
 3f7: 89 74 24 14           mov    %esi,0x14(%esp,1)
 3fb: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 401: 8b 48 0c              mov    0xc(%eax),%ecx
 404: 01 d1                 add    %edx,%ecx
 406: 89 48 0c              mov    %ecx,0xc(%eax)
 409: 8b 74 24 34           mov    0x34(%esp,1),%esi
 40d: 01 d6                 add    %edx,%esi
 40f: 89 74 24 34           mov    %esi,0x34(%esp,1)
 413: 8b b3 e8 00 00 00     mov    0xe8(%ebx),%esi
 419: 85 ed                 test   %ebp,%ebp
 41b: 0f 85 6c ff ff ff     jne    38d <pipe_write+0xcd>
 421: ba 01 00 00 00        mov    $0x1,%edx
 426: b9 01 00 00 00        mov    $0x1,%ecx
 42b: 89 f0                 mov    %esi,%eax
 42d: e8 fc ff ff ff        call   42e <pipe_write+0x16e>
 432: a1 00 00 00 00        mov    0x0,%eax
 437: 89 43 50              mov    %eax,0x50(%ebx)
 43a: 89 43 54              mov    %eax,0x54(%ebx)
 43d: 6a 07                 push   $0x7
 43f: 53                    push   %ebx
 440: e8 fc ff ff ff        call   441 <pipe_write+0x181>
 445: 58                    pop    %eax
 446: 5a                    pop    %edx
 447: e9 22 ff ff ff        jmp    36e <pipe_write+0xae>
 44c: 8b 4c 24 30           mov    0x30(%esp,1),%ecx
 450: 8b 7c 24 14           mov    0x14(%esp,1),%edi
 454: f6 41 19 08           testb  $0x8,0x19(%ecx)
 458: 75 c7                 jne    421 <pipe_write+0x161>
 45a: b8 00 e0 ff ff        mov    $0xffffe000,%eax
 45f: 21 e0                 and    %esp,%eax
 461: 89 04 24              mov    %eax,(%esp,1)
 464: ba 01 00 00 00        mov    $0x1,%edx
 469: 89 f0                 mov    %esi,%eax
 46b: b9 01 00 00 00        mov    $0x1,%ecx
 470: e8 fc ff ff ff        call   471 <pipe_write+0x1b1>
 475: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 47b: 8b 48 20              mov    0x20(%eax),%ecx
 47e: 41                    inc    %ecx
 47f: 89 48 20              mov    %ecx,0x20(%eax)
 482: 53                    push   %ebx
 483: e8 fc ff ff ff        call   484 <pipe_write+0x1c4>
 488: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 48e: 8b 50 20              mov    0x20(%eax),%edx
 491: 4a                    dec    %edx
 492: 89 50 20              mov    %edx,0x20(%eax)
 495: 58                    pop    %eax
 496: 8b 14 24              mov    (%esp,1),%edx
 499: 8b 72 08              mov    0x8(%edx),%esi
 49c: 85 f6                 test   %esi,%esi
 49e: 0f 85 ca fe ff ff     jne    36e <pipe_write+0xae>
 4a4: 8b b3 e8 00 00 00     mov    0xe8(%ebx),%esi
 4aa: 8b 4e 14              mov    0x14(%esi),%ecx
 4ad: 85 c9                 test   %ecx,%ecx
 4af: 74 13                 je     4c4 <pipe_write+0x204>
 4b1: 81 7e 0c 00 10 00 00  cmpl   $0x1000,0xc(%esi)
 4b8: 74 aa                 je     464 <pipe_write+0x1a4>
 4ba: bf f2 ff ff ff        mov    $0xfffffff2,%edi
 4bf: e9 55 ff ff ff        jmp    419 <pipe_write+0x159>
 4c4: 8b 44 24 14           mov    0x14(%esp,1),%eax
 4c8: 85 c0                 test   %eax,%eax
 4ca: 0f 85 9e fe ff ff     jne    36e <pipe_write+0xae>
 4d0: 8b 4c 24 10           mov    0x10(%esp,1),%ecx
 4d4: ff 43 6c              incl   0x6c(%ebx)
 4d7: 0f 8e b8 07 00 00     jle    c95 <.text.lock.pipe+0x3c>
 4dd: 6a 00                 push   $0x0
 4df: b8 00 e0 ff ff        mov    $0xffffe000,%eax
 4e4: 21 e0                 and    %esp,%eax
 4e6: 50                    push   %eax
 4e7: 6a 0d                 push   $0xd
 4e9: e8 fc ff ff ff        call   4ea <pipe_write+0x22a>
 4ee: 83 c4 0c              add    $0xc,%esp
 4f1: b8 e0 ff ff ff        mov    $0xffffffe0,%eax
 4f6: e9 00 fe ff ff        jmp    2fb <pipe_write+0x3b>
 4fb: b8 00 10 00 00        mov    $0x1000,%eax
 500: 8b 7a 0c              mov    0xc(%edx),%edi
 503: 29 f8                 sub    %edi,%eax
 505: 3b 44 24 18           cmp    0x18(%esp,1),%eax
 509: 0f 83 71 fe ff ff     jae    380 <pipe_write+0xc0>
 50f: b9 00 e0 ff ff        mov    $0xffffe000,%ecx
 514: bf 00 fe ff ff        mov    $0xfffffe00,%edi
 519: 21 e1                 and    %esp,%ecx
 51b: 89 4c 24 0c           mov    %ecx,0xc(%esp,1)
 51f: 8b 4a 20              mov    0x20(%edx),%ecx
 522: 41                    inc    %ecx
 523: 89 4a 20              mov    %ecx,0x20(%edx)
 526: 53                    push   %ebx
 527: e8 fc ff ff ff        call   528 <pipe_write+0x268>
 52c: 8b 83 e8 00 00 00     mov    0xe8(%ebx),%eax
 532: 8b 50 20              mov    0x20(%eax),%edx
 535: 4a                    dec    %edx
 536: 89 50 20              mov    %edx,0x20(%eax)
 539: 58                    pop    %eax
 53a: 8b 44 24 0c           mov    0xc(%esp,1),%eax
 53e: 8b 40 08              mov    0x8(%eax),%eax
 541: 85 c0                 test   %eax,%eax
 543: 0f 85 25 fe ff ff     jne    36e <pipe_write+0xae>
 549: 8b b3 e8 00 00 00     mov    0xe8(%ebx),%esi
 54f: 8b 46 14              mov    0x14(%esi),%eax
 552: 85 c0                 test   %eax,%eax
 554: 0f 84 6a ff ff ff     je     4c4 <pipe_write+0x204>
 55a: b8 00 10 00 00        mov    $0x1000,%eax
 55f: 8b 4e 0c              mov    0xc(%esi),%ecx
 562: 29 c8                 sub    %ecx,%eax
 564: 89 f2                 mov    %esi,%edx
 566: 3b 44 24 18           cmp    0x18(%esp,1),%eax
 56a: 72 b3                 jb     51f <pipe_write+0x25f>
 56c: e9 0f fe ff ff        jmp    380 <pipe_write+0xc0>
 571: eb 0d                 jmp    580 <bad_pipe_r>
 573: 90                    nop    
 574: 90                    nop    
 575: 90                    nop    
 576: 90                    nop    
 577: 90                    nop    
 578: 90                    nop    
 579: 90                    nop    
 57a: 90                    nop    
 57b: 90                    nop    
 57c: 90                    nop    
 57d: 90                    nop    
 57e: 90                    nop    
 57f: 90                    nop    

00000580 <bad_pipe_r>:
 580: b8 f7 ff ff ff        mov    $0xfffffff7,%eax
 585: c3                    ret    
 586: 8d 76 00              lea    0x0(%esi),%esi
 589: 8d bc 27 00 00 00 00  lea    0x0(%edi,1),%edi

00000590 <bad_pipe_w>:
 590: b8 f7 ff ff ff        mov    $0xfffffff7,%eax
 595: c3                    ret    
 596: 8d 76 00              lea    0x0(%esi),%esi
 599: 8d bc 27 00 00 00 00  lea    0x0(%edi,1),%edi


... more code ...

__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
