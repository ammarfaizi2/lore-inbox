Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264368AbUE0N7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264368AbUE0N7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 09:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUE0N7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 09:59:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9958
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264368AbUE0N7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 09:59:33 -0400
Date: Thu, 27 May 2004 15:59:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527135930.GC3889@dualathlon.random>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040527124551.GA12194@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 02:45:51PM +0200, Ingo Molnar wrote:
> are a bit belated. I only reacted to Andrea's mail to clear up apparent
> misunderstandings about the impact and implementation of this feature.

note that there is something relevant to improve in the implementation,
that is the per-cpu irq stack size should be bigger than 4k, we use 16k
on x86-64, on x86 it should be 8k. Currently you're decreasing _both_
the normal kernel context and even the irq stack in some condition.
There's no good reason to decrease the irq stack too, that's cheap, it's
per-cpu.
