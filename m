Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbULJRz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbULJRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbULJRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:55:56 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:33992 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261770AbULJRzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:55:46 -0500
Date: Fri, 10 Dec 2004 18:55:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210175504.GY16322@dualathlon.random>
References: <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <20041210163614.GN2714@holomorphy.com> <20041210173554.GW16322@dualathlon.random> <20041210174336.GP2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210174336.GP2714@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 09:43:36AM -0800, William Lee Irwin III wrote:
> Well, the only way I see this happening is the process exiting followed
> by use_mm() on init_mm for unobvious reasons (perhaps reasons not in
> the tree).

I don't see the problem with use_mm. use_mm has either the mm set to
ctx->mm or to NULL, and ctx->mm is set to the mm of the process calling
io_setup.

The only thing using init_mm is the idle task/swapper as far as I can
tell, kernel threads and exiting tasks have a NULL mm.
