Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVHRWPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVHRWPx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVHRWPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:15:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932492AbVHRWPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:15:52 -0400
Date: Thu, 18 Aug 2005 15:15:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] ide update
In-Reply-To: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.58.0508181512240.3412@g5.osdl.org>
References: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 18 Aug 2005, Bartlomiej Zolnierkiewicz wrote:
> 
> 3 obvious fixes + support for 2 new controllers
> (just new PCI IDs).

Btw, things like this:

	+#define IDEFLOPPY_TICKS_DELAY  HZ/20   /* default delay for ZIP 100 (50ms) */

are just bugs waiting to happen.

Hint: see what happens when you do something like this:

	high_byte = IDEFLOPPY_TICKS_DELAY >> 8;
	low_byte = (unsigned char) IDEFLOPPY_TICKS_DELAY;

and watch in amazement how you get entirely the wrong value if HZ is 1000.

Try it out..

		Linus
