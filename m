Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTEPR5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264517AbTEPR5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:57:39 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:16958 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S264516AbTEPR5i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:57:38 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305161045270.738-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305161045270.738-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053108615.2606.35.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 13:10:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 10:33, Alan Stern wrote:
> Paul:
> 
> On 15 May 2003, Paul Fulghum wrote:
> > Con: you would be generating a lot of spurious interrupts
> > as the global USBSTS_RD is set (incorrectly) by the OC ports.
> > Even though you would not actually do the wake, you still
> > burn cycles servicing the false interrupts.
> 
> I'm not sure about that.  For ports in a permanent OC state, the RD bit 
> would get set just once, so a single interrupt would be generated.  When 
> the host clears the Resume Detect bit in the USBSTS register, it shouldn't 
> get set again (not until a different port signals a resume).  Otherwise a 
> properly working system would generate continuous interrupts during the 
> global resume sequence.

Your interpretation checks out. The global RD interrupt does not
reoccur once the individual RD bit is set. So we get a max of
once extra interrupt per OC port.

-- 
Paul Fulghum
paulkf@microgate.com

