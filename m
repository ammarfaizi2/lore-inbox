Return-Path: <linux-kernel-owner+w=401wt.eu-S964841AbXADNIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbXADNIT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbXADNIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:08:19 -0500
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:22854 "EHLO
	extu-mxob-1.symantec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964841AbXADNIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:08:18 -0500
X-AuditID: d80ac21c-9f1c8bb000005c6b-19-459cfc41ec11 
Date: Thu, 4 Jan 2007 13:08:35 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
In-Reply-To: <459CEA93.4000704@tls.msk.ru>
Message-ID: <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com>
References: <459CEA93.4000704@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Jan 2007 13:08:17.0648 (UTC) FILETIME=[66859700:01C73001]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Michael Tokarev wrote:
> I wonder why open() with O_DIRECT (for example) bit set is
> disallowed on a tmpfs (again, for example) filesystem,
> returning EINVAL.

Because it would be (a very small amount of) work and bloat to
support O_DIRECT on tmpfs; because that work didn't seem useful;
and because the nature of tmpfs (completely in page cache) is at
odds with the nature of O_DIRECT (completely avoiding page cache),
so it would seem misleading to support it.

You have a valid view, that we should not forbid what can easily be
allowed; and a valid (experimental) use for O_DIRECT on tmpfs; and
a valid alternative perception, that the nature of tmpfs is already
direct, so O_DIRECT should be allowed as a no-op upon it.

On the other hand, I'm glad that you've found a good workaround,
using loop, and suspect that it's appropriate that you should have
to use such a workaround: if the app cares so much that it insists
on O_DIRECT succeeding (for the ordering and persistence of its
metadata), would it be right for tmpfs to deceive it?

I'm inclined to stick with the status quo;
but could be persuaded by a chorus behind you.

Hugh

p.s.  You said "O_DIRECT (for example)" - what other open
flag do you think tmpfs should support which it does not?
