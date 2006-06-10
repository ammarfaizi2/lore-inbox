Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWFJF5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWFJF5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWFJF5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:57:12 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:26342 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932404AbWFJF5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:57:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=c/rwlk0APHrZGRFzhY7pKtp83UYycLDxMkBPQiJJaGCZx+uGO2Y2YCS/MO6ygVTmULtfdAbDzzwN6LYsS3O56Aitac0GkKpNs14IRxs8WchgiPnQo8YXKtHyBknzXgyVLkAsqqXo6K5xUo0YkjCkVYOY2RrngIjF+MqO+mj28pU=
Message-ID: <448A5F2A.5060104@gmail.com>
Date: Sat, 10 Jun 2006 13:56:58 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] VT binding: Add sysfs support
References: <448933D7.6040301@gmail.com> <20060609220803.GB7636@suse.de> <448A147A.3030108@gmail.com> <20060610043752.GA20088@suse.de>
In-Reply-To: <20060610043752.GA20088@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Jun 10, 2006 at 08:38:18AM +0800, Antonino A. Daplas wrote:
>> Greg KH wrote:
>>> On Fri, Jun 09, 2006 at 04:39:51PM +0800, Antonino A. Daplas wrote:
>>>> Add sysfs attributes for binding and unbinding VT console drivers. The
>>>> attributes are located in /sys/class/tty/console and are namely:
>>>>
>>>>     A. backend - list registered drivers in the following format:
>>>>
>>>>     "I C: Description"
>>> No, this violates the "one value per file" issue with sysfs.  How do you
>>> know you will not overflow the buffer passed to you?
>> I was wondering about this. I just want a way to show what are the currently
>> loaded drivers, so it's a read-only attribute.  It's using snprintf (though
>> I haven't added a check for possible overflows, should be a 2-liner). Maximum
>> number of lines is 16, and there are examples of this rule-breakage in the
>> current sysfs tree.
>>
>> /sys/class/usb_host/usb_hostx/device/pools
> 
> Ah, thanks for pointing this out.  Those files should go to debugfs,
> they do NOT belong in sysfs at all.
> 
>> Yes, none are valid excuses.  Anyway, what would be the best way? I was
>> considering creating another class for vt_console, but that would entail
>> the creation of a new device major number just for this.
> 
> No, you don't need a major to create a new class in sysfs at all.  Look
> at usb_host for an example of that :)

Aha, I see it now. Yes, this is exactly what I need. Thanks for the tip.

> Ok, I also read the 0/5 in this series which describes this in detail,
> sorry for not seeing that (hint, cc: everyone on the series that one
> too, so they get a bit of detail in the future.)
> 

Sorry about that, slipped my mind.

Tony

