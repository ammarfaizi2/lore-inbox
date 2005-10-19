Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbVJSH1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbVJSH1h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 03:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbVJSH1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 03:27:37 -0400
Received: from mailgate.urz.uni-halle.de ([141.48.3.51]:15547 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S1751567AbVJSH1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 03:27:37 -0400
Date: Wed, 19 Oct 2005 09:27:25 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
In-Reply-To: <Pine.LNX.4.58.0510180821140.10054@shark.he.net>
Message-ID: <Pine.HPX.4.33n.0510190910390.13768-100000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scan-Signature: f6096ab4fa117ba63f870fa2b57272d1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> On Tue, 18 Oct 2005, Clemens Ladisch wrote:
>
> > Randy.Dunlap wrote:
> > > hpet_poll, HPET_IE_ON failed: (5) Input/output error
> >
> > This probably means that the interrupt isn't free.
>
> Isn't free because it is already in use as a system timer
> interrupt, for example?

If it tries to use interrupt 0, yes.

> Does this test work (succeed) for you?  If so, is HPET being
> used as replacement for legacy timer and RTC?  (as it is where I
> am testing)

Yes.  Yes.


However, I've patched my kernel to initialize the HPET manually
because my BIOS doesn't bother to do it at all.  A quick Google search
shows that in most cases where the BIOS _does_ bother, the third timer
(which is the only free one after system timer and RTC have grabbed
theirs) didn't get initialized and is still set to interrupt 0 (which
isn't actually supported by most HPET hardware).

This means that hpet.c must initialize the interrupt routing register
in this case.  I'll write a patch for this.


Regards,
Clemens

