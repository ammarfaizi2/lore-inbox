Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTIVP71 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTIVP71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:59:27 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:32386 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263195AbTIVP7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:59:19 -0400
Message-ID: <3F6F1DA9.1090409@pacbell.net>
Date: Mon, 22 Sep 2003 09:04:57 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg KH <greg@kroah.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH (as112) Re: USB APM suspend
References: <Pine.LNX.4.44L0.0309221034230.1884-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0309221034230.1884-100000@ida.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Sun, 21 Sep 2003, David Brownell wrote:
> 
>>>Why was this routine called twice?  (Don't be fooled by the timestamps; I 
>>>think the "suspend D4 --> D3" message was created during the suspend but 
>>>not read by syslogd until after the resume.)
>>
>>That's happened for as long as I remember (2.4 also).
>>Still seems buglike to me, maybe 2.6 will finally squish it...
> 
> 
> Well, the code path is easy enough to find.  If you look at suspend() in
> arch/i386/kernel/apm.c, you'll see calls to pm_send_all() and
> device_suspend().  They both end up filtering down to the USB HC drivers.  
> The bad one is pm_send_all(); it comes too soon.

Rather, "it comes at all".  Call device_{suspend,resume} should
suffice.  It shouldn't pm_send_all() -- either of the two calls.
(The 2.4 bug is necessarily a different issue.)

Does it work if you remove those calls?


> By the way, David, apparently core/hcd-pci.c wants the HC drivers to set 
> the hcd state to USB_STATE_SUSPENDED, but a simple grep shows that neither 
> the EHCI nor the OHCI driver does so.  That certainly looks like an 
> oversight, though I'm not sure in which source file.

And what's odd is that it was working before, too!  I'll have a look,
next I get a chance.  It's good to know that APM is almost behaving again.


> Meanwhile, here's a simple patch to improve logging during suspend and
> resume.  Greg, if David approves please apply it.

Reads OK to me -- go for it!

- Dave




