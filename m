Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWBJT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWBJT7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 14:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWBJT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 14:59:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48030 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbWBJT7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 14:59:52 -0500
Date: Fri, 10 Feb 2006 11:59:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oliver Neukum <oliver@neukum.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <200602102034.07531.oliver@neukum.org>
Message-ID: <Pine.LNX.4.64.0602101152150.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
 <43ECDD9B.7090709@yahoo.com.au> <Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
 <200602102034.07531.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Oliver Neukum wrote:
>
> Am Freitag, 10. Februar 2006 20:05 schrieb Linus Torvalds:
> > So we may have different expectations, because we've seen different 
> > patterns. Me, I've seen the "events are huge, and you stagger them", so 
> > that the previous event has time to flow out to disk while you generate 
> > the next one. There, MS_ASYNC starting IO is _wrong_, because the scale of 
> > the event is just huge, so trying to push it through the IO subsystem asap 
> > just makes everything suck.
> 
> Isn't the benefit of starting writing immediately greater the smaller
> the area in question? If so, couldn't a heuristic be found to decide whether
> to initiate IO at once?

Quite possibly. I suspect you could/should take other issues into account 
too (like whether the queue to the device is busy or bdflush is already 
working).

I wouldn't object to that.

		Linus
