Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWD0Kdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWD0Kdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 06:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWD0Kdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 06:33:32 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:9894 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965082AbWD0Kdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 06:33:32 -0400
Message-ID: <44509DF8.20107@garzik.org>
Date: Thu, 27 Apr 2006 06:33:28 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [git patch] fuse fixes
References: <E1FYJ0r-0006Tv-00@dorka.pomaz.szeredi.hu> <444FD204.7040708@garzik.org> <E1FYzgA-0002V4-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1FYzgA-0002V4-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.0 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.0 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>> This function is called from everywhere, and so, it looks like it should 
>> use SLAB_NOFS rather than SLAB_KERNEL.  I would audit every GFP_KERNEL 
>> and SLAB_KERNEL usage, and consider replacing with SLAB_NOFS or GFP_NOFS.
> 
> GFP_NOFS doesn't make much sense, since mm never calls back into FUSE
> anyway: FUSE writes through the page-cache, and hence never dirties
> any pages.
> 
> I'll add a comment to fuse_request_alloc().

If you're using loop, particularly something insane like swapping over 
loop, "the path" will certainly want to know that its passing through 
the VFS layer, regardless of specific page cache behavior, AFAICS.

	Jeff



