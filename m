Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTLHSfY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTLHSfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:35:23 -0500
Received: from ida.rowland.org ([192.131.102.52]:18436 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261850AbTLHSfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:35:16 -0500
Date: Mon, 8 Dec 2003 13:35:14 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Duncan Sands <baldrick@free.fr>
cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
In-Reply-To: <200312081859.03773.baldrick@free.fr>
Message-ID: <Pine.LNX.4.44L0.0312081328270.1043-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Dec 2003, Duncan Sands wrote:

> Hi Alan, this is for usbfs, not a normal driver.  Recall that I want to replace
> use of ps->devsem with ps->dev->serialize.

Maybe you shouldn't do that.  Other drivers maintain their own data 
structure separately from the struct usb_device and with its own lock.  
But usbfs may suffer from complications as a result of its unorthodox 
approach to device ownership.

>  Currently ps->dev is set to NULL in
> the devio.c usbfs disconnect method (if some interface is claimed) or in
> inode.c on device disconnect, making it hard to lock with ps->dev->serialize :)
> Thus disconnect should no longer be signalled by setting ps->dev to NULL.

If you would keep the ps->devsem lock, would there be any problem in 
setting ps->dev to NULL to indicate disconnection?

Are they any reasons for not keeping ps->devsem?  Since usbfs generally 
acts as a driver and drivers generally don't have to concern themselves 
with usbdev->serialize (the core handles it for them), shouldn't usbfs 
also be able to ignore ps->dev->serialize?

Alan Stern

