Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSGBLf4>; Tue, 2 Jul 2002 07:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSGBLfz>; Tue, 2 Jul 2002 07:35:55 -0400
Received: from pc-62-30-72-191-ed.blueyonder.co.uk ([62.30.72.191]:51840 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316768AbSGBLfy>; Tue, 2 Jul 2002 07:35:54 -0400
Date: Tue, 2 Jul 2002 12:37:18 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: [OKS] Module removal
Message-ID: <20020702123718.A4711@redhat.com>
References: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Jul 01, 2002 at 01:48:55PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The suggestion was made that kernel module removal be depreciated or
> removed. I'd like to note that there are two common uses for this
> capability, and the problems addressed by module removal should be kept in
> mind. These are in addition to the PCMCIA issue raised.
 
> 1 - conversion between IDE-CD and IDE-SCSI. Some applications just work
> better (or usefully at all) with one or the other driver used to read CDs.

The proposal was to deprecate module removal, *not* to deprecate
dynamic registration of devices.  If you want to maintain the above
functionality, then there's no reason why a device can't be
deregistered from one driver and reregistered on another while both
drivers are present.  Note that the scsi stack already allows you to
dynamically register and deregister specific targets on the fly.

> 2 - restarting NICs when total reinitialization is needed. In server
> applications it's sometimes necessary to move or clear a NIC connection,
> force renegotiation because the blade on the switch was set wrong, etc.
> It's preferable to take down one NIC for a moment than suffer a full
> outage via reboot.

Again, you might want to do this even with a non-modular driver, or if
you had one module driving two separate NICs --- the shutdown of one
card shouldn't necessarily require the removal of the module code from
the kernel, which is all Rusty was talking about doing.

Cheers,
 Stephen
