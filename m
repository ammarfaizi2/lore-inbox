Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTISMur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 08:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbTISMur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 08:50:47 -0400
Received: from chaos.analogic.com ([204.178.40.224]:54145 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261539AbTISMup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 08:50:45 -0400
Date: Fri, 19 Sep 2003 08:52:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG at mm/memory.c:1501 in 2.6.0-test5
In-Reply-To: <95932E0ADB@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.53.0309190838440.14130@chaos>
References: <95932E0ADB@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Sep 2003, Petr Vandrovec wrote:

> On 18 Sep 03 at 13:43, William Lee Irwin III wrote:
> > On Thu, Sep 18, 2003 at 10:27:58PM +0200, Petr Vandrovec wrote:
> > > EIP:    0060:[<c015be10>]    Tainted: PF
> >
> >                 snprintf(buf, sizeof(buf), "Tainted: %c%c%c",
> >                         tainted & TAINT_PROPRIETARY_MODULE ? 'P' : 'G',
> >                         tainted & TAINT_FORCED_MODULE ? 'F' : ' ',
> >                         tainted & TAINT_UNSAFE_SMP ? 'S' : ' ');
> >
> > This is probably the reason you're not getting much in the way of a
> > response.
>
> I explicitly stated that it happened shortly after I shut down VMware UI,
> and that I spent whole day trying to find what's going on, finally
> politely asking for help, hoping that someone could have a clue
> what went wrong.
>                                             Petr Vandrovec
>

Okay. I'll be more specific. The "Tainted PF" shown above is
because you have installed a module that is [P]roprietary and
it was [F]orced to load.

Any module running inside the kernel can destroy anything.
There is no protection inside the kernel. A simple bug in any
module can not only cause your machine to die, but it can, in
principle, destroy everything on your hard disk as well as
shutting down your LAN, causing millions of dollars of
damages (seriously). It is possible.

Therefore, If you report a bug, and your system is tainted
with a proprietary module, nobody can help you because the
source-code of the module isn't available for review. Therefore
nobody will waste time reviewing kernel code when a single
out-of-bounds pointer, or a single failure to free a resource
or a lock on some seldom-used path in that proprietary module
could kill the kernel.

That said, the proprietary module may be faultless. However,
nobody is going to be able to find the problem without being
able to review the source-code of that module. So, don't install
that module, wait for the crash again, then file another
report. If the machine doesn't crash again, then you've probably
found the problem, that "secret" module code that the vendor
doesn't want you to see because you might vomit or might reverse-
engineer, resulting in a better product.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


