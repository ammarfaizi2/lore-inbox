Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUHCWME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUHCWME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266903AbUHCWMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:12:03 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:20621 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266896AbUHCWLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:11:43 -0400
Date: Wed, 4 Aug 2004 00:11:21 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040803221121.GN2241@dualathlon.random>
References: <20040729185215.Q1973@build.pdx.osdl.net> <Pine.LNX.4.44.0408031654290.5948-100000@dhcp83-102.boston.redhat.com> <20040803210737.GI2241@dualathlon.random> <20040803211339.GB26620@devserv.devel.redhat.com> <20040803213634.GK2241@dualathlon.random> <20040803213856.GB10978@devserv.devel.redhat.com> <20040803215150.GM2241@dualathlon.random> <20040803150118.Q1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803150118.Q1924@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 03:01:18PM -0700, Chris Wright wrote:
> * Andrea Arcangeli (andrea@suse.de) wrote:
> > On Tue, Aug 03, 2004 at 11:38:57PM +0200, Arjan van de Ven wrote:
> > > not if you keep track of who locked in the first place and give the credit
> > > back to *that* user (struct).
> > 
> > I wasn't talking about chown above. I mean, where's the truncate that
> > releases the user-struct-bind? 
> 
> I'm not sure what you mean.  Truncate should only update the accounting,
> not break the binding, right?

yep, update the accounting. And with that I meant "releasing" part of
it (accordingly to the size of the truncate, a truncate(0) should
release it all).

> It's meant to be done at object destruction.

where?

Maybe it's just that those are incremental patches and I'm missing the
other part of the patch, but reading those patches I can't see where the
user_subtract_mlock happens when I truncate an hugetlbfs file (or delete
it or whatever). Sure it can't be munlock releasing/_updating_ the user-struct
accounting for fs persistent storage. But if other code takes care of it
then maybe you want to delete the user_subtract_mlock function and use
the other piece that already existed for truncate.

Anyways my overall picture of this is that you're trying to do
filesystem quotas with rlimit which sounds quite flawed.
