Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbVLXHqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbVLXHqT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 02:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161170AbVLXHqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 02:46:19 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:42961
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161016AbVLXHqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 02:46:19 -0500
Date: Fri, 23 Dec 2005 23:46:22 -0800 (PST)
Message-Id: <20051223.234622.14020212.davem@davemloft.net>
To: hugh@veritas.com
Cc: torvalds@osdl.org, michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0512240104440.17764@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
	<20051223.154509.86780332.davem@davemloft.net>
	<Pine.LNX.4.61.0512240104440.17764@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Sat, 24 Dec 2005 01:21:07 +0000 (GMT)

> That certainly gets my vote: it should work around the bug correctly
> and effectively without adding any complexity.

And it's even tested successfully :-)

There is an obscure program I wrote a long time ago, which
Michael Bishop spotted, which is in very limited use and doesn't
fall back to MAP_SHARED properly.  But that obscure tool can
be fixed.

> Though really the check ought to be in the sparc and sparc64
> io_remap_pfn_range, which are the guilty parties giving shared write
> access even when none has been asked for.  But I guess it's too risky
> to add failures or change behaviour down there at this stage.

That's a bit too far reaching right now.

> Those "prot = __pgprot(pg_iobits);" lines - any idea why they ever
> got inserted?  I guess to add _PAGE_E in the sparc64 case, and
> whatever the equivalent was in the earlier sparc cases?
> Can they safely be corrected early in 2.6.16?

Corrected?  By that you mean removed?  We have so many hacks
in the tree dealing with this kind of stuff.  For example,
pgprot_noncached() as used by things like snd_pccm_lib_mmap_iomem().
And the uses of that conditionalize with an ifdef, which is how
we get half-implemented interfaces like this which you can't
use consistently, oh and wo' be to the person who defines that
using an inline function and wonders why it never gets ued :-/
