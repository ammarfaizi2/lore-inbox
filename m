Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVLZWfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVLZWfb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 17:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbVLZWfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 17:35:31 -0500
Received: from mx1.rowland.org ([192.131.102.7]:50951 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751090AbVLZWfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 17:35:30 -0500
Date: Mon, 26 Dec 2005 17:35:29 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Bodo Eggert <7eggert@gmx.de>
cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] USB_BANDWIDTH documentation change
In-Reply-To: <Pine.LNX.4.58.0512262244480.22764@be1.lrz>
Message-ID: <Pine.LNX.4.44L0.0512261731001.10595-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005, Bodo Eggert wrote:

> On Mon, 26 Dec 2005, Lee Revell wrote:
> > On Mon, 2005-12-26 at 11:25 +0100, Bodo Eggert wrote:
> 
> > > Document the current status of CONFIG_USB_BANDWITH implementation.
> > 
> > Since most systems use uhci-hcd and/or ehci-hcd maybe we should just
> > mark it BROKEN?  Or EXPERIMENTAL?
> 
> It is EXPERIMENTAL, but the current documentation sounds like "YOU REALLY
> WANT THIS !!!1", and I /guess/ that would be true for ohci-hcd users.

CONFIG_USB_BANDWIDTH isn't _really_ needed.  What it does (or rather, what 
it would do if it worked properly) is prevent the kernel from 
overcommitting on USB bandwidth.

If it's not set, the kernel will allow drivers to reserve more bandwidth
than is actually available, with the result that data transfers will fail.  
If it is set, drivers will not be allowed to reserve too much bandwidth, 
so again the I/O will fail (but at an earlier stage).

Provided drivers never try to overcommit, it doesn't matter whether the 
option is set or not.  And note that a single driver is most unlikely to 
overcommit on bandwidth; the problems arise when you have more than one 
driver all trying to use a lot of bandwidth at the same time.

Alan Stern

