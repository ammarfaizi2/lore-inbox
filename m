Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbTFYViy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTFYViy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:38:54 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:64525 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264776AbTFYVix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:38:53 -0400
Subject: Re: patch O1int for 2.5.73 - interactivity work
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
In-Reply-To: <200306260209.45020.kernel@kolivas.org>
References: <200306260209.45020.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056577981.603.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 25 Jun 2003 23:53:01 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-25 at 18:09, Con Kolivas wrote:
> Hi all 
> 
> I've used the corner cases described that cause a lot of the interactivity 
> problems to develop this patch. What it does different to default (without 
> nasty hacks) is the following:
> 
> The interactivity is based on the max sleep avg (10s) as previously, unless 
> the thread has been running for less than 10s. In that case it is based on 
> the duration it has been running, with a minimum of 10 jiffies to estimate 
> the interactivity (perhaps more might be appropriate here). This should 
> minimise tasks taking ages to be categorised as interactive.
> 
> If tasks sleep for a long time (>1s) they are no longer classified as 
> interactive, but idle - meaning they receive their static priority. However, 
> since they _may_ become interactive, the period over which the interactivity 
> is estimated is decreased (1sec, perhaps can be reduced) so they may become 
> interactive rapidly again. This should minimise idle tasks (like BASH) that 
> suddenly become cpu hungry from stalling everything.
> 
> I'm still working on something for the "xmms stalls if started during very 
> heavy load" as a different corner case.
> 
> This is only a compile tested patch (need sleep bad) but has been tested in 
> 2.4 form and works nicely at avoiding those corner test cases.
> 
> Please comment and test if you can.

This patch is indeed much better than the ones posted before. In fact,
it's really, really hard for me to make XMMS skip audio. It feels much
better in general, but there are still some rough edges when the system
is under load. For example, the mouse cursor on an X session doesn't
move smoothly, and feels a little jumpy. It can be somewhat fixed by
renicing the X server to -20.

Anyways, this is the best I've seen until date, and I'm currently
running on it. We'll see if it's up to expectations... at least, I think
so :-)

> 
> Con

