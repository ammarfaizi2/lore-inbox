Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWFLXPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWFLXPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWFLXPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:15:43 -0400
Received: from rtr.ca ([64.26.128.89]:11201 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932209AbWFLXPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:15:42 -0400
Message-ID: <448DF59D.3050606@rtr.ca>
Date: Mon, 12 Jun 2006 19:15:41 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: pl2303 ttyUSB0: pl2303_open - failed submitting interrupt urb,
 error -28
References: <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD50F.3060002@rtr.ca> <448DC93E.9050200@rtr.ca> <20060612204918.GA16898@suse.de> <448DD968.2010000@rtr.ca> <20060612212812.GA17458@suse.de> <448DE28D.3040708@rtr.ca> <20060612220321.GA19792@suse.de> <448DE6EA.8020708@rtr.ca> <20060612222304.GA21459@suse.de>
In-Reply-To: <20060612222304.GA21459@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 12, 2006 at 06:12:58PM -0400, Mark Lord wrote:
..
>> Eg. If usb_submit_urb() ever fails again (low on memory, etc..)
>> inside  pl2303_open(), will we be back with the same bug?
>>
>> What's the *real* actual bug here?
> 
> There are two of them.
> 
> The fact that the urb submission in the pl2303 driver fails, and is now
> handled properly is fixed in the pl2303 patch.
> 
> The fact that we can (hopefully) handle scheduling TT in the EHCI driver
> fixes the real problem with plugging slow or full speed devices into a
> USB 2.0 hub (not root hub).  That's fixed by the tt patch.
> 
> So we should have finally covered both of them now.

Yes, agreed.

So if modify pl2303_open() to have it simulate -ENOMEM from usb_submit_urb(),
then this should not crash the entire USB subsystem.  Right?

Ditto if it happens due to low-memory, rather than me hacking the code to test it?

Cheers
