Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWJRI4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWJRI4F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJRI4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:56:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:20886 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932135AbWJRI4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:56:02 -0400
Subject: Re: [PATCH/RFC] Call platform_notify_remove later
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Len Brown <lenb@kernel.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <200610180334.20810.len.brown@intel.com>
References: <1161137335.23947.10.camel@localhost.localdomain>
	 <200610180334.20810.len.brown@intel.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 18:34:52 +1000
Message-Id: <1161160492.23947.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 03:34 -0400, Len Brown wrote:
> On Tuesday 17 October 2006 22:08, Benjamin Herrenschmidt wrote:
> > (CC'ed Deepak and Len, the two only users of that callback I could find
> > in the tree).
> > 
> > Right now, the driver core calls the platform_notify hook when adding a
> > device, before attaching to the bus and probing drivers. That is all
> > good. However, it calls platform_notify_remove on removal of a device
> > also -before- calling bus_remove_device(), and thus before unhooking
> > drivers from that device. That strikes me as odd, and even incorrect.
> 
> AFAICS, your change is logical and should be fine.

Thanks. However, before I throw it properly at Andrew for 2.6.20, what
do you think of a different approach: removing those 2 function pointers
and replacing them with a notifier ?

I find that with my refactoring of the DMA ops, I actually have various
bits of code (the pci layer, some platform bus code, etc...) that need
to "hook" there to create my auxilliary data structure depending, among
other, on the bus type, and I'd like to keep those functions well
separated in different files without inter-links.

Thus I'd rather have the interested bits be able to just register a
notifier and get called on device add and remove. Does it look like
something you could use too ?

Cheers,
Ben.

