Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSFRSRR>; Tue, 18 Jun 2002 14:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317537AbSFRSRQ>; Tue, 18 Jun 2002 14:17:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25921 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317536AbSFRSRP>; Tue, 18 Jun 2002 14:17:15 -0400
Date: Tue, 18 Jun 2002 19:17:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: DevilKin <devilkin-lkml@blindguardian.org>, linux-kernel@vger.kernel.org
Subject: Re: VMM - freeing up swap space
In-Reply-To: <Pine.LNX.3.95.1020618125355.5056A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0206181903550.1374-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jun 2002, Richard B. Johnson wrote:
> On Tue, 18 Jun 2002, DevilKin wrote:
> > On Tuesday 18 June 2002 17:10, Richard B. Johnson wrote:
> > >
> > > Sure. Execute `swapoff -a`, followed by `swapon -a`. This is no joke.
> > 
> > Hmm. Now if you happen to get out of memory during the swapoff part, you'll 
> > get the OO killer on your tail? Or will the system just go freeze solid?
> 
> I think `swapoff -a` will just fail to remove the swap device/file(s) if
> it doesn't have the memory. I've done this with 16 Mb of RAM in the
> 'good-old-days', where VM was swap.

You're right that swapoff should just fail, but sadly we've not done
the work to make that so: the OOM-killer does indeed come in (and it's
not the swapoff task it attacks); and if that can't free enough, then
the system will freeze.

In what forum, by the way, may I suggest to distros that they "rm -rf"
in any tmpfs mounts before shutdown swapoff?  It avoids this OOM issue
at shutdown, plus it's a whole lot faster than doing the swapoff.

Hugh

