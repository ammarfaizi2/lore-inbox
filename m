Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268004AbUIUTaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268004AbUIUTaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268010AbUIUTaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:30:20 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:15161 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268004AbUIUTaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:30:16 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>
X-Message-Flag: Warning: May contain useful information
References: <1095758630.3332.133.camel@gaston>
	<1095761113.30931.13.camel@localhost.localdomain>
	<1095766919.3577.138.camel@gaston>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 21 Sep 2004 12:30:13 -0700
In-Reply-To: <1095766919.3577.138.camel@gaston> (Benjamin Herrenschmidt's
 message of "Tue, 21 Sep 2004 21:41:59 +1000")
Message-ID: <523c1bpghm.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] ppc64: Fix __raw_* IO accessors
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 21 Sep 2004 19:30:14.0358 (UTC) FILETIME=[6B04C760:01C4A011]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to use __raw_*() in portable code?  I have some places
in my code where non-byte-swap IO functions would be useful, but on
ppc64, __raw_*() doesn't know about EEH.  Clearly I don't want to
teach portable code about IO_TOKEN_TO_ADDR etc. so it seems I'm out of
luck.  I end up doing the fairly insane:

	writel(swab32(val), addr);

instead of what I really mean, which is:

	__raw_writel(cpu_to_be32(val), addr);

I'm also a little worried that m68k, sh64 and s390 at least don't
define __raw_* functions.

Thanks,
  Roland
