Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUBVLPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 06:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUBVLP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 06:15:26 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:51630 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261225AbUBVLPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 06:15:20 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Sun, 22 Feb 2004 12:08:14 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Kochanowicz <michal@michal.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: Fw: v4l fails after on 2.6.3 (works on 2.6.2)
Message-ID: <20040222110814.GB15351@bytesex.org>
References: <20040221214258.12f56a29.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221214258.12f56a29.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After upgrade of kernel 2.6.2 -> 2.6.3 (built from exactly the same
> config) I'm no longer able to use my TV tuner card. When I launch tvtime
> following appears in system log:
> kernel: tuner: Huh? tv_set is NULL?

Yea, thats exactly the corner case which the last-minute tuner.c fix for
2.6.3 gets very wrong because the initialization code doesn't run :-/

Fix is already in the queue, I think both -mm and Linus' latest -bk have
that.

> tvtime reports that "there is no signal" and when I try to change the
> channel, following appears in the log:
> kernel: bttv0: skipped frame. no signal? high irq latency? [main=1bd24000,o_vbi=1bd24018,o_field=e74c000,rc=ee9c3e0]

Thats just because tuning doesn't work at all and thus there is no
signal.

> options tuner type=5
> options bttv card=16

Use "options bttv card=16 tuner=5" instead, that should work.  I'll
probably drop the "tuner type=" insmod anyway in near future, just have
to check with other users of the tuner.o module that it wouldn't break
anything.

  Gerd

