Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVCJQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVCJQZl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCJQXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:23:05 -0500
Received: from ns1.idleaire.net ([65.220.16.2]:37559 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S262717AbVCJQSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:18:54 -0500
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
From: Dave Dillow <dave@thedillows.org>
To: Park Lee <parklee_sel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050310103724.11220.qmail@web51506.mail.yahoo.com>
References: <20050310103724.11220.qmail@web51506.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 11:18:52 -0500
Message-Id: <1110471532.5050.14.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2005 16:18:53.0051 (UTC) FILETIME=[D9D9DCB0:01C5258C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 02:37 -0800, Park Lee wrote:
> On Fri, 24 Dec 2004 at 16:15, David Dillow wrote:
> > xfrm_lookup() is only called for outgoing packets, 
> > not for received packets.  I don't think ping 
> > replies (ICMP echo replies) will ever have a non-
> > NULL sk, as they are not associated with a socket.

> Then, Why did you say that ping replies (ICMP echo
> replies) were not associated with a socket? 

Because your crashes where caused by blindly assuming the sk would never
be NULL in xfrm_lookup(), and it clearly was. The simple debugging
printk() I suggested you insert with your code would have shown you that
that was the reason for your crashes.

And if I was feeling nice that day, which is possible, since it was
Christmas Eve, I may have even put the printk() in myself and tested.

> Is there any difference between the special purpose
> socket and the socket you mentioned above?

I have no idea. You have the code, and probably as much understanding of
the networking stack as I do. I suggest you use find and grep to track
down the what you are interested in, and how xfrm_lookup() is called in
various situations. Take good notes, especially about avenues of
exploration that come time mind as you chase one code path. It's not
very hard, it's how I learned.
-- 
Dave Dillow <dave@thedillows.org>

