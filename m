Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUAWMGv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 07:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266557AbUAWMGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 07:06:51 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:1503 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266555AbUAWMGt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 07:06:49 -0500
Date: Fri, 23 Jan 2004 13:06:47 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] local APIC LVTT init bug
In-Reply-To: <16400.9569.745184.16182@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.55.0401231250310.3223@jurand.ds.pg.gda.pl>
References: <16400.9569.745184.16182@alkaid.it.uu.se>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, Mikael Pettersson wrote:

> __setup_APIC_LVTT() incorrectly sets i82489DX-only bits
> which are reserved in integrated local APICs, causing
> problems in some machines. Fixed in this patch by making
> this setting conditional.

 Sigh -- why can't designers keep such a trivial backwards
compatibility???  The integrated APIC was said to be backwards compatible
when introduced and so far all implementations used to.  What you write
means that has been broken -- could please say which vendor to blame?

> It's possible these bits don't need to be set on i82489DXs,
> but not having this HW for testing I elected to maintain
> our current behaviour on these old machines.

 They were originally unset, leading to broken behavior.  I introduced the
current settings based on i82489DX specification once the problem was
discovered.  The code was checked at the run time on a few systems with 
i82489DX APICs.

 The timer source has to be correctly selected -- we cannot rely on the
firmware to set it the way we want it as the firmware is free to use the
timer whatever way it wants.  Even the power-on/reset setting is
unsuitable as it's the CLK input, straight, and we want it predivided like
with the integrated APIC.  The third alternative, the TMBASE input, cannot
be used reliably at all -- it may be simply NC on a given system.

 Your proposal is therefore the only correct one.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
