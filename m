Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTFBJD6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262042AbTFBJD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:03:57 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:60057 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S262037AbTFBJDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:03:54 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-mm3
Date: Mon, 2 Jun 2003 10:17:15 +0100
User-Agent: KMail/1.5.9
References: <20030531013716.07d90773.akpm@digeo.com>
In-Reply-To: <20030531013716.07d90773.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306021017.15633.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 May 2003 09:37, Andrew Morton wrote:
>
> . More ext3 fixes.  It seems fully recovered now.
>
> . Some cleanups and enhancements to the O_SYNC rework.
>
> . A couple of fairly significant reiserfs enhancements.  See the changelogs
>   in the individual patches for details.
>

Not sure if this is related to the -mm patches or the bk snapshot, but I left 
2.5.70-mm3 compiling KDE all last night, and when I got up this morning I 
found the machine had oopsed and was in an unusable state. Though I wasn't 
able to note down the final oops, I did get two warnings that were dumped to 
kern.log moments before the machine died.

Bad page state at free_hot_cold_page
flags:0x01010000 mapping:00000000 mapped:1 count:0
Backtrace:
Call Trace:
 [bad_page+93/144] bad_page+0x5d/0x90
 [free_hot_cold_page+112/256] free_hot_cold_page+0x70/0x100
 [zap_pte_range+385/448] zap_pte_range+0x181/0x1c0
 [do_wp_page+437/848] do_wp_page+0x1b5/0x350
 [zap_pmd_range+75/112] zap_pmd_range+0x4b/0x70
 [unmap_page_range+75/128] unmap_page_range+0x4b/0x80
 [unmap_vmas+254/544] unmap_vmas+0xfe/0x220
 [exit_mmap+109/384] exit_mmap+0x6d/0x180
 [mmput+65/176] mmput+0x41/0xb0
 [do_exit+243/832] do_exit+0xf3/0x340
 [do_group_exit+52/128] do_group_exit+0x34/0x80
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

Trying to fix it up, but a reboot is needed
Bad page state at prep_new_page
flags:0x01010000 mapping:00000000 mapped:1 count:0
Backtrace:
Call Trace:
 [bad_page+93/144] bad_page+0x5d/0x90
 [prep_new_page+64/96] prep_new_page+0x40/0x60
 [buffered_rmqueue+167/320] buffered_rmqueue+0xa7/0x140
 [ext3_readpages+0/48] ext3_readpages+0x0/0x30
 [__alloc_pages+144/848] __alloc_pages+0x90/0x350
 [__get_free_pages+26/80] __get_free_pages+0x1a/0x50
 [cache_grow+161/544] cache_grow+0xa1/0x220
 [cache_alloc_refill+324/512] cache_alloc_refill+0x144/0x200
 [kmem_cache_alloc+62/64] kmem_cache_alloc+0x3e/0x40
 [__kfree_skb+68/272] alloc_skb+0x24/0xe0
 [sock_no_connect+7/16] sock_alloc_send_pskb+0xc7/0x1d0
 [sock_no_sendpage+111/192] sock_alloc_send_skb+0x2f/0x40
 [sense_data_texts+692/1008] unix_dgram_sendmsg+0x134/0x4d0
 [__generic_file_aio_read+468/528] __generic_file_aio_read+0x1d4/0x210
 [ide_build_dmatable+128/416] ide_build_sglist+0x40/0xb0
 [vlan_ioctl_set+19/48] sock_aio_write+0xc3/0xf0
 [do_sync_write+182/240] do_sync_write+0xb6/0xf0
 [update_wall_time+22/64] update_wall_time+0x16/0x40
 [do_IRQ+197/240] do_IRQ+0xc5/0xf0
 [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
 [schedule+432/896] schedule+0x1b0/0x380
 [default_wake_function+0/48] default_wake_function+0x0/0x30
 [update_wall_time+22/64] update_wall_time+0x16/0x40
 [do_timer+224/240] do_timer+0xe0/0xf0
 [vfs_write+255/304] vfs_write+0xff/0x130
 [sys_write+66/112] sys_write+0x42/0x70
 [sysenter_past_esp+82/113] sysenter_past_esp+0x52/0x71

Trying to fix it up, but a reboot is needed

As the machine was doing compilation, nothing extraneous was loaded (like X), 
but it could easily have been under stress at the time of oops. I guess I'm 
just making sure it's got nothing to do with your ext3 changes.

Cheers,
Alistair.
