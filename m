Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131936AbQLLPhE>; Tue, 12 Dec 2000 10:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131916AbQLLPgo>; Tue, 12 Dec 2000 10:36:44 -0500
Received: from 4dyn46.com21.casema.net ([212.64.95.46]:49415 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S131936AbQLLPgf>;
	Tue, 12 Dec 2000 10:36:35 -0500
Date: Tue, 12 Dec 2000 16:06:05 +0100
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org
Subject: [BUG] raid5 crash with 2.4.0-test12 [Was: Linux-2.4.0-test12]
Message-ID: <20001212160605.A1835@spaans.ds9a.nl>
In-Reply-To: <Pine.LNX.4.10.10012111850320.976-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012111850320.976-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Dec 11, 2000 at 06:52:55PM -0800
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2000 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2000 at 06:52:55PM -0800, Linus Torvalds wrote:
> 
> Ok, there it is. Noticeable changes from pre8 are mainly (a) new tq list
> compile fixes and (b) the NetApp snapshot thing.

>  - final:
>     - Neil Brown: raid and md cleanups

Hmm, while doing some not-so-heavy things with a mysql-db on a raid5-device
this kernel Oopsed on me; ksymoops output [which went through klogd,
shouldn't matter that much, klogd was using the right System.map]:

Dec 12 14:04:50 spaans kernel: invalid operand: 0000
Dec 12 14:04:50 spaans kernel: CPU:    1
Dec 12 14:04:50 spaans kernel: EIP:    0010:[end_buffer_io_bad+85/92]
Dec 12 14:04:50 spaans kernel: EFLAGS: 00010286
Dec 12 14:04:50 spaans kernel: eax: 0000001c   ebx: c5418dc8   ecx: 00000000   edx: 01000000
Dec 12 14:04:50 spaans kernel: esi: cfd9b960   edi: cfd9b800   ebp: c5418d80   esp: c14ade8c
Dec 12 14:04:50 spaans kernel: ds: 0018   es: 0018   ss: 0018
Dec 12 14:04:50 spaans kernel: Process raid5d (pid: 9, stackpage=c14ad000)
Dec 12 14:04:50 spaans kernel: Stack: c0225409 c022575a 000002fd 00000008 c01c91ac c5418d80 00000001 00000008 
Dec 12 14:04:50 spaans kernel:        cfd9b800 00000002 00000000 c01c9d0f cfd9b800 00000002 00000001 cfd9b800 
Dec 12 14:04:50 spaans kernel:        c146c400 cfd9b800 00000003 00000003 c146c400 c01ca867 cfd9b800 cfd9b800 
Dec 12 14:04:50 spaans kernel: Call Trace: [tvecs+13949/58456] [tvecs+14798/58456] [raid5_end_buffer_io+68/128] [complete_stripe+151/272] [handle_stripe+331/1092] [raid5d+173/260] [md_thread+299/508] 
Dec 12 14:04:50 spaans kernel: Code: 0f 0b 83 c4 0c 5b c3 55 57 56 53 8b 5c 24 14 8b 54 24 18 85 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   5b                        pop    %ebx
Code;  00000006 Before first symbol
   6:   c3                        ret    
Code;  00000007 Before first symbol
   7:   55                        push   %ebp
Code;  00000008 Before first symbol
   8:   57                        push   %edi
Code;  00000009 Before first symbol
   9:   56                        push   %esi
Code;  0000000a Before first symbol
   a:   53                        push   %ebx
Code;  0000000b Before first symbol
   b:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  0000000f Before first symbol
   f:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000013 Before first symbol
  13:   85 00                     test   %eax,(%eax)

Regards,
-- 
Jasper Spaans  <jasper@spaans.ds9a.nl>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
