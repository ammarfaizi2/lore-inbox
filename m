Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbTLLVB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTLLVB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:01:58 -0500
Received: from mail1.kontent.de ([81.88.34.36]:10662 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261974AbTLLVB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:01:57 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Fri, 12 Dec 2003 22:01:43 +0100
User-Agent: KMail/1.5.1
Cc: Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312121547430.677-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312121547430.677-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312122201.48194.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. Dezember 2003 21:48 schrieb Alan Stern:
> On Fri, 12 Dec 2003, David Brownell wrote:
> 
> > Alan Stern wrote:
> > 
> > >>That would also reduce the length of time the address0_sem
> > >>is held,
> > > 
> > > 
> > > It would?  How so?
> > 
> > It would be dropped after the address is assigned (the bus
> > no longer has an "address zero") ... rather than waiting
> > until after the device was configured and all its interfaces
> > were probed.  I think that's the issue Oliver alluded to in
> > his followup to your comment.
> 
> I thought it did that already.  Oh well...

Not so simple. Khubd goes down a list. If the first item on its list
is not your failed reset, a deadlock will occur.

After you have submitted the URB that really does the reset, you
are commited. You must either set a valid address or disable the port.
You can rely on nobody else to do that.

	Regards
		Oliver

