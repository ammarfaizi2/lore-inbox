Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUBYTr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbUBYTrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:47:25 -0500
Received: from zadnik.org ([194.12.244.90]:28886 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261427AbUBYTrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:47:19 -0500
Date: Wed, 25 Feb 2004 21:46:59 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Christer Weinigel <christer@weinigel.se>
Cc: Nikita Danilov <Nikita@Namesys.COM>, <root@chaos.analogic.com>,
       Rik van Riel <riel@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <m3ptc3otbn.fsf@zoo.weinigel.se>
Message-ID: <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 Feb 2004, Christer Weinigel wrote:

> Just because there's an academic paper written about something doesn't
> mean that its right.  For once Richard is partially right, unneccesary
> layering can really ruin a system.  Grigor said that in 25 years he
> has seen few cases of pretty code performing badly, but look at the
> failure of SysV streams, it's a really pretty layering model, but in
> practice it turns out to be too slow for most anything useful.
>
> It's not too uncommon with drivers that breaks just because the actual
> hardware won't fit into the model that is exposed via a layer.  For
> example, look at the error recovery of the old Linux SCSI code: it's
> hard to do proper error recovery, and it is much slower than it needs
> to because first the low level driver tries to do error recovery and
> later on the higher layers try to do error recovery too.  Multiply a
> couple of retries in the SCSI middle layer with another couple of
> retries after a timeout a few seconds at the SCSI controller layer and
> you have a model where it takes a minute to do figure out that
> something is wrong, for something that ought to take just a few
> seconds.
>
> Additionally, because of the strict layering it's not always possible
> to hand up a meaningful error status from the lower layers to the
> higher layers, it gets lost in the middle just because it didn't fit
> into the layers model of the world.  It can also mean that it's not
> possible to use the intelligent features of a smart SCSI controller
> that can do complex error recovery on its own since most layers end up
> exposing only the "least common denominator".

I may be wrong, but this description seems to me more like an example for
bad design and implementation rather than for a bad general idea.

> In the linux kernel I think that one of the most important things I've
> learned from it: middle layers are usually wrong.  Instead of hiding a
> device driver behind a middle layer, expose the low level device
> driver, but give it a library of common functions to build upon.  That
> way the driver is in control all the time and can use all the neat
> features of the hardware if it wants to, but for all the common tasks
> that have to be done, hand them over to the library.

By principle, the "least common denominator" type container layers are
bad, because of not being extendable; you are completely right here. A
class-like driver object model seems better to me. And the class-like
model is not the only one that is nicely extendable. You seem to be
knowledgeable on the topic - what driver object model would you suggest
for a driver layer model?


Grigor


