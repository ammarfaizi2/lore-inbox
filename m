Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbUJ0Rhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUJ0Rhz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbUJ0Rg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:36:58 -0400
Received: from waste.org ([209.173.204.2]:39808 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262577AbUJ0Rat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:30:49 -0400
Date: Wed, 27 Oct 2004 12:30:31 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netpoll_setup questions
Message-ID: <20041027173031.GO31237@waste.org>
References: <16767.50093.59665.83462@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16767.50093.59665.83462@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 11:50:05AM -0400, Jeff Moyer wrote:
> Hi, Matt,
> 
> The section of code in the body of this if statement:
> 
> 	if (!(ndev->flags & IFF_UP)) {
> 
> is a bit broken.  First, upon discussion with jgarzik, it seems we should
> not check for IFF_UP, but instead do netif_running.

Well I cribbed it from the nfsroot code, which is perhaps not up on
fashion.

> However, I'm wondering why we try to force the interface up in the
> first place?

Uh, so we can send packets before userspace has configured the network?

> Just because we force it up doesn't mean that it will get an IP
> address.

I don't expect it does. Usually we have our own IP address from the
command line, but if we don't, we will check if there's an in_dev
connected to the device and if so, look up the device's IP. This is
useful for the modular case where the network is up before we start
and we have a handy default for local IP.

> And, in the case where it doesn't, you will get an oops further on
> when dereferencing the ifa_list.

Does this actually happen? I'm checking in_dev for null already, but
perhaps I need to check ifa_list as well.

> So, why does this section of code exist at all? If it has a good
> purpose, can we replace it with a call to ndev->open?

Maybe. We should probably revisit the nfsroot code as well.

-- 
Mathematics is the supreme nostalgia of our time.
