Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSJ0Ipj>; Sun, 27 Oct 2002 03:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSJ0Ipj>; Sun, 27 Oct 2002 03:45:39 -0500
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:1523 "EHLO
	shunka.yo.cz") by vger.kernel.org with ESMTP id <S262317AbSJ0Ipg>;
	Sun, 27 Oct 2002 03:45:36 -0500
Message-ID: <000601c27d96$15654540$4500a8c0@cybernet.cz>
From: =?iso-8859-1?Q?Vladim=EDr_Trebick=FD?= <guru@cimice.yo.cz>
To: "Alex Riesen" <fork0@users.sf.net>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20021027092337.GA4507@steel>
Subject: Re: Swap doesn't work
Date: Sun, 27 Oct 2002 09:51:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does your swap partition show up in /proc/swaps? It has to contain
> something like this:

I have
/dev/hda6                       partition       594364  0       -1
in my /proc/swaps

> Btw, do you see something swap-related in dmesg? Like:
>
>   Unable to find swap-space signature
>   Unable to handle swap header version ...
>   Swap area shorter than signature indicates
>   Empty swap-file
>
> And do you actually see something like this:
>   Adding Swap: 506008k swap-space (priority -1)
>

In dmesg I see only this, but some problem with signanture is in syslog (at
the
end of this mail)

$ dmesg | grep swap
Starting kswapd
Adding Swap: 594364k swap-space (priority -1)

> How did you initialized the swap partition? Recent kernels support both
> v1 and v2 swaps, which is can be set for mkswap using -v0 (-v1).
> Actually i mean did you initialized it at all? 8)

I just created a partition with fdisk /dev/hda6, done "mkswap /dev/hda6" put
the information to /etc/fstab and turned it on with "swapon -a". TOP shows
Swap:  594364K av,       0K used,  594364K free

syslog logs these kinds of kernel messages (those I guess are important):

