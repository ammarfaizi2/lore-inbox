Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285045AbRLQHxZ>; Mon, 17 Dec 2001 02:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285047AbRLQHxQ>; Mon, 17 Dec 2001 02:53:16 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:2948 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S285045AbRLQHxC>; Mon, 17 Dec 2001 02:53:02 -0500
Message-ID: <3C1DF93E.80907@free.fr>
Date: Mon, 17 Dec 2001 08:55:10 -0500
From: FORT David <popo.enlighted@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011121
X-Accept-Language: fr, en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.16 deadlock in kswapd
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
today i was transfering some files between two drives(reiserfs->ext3) and
suddenly everything locked up. I sys-rqed to show the executed IP and
every five times i've tryed it was showing the following stack trace:

EIP: 0010:[<c0111657>] CPU: 0 EFLAGS: 00200202    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: 00000002 EBX: 02000000 ECX: 00000000 EDX: 00200202
ESI: efe38120 EDI: e112fe90 EBP: efe38120 DS: 0018 ES: 0018
CR0: 8005003b CR2: 4002a009 CR3: 1f165000 CR4: 000002d0
Call Trace: [<c01117b5>] [<c012f052>] [<c01920a5>] [<c0191840>] 
[<c0191f10>]
   [<c012f4f6>] [<c012f6d2>] [<c012f72c>] [<c012f7d1>] [<c012f846>] 
[<c012f981>]
   [<c012f8e0>] [<c0105000>] [<c0105656>] [<c012f8e0>]
Warning (Oops_read): Code line not seen, dumping what data is available

 >>EIP; c0111657 <flush_tlb_others+e7/110>   <=====
Trace; c01117b5 <flush_tlb_page+75/80>
Trace; c012f052 <swap_out+312/4b0>
Trace; c01920a5 <ide_dmaproc+135/210>
Trace; c0191840 <ide_dma_intr+0/c0>
Trace; c0191f10 <dma_timer_expiry+0/60>
Trace; c012f4f6 <shrink_cache+306/390>
Trace; c012f6d2 <shrink_caches+52/80>
Trace; c012f72c <try_to_free_pages+2c/50>
Trace; c012f7d1 <kswapd_balance_pgdat+51/a0>
Trace; c012f846 <kswapd_balance+26/40>
Trace; c012f981 <kswapd+a1/c0>
Trace; c012f8e0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c0105656 <kernel_thread+26/30>
Trace; c012f8e0 <kswapd+0/c0>

The interesting thing is that i don't have any swap, so i'm really 
interested
in knowing why kswapd is envolved here.
Feel free to ask additionnal informations.

PS: the kernel is tainted by lm_sensors

-- 
%--LINUX-HTTPD-PIOGENE----------------------------------------------------%
%  -datamining <-/                        |   .~.                         %
%  -networking/PHP/java/JSPs              |   /V\        L  I  N  U  X    %
%  -opensource                            |  // \\     >Fear the Penguin< %
%  -GNOME/enlightenment/GIMP              | /(   )\                       %
%           feel enlightened....          |  ^^-^^                        %
%                              HomePage: http://www.enlightened-popo.net  %
%---------- -- This was sent by Djinn running Linux 2.4.16 -- ------------%


