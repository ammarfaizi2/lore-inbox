Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbULJAIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbULJAIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 19:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbULJAIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 19:08:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:21380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261488AbULJAIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 19:08:39 -0500
Date: Thu, 9 Dec 2004 16:08:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: akpm@osdl.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB fixes for 2.6.10-rc3
In-Reply-To: <20041209235709.GA8147@kroah.com>
Message-ID: <Pine.LNX.4.58.0412091606130.31040@ppc970.osdl.org>
References: <20041209230900.GA6091@kroah.com> <Pine.LNX.4.58.0412091538510.31040@ppc970.osdl.org>
 <20041209235709.GA8147@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Dec 2004, Greg KH wrote:
> 
> No, the "fun" problem with this specific field (the wTotalLength one) is
> that we initially read them in from the hardware (which for USB is in le
> order) and then, in a later function, convert all of the le fields to
> native cpu order so that all device drivers don't have to worry about
> which fields in the usb structures are in which order.

Aargh. 

> Yeah, it's not the cleanest, and yes, it is just shutting the warning
> up, but that's ok in this case.  I guess I could look into doing the
> "two different structures" type thing again, if people don't like things
> like this in different places.

On the other hand, maybe you could just leave it in "hardware byte order". 

That's something that sparse really can help with - it should pinpoint 
exactly everybody who uses it, and give a reasonable error for them, so 
that everybody can agree on the byte-order.

Oh, well..

		Linus
