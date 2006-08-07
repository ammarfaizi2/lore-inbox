Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWHGB0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWHGB0k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 21:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWHGB0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 21:26:40 -0400
Received: from colin.muc.de ([193.149.48.1]:64777 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750875AbWHGB0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 21:26:40 -0400
Date: 7 Aug 2006 03:26:38 +0200
Date: Mon, 7 Aug 2006 03:26:38 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, davej@redhat.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: 2.6.18-rc3-g3b445eea BUG: warning at /usr/src/linux-git/kernel/cpu.c:51/unlock_cpu_hotplug()
Message-ID: <20060807012638.GA42404@muc.de>
References: <6bffcb0e0608041204u4dad7cd6rab0abc3eca6747c0@mail.gmail.com> <Pine.LNX.4.64.0608041222400.5167@g5.osdl.org> <20060804222400.GC18792@redhat.com> <20060805003142.GH18792@redhat.com> <20060805021051.GA13393@redhat.com> <20060805022356.GC13393@redhat.com> <20060805024947.GE13393@redhat.com> <20060805064727.GF13393@redhat.com> <6bffcb0e0608060959m164436baj9c4c602496e87f5d@mail.gmail.com> <20060806123243.826105fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806123243.826105fc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  [<c0171577>] vfs_write+0xcd/0x179
> >  [<c0171c20>] sys_write+0x3b/0x71
> >  [<c010318d>] sysenter_past_esp+0x56/0x8d
> This "unwinder stuck" thing seems to be very common.

Yes, there are still a lot of bugs in the unwind annotation
unfortunately.

We're also slowly discovering that some things we do cannot
even be expressed in CFI, so some code has to change.

> 
> It's a false-positive in this case - the backtrace was complete.  It would
> be good if we could make the did-we-get-stuck detector a bit smarter.  Even
> special-casing "sysenter_past_esp" would stop a lot of this..

Actually it's not completely false in this case -- it should
have reached user mode and stopped there, but for some reason
I didn't and already stopped still in the kernel.

Most likely the CFI annotation for that sysenter path is not complete.

It's on my todo list to investigate but I still hope Jan does it first ;-)

-Andi


