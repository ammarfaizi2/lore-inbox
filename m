Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270809AbTGPNSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270812AbTGPNSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:18:36 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:51341 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S270809AbTGPNSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:18:33 -0400
Message-ID: <3F15540E.2040405@alpha.dyndns.org>
Date: Wed, 16 Jul 2003 06:33:02 -0700
From: Mark McClelland <mark@alpha.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Gerd Knorr <kraxel@bytesex.org>,
       Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
References: <20030715143119.GB14133@bytesex.org> <20030715212714.GB5458@kroah.com>
In-Reply-To: <20030715212714.GB5458@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Tue, Jul 15, 2003 at 04:31:19PM +0200, Gerd Knorr wrote:
>  
>
>>Changes required/recommended in video4linux drivers:
>>
>>  * some usb webcam drivers (usbvideo.ko, stv680.ko, se401.ko 
>>    and ov511.ko) use the video_proc_entry() to add additional
>>    procfs files.  These drivers must be converted to sysfs too
>>    because video_proc_entry() doesn't exist any more.
>>    
>>
>
>I'd be glad to do this work once your change makes it into the core. 
>

I can do the ov511 work if you want. I can have it done in two days (or 
less).

>Is there any need for these drivers to export anything through sysfs now
>instead of /proc?
>

Yes, at least with ov511. Some of the info that it puts in /proc is no 
longer necessary. However, there are various bits of hardware info that 
still need to get to userspace, for scripts that need to tell otherwise 
identical (same VID/PID/revision) cameras apart when creating /dev nodes.

Is there a convention for naming driver-specific files in /sys? E.g.: 
ov511_foo, _foo, etc...? I don't want to pollute the namespace.

>From what I remember, it only looked like debugging and other general info stuff.
>

There *is* some debugging stuff I would like to keep, at least for now. 
Approximately half of the bug reports I get are resolved after I see the 
user's /proc info. Is it acceptable to put it all in one file, since it 
isn't meant to be machine-parseable anyway? Some of the HCI drivers do 
that, right?

-- 
Mark McClelland
mark@alpha.dyndns.org


