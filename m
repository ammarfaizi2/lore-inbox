Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTLLV3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTLLV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:28:39 -0500
Received: from ida.rowland.org ([192.131.102.52]:22276 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262048AbTLLV1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:27:55 -0500
Date: Fri, 12 Dec 2003 16:27:54 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312122201.48194.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0312121623260.677-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Dec 2003, Oliver Neukum wrote:

> Not so simple. Khubd goes down a list. If the first item on its list
> is not your failed reset, a deadlock will occur.
> 
> After you have submitted the URB that really does the reset, you
> are commited. You must either set a valid address or disable the port.
> You can rely on nobody else to do that.

I think we agree on that.  It was never my intention that fixing up a 
failure between the port reset and setting the device address should be 
put off for later handling by khubd.  That would be done immediately.

Hoever the consequent changes to the device structure (i.e., everything
needed to reflect the fact that it is disconnected) could be done in
another thread.

Alan Stern

