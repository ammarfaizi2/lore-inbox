Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWESBys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWESBys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWESBys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:54:48 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:15120 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932200AbWESByr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:54:47 -0400
Date: Thu, 18 May 2006 18:54:32 -0700
From: Tim Mann <mann@vmware.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mann@vmware.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: Fix time going backward with clock=pit [1/2]
Message-ID: <20060518185432.27b853e0@mann-lx.eng.vmware.com>
In-Reply-To: <20060518011116.68055275.akpm@osdl.org>
References: <20060517160428.62022efd@mann-lx.eng.vmware.com>
	<20060518011116.68055275.akpm@osdl.org>
Organization: VMware, Inc.
X-Mailer: Sylpheed-Claws 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2006 01:11:16 -0700, Andrew Morton <akpm@osdl.org> wrote:
> Tim Mann <mann@vmware.com> wrote:
> >
> >  Currently, if you boot with clock=pit on the kernel command line and
> >  run a program that loops calling gettimeofday, on many machines you'll
> >  observe that time frequently goes backward by about one jiffy.  This
> >  patch fixes that symptom and also some other related bugs.
> 
> It might be a bit late to get this into 2.6.17.  Although it does look
> pretty safe and simple.  
> 
> Are many people hitting this problem?

No, since pit is a lower-priority clock source than tsc, pmtmr, or hpet,
and most systems can use one of the latter.  However, we currently
recommend clock=pit to VMware users because clock=tsc and clock=pmtmr
have bugs in their lost-tick compensation that makes them actually gain
extra time, and those bugs get tickled often in a VM, making the time
gain quite bad.  (See http://bugzilla.kernel.org/show_bug.cgi?id=5127.)
So it would be nice for us if clock=pit didn't go backward, but most
people wouldn't care.

> And for 2.6.18 we're hoping to get John's x86 timer rework merged up. 

That would be great.  I'm much more excited about seeing John's rework
go in than this little patch of mine.  I only sent out this patch
because John said he wasn't sure how soon his rework would get in.

> John, do those patches address this bug?

I can answer that.  Yes -- John's patch had a similar bug, but I sent
him a similar fix for it and he has merged it in his version C2. 
(However, the issues that Roman and I are discussing apply there too, so
more work may still be needed to make pit a good clocksource, and maybe
it can be good only on UP systems...)

> So if we decide these two patches are not-for-2.6.17 then I'll sit on them
> until we decide whether or not to merge John's patches.  If we do, and if
> those patches fix this problem then your two patches aren't needed.  If
> John's patches don't get merged then I'll need to merge these two.
> 
> Hope that all makes sense ;)

It makes perfect sense to me and sounds like the right thing to do.  Thanks!


-- 
Tim Mann  work: mann@vmware.com  home: tim@tim-mann.org
          http://www.vmware.com  http://tim-mann.org
