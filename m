Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbULIQni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbULIQni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULIQnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 11:43:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:53170 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261556AbULIQnH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 11:43:07 -0500
Date: Thu, 9 Dec 2004 08:40:20 -0800
From: Greg KH <greg@kroah.com>
To: Ed L Cashin <ecashin@coraid.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
Message-ID: <20041209164020.GC12257@kroah.com>
References: <87acsrqval.fsf@coraid.com> <20041206215456.GB10499@kroah.com> <87k6rr5usu.fsf@coraid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k6rr5usu.fsf@coraid.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2004 at 10:57:05AM -0500, Ed L Cashin wrote:
> Greg KH <greg@kroah.com> writes:
> 
> ...
> >> +typedef struct Bufq Bufq;
> >> +struct Bufq {
> >> +	Buf *head, *tail;
> >> +};
> >
> > What's wrong with the in-kernel list structures that you need to create
> > your own?
> 
> The Buf structures are singly linked (one next pointer).  We could
> convert it to use list.h, but that would mean having another pointer
> per list element.

Is the extra overhead of another pointer worth the effort of ensuring
that your list handling code is correct in all cases?  (hint, the answer
is usually no...)

The in-kernel list code is very well debugged, and does lots of extra
cpu lookup goodness if it can, ensuring that it is as fast as it
possibly can be.  It's also much better to rely on in-kernel
datastructures as programmers can instantly recognize that you are using
that, and not have to worry about exactly how you call your own custom
list code, and if your list code is even correct in the first place.

So in short, unless this is a structure that is in dire need of a memory
savings, I really suggest you use the in-kernel stuff.

thanks,

greg k-h
