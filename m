Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTLXLNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 06:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTLXLNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 06:13:37 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:6124 "EHLO
	iapetus.localdomain") by vger.kernel.org with ESMTP id S263545AbTLXLNf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 06:13:35 -0500
Date: Wed, 24 Dec 2003 12:12:26 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.22/2.4.23 Oops in try_to_free_buffers() on X restart.
Message-ID: <20031224111226.GA18986@iapetus.localdomain>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20031215110228.GA15976@iapetus.localdomain> <Pine.LNX.4.44.0312151000430.5362-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312151000430.5362-100000@logos.cnet>
User-Agent: Mutt/1.4i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Got a new kernel oops. Same machine as the previous reported oops
> > in journal_try_to_free_buffers(). Something seems definately wrong
> > in 2.4.23.
> > 
> > Marcelo, I'll follow your suggestion te revert a particular change.

The 2.4.23 problems I'm experiencing are not a regression. Patch reversal
didn't solve it and 2.4.22 seems to suffer as well. Somehow RedHat 9 plus
some desktop triggers the problem, almost always when X is started for the
second time the day after the crash (probably some things got paged out in between).

2.4.22 Oops:

aksymoops 2.4.9 on i686 2.4.22-x90.  Options used
     -V (default)
     -k /var/log/ksyms.1 (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-x90/ (default)
     -m /boot/System.map-2.4.22-x90 (specified)

No modules in ksyms, skipping objects
Dec 24 11:36:57 tornio kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000018
Dec 24 11:36:57 tornio kernel: c013a213
Dec 24 11:36:57 tornio kernel: *pde = 00000000
Dec 24 11:36:57 tornio kernel: Oops: 0000
Dec 24 11:36:57 tornio kernel: CPU:    0
Dec 24 11:36:57 tornio kernel: EIP:    0010:[<c013a213>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 24 11:36:57 tornio kernel: EFLAGS: 00010217
Dec 24 11:36:57 tornio kernel: eax: 00000000   ebx: c11795a0   ecx: 000001d0   edx: 00000000
Dec 24 11:36:57 tornio kernel: esi: 00000000   edi: c2bb75d8   ebp: c11cbf1c   esp: c11cbf0c
Dec 24 11:36:57 tornio kernel: ds: 0018   es: 0018   ss: 0018
Dec 24 11:36:57 tornio kernel: Process kswapd (pid: 4, stackpage=c11cb000)
Dec 24 11:36:57 tornio kernel: Stack: c11795a0 000001d0 0000001d c11795a0 c11cbf2c c0138690 c2bb75d8 c11795a0
Dec 24 11:36:57 tornio kernel:        c11cbf60 c012f512 c11795a0 000001d0 00000020 000001d0 00000020 00000020
Dec 24 11:36:57 tornio kernel:        c11ca000 00000062 000003d5 000001d0 c03b2ad4 c11cbf84 c012f765 00000006
Dec 24 11:36:57 tornio kernel: Call Trace:    [<c0138690>] [<c012f512>] [<c012f765>] [<c012f7cc>] [<c012f8e2>]
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; c013a213 <try_to_free_buffers+13/10c>   <=====

Trace; c0138690 <try_to_release_page+48/54>
Trace; c012f512 <shrink_cache+1e6/2fc>
Trace; c012f765 <shrink_caches+55/84>
Trace; c012f7cc <try_to_free_pages_zone+38/5c>
Trace; c012f8e2 <kswapd_balance_pgdat+4e/a0>


Notice that both journal_try_to_free_buffers() and this time
try_to_free_buffers() is Oopsing.


-- 
Frank
