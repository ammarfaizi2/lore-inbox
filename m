Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270645AbTGUSmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270644AbTGUSmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:42:17 -0400
Received: from tudela.mad.ttd.net ([194.179.1.233]:17588 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP id S270637AbTGUSmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:42:05 -0400
Date: Mon, 21 Jul 2003 20:56:23 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Mike Kershaw <dragorn@melchior.nerv-un.net>
cc: Christoph Hellwig <hch@infradead.org>, Daniel Ritz <daniel.ritz@gmx.ch>,
       Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>
Subject: Re: [PATCH 2.5] fixes for airo.c
In-Reply-To: <20030721150821.GA18134@melchior.nerv-un.net>
Message-ID: <Pine.SOL.4.30.0307212055240.29431-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Understood. I'm checking that change in my code and I'll update it in the
CVS (before commiting to the kernel tree).B

On Mon, 21 Jul 2003, Mike Kershaw wrote:

> Grargh.  At work all weekend.  Didn't have time to make a real patch.
>
> Anyhow - Proposed changes to airo.c for rfmonitor mode.  I've been working
> on making it quiet (not continually probing) and on making it enter "true"
> rfmon mode (right now it doesn't, which is why user-controlled channel
> hopping doesn't work).  Both of these are "special case" stuff that doesn't
> affect normal users, but are near and dear to my own pursuits. :P
>
> I've succeeded in the first, but not the second, so I hadn't released any
> changed driver code.  The first is actually a very simple change - in the
> code block that puts the driver into rfmon mode (around line 2480 on my
> code) after setting:
> config.rmode = RXMODE_RFMON | RXMODE_DISABLE_802_3_HEADER;
> or
> config.rmode = RXMODE_RFMON_ANYBSS | RXMODE_DISABLE_802_3_HEADER;
>
> it should set:
> config.scanMode = SCANMODE_PASSIVE;
>
> and in the code block exiting rfmon mode, after:
> config.opmode = 0;
> it should set:
> config.scanMode = SCANMODE_ACTIVE;
>
> With my testing this stops the probing in rfmon (good) and doesn't have any
> negative impacts.  More testing is, of course, a good idea.
>
> I can try to come up with an exact diff but I figured I should get something
> out while everyone is discussing changes, and I don't know how much time I'm
> going to have in the coming weeks.
>
> -m
>
> --
> I like my coffee like I like my friends -- Dark, and bitter.
>

