Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbUK0Dgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUK0Dgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 22:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbUKZTUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:20:43 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261235AbUKZTTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:19:43 -0500
Date: Fri, 26 Nov 2004 17:54:54 +0100
From: Colin Leroy <colin@colino.net>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop
Message-ID: <20041126175454.17b62cf5@pirandello>
In-Reply-To: <200411260838.10508.david-b@pacbell.net>
References: <20041125191726.5ca95299@jack.colino.net>
	<200411260838.10508.david-b@pacbell.net>
X-Mailer: Sylpheed-Claws 0.9.12cvs169.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2004 at 08h11, David Brownell wrote:

Hi, 

> The infinite loop means that something trashed the stack, yes?
> 
> The "limit-- < -1000" test below should never be able to succeed
> unless the previous "limit-- == 0" test got trashed by having
> something obliterate the stack. 

Sure? the (limit -- == 0) gotoes higher to test again.
from what I understand the loop goes back to rescan 1000 times, then once 
to sanitize, then to back to rescan again infinetely...
I may be wrong but I don't think there's a stack corruption there.

> If you got the "IRQ INTR_SF lossage" diagnostic, there's clearly
> some problem with IRQ handling after the resume ... is the iBook
> firmware (or hardware) doing wierd stuff so that the normal PCI
> IRQ calls stopped working?

No, the rest of the computer worked fine.

> And for that matter, "limit" is unsigned, so you must be getting
> (and ignoring) some compiler warnings too.

Yes, noticed and sent a second patch.

-- 
Colin
