Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTLIWRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbTLIWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:17:17 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:54235 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263343AbTLIWRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:17:16 -0500
Message-ID: <3FD64BD9.1010803@pacbell.net>
Date: Tue, 09 Dec 2003 14:25:29 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Duncan Sands <baldrick@free.fr>
CC: Alan Stern <stern@rowland.harvard.edu>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312091638140.7053-100000@ida.rowland.org> <200312092307.04924.baldrick@free.fr>
In-Reply-To: <200312092307.04924.baldrick@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
>>It's not at all clear how that could happen.  Those pointers are located
>>in static data in the HCD modules.  It doesn't seem likely that the
>>pointer was overwritten.  The only other possibility I can think of is
>>that the module was already unloaded.  But that's not possible since you
>>were holding a reference to a device on that bus.
> 
> 
> It occurred on system shutdown - so I guess the module was unloaded.
> Maybe the bus reference counting is borked.  

Various folk have reported similar problems on system shutdown
before, and the simple fix has been not to clean up so aggressively.

What puzzled me was that a normal "rmmod" wouldn't give the
same symptoms -- but the same codepaths could oops in certain
system shutdown scenarios.

- Dave



