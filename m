Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVIERXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVIERXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 13:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVIERXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 13:23:55 -0400
Received: from lucidpixels.com ([66.45.37.187]:48277 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932351AbVIERXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 13:23:55 -0400
Date: Mon, 5 Sep 2005 13:23:54 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, linux-ide@vger.kernel.org,
       apiszcz@lucidpixels.com
Subject: Re: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
In-Reply-To: <1125923397.8714.22.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.63.0509051322400.3389@p34>
References: <Pine.LNX.4.63.0508311328230.1945@p34>  <Pine.LNX.4.63.0508311408320.1945@p34>
  <58cb370e050905002630a0e02e@mail.gmail.com> <1125923397.8714.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also,

Part of the problem may be that I have two ATA/133 Promise cards in one 
box and only one ATA/133 in the other box.

Kernel 2.6.13 has fixed the problem with one ATA/133 card in the box.
Kernel 2.6.13 has not fixed the problem with two ATA/133 cards in the box.

FYI

Justin.


On Mon, 5 Sep 2005, Alan Cox wrote:

> On Llu, 2005-09-05 at 09:26 +0200, Bartlomiej Zolnierkiewicz wrote:
>> After DMA timeout driver reverted back to PIO,
>> ide-taskfile.c also holds PIO code besides IDE Taskfile Access.
>
>
> On SMP after a DMA timeout it will potentially freeze. There are some
> paths in that code which lead to double lock takes and hangs, plus some
> timer races.
>
> Justin can you make a backup (I mean that seriously), then build a
> kernel with spin lock debug enabled and see if you can reproduce the
> problem and get a trace.
>
> If its the locking you'll get a trace and the kernel will continue. At
> that point because the spinlock debug continues unsafely through a
> double lock after the trace you are in the "danger zone" hence the
> backup warning
>
> [Yes the spin lock debug code really should warn you its dangerous for
> non debug uses or get patched as it is in Fedora to trace and stop]
>
> If its a hardware or other problem it will still hang
>
> if its an unrelated lock problem it should still get a trace.
>
>
> Why you see this only on 2.6.13 not 2.6.13-rc7 I don't know. It makes me
> wonder if you have a bad drive - but then you imply going back to rc7
> goes back to stable. Can you therefore also check the .config options
> between the two kernels match.
>
> Alan
>
