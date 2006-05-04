Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWEDCg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWEDCg7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 22:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWEDCg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 22:36:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750889AbWEDCg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 22:36:59 -0400
Date: Wed, 3 May 2006 19:36:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] 2.6.17-rc3-mm1 breaks AGP on amd64 boxes in 32 bit mode
Message-Id: <20060503193650.1a8edf16.akpm@osdl.org>
In-Reply-To: <200605040033.33579.bero@arklinux.org>
References: <200605040033.33579.bero@arklinux.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006 00:33:33 +0200
Bernhard Rosenkraenzer <bero@arklinux.org> wrote:

> 2.6.17-rc3-mm1 breaks AGP on amd64 boxes in 32 bit mode - a change in the 
> related Kconfig file forces the agp-amd64 module to be built only on x86_64, 
> simply reverting that bit introduces unresolved symbols k8_nb_ids and 
> k8_northbridges (defined but not exported).

Yeah, it turns out that x86 is doing

+k8-y                      += ../../x86_64/kernel/k8.o

which I failed to spot.  This, along with the "amd64" in the name fooled me
into believing that x86 wasn't supposed to be using this code.

x86_64 uses numerous x86 files in this manner, and now we we have x86 using
a couple of x86_64 files in a siilar manner.  I think this is a bad thing,
and that we should make all these cross-references operate in the same
direction rather than in both directions.  x86_64 developers already have
to deal with this problem, so why make start burdening x86 developers also?


Anyway.  Andi, I'll drop x86_64-mm-new-northbridge-fix.patch.  Please add
these exports to your copy of x86_64-mm-new-northbridge.patch
