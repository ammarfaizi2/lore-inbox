Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbULJSQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbULJSQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbULJSQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:16:15 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:25219 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261785AbULJSQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:16:12 -0500
Date: Fri, 10 Dec 2004 19:15:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210181529.GZ16322@dualathlon.random>
References: <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <20041210163614.GN2714@holomorphy.com> <20041210173554.GW16322@dualathlon.random> <20041210174336.GP2714@holomorphy.com> <20041210175504.GY16322@dualathlon.random> <20041210180031.GT2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210180031.GT2714@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 10:00:31AM -0800, William Lee Irwin III wrote:
> Yet those don't appear in the tasklist, so some task in the tasklist
> has to get ->mm set to &init_mm. The notion above was that the init_mm
> check was to handle some out-of-tree attempt to do aio from kernel threads.

Not sure to understand correctly but, aio has always been done through
kernel threads, and that's the whole thing about aio. Not sure what
you're doing out-of-tree, but you don't need to use init_mm to deal with
kernel threads, infact kernel threads can only have ->mm = NULL. When
switching mm with use_mm the aio thread is only going to use a real mm
with mappings in userspace, so even in that case you don't need init_mm.
I didn't see the out of tree code though.
