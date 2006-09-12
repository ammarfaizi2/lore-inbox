Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWILF51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWILF51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWILF51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:57:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:12473 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751313AbWILF50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:57:26 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
	 <1157969261.23085.108.camel@localhost.localdomain>
	 <m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 15:56:45 +1000
Message-Id: <1158040605.15465.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Frame buffers are rarely cachable as such, on x86 they are usually
> write-combining.   Which means that the writes can be merged and
> possibly reordered while they are being written but they can't be
> cached.  Most arches I believe have something that roughly corresponds
> to write combining.
> 
> Ensuring we can still use this optimization to mmio space is
> moderately important.

I've not gone too much in details about write combining (we need to do
something about it but I don't want to mix problems) but I did define
that the ordered accessors aren't guaranteed to provide write combining
on storage mapped with WC enabled while the relaxed or non ordered ones
are. That should be enough at this point.

Later, we should look into providing an ioremap_wc() and possibly page
table flags for write combining userland mappings. Time to get rid of
MTRRs for graphics :) And infiniband-style stuff seems to want that too.

Ben.


