Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUJVWwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUJVWwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJVWtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:49:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3821 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268269AbUJVWtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:49:11 -0400
Date: Fri, 22 Oct 2004 15:49:24 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC32: Fix cpu voltage change delay
Message-ID: <20041022224924.GD11126@us.ibm.com>
References: <16744.45392.781083.565926@cargo.ozlabs.ibm.com> <20041022180117.GA2162@us.ibm.com> <1098484464.11740.77.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098484464.11740.77.camel@gaston>
X-Operating-System: Linux 2.6.9-rc4 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 08:34:24AM +1000, Benjamin Herrenschmidt wrote:
> On Sat, 2004-10-23 at 04:01, Nishanth Aravamudan wrote:
> 
> > While looking through the latest bk changelogs, I noticed that you had
> > submitted this patch using msleep(). When I read the comment, though,
> > that you were offsetting the 1 millisecond with a jiffy, I was slightly
> > confused as msleep() is designed to sleep for *at least* the time
> > requested. So if you just use msleep(1) in these cases, you should have
> > the desired effect. msleep() is designed to be independent of HZ (as the
> > timeout is specified in non-jiffy units). Not using the
> > jiffies_to_msecs() macro would remove some extra instructions... The
> > attached patch makes this change (on top of your patch currently in bk7)
> > and also changes the other schedule_timeout()s (at least, those that can
> > be) to msleep.
> 
> No, please leave them as-is at least for now... Last we saw, there was
> a potential issue with schedule_timeout(1) itself not guaranteeing it would
> sleep for an entire jiffie, but only up to the next jiffie...

Ah, ok. Sorry, I was not aware of this issue. Would you mind giving me
more details (off-list, if you'd prefer?).

Thanks,
Nish
