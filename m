Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUIBUtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUIBUtW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbUIBUsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:48:37 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:53960 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268370AbUIBUp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:45:58 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Robert Love <rml@ximian.com>, greg@kroah.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040901100750.GA23337@vrfy.org>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <1094004324.1916.63.camel@localhost.localdomain>
	 <20040901100750.GA23337@vrfy.org>
Content-Type: text/plain
Message-Id: <1094157902.1316.83.camel@DYN319498.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 13:45:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-01 at 03:07, Kay Sievers wrote:
[snip]
> The motivation for doing this, is the ambitioned idea, that _data_ should
> only be exposed through sysfs values to userspace. This would make it
> possible for userspace to scan any state at any time, regardless of a
> received event. Which should make the whole setup more reliable, as
> applications can just read in the state at startup. We do a similar job
> with udevstart, as all lost hotplug events during the early boot are
> recovered just by reading sysfs and synthesize these events for creating
> device nodes.
> 
> The same applies to the way back to the kernel. We don't want to send
> data over the netlink back to the kernel, we can write to sysfs.


Ok.. so if I wanted to send an event (that included data at event time)
from a driver for a particular device, I would send the event with the
send_kevent() call and create and maintain an attribute for that
specific event. In order for an application to receive the data for the
event, the driver would need to store the data for that event somewhere
and keep it. Unless there's a write attribute to tell me it's been read,
I must maintain it or write over it if the same event occurs again. 

Is this how it's supposed to work? 

Even though 1) there won't be many events and 2) few events will include
data - don't you think this is a bit too much development overhead for
the driver? 

If you had the payload with the event, you could fire and forget. It
would be fewer steps for the driver and require less management and
storage.

Thanks,

Dan

