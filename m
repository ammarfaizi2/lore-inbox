Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUCAVPk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 16:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbUCAVPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 16:15:40 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51385 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261439AbUCAVPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 16:15:37 -0500
Subject: Re: [start_kernel] Suggest to move parse_args() before trap_init()
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, yi.zhu@intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p73vfloz45t.fsf@verdi.suse.de>
References: <Pine.LNX.4.44.0403011721220.2367-100000@mazda.sh.intel.com>
	 <20040301025637.338f41cf.akpm@osdl.org>  <p73vfloz45t.fsf@verdi.suse.de>
Content-Type: text/plain
Message-Id: <1078175723.27444.214.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 01 Mar 2004 13:15:23 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-01 at 12:46, Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > I think the only problem with this is if we get a fault during
> > parse_args(), the kernel flies off into outer space.  So you lose some
> > debuggability when using an early console.
> > 
> > But 2.4 does trap_init() after parse_args() and nobody has complained, as
> > did 2.6 until recently.  So the change is probably OK.
>...
> Another way that i've considered on x86-64 for 2.7 at least is a special
> __early_setup() for this

It might be nice to have the same thing as the initcalls:
#define core_initcall(fn)               __define_initcall("1",fn)
...
#define late_initcall(fn)               __define_initcall("7",fn)

If we had something like this, we could also use it for stuff like
early_printk(), in addition to things like mem= in setup_arch().  You
can actually do serial early printk in about 3 lines of code if you can
parse arguments really, really early.  

-- dave

