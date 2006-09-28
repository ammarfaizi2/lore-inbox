Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751394AbWI1Egm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbWI1Egm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWI1Egm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:36:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751377AbWI1Egl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:36:41 -0400
Date: Wed, 27 Sep 2006 21:36:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
Message-Id: <20060927213628.ef12b1ed.akpm@osdl.org>
In-Reply-To: <451B4D58.9070401@garzik.org>
References: <20060928005830.GA25694@havoc.gtf.org>
	<20060927183507.5ef244f3.akpm@osdl.org>
	<451B29FA.7020502@garzik.org>
	<20060927203417.f07674de.akpm@osdl.org>
	<451B4D58.9070401@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 00:19:36 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Andrew Morton wrote:
> > And it's not sufficient to say "gee, I can't think of any reason why this
> > handler would return an error, so I'll design its callers to assume that". 
> > It is _much_ better to design the callers to assume that callees _can_
> > fail, and to stick the `return 0;' into the terminal callee.  Because
> > things can change.
> 
> huh?  You're going off on a tangent.  I agree with the above, just like 
> I already agreed that SCSI needs better error checking.

No I'm not.  I'm saying that the bugs which this exposed are a far, far
more serious matter than a few false-positive warnings which need
workarounds.

> You're ignoring the API issue at hand.  Let me say it again for the 
> cheap seats:  "search"  You search a list, and stick a pointer somewhere 
> when found.  No hardware touched.  No allocations.  Real world.  There 
> is an example of usage in the kernel today.

If it's called in that fashion then the caller should still check the
device_for_each_child() return value to find out if it actually got a
match.

Now it could be that the mysterious caller to which you refer uses the
non-NULLness of some pointer to work out if a match occurred.  Well shrug -
add a BUG_ON(!device_for_each_child_return_value) or something.

Or write a new version of device_for_each_child() which returns void and
don't tell anyone about it.

But let's not encourage error-ignoring.

