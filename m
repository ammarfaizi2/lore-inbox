Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268240AbUHFSVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268240AbUHFSVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUHFQzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:55:47 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:23007 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268193AbUHFQzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:55:08 -0400
Message-ID: <4113B7DC.6000000@tungstengraphics.com>
Date: Fri, 06 Aug 2004 17:54:52 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
References: <20040806024907.13024.qmail@web14923.mail.yahoo.com> <4113B2AE.8090706@us.ibm.com>
In-Reply-To: <4113B2AE.8090706@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Romanick wrote:
> Jon Smirl wrote:
> 
>> The only case I see a problem is when drm-core is compiled into the
>> kernel. Why don't we just change the Makefile to default to copying the
>> CVS code into the kernel source tree and tell the user to rebuild his
>> kernel? 
> 
> 
> I don't think that will fly with Joe-user that just wants to upgrade his 
> graphics driver.  The other problem case is if the user has two graphics 
> cards in his system.  He wants to upgrade the driver for one of them (or 
> install a new driver for a new card), but the interface between the 
> device-independent (in-kernel) layer and the device-dependent 
> (in-kernel) layer has changed.
> 
> Unless there is some way to have multiple device-independent modules (on 
> a built-in and a module) loaded, the user is stuck in a situation where 
> he has to update both drivers, but it may not be obvious that they need 
> to do so.
> 
> I don't think this situation is likely to happen, but if there is even 
> the potential for it to happen, we will get bitten. :(

Yes, while I support the current rework and de-templatization of the code, I 
don't support any attempt to split the drm modules to try and share code at 
runtime - ie. I don't support a core/submodule approach.

The arguments are pretty much the same as those against unbundling core mesa 
from the drivers - as soon as somebody tries to do an upgrade you're screwed. 
  Anyone trying to run dual head with different 'versions' on each head, 
you're screwed.

The last thing we need right now is a new ABI to worry about.

Keith

