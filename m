Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUHFQdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUHFQdR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268169AbUHFQdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:33:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:38653 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S268157AbUHFQdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:33:01 -0400
Message-ID: <4113B2AE.8090706@us.ibm.com>
Date: Fri, 06 Aug 2004 09:32:46 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@yahoo.com>
CC: Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
References: <20040806024907.13024.qmail@web14923.mail.yahoo.com>
In-Reply-To: <20040806024907.13024.qmail@web14923.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> The only case I see a problem is when drm-core is compiled into the
> kernel. Why don't we just change the Makefile to default to copying the
> CVS code into the kernel source tree and tell the user to rebuild his
> kernel? 

I don't think that will fly with Joe-user that just wants to upgrade his 
graphics driver.  The other problem case is if the user has two graphics 
cards in his system.  He wants to upgrade the driver for one of them (or 
install a new driver for a new card), but the interface between the 
device-independent (in-kernel) layer and the device-dependent 
(in-kernel) layer has changed.

Unless there is some way to have multiple device-independent modules (on 
a built-in and a module) loaded, the user is stuck in a situation where 
he has to update both drivers, but it may not be obvious that they need 
to do so.

I don't think this situation is likely to happen, but if there is even 
the potential for it to happen, we will get bitten. :(

> Then for us DRM hackers just have another make target that builds
> outside of the tree like we are currently doing. We could add a single
> symbol as a check, drm_core in kernel would not provide the symbol.
> drm_core compiled as a module provides it. drm compiled out of tree
> requires it. drm compiled in tree doesn't care.

