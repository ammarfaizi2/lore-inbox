Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVCWUYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVCWUYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 15:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262891AbVCWUXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 15:23:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:13730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262906AbVCWUVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 15:21:31 -0500
Date: Wed, 23 Mar 2005 12:21:30 -0800
From: Mark Wong <markw@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: ext3 journalling BUG on full filesystem
Message-ID: <20050323202130.GA30844@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I originally reported this to the linuxppc64-dev list, since I made it
happen on a POWER system.  I'm told this might be more generic...

Anyone run into something like this?

Mark

----- Forwarded message from Mark Wong <markw@osdl.org> -----

Date: Wed, 23 Mar 2005 08:05:30 -0800
To: linuxppc64-dev@ozlabs.org
From: Mark Wong <markw@osdl.org>
Subject: ext3 journalling BUG on full filesystem

Hi,

I'm running 2.6.11 and I'm suspecting that a full ext3 filesystem is
causing the following problem when performing some journaling
operation.  Let me know if I can provide more details:

cpu 0x6: Vector: 700 (Program Check) at [c0000002e4f3f6d0]
    pc: c0000000000a5fbc: .submit_bh+0x64/0x1fc
    lr: c0000000000a62b4: .ll_rw_block+0x160/0x164
    sp: c0000002e4f3f950
   msr: 8000000000029032
  current = 0xc00000038ff5c7c0
  paca    = 0xc000000000612000
    pid   = 1376, comm = kjournald
kernel BUG in submit_bh at fs/buffer.c:2706!
enter ? for help
6:mon> t
[c0000002e4f3f9f0] c0000000000a62b4 .ll_rw_block+0x160/0x164
[c0000002e4f3fab0] c000000000151ac4 .journal_commit_transaction+0xd88/0x16d4
[c0000002e4f3fe30] c000000000155590 .kjournald+0x114/0x308
[c0000002e4f3ff90] c000000000013ec0 .kernel_thread+0x4c/0x6c
