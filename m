Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262936AbVCWWCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262936AbVCWWCe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVCWWCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:02:33 -0500
Received: from ozlabs.org ([203.10.76.45]:34501 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262936AbVCWWCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:02:20 -0500
Date: Thu, 24 Mar 2005 09:00:37 +1100
From: Anton Blanchard <anton@samba.org>
To: Mark Wong <markw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 journalling BUG on full filesystem
Message-ID: <20050323220037.GR17561@krispykreme>
References: <20050323202130.GA30844@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323202130.GA30844@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> I originally reported this to the linuxppc64-dev list, since I made it
> happen on a POWER system.  I'm told this might be more generic...
> 
> Anyone run into something like this?

Just in case it got lost in the rest of the xmon output... We hit a BUG():

kernel BUG in submit_bh at fs/buffer.c:2706!

Which looks like:

        BUG_ON(!buffer_mapped(bh));

Backtrace:

	ll_rw_block+0x160/0x164
	journal_commit_transaction+0xd88/0x16d4
	kjournald+0x114/0x308
	kernel_thread+0x4c/0x6c

Anton
