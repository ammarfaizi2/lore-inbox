Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJLQ0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJLQ0t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUJLQ0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:26:49 -0400
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:34280
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S266096AbUJLQ0s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:26:48 -0400
Date: Tue, 12 Oct 2004 12:26:30 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Paul Mundt <paul.mundt@nokia.com>
cc: Andrew Morton <akpm@osdl.org>, takata@linux-m32r.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: fix smc91x build for sh/ppc
In-Reply-To: <20041012161631.GA8766@hed040-158.research.nokia.com>
Message-ID: <Pine.LNX.4.61.0410121223310.17226@xanadu.home>
References: <20041012161631.GA8766@hed040-158.research.nokia.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Paul Mundt wrote:

> The current smc91x code uses set_irq_type(). It looks like the m32r guys
> worked around this by adding a !defined(__m32r__) check, but this is equally
> bogus as set_irq_type() is an arm/arm26-specific function.
> 
> Trying to get this to build on sh died in the same spot, so we just back out
> the m32r change and make it depend on CONFIG_ARM instead. Notably, the ppc
> build would have been broken by this as well, but it doesn't seem like anyone
> noticed this there yet.

I previously suggested that architectures without set_irq_type() define 
it as an empty macro, but if only ARM has that function it's probably 
saner to just enable it for ARM as you did.


Nicolas
