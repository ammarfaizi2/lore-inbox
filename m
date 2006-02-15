Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423052AbWBOJCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423052AbWBOJCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423058AbWBOJCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:02:06 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:58308 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1423052AbWBOJCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:02:02 -0500
thread-index: AcYyDnhEyIuCt3h+SSaHW4BYvb1IIw==
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Content-Class: urn:content-classes:message
Importance: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Message-ID: <43F2EE04.9060500@bfh.ch>
Date: Wed, 15 Feb 2006 10:01:56 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Cc: "Phillip Susi" <psusi@cfl.rr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com>
In-Reply-To: <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 09:01:55.0200 (UTC) FILETIME=[7811C800:01C6320E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Bartlomiej Zolnierkiewicz wrote:
> On 2/15/06, Seewer Philippe <philippe.seewer@bfh.ch> wrote:
>>
>>Hi Phillip
>>
>>I'd like to close this discussion if possible.
>>
>>I think we both know that disk geometry is a fiction and except for a
>>few "older" devices which still need support, Linux couldn't care less
>>about it (and in an ideal world this would include myself).
>>
>>On the other hand, at least in the x86 world, we must live with the fact
>>that there are other os around, which, as you so aptly put, aren't sane.
>>In order to work with them and if necessary to fix things, geometry
>>information is necessary. One part is the bios geometry, available
>>through edd or other means. The other part is the geometry the kernel
>>exports (whatever sane values it contains or where they come from).
>>
>>Both are necessary for debugging and fixing. And sometimes it actually
>>makes sense to overwrite the kernel with values that are "compatible".
>>Whether gleaned from the bios via edd or computed by hand does not
>>matter as long as the user has to it by himself. I've given a few
>>examples for this, others can be found by googling (For example the ide
>>disk geometry rewrite for http://unattended.sourceforge.net).
>>
>>I completely agree with all that the kernel should never try to report
>>bios geometry for a disk unless absolutely necessary and should not
>>attempt to fix things automagically.
>>
>>But, as long as the Linux kernel does something with disk geometry, and
>>this could mean just returning some bogus values, it makes sense to
>>export these values read/write in sysfs. Because we all know, sysfs is
>>much easier to handle than say for example ioctls.
> 
> 
> This made me thinking - if all the kernel does is returning some bogus
> values and we need to fix applications to use sysfs interface why not
> instead just fix applications to not use ioctl interface?
> 
> Bartlomiej

Good point (and the one I was afraid of coming up).

This would mean dropping the HDIO_GETGEO ioctl completely and force
applications such as fdisk/sfdisk and even dosemu to determine disk
geometry for themselves. Which I think actually would be the most
correct approach.

But this would come to a similar situation as in the beginnings of 2.6
when we had partitioning problems because bios geometry support was
dropped.

That's something I don't have the guts to decide (and luckily can't), so
I'd rather go with sysfs and provide a means to be as compatible as
possible without doing anything automagically.


