Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWC3XmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWC3XmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWC3XmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:42:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751153AbWC3XmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:42:15 -0500
Date: Thu, 30 Mar 2006 15:41:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Beber <beber.lkml@gmail.com>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org, beber@gna.org,
       akpm@osdl.org
Subject: Re: [PATCH] isd200: limit to BLK_DEV_IDE
In-Reply-To: <Pine.LNX.4.58.0603301510140.26598@shark.he.net>
Message-ID: <Pine.LNX.4.64.0603301531020.27203@g5.osdl.org>
References: <20060328075629.GA8083@kroah.com>
 <4615f4910603301146x5496ccaai17bf5f4636c91c45@mail.gmail.com>
 <Pine.LNX.4.58.0603301431560.26598@shark.he.net> <Pine.LNX.4.64.0603301446340.27203@g5.osdl.org>
 <Pine.LNX.4.58.0603301510140.26598@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Mar 2006, Randy.Dunlap wrote:
> 
> In some way, the original line made sense to me:
> 	depends on USB_STORAGE && BLK_DEV_IDE
> where we have:        =y       &&     =m
> 
> so if USB_STORAGE_ISD200 were a tristate, it would have been limited
> to 'm', but since it's a bool, it's not limited.

Oh, the original makes _tons_ of sense. It's just that it doesn't show the 
real dependency.

It's perfectly fine to say

	bool
	depends on USB_STORAGE && BLK_DEV_IDE

and the bool will be true whenever usb storage and blk-dev-ide both are 
enabled somehow. So far so fine. 

It's just that in this case, it simply wasn't enough. It didn't _just_ 
depend on BLK_DEV_IDE, it depended on it being available at link-time. So 
the original Kconfig rule made perfect sense, it just didn't match the 
real dependency.

		Linus
