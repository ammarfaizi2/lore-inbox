Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264147AbUFPQWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUFPQWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUFPQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:22:34 -0400
Received: from zero.aec.at ([193.170.194.10]:49413 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264147AbUFPQWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:22:33 -0400
To: Dimitri Sivanich <sivanich@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Option to run cache reap in thread mode
References: <27JKg-4ht-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Wed, 16 Jun 2004 18:22:28 +0200
In-Reply-To: <27JKg-4ht-11@gated-at.bofh.it> (Dimitri Sivanich's message of
 "Wed, 16 Jun 2004 16:40:16 +0200")
Message-ID: <m3r7sfmq0r.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> writes:

> I would like to know what others think about running cache_reap() as a low
> priority realtime kthread, at least on certain cpus that would be configured
> that way (probably configured at boottime initially).  I've been doing some
> testing running it this way on CPU's whose activity is mostly restricted to
> realtime work (requiring rapid response times).
>
> Here's my first cut at an initial patch for this (there will be other changes
> later to set the configuration and to optimize locking in cache_reap()).

I would run it in the standard work queue threads. We already have 
too many kernel threads, no need to add more.

Also is there really a need for it to be real time? 
Note that we don't make any attempt at all in the linux kernel to handle
lock priority inversion, so this isn't an argument.

-Andi

