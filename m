Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWI1ETk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWI1ETk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWI1ETk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:19:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:38358 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750786AbWI1ETj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:19:39 -0400
Message-ID: <451B4D58.9070401@garzik.org>
Date: Thu, 28 Sep 2006 00:19:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
References: <20060928005830.GA25694@havoc.gtf.org>	<20060927183507.5ef244f3.akpm@osdl.org>	<451B29FA.7020502@garzik.org> <20060927203417.f07674de.akpm@osdl.org>
In-Reply-To: <20060927203417.f07674de.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> And it's not sufficient to say "gee, I can't think of any reason why this
> handler would return an error, so I'll design its callers to assume that". 
> It is _much_ better to design the callers to assume that callees _can_
> fail, and to stick the `return 0;' into the terminal callee.  Because
> things can change.

huh?  You're going off on a tangent.  I agree with the above, just like 
I already agreed that SCSI needs better error checking.

You're ignoring the API issue at hand.  Let me say it again for the 
cheap seats:  "search"  You search a list, and stick a pointer somewhere 
when found.  No hardware touched.  No allocations.  Real world.  There 
is an example of usage in the kernel today.

Yes, SCSI needs better error checking.  Yes, device_for_each_child() 
actors _may_ return errors.  No, that doesn't imply 
device_for_each_child() actors must be FORCED BY DESIGN to return error 
codes.  It's just walking a list.  The current implementation and API is 
fine... save for the "__must_check" marker itself.  The actor CAN return 
an error code via the current API.

CAN, not MUST.  (using RFC language)

	Jeff


