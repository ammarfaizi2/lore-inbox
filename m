Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbTFSAHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTFSAHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:07:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:17547 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265640AbTFSAHB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:07:01 -0400
Date: Wed, 18 Jun 2003 17:20:39 -0700
From: Greg KH <greg@kroah.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>
Cc: Oliver Neukum <oliver@neukum.org>, Robert Love <rml@tech9.net>,
       Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030619002039.GA2866@kroah.com>
References: <3EE8D038.7090600@mvista.com> <1055459762.662.336.camel@localhost> <20030612232523.GA1917@kroah.com> <200306132201.47346.oliver@neukum.org> <20030618225913.GB2413@kroah.com> <3EF10002.7020308@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF10002.7020308@cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 05:12:50PM -0700, Kevin P. Fleming wrote:
> Greg KH wrote:
> 
> >>If this kmalloc fails, you'll have a hole in the numbers and
> >>user space will be very confused. You need to report dropped
> >>events if you do this.
> >
> >
> >Yes, we should add the sequence number last.
> >
> 
> While this is not a bad idea, I don't think you want to make a promise 
> to userspace that there will never be gaps in the sequence numbers. When 
> this sequence number was proposed, in my mind it seemed perfect because 
> then userspace could _order_ multiple events for the same device to 
> ensure they got processed in the correct order. I don't know that any 
> hotplug userspace implementation is going to be large and complex enough 
> to warrant "holding" events until lower-numbered events have been 
> delivered. That just seems like a very difficult task with little 
> potential gain, but I could very well be mistaken :-)

Yes you are :)

You will have to handle gaps properly yes.

But you also have to "hold" events for a bit of time in order to
determine that things are out of order, or we have a gap.  So a bit of
"complex" logic is in the works, but it's much less complex than if we
didn't have that sequence number.

thanks,

greg k-h
