Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274666AbRIYWp5>; Tue, 25 Sep 2001 18:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274668AbRIYWpj>; Tue, 25 Sep 2001 18:45:39 -0400
Received: from [195.223.140.107] ([195.223.140.107]:39664 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274666AbRIYWpV>;
	Tue, 25 Sep 2001 18:45:21 -0400
Date: Wed, 26 Sep 2001 00:45:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Pawel Kot <pkot@linuxnews.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 BUG()
Message-ID: <20010926004536.N8350@athlon.random>
In-Reply-To: <Pine.LNX.4.33.0109251029200.13603-100000@urtica.linuxnews.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109251029200.13603-100000@urtica.linuxnews.pl>; from pkot@linuxnews.pl on Tue, Sep 25, 2001 at 10:33:09AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 10:33:09AM +0200, Pawel Kot wrote:
> Hi,
> 
> Just came back to work today morning and ofund following:
> Sep 25 01:06:12 enenon kernel: kernel BUG at page_alloc.c:76!
> Sep 25 01:06:12 enenon kernel: invalid operand: 0000
> Sep 25 01:06:12 enenon kernel: CPU:    0
> Sep 25 01:06:12 enenon kernel: EIP:    0010:[__free_pages_ok+52/688]
> Sep 25 01:06:12 enenon kernel: EFLAGS: 00010282
> Sep 25 01:06:12 enenon kernel: eax: 0000001f   ebx: c12ac640   ecx:
> c021305c   edx: 00001208
> Sep 25 01:06:12 enenon kernel: esi: c12ac640   edi: 00000015   ebp:
> 00000000   esp: c13e5f2c
> Sep 25 01:06:12 enenon kernel: ds: 0018   es: 0018   ss: 0018
> Sep 25 01:06:12 enenon kernel: Process kswapd (pid: 5, stackpage=c13e5000)
> Sep 25 01:06:12 enenon kernel: Stack: c01e4893 0000004c c02141c8 c12ac640
> 00000015 0000077a c12ac640 00000015
> Sep 25 01:06:12 enenon kernel:        0000077a 00000001 c0128c17 c0129f87
> c0128c91 00000020 000001d0 00000006
> Sep 25 01:06:12 enenon kernel:        00000786 c13e4000 c02141c8 c0128fec
> 000001d0 00000006 000001d0 c02141c8
> Sep 25 01:06:12 enenon kernel: Call Trace: [shrink_cache+363/864]
> [__free_pages+27/28] [shrink_cache+485/864] [shrink_caches+84/128]
> [try_to_free_pages+28/76]
> Sep 25 01:06:12 enenon kernel:    [kswapd_balance_pgdat+67/140]
> [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]
> Sep 25 01:06:12 enenon kernel:
> Sep 25 01:06:12 enenon kernel: Code: 0f 0b 83 c4 08 8d b4 26 00 00 00 00
> 89 d8 2b 05 0c cf 26 c0
> 
> The machine was idle at night, but ad 1:01 cron.daily was scheduled with
> following jobs:
> datesync
> logrotate
> makewhatis.cron
> slocate.cron
> 
> Swap in not used:
> [root@enenon root]# free
>              total       used       free     shared    buffers     cached
> Mem:        191716     178180      13536          0       4760      67480
> -/+ buffers/cache:     105940      85776
> Swap:       104384          0     104384

do I guess right that you aren't running just ext2 on your machine? if
so what other fses or patches are you running?

Andrea
