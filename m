Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311479AbSCNCcn>; Wed, 13 Mar 2002 21:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311481AbSCNCce>; Wed, 13 Mar 2002 21:32:34 -0500
Received: from quechua.inka.de ([212.227.14.2]:17174 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S311479AbSCNCcS>;
	Wed, 13 Mar 2002 21:32:18 -0500
From: Bernd Eckenfels <ecki-news2002-02@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18
In-Reply-To: <3C8FF7C7.5CA133B0@us.ibm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E16lL2R-0006Rt-00@sites.inka.de>
Date: Thu, 14 Mar 2002 03:32:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C8FF7C7.5CA133B0@us.ibm.com> you wrote:
> Another way to "replace" printk is not to replace the function itself,
> but
> instead combine printk's ring buffer with the event logging buffer, but
> still
> the end-user would see events in the event log and/or messages in
> /var/log/messages.  A proposal like that at this point in time would
> probably
> be too radical, but is certainly a possibility.

Yes, I think it is at least needed to share the ring buffer.

> I am sorry, I am not really familiar with netlink.  Please explain why
> you 
> think netlink could be (or perhaps should be) replaced with event
> logging ?      

There are different uses for netlink, but one of the most common is event
signalling (high performance) for routing and interface changes. Also
denied/accounted/accepted packets need to be logged by something like ulogd
because printk is not the right solution for that.

> I think the point you are making is that there are certain events that
> you
> never under any circumstances want to miss or discard because of their 
> importance.  printk does not address this nor does it report the fact
> that
> messages in the ring buffer have even been overwritten.  Event logging
> is a little better, but it does not prevent the loss of events either.

Posix and BSD Auditing events are an example for that. In secure mode the
system must be halted on overflow. a printk replacement will want to keep the
oldest entries and a enterprise event system may want to keep the oldest.

> One scheme we have thought of is to add dynamic event buffer allocation,
> so
> that if the static event buffer overflows additional dynamic buffering
> will
> activate until the logging daemon can read-out the events.  Another 
> possibility is the "selective" discarding of lower severity events when
> the
> event buffer reaches a high-water mark.

yes, but even larger dynamic kernel buffers will not stop you from running
into full buffers. And I think a flexible policy will allow everybody to be
happy with your framework. the only way to get it accepted, right?

> draining them out, the "per-event type"  policy you seem to be
> suggesting 
> *I think* would add more complexity than dynamically allocating more
> buffer
> space when needed.  Please elaborate if you disagree.    

I agree, it adds more complexity. Simple solutions are prefered, as long as
they are solutions :)

Greetings
Bernd
