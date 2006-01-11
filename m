Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWAKVou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWAKVou (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbWAKVou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:44:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:58253 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750877AbWAKVot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:44:49 -0500
From: Neil Brown <neilb@suse.de>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 12 Jan 2006 08:44:42 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17349.31818.631247.842663@cse.unsw.edu.au>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.15-mm2
In-Reply-To: message from Jens Axboe on Wednesday January 11
References: <20060110044240.3d3aa456.akpm@osdl.org>
	<20060110131618.GA27123@elte.hu>
	<17348.34472.105452.831193@cse.unsw.edu.au>
	<43C4947C.1040703@reub.net>
	<20060110213001.265a6153.akpm@osdl.org>
	<20060110213056.58f5e806.akpm@osdl.org>
	<43C4E2BE.6050800@reub.net>
	<20060111030529.0bc03e0a.akpm@osdl.org>
	<20060111111313.GD3389@suse.de>
	<43C4EEA4.3050502@reub.net>
	<20060111115616.GE3389@suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 11, axboe@suse.de wrote:
> 
> Then the barrier changes from git2 -> git3 should not have anything to
> do with it. Strange... I guess you should try the git bisect method to
> narrow it down.

Not true, though you seem to have already figured that out.

md uses barrier writes when writing the superblock.  This is partly
because it seems like a good idea, but largely to test if barrier
writes are going to work on the component devices.  If any device
claims not to support barriers, then raid1 will claim not to support
barriers.

And the strange hang happens while md is trying to update the
superblock.

NeilBrown
