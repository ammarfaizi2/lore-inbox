Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSHNPPi>; Wed, 14 Aug 2002 11:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318813AbSHNPPi>; Wed, 14 Aug 2002 11:15:38 -0400
Received: from port-212-202-177-143.reverse.qdsl-home.de ([212.202.177.143]:1798
	"EHLO pinguin.dyndns.org") by vger.kernel.org with ESMTP
	id <S313558AbSHNPPi>; Wed, 14 Aug 2002 11:15:38 -0400
Date: Wed, 14 Aug 2002 17:19:29 +0200
From: Ingo Saitz <Ingo.Saitz@stud.uni-hannover.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
Message-ID: <20020814151929.GA1324@pinguin.subspace.exe>
References: <3D51DB52.6000200@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D51DB52.6000200@verizon.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the same bug this morning. Untainted 2.4.19 vanilla kernel.
I just noticed it because my kernel was creating Zombies ~10 hours
later.

My system: Debian unstable, P2 Celeron (Mendocino), ext3, bttv card,
lirc 0.6.5 and ati.2 driver from gatos.sf.net installed (does not
require kernel modules).

Aug 14 05:42:31 pinguin kernel: kernel BUG at page_alloc.c:91!
Aug 14 05:42:31 pinguin kernel: invalid operand: 0000
Aug 14 05:42:31 pinguin kernel: CPU:    0
Aug 14 05:42:31 pinguin kernel: EIP:    0010:[__free_pages_ok+45/612]    Not tainted
Aug 14 05:42:31 pinguin kernel: EFLAGS: 00010282
Aug 14 05:42:31 pinguin kernel: eax: c1301bc0   ebx: c100ffdc   ecx: c100ffdc   edx: c02cfc40
Aug 14 05:42:31 pinguin kernel: esi: 00000000   edi: 00000011   ebp: 00000200   esp: c15c7f18
Aug 14 05:42:31 pinguin kernel: ds: 0018   es: 0018   ss: 0018
Aug 14 05:42:31 pinguin kernel: Process kswapd (pid: 5, stackpage=c15c7000)
Aug 14 05:42:31 pinguin kernel: Stack: d3bfb620 c100ffdc 00000011 00000200 c01350dc c100ffdc 000001d0 00000011 
Aug 14 05:42:31 pinguin kernel:        00000200 c013365c d3bfb620 c100ffdc c012b652 c012c583 c012b68b 00000020 
Aug 14 05:42:31 pinguin kernel:        000001d0 00000020 00000006 00000006 c15c6000 00002a19 000001d0 c02cfdd4 
Aug 14 05:42:31 pinguin kernel: Call Trace:    [try_to_free_buffers+144/228] [try_to_release_page+68/72] [shrink_cache+474/748] [__free_pages+27/28] [shrink_cache+531/748]
Aug 14 05:42:31 pinguin kernel:   [shrink_caches+88/128] [try_to_free_pages+55/88] [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]
Aug 14 05:42:31 pinguin kernel: 
Aug 14 05:42:31 pinguin kernel: Code: 0f 0b 5b 00 d3 b3 27 c0 89 d8 2b 05 b0 14 33 c0 69 c0 a3 8b 

    Ingo
-- 
echo "I love  windows" | tr wisd \\buxi
