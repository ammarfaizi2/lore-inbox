Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUHJWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUHJWlx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267794AbUHJWlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:41:53 -0400
Received: from digitalimplant.org ([64.62.235.95]:15829 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267792AbUHJWlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:41:50 -0400
Date: Tue, 10 Aug 2004 15:41:45 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@suse.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Fix Device Power Management States
In-Reply-To: <20040810175637.GB28113@elf.ucw.cz>
Message-ID: <Pine.LNX.4.50.0408101539540.28789-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
 <1092098425.14102.69.camel@gaston> <Pine.LNX.4.50.0408092131260.24154-100000@monsoon.he.net>
 <20040810100751.GC9034@atrey.karlin.mff.cuni.cz>
 <Pine.LNX.4.50.0408100700460.13807-100000@monsoon.he.net>
 <20040810175637.GB28113@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Aug 2004, Pavel Machek wrote:

> I still do not see it... swsusp does not care about logical state of
> device. (Actually manipulating logical state of device might make
> swsusp less transparent). It cares about device not doing DMA (I also
> said "no interrupts", but that is not strictly neccessary: we disable
> interrupts for atomic copy. Device should do no NMIs, through).

Perhaps it is unncessary to do at a class level, at least at this point.
I think we all agree that we need some sort of stop/start methods for
devices, though. In which, we can add to struct bus_type:

	int (*dev_stop)(struct device *);
	int (*dev_start)(struct device *);

Sound good?


	Pat
