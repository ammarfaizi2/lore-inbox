Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262895AbVFVIBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262895AbVFVIBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 04:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262929AbVFVHxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:53:48 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:50601 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262872AbVFVHsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:48:06 -0400
In-Reply-To: <20050622062627.GA29759@kroah.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, mochel@digitalimplant.org
Subject: Re: [patch 1/16] s390: klist bus_find_device & driver_find_device callback.
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
From: Cornelia Huck <COHUCK@de.ibm.com>
Message-ID: <OF6148E781.C94AF99A-ON42257028.002925D7-42257028.002AF389@de.ibm.com>
Date: Wed, 22 Jun 2005 09:48:02 +0200
X-MIMETrack: Serialize by Router on D12ML064/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 22/06/2005 09:48:03,
	Serialize complete at 22/06/2005 09:48:03
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote on 22.06.2005 08:26:27:

> What's wrong with just using bus_for_each_dev() instead?  You have to
> supply a "match" type function anyway, so the caller doesn't have an
> easier time using this function instead.

Maybe it's just too early in the morning, but I don't see how I could
achive what I want to do with bus_for_each_dev(). The idea behind
bus_find_device() is to scan the bus for a device matching some
criterium and to return a pointer to it with which the caller can
continue to work. bus_for_each_dev() calls the match function for
every device until we abort, but I don't see how I can grab a reference
to a specific device for later use.

> You also don't increment the reference properly when you return the
> pointer, so you better document that... :(

You're right, this should be done in the base code and not by the
caller...

> In short, I don't think this is needed at all, as it's an almost
> identical copy of bus_for_each_dev().

It looks similar, yes, but they are for different purposes:
- bus_for_each_dev(): do something for each device (as specified
  in the callback function)
- bus_find_device(): get a reference to a specific device for later
  use (as matched in the callback function)

> Same comment as above, I don't think this function is necessary.

Same comment from me, I think I need this interface for drivers
as well.

> thanks,
> 
> greg k-h

Regards,
Cornelia

