Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752030AbWCIXcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbWCIXcZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCIXcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:32:25 -0500
Received: from mx.pathscale.com ([64.160.42.68]:27526 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752030AbWCIXcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:32:24 -0500
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adapskvfbqe.fsf@cisco.com>
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
	 <adapskvfbqe.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:32:23 -0800
Message-Id: <1141947143.10693.40.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:18 -0800, Roland Dreier wrote:
>  > +static ssize_t show_version(struct device_driver *dev, char *buf)
>  > +{
>  > +	return scnprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
>  > +}
> 
> Any reason you left a "\n" off of this attribute?

Nope, just a bogon.

>  > +static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
>  > +{
>  > +	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
>  > +
>  > +	return sizeof(ipath_stats);
>  > +}
> 
> I think putting a whole binary struct in a sysfs attribute is
> considered a no-no.

Grumble.  it's a fairly small struct, much less than a page in length,
and userspace needs an atomic view of it, instead of reading each of the
umpteen broken-out files that we also provide for humean-readable access
to each counter.

I didn't see any point to implementing the sysfs binary file interface
in order to do exactly what this 6-line function does.  Still don't, in
fact :-)

> Another missing "\n"

Thanks.

	<b

