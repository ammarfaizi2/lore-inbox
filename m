Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbTLMBK6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 20:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTLMBK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 20:10:58 -0500
Received: from netrider.rowland.org ([192.131.102.5]:30214 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP id S262838AbTLMBK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 20:10:57 -0500
Date: Fri, 12 Dec 2003 20:10:55 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312130036.29053.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0312122001460.16010-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Dec 2003, Oliver Neukum wrote:

> > Hoever the consequent changes to the device structure (i.e., everything
> > needed to reflect the fact that it is disconnected) could be done in
> > another thread.
> 
> Please clarify. You have to disconnect() before you do the physical reset.

No you don't.  In fact, that would defeat one of the purposes of
usb_reset_device, which is to re-initialize the device while leaving an 
existing driver bound to it (so far as I know that feature is only used by 
usb-storage).  It's a last-ditch form of error recovery.

The API has an admitted weak spot when more than one driver is bound to 
the device.  No one has settled on a definite policy for how to handle 
that situation.

> IMHO you should do the code paths for late errors and the device morphed
> case in another thread, but what's the benefit for success?

In the success case there are no errors, the device hasn't morphed, and 
there's no need to do anything in another thread.  The existing driver(s) 
can remain bound, usb_reset_device returns 0, and nothing more has to be 
done.

Alan Stern

