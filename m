Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTLLXgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 18:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLLXgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 18:36:38 -0500
Received: from mail1.kontent.de ([81.88.34.36]:55733 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263101AbTLLXgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 18:36:37 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Sat, 13 Dec 2003 00:36:28 +0100
User-Agent: KMail/1.5.1
Cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312121623260.677-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0312121623260.677-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312130036.29053.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. Dezember 2003 22:27 schrieb Alan Stern:
> On Fri, 12 Dec 2003, Oliver Neukum wrote:
> 
> > Not so simple. Khubd goes down a list. If the first item on its list
> > is not your failed reset, a deadlock will occur.
> > 
> > After you have submitted the URB that really does the reset, you
> > are commited. You must either set a valid address or disable the port.
> > You can rely on nobody else to do that.
> 
> I think we agree on that.  It was never my intention that fixing up a 
> failure between the port reset and setting the device address should be 
> put off for later handling by khubd.  That would be done immediately.

OK.

> Hoever the consequent changes to the device structure (i.e., everything
> needed to reflect the fact that it is disconnected) could be done in
> another thread.

Please clarify. You have to disconnect() before you do the physical reset.
IMHO you should do the code paths for late errors and the device morphed
case in another thread, but what's the benefit for success?

	Regards
		Oliver

