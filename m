Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUFCSB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUFCSB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 14:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263807AbUFCSB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 14:01:26 -0400
Received: from not.theboonies.us ([66.139.79.224]:29884 "EHLO
	not.theboonies.us") by vger.kernel.org with ESMTP id S263733AbUFCSBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 14:01:24 -0400
Message-ID: <1086285678.40bf676e1da4d@mail.theboonies.us>
Date: Thu,  3 Jun 2004 13:01:18 -0500
To: adaplas@pol.net
Cc: David Eger <eger@havoc.gtf.org>, Andrew Morton <akpm@osdl.org>,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fb accel capabilities (resend against
	2.6.7-rc2)
References: <20040603023653.GA20951@havoc.gtf.org>
	<200406032307.13121.adaplas@hotpop.com>
In-Reply-To: <200406032307.13121.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.3
X-Originating-IP: 208.61.36.73
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: David Eger <eger@theboonies.us>
X-Primary-Address: random@theboonies.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting "Antonino A. Daplas" <adaplas@hotpop.com>:

> 1. SCROLL_ACCEL = no panning + copyarea;
> 2. SCROLL_REDRAW = no panning + imageblit;
> 3. SCROLL_PAN/SCROLL_WRAP = pan/wrap + copyarea;

Correct.

> Personally, the pseudocode below might be better.
>
> If (pan/wrap is available) {
> 	if (fb reading is fast || accel copyarea is available)
> 		SCROLL_PAN/WRAP;
> 	else
> 		SCROLL_REDRAW; /* since SCROLL_PAN/WRAP_REDRAW not available */
> } else {
> 	if (fb_reading is fast || accel copyarea is available)
> 		SCROLL_ACCEL;
> 	else
> 		SCROLL_REDRAW;
> }

I coded your pseudocode up, and I'm convinced now that you and Thomas are right.
 We should prefer panning when it's available
cat /usr/src/linux/MAINTAINERS is 0.3 seconds instead of 1.5 seconds.

On the down side, panning makes screen corruption for me... time to investigate
to see if fbcon or radeonfb is to blame... perhaps panning is just incompatible
with accel engine at all in radeon...

-dte

