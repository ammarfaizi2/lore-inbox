Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129711AbRBTMeu>; Tue, 20 Feb 2001 07:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129549AbRBTMek>; Tue, 20 Feb 2001 07:34:40 -0500
Received: from mail2.aracnet.com ([216.99.193.35]:44553 "EHLO
	mail2.aracnet.com") by vger.kernel.org with ESMTP
	id <S129905AbRBTMeb>; Tue, 20 Feb 2001 07:34:31 -0500
Date: Tue, 20 Feb 2001 04:34:22 -0800
From: Kevin Turner <acapnotic@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.1] system goes glacial, Reiser on /usr doesn't sync
Message-ID: <20010220043422.A13432@troglodyte.menefee>
Mail-Followup-To: Kevin Turner <acapnotic@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010220011536.A10778@troglodyte.menefee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010220021609.B11523@troglodyte.menefee>; from acapnotic@users.sourceforge.net on Tue, Feb 20, 2001 at 01:15:36AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Keith who pointed out that "klogd conversion of addresses to
symbols is a pile of crud."  Here's what I'm getting out of ksymoops
now.  It's not as much, since it's just the parts I copied down by
hand...  (I'll get it next time.  Whenever that happens to be.
Installing the ksymoops package didn't trigger it.)


from magic-showPc:


EIP: 0010:[<c0126533>] CPU: 0 EFLAGS: 00000207
Using defaults from ksymoops -t elf32-i386 -a i386
EAX: c0206f98 EBX: c10af1e0 ECX: c10af1fc EDX: c1091200
ESI: c10af1fc EDI: 00000000 EBP: 000005ac DS: 0018 ES: 0018
CR0: 8005003b CR2: 08052beb CR3: 00839000 CR4: 00000010
Call Trace: [<c0126dec>] [<c0126f66>] [<c0127c58>] [<c0127d0c>] [<c01283b1>] [<c011e0ea>] [<c011e140>]
	[<c011e485>] [<c010f83c>] [<c010f704>] [<c0110336>] [<c0127d5e>] [<c0127d84>] [<c0139cea>] [<c0138fe8>]
	[<c0108ee4>] [<c013a3e4>] [<c0108da3>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c0126533 <page_launder+2d3/8a0>   <=====
Trace; c0126dec <do_try_to_free_pages+34/7c>
Trace; c0126f66 <try_to_free_pages+22/2c>
Trace; c0127c58 <__alloc_pages+230/2d0>
Trace; c0127d0c <__get_free_pages+14/20>
Trace; c01283b1 <read_swap_cache_async+31/a0>
Trace; c011e0ea <swapin_readahead+8e/c4>
Trace; c011e140 <do_swap_page+20/114>
Trace; c011e485 <handle_mm_fault+fd/154>
Trace; c010f83c <do_page_fault+138/3fc>
Trace; c010f704 <do_page_fault+0/3fc>
Trace; c0110336 <schedule+26a/394>
Trace; c0127d5e <__free_pages+1a/1c>
Trace; c0127d84 <free_pages+24/28>
Trace; c0139cea <poll_freewait+3a/44>
Trace; c0138fe8 <do_fcntl+14c/204>
Trace; c0108ee4 <error_code+34/40>
Trace; c013a3e4 <sys_select+3bc/494>
Trace; c0108da3 <system_call+33/40>

The running dpkg process:

Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c0127b9c <__alloc_pages+174/2d0>
Trace; c012f932 <grow_buffers+3e/16c>
Trace; c012dad4 <refill_freelist+1c/30>
Trace; c012dae1 <refill_freelist+29/30>
Trace; c012dec2 <getblk+f2/108>
Trace; c38b7378 <[reiserfs].bss.end+45979/af661>
Trace; c386226b <[reiserfs]do_journal_end+633/ab4>
Trace; c3897b78 <[reiserfs].bss.end+26179/af661>
Trace; c386090c <[reiserfs]do_journal_begin_r+188/258>
Trace; c012c0bc <filp_close+5c/64>
Trace; c0108da3 <system_call+33/40>

The running dpkg process, several minutes later is the same, but 
the "bss.end" line above the 'do_journal_end' call reads:

Trace; c38b73e4 <[reiserfs].bss.end+459e5/af661>




