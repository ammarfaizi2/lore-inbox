Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbTFSGN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265670AbTFSGN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:13:56 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:40877 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265661AbTFSGNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:13:53 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "Kevin P. Fleming" <kpfleming@cox.net>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Date: Thu, 19 Jun 2003 08:27:08 +0200
User-Agent: KMail/1.5.1
Cc: Robert Love <rml@tech9.net>, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
References: <3EE8D038.7090600@mvista.com> <20030618225913.GB2413@kroah.com> <3EF10002.7020308@cox.net>
In-Reply-To: <3EF10002.7020308@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306190827.08352.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. Juni 2003 02:12 schrieb Kevin P. Fleming:
> Greg KH wrote:
> >>If this kmalloc fails, you'll have a hole in the numbers and
> >>user space will be very confused. You need to report dropped
> >>events if you do this.
> >
> > Yes, we should add the sequence number last.
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

You cannot order events unless you hold such events. One event always
arrives first. If it's the lower numbered, the point is moot. If it's the
higher numbered, you'll need to hold it or there's no ordering.

For the paranoid even that is not enough. A hotplug script may die in user
space due to OOM oe EIO.

	Regards
		Oliver

