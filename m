Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTDTWrH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 18:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263727AbTDTWrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 18:47:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42756 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263726AbTDTWrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 18:47:06 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
Date: Sun, 20 Apr 2003 22:58:49 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b7v8n9$p8o$1@penguin.transmeta.com>
References: <200304201811_MC3-1-3537-1648@compuserve.com>
X-Trace: palladium.transmeta.com 1050879529 26174 127.0.0.1 (20 Apr 2003 22:58:49 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Apr 2003 22:58:49 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200304201811_MC3-1-3537-1648@compuserve.com>,
Chuck Ebbert  <76306.1226@compuserve.com> wrote:
>
> Looks like the fix for the "ran out of interrupt sources" panic
>has a problem.  It will eventually assign a device the same IRQ
>number as the first system vector, i.e. the local APIC timer.

Good call.

Although I suspect you need about a million interrupt sources to hit
this, since FIRST_SYSTEM_VECTOR is somethign like 0xef, and thus you can
hit it only when "offset" has already been incremented seven times
(which implies that we've walked the whole vector space quite a few
times by then).

Did you actually see this on hardware?

Anyway, applied as obvious.

		Linus
