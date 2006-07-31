Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWGaX6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWGaX6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWGaX6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:58:34 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:18351 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751490AbWGaX6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:58:33 -0400
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
Date: Mon, 31 Jul 2006 14:30:53 -0700
User-Agent: KMail/1.7.1
Cc: Aleksey Gorelov <dared1st@yahoo.com>,
       linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0607311542240.8671-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0607311542240.8671-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311430.54313.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 12:46 pm, Alan Stern wrote:
> On Mon, 31 Jul 2006, Aleksey Gorelov wrote:
> 
> > > What code duplication?  Doing it the way I suggested doesn't require 
> > > adding any new code at all.  You, on the other hand, added several 
> > > routines for bus glue that does virtually nothing.
> > 
> >   But you can not use exactly same shutdown function with both pci and platform glue. You need to
> > convert pci/platform device to hcd anyway, right ? So this will add 2 doing 'virtually nothing'
> > routines anyway (unless you just want to duplicate the code of shutdown routine for for platform
> > glue). For ohci, you would need to do the same, hence 2 more routines, 4 total. With bus glue, I
> > added just 2. Am I missing something here ?
> 
> Okay, now I understand your point.  Yes, it makes sense to do it your way.

I confess that I had thought about doing it purely at the "bus glue" level
rather than as a new HCD method, but having an HCD method for this does make
sense in terms of simpler code in HCDs that cope with more than one kind of
bus glue.  (And I'd forgotten that OHCI needs a third type, because of that
SA1111 "minibus".)

So as for Aleksey's new patch:

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
