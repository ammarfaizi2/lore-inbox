Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131640AbQKRWkt>; Sat, 18 Nov 2000 17:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbQKRWkj>; Sat, 18 Nov 2000 17:40:39 -0500
Received: from mail2.rdc3.on.home.com ([24.2.9.41]:17618 "EHLO
	mail2.rdc3.on.home.com") by vger.kernel.org with ESMTP
	id <S131702AbQKRWkb>; Sat, 18 Nov 2000 17:40:31 -0500
Message-ID: <3A16FE50.2B6BA09B@home.com>
Date: Sat, 18 Nov 2000 17:10:24 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (new for ppa and imm) Re: [PATCH] Re: Patch to fix lockup on 
 ppa insert
In-Reply-To: <3A13D4BA.AD4A580B@home.com> <3A13D8D6.8C12E31A@home.com> <20001116162027.C597@suse.de> <3A149D00.9D38FA24@home.com> <20001117102411.S6735@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Thu, Nov 16, 2000 at 09:50:40PM -0500, John Cavan wrote:
> 
> > [...] This patch unlocks, allows the lowlevel driver to do it's
> > probes, and then relocks. It could probably be more granular in the
> > parport_pc code, but my own home tests show it to be working fine.
> 
> Is that safe?

I'm not sure. I know why it causes the NMI lockup, but I'm not enough of
an expert to sort it out. I've got a pretty good feel for the Zip
driver, but not the parport or scsi code yet, so I don't know how safe
it is. The new scsi error stuff does mention that drivers must
spinunlock/spinlock if it enables interrupts.

> Also, what bit of the parport code is tripping over the lock?
> Request_module or something?

During the init phase of the parport_pc module it probes and enables the
IRQ(s) of the parallel port, but the scsi layer has them locked.

> A nicer fix would probably be to use parport_register_driver, but
> that's likely to be too big a change right now.

I agree and it's recommended in the parport code. Now if I can get
enough time, I will take a stab at it, but nobody should be relying on
me for it. :o)

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