Sep 29 22:04:19 shunka kernel: swap_free: Bad swap offset entry 1b3d0000
...
Sep 29 22:04:19 shunka kernel: swap_free: Bad swap offset entry 1b3d0000
...
Sep 10 10:03:28 shunka2 kernel: swap_dup: Bad swap file entry 00000022
...
Sep  4 21:30:40 shunka kernel: Unable to find swap-space signature        //
!!!!!!!!
...
Oct 26 19:25:29 shunka kernel:  <1>Unable to handle kernel paging request at
virtual address 2064656e
Oct 26 19:25:29 shunka kernel:  printing eip:
Oct 26 19:25:29 shunka kernel: c012f781
Oct 26 19:25:29 shunka kernel: *pde = 00000000
Oct 26 19:25:29 shunka kernel: Oops: 0000
Oct 26 19:25:29 shunka kernel: CPU:    0
Oct 26 19:25:29 shunka kernel: EIP:    0010:[<c012f781>]    Not tainted
Oct 26 19:25:29 shunka kernel: EFLAGS: 00010202
Oct 26 19:25:29 shunka kernel: eax: c026a19c   ebx: c026a19c   ecx: c105f584
edx: 2064656e
Oct 26 19:25:29 shunka kernel: esi: c95472f8   edi: c1d57000   ebp: c95472f8
esp: c459de94
Oct 26 19:25:29 shunka kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 19:25:29 shunka kernel: Process cpp0 (pid: 12431, stackpage=c459d000)
Oct 26 19:25:29 shunka kernel: Stack: c105f584 c012f465 c026a19c 01d56067
c105f584 c012091c cb728da0 080be6e4
Oct 26 19:25:29 shunka kernel:        080be6e4 c3823080 c0120963 cb728da0
c60fd7a0 c95472f8 00000001 080be6e4
Oct 26 19:25:29 shunka kernel:        cb728da0 080be6e4 080be6e4 c3823080
c0120b8b cb728da0 c60fd7a0 080be6e4
Oct 26 19:25:29 shunka kernel: Call Trace:    [<c012f465>] [<c012091c>]
[<c0120963>] [<c0120b8b>] [<c010fe47>]
Oct 26 19:25:29 shunka kernel:   [<c010fd34>] [<c0121f78>] [<c0122067>]
[<c0120f40>] [<c0108844>]
Oct 26 19:25:29 shunka kernel:
Oct 26 19:25:29 shunka kernel: Code: 8b 02 89 83 b4 00 00 00 c7 02 00 00 00
00 89 d0 5b c3 90 56
Oct 26 19:25:29 shunka kernel:  <1>Unable to handle kernel paging request at
virtual address 6164262c
Oct 26 19:25:29 shunka kernel:  printing eip:
Oct 26 19:25:29 shunka kernel: c012f510
Oct 26 19:25:29 shunka kernel: *pde = 00000000
Oct 26 19:25:29 shunka kernel: Oops: 0000
Oct 26 19:25:29 shunka kernel: CPU:    0
Oct 26 19:25:29 shunka kernel: EIP:    0010:[<c012f510>]    Not tainted
Oct 26 19:25:29 shunka kernel: EFLAGS: 00010206
Oct 26 19:25:29 shunka kernel: eax: 61642628   ebx: c1089dfc   ecx: 00000010
edx: c954713c
Oct 26 19:25:29 shunka kernel: esi: c026a19c   edi: c3789760   ebp: 08448000
esp: c459dd10
Oct 26 19:25:29 shunka kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 19:25:29 shunka kernel: Process cpp0 (pid: 12431, stackpage=c459d000)
Oct 26 19:25:29 shunka kernel: Stack: c954713c 00017000 00007000 c011fa1d
c60fd5c0 cb728da0 00017000 08048000
Oct 26 19:25:29 shunka kernel:        08448000 c3823084 c3823084 00000008
00000000 0805f000 c3823080 00000000
Oct 26 19:25:29 shunka kernel:        0805f000 c0122192 cb728da0 08048000
00017000 cb728da0 c459de60 c459c000
Oct 26 19:25:29 shunka kernel: Call Trace:    [<c011fa1d>] [<c0122192>]
[<c0112212>] [<c0116265>] [<c0108d59>]
Oct 26 19:25:29 shunka kernel:   [<c0110037>] [<c010fd34>] [<c012091c>]
[<c0120963>] [<c0120b8b>] [<c010fe47>]
Oct 26 19:25:29 shunka kernel:   [<c015e6c2>] [<c0108844>] [<c012f781>]
[<c012f465>] [<c012091c>] [<c0120963>]
Oct 26 19:25:29 shunka kernel:   [<c0120b8b>] [<c010fe47>] [<c010fd34>]
[<c0121f78>] [<c0122067>] [<c0120f40>]
Oct 26 19:25:29 shunka kernel:   [<c0108844>]
Oct 26 19:25:29 shunka kernel:
Oct 26 19:25:29 shunka kernel: Code: 39 50 04 75 0e 56 53 57 50 e8 76 02 00
00 83 c4 10 eb 08 89
Oct 26 19:25:29 shunka kernel:  <1>Unable to handle kernel paging request at
virtual address 2064656e
Oct 26 19:25:29 shunka kernel:  printing eip:
Oct 26 19:25:29 shunka kernel: c012f781
Oct 26 19:25:29 shunka kernel: *pde = 00000000
Oct 26 19:25:29 shunka kernel: Oops: 0000
Oct 26 19:25:29 shunka kernel: CPU:    0
Oct 26 19:25:29 shunka kernel: EIP:    0010:[<c012f781>]    Not tainted
Oct 26 19:25:29 shunka kernel: EFLAGS: 00010202
Oct 26 19:25:29 shunka kernel: eax: c026a19c   ebx: c026a19c   ecx: c97fe744
edx: 2064656e
Oct 26 19:25:29 shunka kernel: esi: c97fe744   edi: 081d1e42   ebp: c39f4080
esp: c6657ebc
Oct 26 19:25:29 shunka kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 19:25:29 shunka kernel: Process cc1 (pid: 12432, stackpage=c6657000)
Oct 26 19:25:29 shunka kernel: Stack: c110d17c c012f465 c026a19c c110d17c
081d1e42 c0120aa1 cb7289e0 081d1e42
Oct 26 19:25:29 shunka kernel:        081d1e42 c39f4080 c0120b8b cb7289e0
c493ed40 081d1e42 00000000 c97fe744
Oct 26 19:25:29 shunka kernel:        cb7289e0 081d1e42 cb7289fc c493ed40
c010fe47 cb7289e0 c493ed40 081d1e42
Oct 26 19:25:29 shunka kernel: Call Trace:    [<c012f465>] [<c0120aa1>]
[<c0120b8b>] [<c010fe47>] [<c010fd34>]
Oct 26 19:25:29 shunka kernel:   [<c01e0e5d>] [<c01e0f5e>] [<c01173ea>]
[<c0109c0d>] [<c0108844>]
Oct 26 19:25:29 shunka kernel:
Oct 26 19:25:29 shunka kernel: Code: 8b 02 89 83 b4 00 00 00 c7 02 00 00 00
00 89 d0 5b c3 90 56
...
Oct 26 19:20:52 shunka kernel: kernel BUG at page_alloc.c:117!
Oct 26 19:20:52 shunka kernel: invalid operand: 0000
Oct 26 19:20:52 shunka kernel: CPU:    0
Oct 26 19:20:52 shunka kernel: EIP:    0010:[<c012ab39>]    Not tainted
Oct 26 19:20:52 shunka kernel: EFLAGS: 00010282
Oct 26 19:20:52 shunka kernel: eax: 01000010   ebx: c1111d40   ecx: c026a19c
edx: c10c42a4
Oct 26 19:20:52 shunka kernel: esi: 00000000   edi: 00148000   ebp: 085e5000
esp: c8fb1e30
Oct 26 19:20:52 shunka kernel: ds: 0018   es: 0018   ss: 0018
Oct 26 19:20:52 shunka kernel: Process cc1 (pid: 12012, stackpage=c8fb1000)
Oct 26 19:20:52 shunka kernel: Stack: c1111d40 001e9000 00148000 085e5000
c01173ea 00000046 00000000 c026a19c
Oct 26 19:20:52 shunka kernel:        c103400c c026a1d8 00000216 ffffffff
00003321 c012b389 c012b807 c1111d40
Oct 26 19:20:52 shunka kernel:        c011f5f9 c1111d40 c3af5cb4 c011fa2b
05441067 c493ec80 cb728bc0 001e9000
Oct 26 19:20:52 shunka kernel: Call Trace:    [<c01173ea>] [<c012b389>]
[<c012b807>] [<c011f5f9>] [<c011fa2b>]
Oct 26 19:20:52 shunka kernel:   [<c0122192>] [<c0112212>] [<c0116265>]
[<c011b21a>] [<c01085cf>] [<c010fd34>]
Oct 26 19:20:52 shunka kernel:   [<c0122067>] [<c01173ea>] [<c0120f40>]
[<c0108844>] [<c0108774>]
Oct 26 19:20:52 shunka kernel:
Oct 26 19:20:52 shunka kernel: Code: 0f 0b 75 00 2c c1 22 c0 8b 43 18 24 eb
89 43 18 c6 43 24 05

Thanks,
Vladimir Trebicky

--
Vladimir Trebicky
guru@cimice.yo.cz

