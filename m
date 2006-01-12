Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbWALLzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbWALLzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 06:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWALLzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 06:55:20 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:40363 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1030296AbWALLzT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 06:55:19 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [ck] Bad page state at free_hot_cold_page : Three more reports, suspend2 but non-ck as far as I know.
Date: Thu, 12 Jan 2006 21:15:53 +1000
User-Agent: KMail/1.9.1
Cc: Chase Venters <chase.venters@clientec.com>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
References: <200601120301.00361.chase.venters@clientec.com> <20060112092406.GA2587@rhlx01.fht-esslingen.de>
In-Reply-To: <20060112092406.GA2587@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601122115.53788.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thursday 12 January 2006 19:24, Andreas Mohr wrote:
> Hi,
>
> On Thu, Jan 12, 2006 at 03:00:59AM -0600, Chase Venters wrote:
> > Greetings,
> > 	(I'm posting this to LKML and CK because I'm not sure if any of
> > 2.6.15-ck1's changes might cause this scenario)
> > 	Recently I've noticed that after my desktop has been up for a while, my
> > music playback / mouse cursor movement will on occasion pause briefly. I
> > got frustrated with it a minute ago and decided to kill artsd, wondering
> > if there could be issues with both arts and amarok's backend holding the
> > audio device open at once.
> > 	When running killall artsd, I locked up for a second and found this in
> > dmesg:
> >
> > Bad page state at free_hot_cold_page (in process 'artsd', page b1761620)
> > flags:0x80000404 mapping:00000000 mapcount:0 count:0
> > Backtrace:
> >  [<b0148e9a>] bad_page+0x84/0xbc
> >  [<b0149699>] free_hot_cold_page+0x65/0x13a
> >  [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
> >  [<b0153bf1>] zap_pte_range+0x1d1/0x28f
> >  [<b0153d70>] unmap_page_range+0xc1/0x122
> >  [<b0153ebe>] unmap_vmas+0xed/0x242
> >  [<b0158099>] unmap_region+0xb4/0x156
> >  [<b01583e2>] do_munmap+0x108/0x144
> >  [<b015846f>] sys_munmap+0x51/0x76
> >  [<b0102eff>] sysenter_past_esp+0x54/0x75
> > Trying to fix it up, but a reboot is needed
>
> AFAIK random page state toggling often happens due to bad RAM.
>
> Care to run memtest86 or similar to confirm this?
> Or also try running an older kernel to verify whether it doesn't happen
> there. But I'm betting on bad RAM :-\

I've had the same reports, so far as I know without the ck patches, and also 
in artsd....

One message:

Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page c16962e8)
flags:0x80000414 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<c0155660>] bad_page+0x84/0xbc
 [<c0155e5f>] free_hot_cold_page+0x55/0x169
 [<c0156759>] __pagevec_free+0x16/0x1e
 [<c015c6f2>] release_pages+0x16e/0x190
 [<c01614dd>] unmap_page_range+0xb4/0x13a
 [<c0169bd9>] free_pages_and_swap_cache+0x5d/0x83
 [<c016177b>] unmap_vmas+0x218/0x22e
 [<c0165cc8>] unmap_region+0xb7/0x159
 [<c0166037>] do_munmap+0x10f/0x179
 [<c01660f2>] sys_munmap+0x51/0x76
 [<c01032a7>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed
Bad page state at free_hot_cold_page (in process 'artsd', page c16962c4)
flags:0x80000414 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<c0155660>] bad_page+0x84/0xbc
 [<c0155e5f>] free_hot_cold_page+0x55/0x169
 [<c0156759>] __pagevec_free+0x16/0x1e
 [<c015c6f2>] release_pages+0x16e/0x190
 [<c01614dd>] unmap_page_range+0xb4/0x13a
 [<c0169bd9>] free_pages_and_swap_cache+0x5d/0x83
 [<c016177b>] unmap_vmas+0x218/0x22e
 [<c0165cc8>] unmap_region+0xb7/0x159
 [<c0166037>] do_munmap+0x10f/0x179
 [<c01660f2>] sys_munmap+0x51/0x76
 [<c01032a7>] sysenter_past_esp+0x54/0x75
Trying to fix it up, but a reboot is needed

To which another user replied:

I am seeing this with the fglrx (commercial ATI) driver version 8.20.8.

A third user:

Bad page state at free_hot_cold_page (in process 'artsd', page c15ba7e0)
flags:0x80000414 mapping:00000000 mapcount:0 count:0
Backtrace:
 [<c01420fa>] bad_page+0x5c/0x92
 [<c01427db>] free_hot_cold_page+0x5a/0xe9
 [<c014aa0c>] zap_pte_range+0x164/0x1ea
 [<c014ab3b>] unmap_page_range+0xa9/0xf3
 [<c014ac4c>] unmap_vmas+0xc7/0x18c
 [<c014e22b>] unmap_region+0x7d/0xed
 [<c014e4a3>] do_munmap+0xdd/0xf3
 [<c014e4ea>] sys_munmap+0x31/0x4b
 [<c0102bc9>] syscall_call+0x7/0xb

One person said these were happening before they'd ever suspended, so I don't 
believe it's suspend2 related.

Regards,

Nigel
