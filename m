Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264450AbUE0ODp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUE0ODp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 10:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUE0ODo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 10:03:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19622 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264450AbUE0ODi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 10:03:38 -0400
Date: Thu, 27 May 2004 16:03:22 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527140322.GA11966@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20040527135930.GC3889@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, May 27, 2004 at 03:59:30PM +0200, Andrea Arcangeli wrote:
> On Thu, May 27, 2004 at 02:45:51PM +0200, Ingo Molnar wrote:
> > are a bit belated. I only reacted to Andrea's mail to clear up apparent
> > misunderstandings about the impact and implementation of this feature.
> 
> note that there is something relevant to improve in the implementation,
> that is the per-cpu irq stack size should be bigger than 4k, we use 16k
> on x86-64, on x86 it should be 8k. Currently you're decreasing _both_
> the normal kernel context and even the irq stack in some condition.
> There's no good reason to decrease the irq stack too, that's cheap, it's
> per-cpu.

In theory you are absolutely right, problem is the current macro..... it's
SO much easier to have one stacksize everywhere (and cheaper too) for
this... (and it hasn't been a problem so far, esp since the softirq's have
their own stack, irq handlers seem to be all really light on the stack
already since they punt all the heavy lifting to tasklets etc.
Tasklets don't recurse stack wise, and have their own stack, so that ought
to be fine.

On x86_64 you have the PDA for current so that's not a problem, and you can
do the bigger stacks easily but for x86 you don't...
--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAtfUqxULwo51rQBIRAo30AKCgLx/hM+k2e9WB28XpmZZvHY9w5ACghrrj
kmebMnQ+BU4/D0IP70NS3ag=
=328j
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
