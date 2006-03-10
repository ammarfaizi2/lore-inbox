Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWCJFJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWCJFJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 00:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWCJFJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 00:09:43 -0500
Received: from mx.pathscale.com ([64.160.42.68]:40099 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751798AbWCJFJm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 00:09:42 -0500
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <gregkh@suse.de>
Cc: rolandd@cisco.com, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20060310011106.GD9945@suse.de>
References: <patchbomb.1141950930@eng-12.pathscale.com>
	 <1123028ac13ac1de2457.1141950938@eng-12.pathscale.com>
	 <20060310011106.GD9945@suse.de>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 21:09:37 -0800
Message-Id: <1141967377.14517.32.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 17:11 -0800, Greg KH wrote:

> These two files sure do show a lot of different stuff, all in a
> predefined structure for a single file.  Please break them up into the
> different individual files please.

The problem is that I want them to be presented together.  They look
like a pile of different stuff, but they're actually Infiniband NodeInfo
and PortInfo structures.  And yes, they are that ugly.

These files fall into the same categories as the atomic_counters and
atomic_snapshots files you raised objections to earlier; it actually
makes sense to look at them as a whole, not their constituent parts.

In the earlier round of review, people suggested that I use netlink for
stuff like this, but I quickly decided I'd rather gnaw my leg off than
use the netlink API.

I'm thinking at this point that I should just route this information
through the /dev/ipath_sma char device, and maybe
add /dev/ipath_counters%d and /dev/ipath_stats to go with it.  I think
that's a pretty crummy approach that sysfs solves more cleanly, but
there you go.

	<b

