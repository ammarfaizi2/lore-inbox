Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTFEHWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 03:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTFEHWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 03:22:36 -0400
Received: from angband.namesys.com ([212.16.7.85]:44934 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S264489AbTFEHWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 03:22:35 -0400
Date: Thu, 5 Jun 2003 11:36:04 +0400
From: Oleg Drokin <green@namesys.com>
To: Daniel Sobe <daniel.sobe@epost.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Oops (semms in reiserfs)
Message-ID: <20030605073604.GA8646@namesys.com>
References: <1054759139.1100.58.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054759139.1100.58.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jun 04, 2003 at 10:38:56PM +0200, Daniel Sobe wrote:
> working a while in X i got these errors (second error repeating for some
> time, i was able to use SysRq to sync, mount ro and reboot). seems to be
> related to reiserfs.

This looks like as if you have some memory corruption that is not reiserfs related,
it is just reiserfs was unfortunate to call the kmem_cache_alloc() that stepped on
the corrupted pointer. (and how the pointer got corrupted is not clear).
And you can see, there was another non-reiserfs related caller that stepped on that
same bad pointer in kmem_cache_alloc() too (only a bit later).
Perhaps you want to run memtest86 for some time to see if your memory is ok.
And to run without binary modules loaded to see if they are the reason for
the problem.
 
> Jun  4 15:14:14 localhost kernel:  <1>Unable to handle kernel paging
> request at virtual address c4449020 
> Jun  4 15:14:14 localhost kernel:  printing eip: 
> Jun  4 15:14:14 localhost kernel: c012a9b3 
> Jun  4 15:14:14 localhost kernel: Oops: 0000 
> Jun  4 15:14:14 localhost kernel: CPU:    0 
> Jun  4 15:14:14 localhost kernel: EIP:   
> 0010:[kmem_cache_alloc+131/224]    Tainted: PF 
> Jun  4 15:14:14 localhost kernel: EFLAGS: 00010803 
> Jun  4 15:14:14 localhost kernel: eax: 00400002   ebx: 43449440   ecx:
> c3449000   edx: c02f38a0 
> Jun  4 15:14:14 localhost kernel: esi: c10b7130   edi: 00000246   ebp:
> 000001f0   esp: c1949f1c 
> Jun  4 15:14:14 localhost kernel: ds: 0018   es: 0018   ss: 0018 
> Jun  4 15:14:14 localhost kernel: Process wmxmms (pid: 625,
> stackpage=c1949000) 
> Jun  4 15:14:14 localhost kernel: Stack: 00000001 00000004 c02f38a0
> 00000001 c01448a9 c10b7130 000001f0 00000001 
> Jun  4 15:14:14 localhost kernel:        c01e7f06 00000001 c01e883d
> 00000001 08097eb0 0805b248 bffffb8c 00000c69 
> Jun  4 15:14:14 localhost kernel:        c012ca1b c012ca3a c013f1aa
> 00000000 080980f0 080980e0 c013fdc4 c01e88ad 
> Jun  4 15:14:14 localhost kernel: Call Trace:   
> [get_empty_inode+25/160] [sock_alloc+6/192] [sock_create+173/256]
> [__free_pages+27/32] [free_pages+26/32] 
> Jun  4 15:14:14 localhost kernel:   [poll_freewait+58/80]
> [sys_poll+724/752] [sys_socket+29/96] [sys_socketcall+99/512]
> [system_call+51/56] 
> Jun  4 15:14:14 localhost kernel: 
> Jun  4 15:14:14 localhost kernel: Code: 8b 44 81 18 89 41 14 83 f8 ff 75
> 23 8b 41 04 8b 11 89 42 04 

Bye,
    Oleg
