Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSBCNGF>; Sun, 3 Feb 2002 08:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSBCNFr>; Sun, 3 Feb 2002 08:05:47 -0500
Received: from gre12-2.n.club-internet.fr ([195.36.211.2]:5636 "HELO
	lanzarote.fxk.org") by vger.kernel.org with SMTP id <S287106AbSBCNFd>;
	Sun, 3 Feb 2002 08:05:33 -0500
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.17 kills processes in shrink_cache
X-Face: "(f3\<&&St}J$nr=ZjygGjeVd}5q~>[n~+5^>{c2#.1+jvCZxr1BNq#*C3p,2gRi^9e0osq
 A%OL;jNrgIf(S9[ala/vrL<4p=&HC(GV;`)v!}G8>U9s<6aJ(H19^[N-@UrmHqlyQ7A7@I8{u1/W+U
 pa+WWPU^@a;=qxw|_?|mwkSc7HI4`M4DTt|*BXPlX40uQ_ts$7$U9LN;gdd1a?=Ket6&Nfb=
From: "Francois-Xavier 'FiX' KOWALSKI" 
	<francois-xavier.kowalski@club-internet.fr>
Date: 03 Feb 2002 14:05:03 +0100
Message-ID: <lvelk23edc.fsf@fuerteventura.fxk.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel maintainers,

1st, please Cc me in reply.

I encounter the following kernel error using stock kernel.org 2.4.17:

kernel BUG at vmscan.c:360!
invalid operand: 0000
CPU:    0
EIP:    0010:[shrink_cache+206/764]    Not tainted
EIP:    0010:[<c01293f2>]    Not tainted
EFLAGS: 00010282
eax: 0000001c   ebx: c106cf9c   ecx: 00000001   edx: 000026da
esi: c106cf80   edi: 0000000b   ebp: 0000022e   esp: c1171f2c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1171000)
Stack: c0216359 00000168 c11030b0 c1170000 0000003a 000001d0 c02548c8 c11030b0 
       c3603d80 c02546a0 00000000 00000020 000001d0 00000006 00000020 c0129752 
       00000006 0000002e c02548c8 00000006 000001d0 c02548c8 00000000 c01297b4 
Call Trace: [shrink_caches+78/128] [try_to_free_pages+48/76] [kswapd_balance_pgdat+69/144] [kswapd_balance+18/44] [kswapd+149/176] 
Call Trace: [<c0129752>] [<c01297b4>] [<c0129845>] [<c01298a2>] [<c01299b9>] 
   [kswapd+0/176] [_stext+0/40] [kernel_thread+38/48] [kswapd+0/176] 
   [<c0129924>] [<c0105000>] [<c010567a>] [<c0129924>] 

Code: 0f 0b 5a 59 8b 03 8b 53 04 89 50 04 89 02 a1 40 0f 2b c0 89 
 <7>PPP: VJ decompression error

When this error occur, it happens very quickly on many more processes
(a totoal of 20 process, both kernel & user), killing them all, with
the same "kernel BUG" prefix.  Of course, the machine ends-up in a
very bad state & I have to use the magic SysRq to sync it & reboot it.

Looking on various linux-kernel ML archives, I found that the VM is
having some troubles, but no failure with the same backtrace as the
one I have, whereas I always have exactly the same one, at least on
the 2 lowest levels:

	[shrink_caches+78/128]
	[try_to_free_pages+48/76]
differences from here:
	[balance_classzone+102/576]
	[__alloc_pages+258/348]
	[read_swap_cache_async+92/152]
	[swapin_readahead+55/68]
	[do_swap_page+43/220]
	[handle_mm_fault+107/192]
	[set_termios+368/380]
	[do_page_fault+363/1140]
	[tty_check_change+63/120] 

My box is a K6 200 with 64Mb cache, ~800Mb swap.  It is my mail,news &
web proxy.  It also does IP masquerading.

Anything else I can provide to you?

-- 
François-Xavier 'FiX' KOWALSKI

