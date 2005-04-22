Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVDVWCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDVWCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVDVWCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 18:02:25 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:34718 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261179AbVDVWCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 18:02:20 -0400
Date: Sat, 23 Apr 2005 00:01:23 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Fab Tillier <ftillier@infiniconsys.com>
Cc: "'Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>'" 
	<7eggert@gmx.de>,
       Andy Isaacson <adi@hexapodia.org>, Timur Tabi <timur.tabi@ammasso.com>,
       Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: RE: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace
 verbsimplementation
In-Reply-To: <000101c5475c$fe3c5fa0$8d5aa8c0@infiniconsys.com>
Message-ID: <Pine.LNX.4.58.0504222331190.5827@be1.lrz>
References: <000101c5475c$fe3c5fa0$8d5aa8c0@infiniconsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2005, Fab Tillier wrote:
> > From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
> > Sent: Friday, April 22, 2005 6:10 AM

> > You can't even set a time limit, the driver may have allocated all DMA
> > memory to queued transfers, and some media needs to get plugged in by
> > the lazy robot. As soon as the robot arrives - boom. (For the same reason,
> > this memory MUST NOT be freed if the application terminates abnormally,
> > e.g. killed by OOM).
> 
> InfiniBand provides support for deregistering memory that might be
> referenced at some future time by an RDMA operation.  The only side effect
> this has is that the QP on both sides of the connection transition to an
> error state.
> 
> Upon abnormal termination, all registrations must be undone and the memory
> unpinned.  This must be synchronized with the hardware so that there are no
> races.

If you know the hardware. If you have userspace drivers, this will be
impossible, and even if you have kernel drivers, you'll need to know 
which of them is responsible for each part of the pinned memory.

This doesn't imply the affected memory to be lost. The same application
that created the pinned memory can reset the hardware (provided nobody
changed the configuration), then reconnect to the shared memory segment
you'll use for that purpose and use or free it.

-- 
To iterate is human; to recurse, divine. 
