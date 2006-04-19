Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWDSA3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWDSA3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbWDSA3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:29:41 -0400
Received: from test-iport-1.cisco.com ([171.71.176.117]:18488 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750828AbWDSA3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:29:40 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: class_device_create() and class_interfaces ?
X-Message-Flag: Warning: May contain useful information
References: <adafykacur0.fsf@cisco.com> <20060419000438.GA6522@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 18 Apr 2006 17:29:39 -0700
In-Reply-To: <20060419000438.GA6522@kroah.com> (Greg KH's message of "Tue, 18 Apr 2006 17:04:38 -0700")
Message-ID: <adabquycsr0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 19 Apr 2006 00:29:40.0122 (UTC) FILETIME=[588F4FA0:01C66348]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> I'm working toward getting rid of class_devices entirely.
    Greg> What you can do is use a struct device heirachy, right?  If
    Greg> so, take a look at this patch:
    Greg> http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/device-class.patch
    Greg> which implements the start of this changeover.  So, if you
    Greg> were to do this, you can just create a separate "bus" and
    Greg> drivers for these different devices, and everything should
    Greg> bind just fine.

Hmm, that seems a lot more complicated that what I need.  And it seems
I end up needing to handle some sort of registration myself anyway,
because someone has to create the virtual devices when a real device
shows up (since multiple drivers can't bind to the same device).

I think I'll just code my own simple registration for sub-drivers of
the combo device -- it will just take a list_head, a mutex and a few
of lines of code.  That seems simpler to me than creating a fake bus
and fake devices for each combo device.

Thanks,
  Roland
