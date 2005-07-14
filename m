Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVGNUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVGNUkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVGNUkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 16:40:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3222 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261645AbVGNUks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 16:40:48 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Daniel McNeil <daniel@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050714182325.GI23737@wotan.suse.de>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel>
	 <p73hdex5xws.fsf@bragg.suse.de>
	 <1121356952.6025.33.camel@ibm-c.pdx.osdl.net>
	 <20050714182325.GI23737@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1121373639.6025.70.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Jul 2005 13:40:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 11:23, Andi Kleen wrote:
> > That is exactly why I made this a separate patch, so that we
> > can test and find out where the problems are and work to fix
> > them.
> 
> That's pretty hard because there are a lot of block drivers.
> 
> And might not very nice for people's data.
> 
> > 
> > Are there problems only with odd sizes, or do drivers have problems
> > with non-512 sizes?
> 
> I believe they have problems with non 512 sizes (and probably alignments) 
> too.

The check still only allows i/o that is multiple of the device block
size.  That will always be a requirement.

I was trying to ask:
Do drivers have problems with odd addresses or with
non-512 addresses?

In my limited testing, I saw problems with odd user space
addresses on IDE (using DMA).  When testing 2-byte aligned
addresses, I did not see any problems, and so far, the data
looks correct.

I am continuing to test and this patch allows other to try
it out as well.  For the most part, it should be safe because
nobody has application code that uses O_DIRECT with non-aligned
addresses.  Obviously, it will only be ready for mainline
if/when we fix all the drivers.

Thanks,

Daniel

