Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbULJSBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbULJSBx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbULJSBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:01:12 -0500
Received: from holomorphy.com ([207.189.100.168]:46738 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261782AbULJSAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:00:40 -0500
Date: Fri, 10 Dec 2004 10:00:31 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210180031.GT2714@holomorphy.com>
References: <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <20041210163614.GN2714@holomorphy.com> <20041210173554.GW16322@dualathlon.random> <20041210174336.GP2714@holomorphy.com> <20041210175504.GY16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210175504.GY16322@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 09:43:36AM -0800, William Lee Irwin III wrote:
>> Well, the only way I see this happening is the process exiting followed
>> by use_mm() on init_mm for unobvious reasons (perhaps reasons not in
>> the tree).

On Fri, Dec 10, 2004 at 06:55:04PM +0100, Andrea Arcangeli wrote:
> I don't see the problem with use_mm. use_mm has either the mm set to
> ctx->mm or to NULL, and ctx->mm is set to the mm of the process calling
> io_setup.
> The only thing using init_mm is the idle task/swapper as far as I can
> tell, kernel threads and exiting tasks have a NULL mm.

Yet those don't appear in the tasklist, so some task in the tasklist
has to get ->mm set to &init_mm. The notion above was that the init_mm
check was to handle some out-of-tree attempt to do aio from kernel threads.


-- wli
