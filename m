Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVAUHIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVAUHIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVAUHIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:08:46 -0500
Received: from one.firstfloor.org ([213.235.205.2]:35532 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262299AbVAUHI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:08:28 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: OOM fixes 2/5
References: <20050121054840.GA12647@dualathlon.random>
	<20050121054916.GB12647@dualathlon.random>
	<20050120222056.61b8b1c3.akpm@osdl.org>
	<1106289375.5171.7.camel@npiggin-nld.site>
	<20050120224645.3351d22c.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Fri, 21 Jan 2005 08:08:21 +0100
In-Reply-To: <20050120224645.3351d22c.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 20 Jan 2005 22:46:45 -0800")
Message-ID: <m14qhb1cpm.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Just that it throws away a bunch of potentially usable memory.  In three
> years I've seen zero reports of any problems which would have been solved
> by increasing the protection ratio.

We ran into a big problem with this on x86-64. The SUSE installer
would load the floppy driver during installation. Floppy driver would
try to allocate some pages with GFP_DMA and on a small memory x86-64
system (256-512MB) the OOM killer would always start to kill things
trying to free some DMA pages. This was quite a show stopper
because you effectively couldn't install.

So at least for GFP_DMA it seems to be definitely needed.

-Andi
