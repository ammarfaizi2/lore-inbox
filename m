Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJ1QzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJ1QzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUJ1QzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:55:01 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:48281 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261724AbUJ1Qyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 12:54:51 -0400
From: David Brownell <david-b@pacbell.net>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.10-rc1 OHCI usb error messages
Date: Thu, 28 Oct 2004 09:51:35 -0700
User-Agent: KMail/1.6.2
Cc: Colin Leroy <colin@colino.net>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0410281044070.1088-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0410281044070.1088-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410280951.35639.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 07:46, Alan Stern wrote:
> On Wed, 27 Oct 2004, David Brownell wrote:
> 
> > So:  since it's not being actively used then, why shouldn't the
> > root hub (or any other device) be suspended?  During boot, or at
> > any other time.  So long as it works when you plug in a USB device,
> > it looks to me like everything is behaving quite reasonably.
> 
> The root hub _is_ actively being used during initial probing and 
> enumeration, even though no devices may be plugged into it.  Is it 
> guaranteed that the root hub isn't suspended until after 
> usb_register_root_hub returns?

It's never going to be suspended until after the hub driver has
set everything up -- that's the essential constraint.  Since that
routine is called in a preemptible context, some systems could
end up preempting that call, so it'd suspend before that call
manages to return.  That'd be OK, since everything's set up.

- Dave


