Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTEPAHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264324AbTEPAHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:07:35 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:43601 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264322AbTEPAHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:07:32 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <1053034205.2025.3.camel@diemos>
References: <Pine.LNX.4.44L0.0305151709120.1125-100000@ida.rowland.org>
	 <1053034205.2025.3.camel@diemos>
Content-Type: text/plain
Organization: 
Message-Id: <1053026258.1548.7.camel@doobie>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 15 May 2003 14:17:38 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 16:30, Paul Fulghum wrote:
> On Thu, 2003-05-15 at 16:13, Alan Stern wrote:
> > My intention was to avoid resuming if the resume-detect bit is set only 
> > on ports in an over-current condition, since that is the case mentioned in 
> > the erratum.  Of course, this isn't as failsafe as your suggestion.  Which 
> > do you think would work better?
> 
> This should be caught on the suspend side so
> that you can still service the ports that do not
> have the over current condition.
> 
> A single port in OC makes resume unreliable,
> so the only thing to do is not suspend.

Alan:

I think I misread your message. Is there a per port resume
indication? (I'm at home and don't have the specs in front
of me) I was thinking of the global USBSTS_RD bit.

If you can qualify the global USBSTS_RD bit with a per
port resume indication on a non OC port, then it might
make sense to do this on the wakeup side.

Pro: you could suspend the controller when appropriate
without interference from the OC ports

Con: you would be generating a lot of spurious interrupts
as the global USBSTS_RD is set (incorrectly) by the OC ports.
Even though you would not actually do the wake, you still
burn cycles servicing the false interrupts.

So my inclination is still to nab this on the suspend side.

Paul Fulghum
paulkf@microgate.com



