Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269200AbUIYDN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269200AbUIYDN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269201AbUIYDN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:13:57 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:895 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269200AbUIYDNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:13:55 -0400
Message-ID: <9e47339104092420131410dd3@mail.gmail.com>
Date: Fri, 24 Sep 2004 23:13:52 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>
Subject: sparse, __iomem and framebuffer memory
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just spent sometime looking at about a thousand errors from sparse
in the DRM code.

There are two main problems, first DRM makes use of opaque handles
which are passed to user space. These handles can be to normal or
iomem memory. Since the handles are typeless this generates a lot of
sparse errors. Other data associated with the handle can be use to
tell if it is normal or iomem.

Second the DRM code always treats the framebuffer as if it is in
IOMEM. But what about IGP type devices where the framebuffer is in
main memory? These only exist on the x86 so treating their framebuffer
as IOMEM works since there is no difference between IOMEM and normal
memory access on an x86.

Is there an example of a IGP type device on an architecture where
normal and IOMEM need different access functions? I suspect DRI/DRM
would break on the device.

This implies that DRM should be passing back two distinct handle
types, one for normal and one for IOMEM, so that the user space app
will use the correct access function. This is also a pretty good
argument for hiding direct framebuffer access and forcing access with
read/write calls on a handle like the IA64 people want to do.

Of course there are a thousand errors to browse though and I may not
be interpreting everything right.

-- 
Jon Smirl
jonsmirl@gmail.com
