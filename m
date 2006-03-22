Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWCVV3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWCVV3G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbWCVV3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:29:06 -0500
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:23286 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932762AbWCVV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:29:04 -0500
Message-ID: <4421C19F.6040409@acm.org>
Date: Wed, 22 Mar 2006 15:29:03 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Yani Ioannou <yani.ioannou@gmail.com>
Subject: Re: [PATCH 2/2] Add full sysfs support to the IPMI driver
References: <20060321221328.GB27436@i2.minyard.local> <1143018069.2955.43.camel@laptopd505.fenrus.org> <20060322204751.GC12335@kroah.com>
In-Reply-To: <20060322204751.GC12335@kroah.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Wed, Mar 22, 2006 at 10:01:09AM +0100, Arjan van de Ven wrote:
>  
>
>>On Tue, 2006-03-21 at 16:13 -0600, Corey Minyard wrote:
>>
>>
>>    
>>
>>>+static void ipmi_bmc_release(struct device *dev)
>>>+{
>>>+	printk(KERN_DEBUG "ipmi_bmc release\n");
>>>+}
>>>      
>>>
>>eehhhh NO.
>>Please read the many comments and documentations about why a release
>>function is NOT allowed to be empty. In fact the kernel warned you about
>>that, didn't it?
>>    
>>
>
>Of course that's not ok.
>
>Come on people, does everyone think I just put that warning message in
>the kernel for fun to force you to create an empty release function?
>Why do people ignore the helpful hints that the kernel provides?
>
>I can take that check out and watch people get their code wrong even
>more, as it sure doesn't seem like it is helping anyone out these
>days...
>
>Corey, haven't we discussed this in the past?
>  
>
I don't think so, this is my first attempt at anything beyond a simple
class device for the driver model.  This code was a rework of
something that came from someone else, so I never actually saw
the kernel message.

I did look in the include files while doing this and a little at the
driver-model docs, and I didn't see anything that jumped out and said
"THIS IS IMPORTANT".  The release field documented in devices.txt,
for instance, says:

release:       Callback to free the device after all references have
           gone away. This should be set by the allocator of the
           device (i.e. the bus driver that discovered the device).

It's not altogether obvious how to use this function or its importance
from this text, though if I had thought about it I would have figured
it out.  If you want to affect behaviour, you need to add text
like:  "NOTE: You must keep the data that holds the device structure
around until the release function is called.  If you do not, something
could be using the device structure after you free it's data, resulting
in bad things happening".  A comment should probably appear in
the include file, too.

If the issue Russell brought up is really an issue, it truely needs some
documentation written about it.

That said, I should have looked a little deeper on this.  I saw it there,
read the docs and include file, and thought, "That's probably just there
to aid debugging," and left it in.

-Corey
