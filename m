Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUJVWjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUJVWjH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUJVWhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:37:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:65210 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268025AbUJVWfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:35:42 -0400
Subject: Re: [PATCH] PPC32: Fix cpu voltage change delay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041022180117.GA2162@us.ibm.com>
References: <16744.45392.781083.565926@cargo.ozlabs.ibm.com>
	 <20041022180117.GA2162@us.ibm.com>
Content-Type: text/plain
Message-Id: <1098484464.11740.77.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 08:34:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 04:01, Nishanth Aravamudan wrote:

> While looking through the latest bk changelogs, I noticed that you had
> submitted this patch using msleep(). When I read the comment, though,
> that you were offsetting the 1 millisecond with a jiffy, I was slightly
> confused as msleep() is designed to sleep for *at least* the time
> requested. So if you just use msleep(1) in these cases, you should have
> the desired effect. msleep() is designed to be independent of HZ (as the
> timeout is specified in non-jiffy units). Not using the
> jiffies_to_msecs() macro would remove some extra instructions... The
> attached patch makes this change (on top of your patch currently in bk7)
> and also changes the other schedule_timeout()s (at least, those that can
> be) to msleep.

No, please leave them as-is at least for now... Last we saw, there was
a potential issue with schedule_timeout(1) itself not guaranteeing it would
sleep for an entire jiffie, but only up to the next jiffie...

Ben.


