Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbTEOPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264077AbTEOPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:15:16 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:41782 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264073AbTEOPPO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:15:14 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@digeo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@arndb.de>, johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305141634070.626-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053012368.2026.6.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 10:26:08 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think I found the key to this whole problem:

Note:I mistakenly referred to the chipset as PIIX3
in previous messages, in fact it is the PIIX4 (BX)

The PIIX4 errata states that false resume indications
can be generated if CLK48 is active during an
overcondition indication (OC[1..0]).

Sure enough, the USBPORTSC[12] registers constantly
report a status of 0C80 which shows that both
ports are showing overcurrent condition (which
disables the associated port).

My guess is that HP deliberately tied the OC[1..0]
inputs active to force the ports to a disabled state.

So checking for the case of both ports constantly
in OC condition and disabled may be a reasonable
way to either disable the controller altogether or 
at least not do the wakeup/suspend shuffle.

Any comments?

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


