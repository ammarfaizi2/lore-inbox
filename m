Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264153AbTCXLMx>; Mon, 24 Mar 2003 06:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264154AbTCXLMx>; Mon, 24 Mar 2003 06:12:53 -0500
Received: from postoffice.Princeton.EDU ([128.112.129.120]:10372 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id <S264153AbTCXLMv>;
	Mon, 24 Mar 2003 06:12:51 -0500
Date: Mon, 24 Mar 2003 06:23:58 -0500
From: Andrew Ferguson <owsla@Princeton.EDU>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre5 BUG: vmscan.c:359
Message-ID: <20030324112358.GA1265@saimiri.Princeton.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	First off, I am not subscribed to this list and I have never filed an 
OOPS report before, but I was encouraged to do so by the original poster of 
this problem. I had the exact same OOPS  as vmscan.c:359 in the kswapd process 
under kernel 2.4.21-pre5. It is important to note that there are no hardware 
similarities between the two computers. The original poster had a quad Pentium 
4, my computer is an Athlon. We are both using ext3 on our filesystems, 
however.

kernel BUG at vmscan.c:359!
invalid operand: 0000
CPU:    0
EIP:    0010:[shrink_cache+192/784]    Not tainted
EIP:    0010:[<c012b940>]    Not tainted
EFLAGS: 00010202
eax: 010000cc   ebx: c17a6000   ecx: c19c033c   edx: c1c34000
esi: c19c0320   edi: 0000001e   ebp: 00005041   esp: c1c35f34
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1c35000)
Stack: 00000000 c1c34000 00000200 000001d0 c02754e0 c1c0d198 d075fcc0 c1c0dae0
        00000001 00000020 000001d0 00000006 00000020 c012bce0 00000006 0000000b
        c02754e0 00000006 000001d0 c02754e0 00000000 c012bd4c 00000020 
c02754e0 Call Trace:    [shrink_caches+80/128] [try_to_free_pages_zone+60/96] 
[kswapd_balance_pgdat+79/160] [kswapd_balance+38/64] [kswapd+161/192]
Call Trace:    [<c012bce0>] [<c012bd4c>] [<c012be5f>] [<c012bed6>] [<c012c011>]
   [kswapd+0/192] [_stext+0/48] [kernel_thread+38/48] [kswapd+0/192]
   [<c012bf70>] [<c0105000>] [<c0107116>] [<c012bf70>]

Code: 0f 0b 67 01 a6 3d 24 c0 8b 01 8b 51 04 31 db 89 50 04 89 02

>> EIP; c012b940 <shrink_cache+c0/310>   <=====
Trace; c012bce0 <shrink_caches+50/80>
Trace; c012bd4c <try_to_free_pages_zone+3c/60>
Trace; c012be5e <kswapd_balance_pgdat+4e/a0>
Trace; c012bed6 <kswapd_balance+26/40>
Trace; c012c010 <kswapd+a0/c0>
Trace; c012bf70 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0107116 <kernel_thread+26/30>
Trace; c012bf70 <kswapd+0/c0>
Code;  c012b940 <shrink_cache+c0/310>
00000000 <_EIP>:
Code;  c012b940 <shrink_cache+c0/310>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c012b942 <shrink_cache+c2/310>
    2:   67 01 a6 3d 24            addr16 add %esp,9277(%bp)
Code;  c012b946 <shrink_cache+c6/310>
    7:   c0 8b 01 8b 51 04 31      rorb   $0x31,0x4518b01(%ebx)
Code;  c012b94e <shrink_cache+ce/310>
    e:   db 89 50 04 89 02         (bad)  0x2890450(%ecx)


The system was under minimal load at the time (xmms, StarOffice, gaim) and 
does not use either the netdump or O_STREAMING patches that were used in the 
original post. The system has successfully passed several hours of memtest86.

Also, when I rebooted, ext3 declared that it was "recovering journal" on my 
/home filesystem if that's of any consequence.

Please CC me on any replies, thanks!

Oh, and the original reporter has stated that moving to 2.4.21-pre5aa2 seems 
to have cured him of this problem.

______________________________________
Andrew Ferguson - owsla@princeton.edu
   http://www.princeton.edu/~owsla/
       http://www.phstower.org/
