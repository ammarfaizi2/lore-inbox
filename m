Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUBKPMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUBKPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:12:37 -0500
Received: from ida.rowland.org ([192.131.102.52]:3332 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265354AbUBKPMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:12:35 -0500
Date: Wed, 11 Feb 2004 10:12:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: eric.piel@tremplin-utc.net
cc: Johannes Erdfelt <johannes@erdfelt.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Slight optimisation of the uhci-hcd init code
In-Reply-To: <1076496008.402a0688ad0aa@mailetu.utc.fr>
Message-ID: <Pine.LNX.4.44L0.0402111000410.791-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Feb 2004 eric.piel@tremplin-utc.net wrote:

> > I'm not sure exactly what the ffffffff value means -- maximum utilization?
> Yes, more exactly it means that the last 64 times the idle task was called the
> bus master was detected as being used.

By "detected as being used", do you mean that the device was actually
carrying out bus transactions or only that it was enabled as a bus master?  
And if it's the first, do you mean that the bus activity was occurring
just as the idle task happened to check or that some bus activity had
occurred since the last time the idle task checked?

USB controllers are more or less permanently enabled, but they only create
bus activity when they actually have some work to do.  If the only USB
device you have connected is a mouse then there should be a small amount
of bus activity occuring once every millisecond, with a little more than
that every 32 milliseconds (or whatever polling period your mouse uses --
look in /proc/bus/usb/devices), and even more when you actually move the
mouse or press a button.

> Well, my laptop seems fine. When I unplug the mouse the bus master activity goes
> to 0000000. I've very little idea about how the bus master has to be used and
> even less about the uhci host controller. However, at a first glance I thought
> it was weird to see full bus master activity when all that is connected is a
> mouse not being used. Do you think it's normal? 

Since I don't really understand the value being reported, I can't say.  
You can judge for yourself from the explanation above.

Alan Stern

