Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVFOVOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVFOVOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVFOVOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:14:30 -0400
Received: from opersys.com ([64.40.108.71]:60690 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261581AbVFOVO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 17:14:27 -0400
Message-ID: <42B09CB3.4030101@opersys.com>
Date: Wed, 15 Jun 2005 17:25:07 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Kristian Benoit <kbenoit@opersys.com>
Subject: Spurious parport interrupts (IRQ 7) / rt benchmarking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is related to our continued benchmarking of the rt stuff.

Using the same setup we described earlier, we're now getting
some really odd behavior on rc6. Basically, our target system
is getting more interrupts than our logger is sending to it.

[ recap: our target and logger are rigged via the parallel
port. The logger toggles an output pin on the parallel pin
which, in turn, generates an interrupt on the target. Our
driver on the target catches the interrupt and then toggles
an output pin on the target's parallel port. This, in turn,
generates an interrupt on the logger. The difference between
the time the interrupt was sent by the logger and the time
the interrupt is received from the target on the logger is
what we measure as the interrupt response time. ]

Under ping flood conditions with vanilla Linux, and in that
case only, rc6 gets more interrupts than the logger sends
to it. We've double checked this by not sending any ints
from the logger whatsoever, and ping flooding the rc6 on
the target, and the moment we do that our driver on the
target starts responding to phantom interrupts.

It must be noted that when we did these tests on rc4 we didn't
have such spurious interrupts. Also, we don't get these when
PREEMPT_RT is applied to rc6 (all of which under ping flood
conditions.)

We've tried to find a pattern in the spuriousness, but there
really isn't any.

We've spent quite some time tracking this down, hence the
delayed publication of new numbers.

Any insight anyone may have on this issue would be greatly
appreciated.

Thanks,

Karim Yaghmour
Kristian Benoit
-- 
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || 1-866-677-4546
