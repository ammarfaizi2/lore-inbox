Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbTFESIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264783AbTFESIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:08:21 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:52491 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264782AbTFESIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:08:20 -0400
Date: Thu, 5 Jun 2003 20:14:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <20030605181423.GA17277@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <2804790000.1052441142@aslan.scsiguy.com> <20030509120648.1e0af0c8.skraw@ithnet.com> <20030509120659.GA15754@alpha.home.local> <20030509150207.3ff9cd64.skraw@ithnet.com> <20030524111608.GA4599@alpha.home.local> <20030605170551.3d61b0d4.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605170551.3d61b0d4.skraw@ithnet.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 05:05:51PM +0200, Stephan von Krawczynski wrote:
> Hello all,
> 
> It took some days to produce output for my freezing problem. This one is rc7+aic20030603:

Good !

It seems that it crashed in the reiserfs code rather than in aic7xxx ! perhaps
you hit 2 different bugs, or perhaps there's a race that only newer code can
trigger, or there's a leak somewhere. You may want to forward the oops to the
reiserfs team too.

> Jun  5 16:53:55 admin kernel: Call Trace:    [<c01382eb>] [<c013749c>] [<c01382fd>] [<c01846a7>] [<c0184bc6>]
> Jun  5 16:53:55 admin kernel:   [reiserfs_paste_into_item+147/304] [reiserfs_get_block+1989/4800] [bh_action+106/112] [tasklet_hi_action+83/160] [smp_apic_timer_interrupt+264/304] [.text.lock.buffer+191/610]
> Jun  5 16:53:55 admin kernel:   [<c0191ae3>] [<c017cca5>] [<c012252a>] [<c01223b3>] [<c0115d88>] [<c01474bd>]
> Jun  5 16:53:55 admin kernel:   [getblk+109/128] [is_tree_node+100/112] [search_by_key+1824/3792] [__block_prepare_write+479/880] [block_prepare_write+51/144] [reiserfs_get_block+0/4800]
> Jun  5 16:53:55 admin kernel:   [<c014447d>] [<c018e8f4>] [<c018f020>] [<c014503f>] [<c0145a23>] [<c017c4e0>]
> Jun  5 16:53:55 admin kernel:   [generic_file_write+970/2128] [reiserfs_get_block+0/4800] [sys_write+155/384] [system_call+51/56]
> Jun  5 16:53:55 admin kernel:   [<c013397a>] [<c017c4e0>] [<c0141d8b>] [<c010782f>]
> Jun  5 16:53:55 admin kernel: 
> Jun  5 16:53:55 admin kernel: Code: 8b 44 81 18 0f af da 8b 51 0c 89 41 14 01 d3 40 0f 84 89 00

Cheers and thanks for the test !

Willy

