Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264617AbSKMWuB>; Wed, 13 Nov 2002 17:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSKMWuB>; Wed, 13 Nov 2002 17:50:01 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:65220 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264617AbSKMWuA>; Wed, 13 Nov 2002 17:50:00 -0500
Date: Wed, 13 Nov 2002 15:00:05 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
To: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Cc: rusty@rustcorp.com.au, kaos <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Message-id: <3DD2D975.6020302@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3DD2B1D5.7020903@pacbell.net> <20021113201710.GB7238@kroah.com>
 <3DD2B8D3.6060106@pacbell.net> <3DD2BD4C.7060502@pobox.com>
 <20021113210711.GA7810@kroah.com> <3DD2C30B.9000404@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Greg KH wrote:
> 
>> On Wed, Nov 13, 2002 at 03:59:56PM -0500, Jeff Garzik wrote:
>>
>> >(tangent warning!)
>> >Another long term idea I would eventually like to realize is the removal
>> >of device ids from the C source code.  ...

Hmm, maybe Linux should use Microsoft's ".inf" file syntax?  %-)

That's one thing that it achieves, at the cost of serious chaos
when the files with the device IDs get out of sync with the
drivers they supposedly work with.


>> True, this would be nice, but how would the driver know to bind to a new
>> device, if it isn't rebuilt, and doesn't know about the new id that was
>> just added?  In the current scheme of driver matching to devices, I
>> don't see how this could be done.

It'd be good if we had ways that user mode tools can request drivers be
bound and un-bound.  "usbfs" has some support for that, not exactly
packaged in the way I'd most like (and "usbfs" is problematic too).


> I think that truly seamless rebinding is doable but would require too 
> much additional complexity in the kernel.  Rebinding to a new id table 
> between unregister() ... register() pairs, or between mod unload and mod 
> load, should be enough to be useable for 98% of the cases.

I'd rather not try swapping ID tables ... likely better to keep some
of that information compiled in to the drivers, but also ADD ways that
user mode tools can modify the bindings that the kernel does (or doesn't)
establish.  Unless someone wants to get radical and insist that ONLY the
user mode tools can define such policies (after bootstrapping is done).

Of course Greg's example of a Palm could be addressed using current
infrastructure and module parameters, with "wildcard" binding (to
make sure the driver can see if the device matches the parameters).

- Dave


