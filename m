Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWDGHV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWDGHV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 03:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWDGHV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 03:21:57 -0400
Received: from main.gmane.org ([80.91.229.2]:40590 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932323AbWDGHV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 03:21:57 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Anand Kumria <wildfire@progsoc.org>
Subject: Re: [PATCH] net: Broadcast ARP packets on link local addresses
Date: Fri, 07 Apr 2006 17:20:48 +1000
Message-ID: <pan.2006.04.07.07.20.44.797909@progsoc.org>
References: <17453.47752.914390.692779@dl2.hq2.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 203.7.227.147
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006 15:26:00 -0800, David Daney wrote:

> From: David Daney
> 
> Greetings,
> 
> When an internet host joins a network where there is no DHCP server,
> it may auto-allocate an IP address by the method described in RFC
> 3927.  There are several user space daemons available that implement
> most of the protocol (zcip, busybox, ...).  The kernel's APR driver
> should function in the normal manner except that it is required to
> broadcast all ARP packets that it originates in the link local address
> space (169.254.0.0/16).  RFC 3927 section 2.5 explains the requirement.
> 
> The current ARP code is non-compliant because it does not broadcast
> some ARP packets as required by RFC 3927.

I haven't seem anyone comment on this, but it would be useful to see this
integrated.

If you have a bunch of Linux machines and two machines have the same
address allocated (not so impossible) they won't notice until they start
communicating with each other.

A third machine attempting to communicate with either party won't be able
to do so.  With this patch in place, overlapping assignments are noticed
much faster due to the broadcast.

Something else I've noticed while I've been implementing my zeroconf
daemon is that the kernel returns link-scoped primary addresses first to
'ifconfig'.  Unfortunately quite a lot of user-space programs parse its
output and interpret the address it presents as the primary for the
specified interface.

Is that a case of user-space breakage that the kernel team would
ordinarily worry about?

Thanks,
Anand

