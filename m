Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271203AbTGWSGB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271200AbTGWSF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:05:29 -0400
Received: from tudela.mad.ttd.net ([194.179.1.233]:5771 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP id S271194AbTGWSFS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:05:18 -0400
Date: Wed, 23 Jul 2003 20:20:20 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>
Subject: Re: [PATCH 2.5] fixes for airo.c
In-Reply-To: <1058983403.5516.101.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0307232018120.15976-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 Jul 2003, Alan Cox wrote:

> On Mer, 2003-07-23 at 18:56, Daniel Ritz wrote:
> > > You cannot use down() in xmit, as it may be called in interrupt context. I
> > > know it slows things down, but that's the only way I figured out of
> > > handling a transmission while the card is processing a long command.
> >
> > hu? no. you can do a down() as xmit is never called from interrupt context. and
> > the dev->hard_start_xmit() calls are serialized with the dev->xmit_lock. the
> > serialization is broken by the schedule_work() thing.
>
> If you are about to start a long command why not mark the device busy
> for transmit before starting ?

I thought about that some time ago. The problem I have in some cases is
that there are commands that, based on the status of the radio, may be
very fast or very long, I didn't think that marking the devide busy "just
in case" before every command was very efficient.

Javier Achirica

