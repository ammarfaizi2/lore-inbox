Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVKQU7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVKQU7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVKQU7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:59:24 -0500
Received: from isilmar.linta.de ([213.239.214.66]:49325 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S964849AbVKQU7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:59:24 -0500
Date: Thu, 17 Nov 2005 21:59:22 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
Message-ID: <20051117205922.GA18487@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com> <Pine.LNX.4.61.0511171929210.4563@goblin.wat.veritas.com> <20051117194102.GE5772@redhat.com> <20051117204617.GA10925@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117204617.GA10925@isilmar.linta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uh,

On Thu, Nov 17, 2005 at 09:46:17PM +0100, Dominik Brodowski wrote:
> [4294994.302000] Restarting tasks... done
> [4295188.230000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb020)
> [4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> [4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> [4295188.230000] Backtrace:
> [4295188.230000]  [<c0103b59>] dump_stack+0x15/0x17
> [4295188.230000]  [<c0138f99>] bad_page+0x5b/0x92
> [4295188.230000]  [<c013967b>] free_hot_cold_page+0x5c/0xfe
> [4295188.230000]  [<c0139727>] free_hot_page+0xa/0xc
> [4295188.230000]  [<c013eff0>] __page_cache_release+0x8f/0x94
> [4295188.230000]  [<c013ecd3>] put_page+0x5b/0x5d
> [4295188.230000]  [<c0148d69>] free_page_and_swap_cache+0x2c/0x2f
> [4295188.230000]  [<c0142609>] zap_pte_range+0x1a1/0x214
> [4295188.230000]  [<c014271a>] unmap_page_range+0x9e/0xe8
> [4295188.230000]  [<c0142827>] unmap_vmas+0xc3/0x199
> [4295188.230000]  [<c0145cf7>] unmap_region+0x77/0xf2
> [4295188.230000]  [<c0145f91>] do_munmap+0xdd/0xf3
> [4295188.230000]  [<c0145ff6>] sys_munmap+0x4f/0x68
> [4295188.230000]  [<c0102cab>] sysenter_past_esp+0x54/0x75
> [4295188.230000] Trying to fix it up, but a reboot is needed
> [4295188.230000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb040)
> [4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> [4295188.230000] Backtrace:
> [4295188.230000]  [<c0103b59>] dump_stack+0x15/0x17
> [4295188.230000]  [<c0138f99>] bad_page+0x5b/0x92
> [4295188.230000]  [<c013967b>] free_hot_cold_page+0x5c/0xfe
> [4295188.230000]  [<c0139727>] free_hot_page+0xa/0xc
> [4295188.230000]  [<c013eff0>] __page_cache_release+0x8f/0x94
> [4295188.230000]  [<c013ecd3>] put_page+0x5b/0x5d
> [4295188.230000]  [<c0148d69>] free_page_and_swap_cache+0x2c/0x2f
> [4295188.230000]  [<c0142609>] zap_pte_range+0x1a1/0x214
> [4295188.230000]  [<c014271a>] unmap_page_range+0x9e/0xe8
> [4295188.230000]  [<c0142827>] unmap_vmas+0xc3/0x199
> [4295188.230000]  [<c0145cf7>] unmap_region+0x77/0xf2
> [4295188.230000]  [<c0145f91>] do_munmap+0xdd/0xf3
> [4295188.230000]  [<c0145ff6>] sys_munmap+0x4f/0x68
> [4295188.230000]  [<c0102cab>] sysenter_past_esp+0x54/0x75
> [4295188.230000] Trying to fix it up, but a reboot is needed
> [4295188.230000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb060)
> [4295188.230000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> [4295188.230000] Backtrace:
> [4295188.230000]  [<c0103b59>] dump_stack+0x15/0x17
> [4295188.230000]  [<c0138f99>] bad_page+0x5b/0x92
> [4295188.230000]  [<c013967b>] free_hot_cold_page+0x5c/0xfe
> [4295188.230000]  [<c0139727>] free_hot_page+0xa/0xc
> [4295188.230000]  [<c013eff0>] __page_cache_release+0x8f/0x94
> [4295188.231000]  [<c013ecd3>] put_page+0x5b/0x5d
> 
> ... and so on. Don't know whether this is related... and it isn't
> reproducible.

It _is_ reproducible. Only happened after suspend-to-ram, though; but the
first real thing I did after reboot was trying to suspend-to-ram... Will
check tomorrow whether this also appears without suspend-to-ram in between.

	Dominik
