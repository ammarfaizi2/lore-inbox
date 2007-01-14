Return-Path: <linux-kernel-owner+w=401wt.eu-S1751295AbXANOeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbXANOeK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 09:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbXANOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 09:34:10 -0500
Received: from www.osadl.org ([213.239.205.134]:49728 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751295AbXANOeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 09:34:08 -0500
Subject: Re: 2.6.20-rc4-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       axboe@kernel.dk
In-Reply-To: <1168771617.2941.59.camel@localhost.localdomain>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <1168768104.2941.53.camel@localhost.localdomain>
	 <1168771617.2941.59.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 15:40:16 +0100
Message-Id: <1168785616.2941.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-14 at 11:46 +0100, Thomas Gleixner wrote:
> > Boot proceeds, but gets stuck hard at:
> > "Remounting root filesystem in read-write mode:"
> > 
> > No SysRq-T, nothing.
> > 
> > The above BUG seems unrelated to that. Investigating further.
> 
> Bisect identified: git-block.patch

Does only happen on 2 systems. Both have sata + raid1 setup. I managed 
to get a stacktrace from the SMP box. Sits there and sleeps forever.

	tglx

[<c032ac64>] io_schedule+0x7a/0x9a
[<c0157f89>] sleep_on_page+0x8/0xc
[<c032ae45>] __wait_on_bit+0x36/0x5d
[<c01580d8>] wait_on_page_bit+0x5b/0x61
[<c0158a2b>] wait_on_page_writeback_range+0x4f/0xef
[<c0158b0f>] filemap_fdatawait+0x44/0x49
[<c0158da0>] filemap_write_and_wait+0x22/0x2d
[<c0190e39>] sync_blockdev+0x17/0x1d
[<c01a27af>] quota_sync_sb+0x33/0xd6
[<c01a2874>] sync_dquots+0x22/0xfa
[<c01757cf>] __fsync_super+0x17/0x66
[<c0175829>] fsync_super+0xb/0x19
[<c0175880>] do_remount_sb+0x49/0x101
[<c0187f98>] do_mount+0x1ad/0x678
[<c01884d2>] sys_mount+0x6f/0xa4
[<c0103f6a>] sysenter_past_esp+0x5f/0x99


