Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUHCP2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUHCP2h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 11:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUHCP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 11:28:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:17311 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266607AbUHCP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 11:28:32 -0400
Message-Id: <200408031528.i73FSPrB021051@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
In-reply-to: <1091490870.1649.23.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jens Axboe <axboe@suse.de>, Zinx Verituse <zinx@epicsol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd problems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Aug 2004 10:28:25 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 03 Aug 2004 00:54:31 BST, Alan Cox wrote:
>On Sad, 2004-07-31 at 21:00, Jens Axboe wrote:
>> If you want it to work that way, you have the have a pass-through filter
>> in the kernel knowing what commands are out there (including vendor
>> specific ones). That's just too ugly and not really doable or
>> maintainable, sorry.
>
>I disagree providing you turn it the other way around. The majority of
>scsi commands have to be protected because you can destroy the drive
>with some of them or bypass the I/O layers. (Eg using SG_IO to do writes
>to raw disk to bypass auditing layers)
>

  Where would the case of firmware download fit?  For x86 ATA/ATAPI
  devices, the vendor usually supplies a dos disk to accomplish this.
  However, that method is absolutely broken a PPC system.  We have to
  use a proprietary driver that was written using vendor specific
  commands.  I assume that all vendors have their own set of
  proprietary commands, specific to the device to be updated.

  Usually one does not need to do firmware updates, but when
  necessary, it is generally a requirement to do it on the system with
  the device, not to remove the device and carry it to a system where
  it can be done.

  If there was an interface to allow wide open operations, including a
  non-interrupt (polling) mode of operation, this would cover a large
  portion of devices.

>So you need CAP_SYS_RAWIO for most commands. You can easily build a list
>of sane commands for a given media type that are harmless and it fits
>the kernel role of a gatekeeper to do that.

>
>Providing the 'allowed' function is driver level and we also honour
>read/write properly for that case (so it doesnt bypass block I/O
>restrictions and fail the least suprise test) then it seems quite
>doable.
>
>For such I/O you'd then do
>
>	if(capable(CAP_SYS_RAWIO) || driver->allowed(driver, blah, cmdblock))
>
>If the allowed function filters positively "unknown is not allowed" and
>the default allowed function is simply "no" it works.
>
>We'd end up with a list of allowed commands for all sorts of operations
>that don't threaten the machine while blocking vendor specific wonders
>and also cases where users can do stuff like firmware erase.

  Allowed commands are really on a device specfic basis.  And a RAS
  requirement, for at least those of use that have funny endianess
  hardware.  :)

++doug


