Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTJWBgp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 21:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTJWBgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 21:36:45 -0400
Received: from dark.beer.net ([204.145.225.20]:1040 "EHLO dark.beer.net")
	by vger.kernel.org with ESMTP id S261567AbTJWBgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 21:36:44 -0400
Date: Wed, 22 Oct 2003 20:36:35 -0500 (CDT)
Message-Id: <200310230136.h9N1aZfn002145@dark.beer.net>
From: "Michael Glasgow" <glasgowNOSPAM@beer.net>
To: "Andy Lutomirski" <luto@stanford.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: posix capabilities inheritance
In-reply-to: <fa.f9mv0tb.27sf3j@ifi.uio.no>
References: <fa.f9mv0tb.27sf3j@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski wrote:
> Maybe I misread the spec, but I thought it explicitly stated
> pP' = (fP & X) | (fI & pI)
> (I can't find it right now, though...)

I don't see *any* rules for capabilities evolution explicitly
defined.  There are some limitations and some mandatory characteristics
that any rules of evolution must possess, and these seem to make
sense to me as far as they go.  But there's no explicit "pP' = blah";
perhaps there needs to be.

> I would hope that, on a system that supports file capabilities, a
> file w/o capabilities set and w/o setuid would behave exactly like
> a file with some "default" capabilities.  In my patch, these
> capabilities are (=ei).  In mainline Linux, there is no such
> capability set (witness the logic in cap_binprm_set_security).

I agree for the most part, but why would you choose (=ei) rather
than just (=i)?  Also, what in your opinion should be the meaning
of (fE != 0 && fP=0) versus (fE != 0 && fP = fE)?

> With the (POSIX) rule pE' = pP' & fE, the dumpcap process would
> have been uid=0, euid=500, and all caps effective, which is
> inconsistant with traditional semantics.  Linux currently works
> correctly because fE and fP are dependent on initial uid and euid.

I do not think that rule is specified by the POSIX 1003.1e draft
either, although it is compliant.  Necessary distinction because
I believe we can change the rules in various ways and still be
compliant, if that is important.

Also, it is clear that the inconsistency you point out is due to
your assumption that a file with no capabilities is (=ei) by default.
If it were (=i), then this problem goes away, right?

--
Michael Glasgow < glasgow at beer dot net >
