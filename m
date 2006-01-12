Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWALJYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWALJYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWALJYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:24:19 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:53474 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S964983AbWALJYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:24:19 -0500
Date: Thu, 12 Jan 2006 10:24:06 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Chase Venters <chase.venters@clientec.com>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [ck] Bad page state at free_hot_cold_page
Message-ID: <20060112092406.GA2587@rhlx01.fht-esslingen.de>
References: <200601120301.00361.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601120301.00361.chase.venters@clientec.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 12, 2006 at 03:00:59AM -0600, Chase Venters wrote:
> Greetings,
> 	(I'm posting this to LKML and CK because I'm not sure if any of 2.6.15-ck1's 
> changes might cause this scenario)
> 	Recently I've noticed that after my desktop has been up for a while, my music 
> playback / mouse cursor movement will on occasion pause briefly. I got 
> frustrated with it a minute ago and decided to kill artsd, wondering if there 
> could be issues with both arts and amarok's backend holding the audio device 
> open at once.
> 	When running killall artsd, I locked up for a second and found this in dmesg:
> 
> Bad page state at free_hot_cold_page (in process 'artsd', page b1761620)
> flags:0x80000404 mapping:00000000 mapcount:0 count:0
> Backtrace:
>  [<b0148e9a>] bad_page+0x84/0xbc
>  [<b0149699>] free_hot_cold_page+0x65/0x13a
>  [<b05b6901>] _spin_unlock_irqrestore+0xf/0x23
>  [<b0153bf1>] zap_pte_range+0x1d1/0x28f
>  [<b0153d70>] unmap_page_range+0xc1/0x122
>  [<b0153ebe>] unmap_vmas+0xed/0x242
>  [<b0158099>] unmap_region+0xb4/0x156
>  [<b01583e2>] do_munmap+0x108/0x144
>  [<b015846f>] sys_munmap+0x51/0x76
>  [<b0102eff>] sysenter_past_esp+0x54/0x75
> Trying to fix it up, but a reboot is needed

AFAIK random page state toggling often happens due to bad RAM.

Care to run memtest86 or similar to confirm this?
Or also try running an older kernel to verify whether it doesn't happen there.
But I'm betting on bad RAM :-\

Andreas Mohr
