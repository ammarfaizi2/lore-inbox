Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268394AbUGXJQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268394AbUGXJQK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268391AbUGXJPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 05:15:34 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:58769 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264819AbUGXJPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 05:15:10 -0400
Message-ID: <4102289A.8090303@metaparadigm.com>
Date: Sat, 24 Jul 2004 17:15:06 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040715 Debian/1.7.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
References: <1090604517.13415.0.camel@lucy>	 <4101D14D.6090007@metaparadigm.com> <1090638881.2296.14.camel@localhost>
In-Reply-To: <1090638881.2296.14.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/04 11:14, Robert Love wrote:
> On Sat, 2004-07-24 at 11:02 +0800, Michael Clark wrote:
> 
> 
>>Should there be some sharing with the device naming of sysfs or are
>>will we introduce a new one? ie sysfs uses:
>>
>>devices/system/cpu/cpu0/<blah>
>>
>>Would it be a better way to have a version that takes struct kobject
>>to enforce consistency in the device naming scheme. This also means
>>userspace would automatically know where to look in /sys if futher
>>info was needed.
> 
> 
> No, we want to give an interface that matches the sort of provider URI
> used by object systems such as CORBA, D-BUS, and DCOP.  We also do _not_
> want to put policy in the kernel.
> 
> The easiest way to avoid that is simply to use a name similar to the
> path name.

So if it is only similar - then a mapping would be needed to maintain
a link with the new kernel message naming model if userspace wants
to relate the message back to the kernel device it was related too.

> Passing the sysfs name would probably be a good potential argument to
> the signal, though.  The temperature signal in the patch is just an
> example.
> 
> 
>>Question is does it make sense to use this infrastructure without sysfs
>>as hald, etc require it. ie depends CONFIG_SYSFS
> 
> 
> That sounds like policy to me.

Perhaps it is, although consist naming of system objects and messages
related to them as a policy sounds like a good one.

I see the argument of not making this depend on sysfs although it could
perhaps be argued both ways. Certainly using the sysfs kojects gives
you the consistent naming for free. You are making a similar policy
assumption by using netlink, that all users of event logging will want
want networking compiled in. Just as fs's depend on block devices,
so can system object related messages depend on *the* system object naming
and toplogy framework.

> Especially if drivers start using this for error logging, there are no
> ties to sysfs.  Configuration dependencies tend to be hard build-time
> deps anyhow.

Perhaps these driver errors are most likely in the context of a system object
that would be registered with sysfs (drivers, device instances, buses, etc).
Which in your example is one such case.

I'm not saying it should be either way just that there are logical
benefits to having this dependancy. If not, it is a choice of duplication
of effort to name and/or maintain these seperate but "similar" to sysfs names.

The question you have to ask is - how many systems that use this will not
have sysfs compiled in? (ie. all 2.6 based desktop systems or any 2.6 embedded
device using hotplug and udev will have sysfs).

As I said it can be argued both ways and forgoing the depedancy on sysfs
may have other negative maintenance aspects of yet another naming scheme.
ie. does LANANA need to set up a registry for these?

just my 2c.

~mc
