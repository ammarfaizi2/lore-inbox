Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSGXNKb>; Wed, 24 Jul 2002 09:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSGXNKb>; Wed, 24 Jul 2002 09:10:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43476 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317035AbSGXNKa>; Wed, 24 Jul 2002 09:10:30 -0400
Date: Wed, 24 Jul 2002 15:13:22 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] irqlock patch 2.5.27-H4
In-Reply-To: <Pine.LNX.4.44.0207241344160.14551-100000@localhost.localdomain>
Message-ID: <Pine.SOL.4.30.0207241505430.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Ingo Molnar wrote:

> the latest irqlock patch can be found at:
>
>    http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-H4
>
> Changes in -H4:
>
>  - fix the cli()/sti() hack in ide/main.c, per Marcin Dalecki's
>    suggestion. [this leaves the tty layer as the only remaining subsystem
>    that still has cli()/sti() related hacks.]

Hi Ingo,

Marcin's suggestions will bring you nowhere.

You should remove all these locking from ide_unregister_subdriver()
because in 100% cases it is already called with ide_lock held.

Also in ide subsystem ide-tape.c needs fixing, however it is already
broken and proper locking fixing may be non-trivial task.

Regards
--
Bartlomiej

