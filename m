Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbTE0Fyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTE0Fyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:54:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23500 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262645AbTE0Fye
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:54:34 -0400
Message-ID: <3ED300A8.4000405@pobox.com>
Date: Tue, 27 May 2003 02:07:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305261306500.12186-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305261306500.12186-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 26 May 2003, Jeff Garzik wrote:
> 
>>Correct, but precisely by saying that, you're missing something.
> 
> 
> You're missing _my_ point.
> 
> 
>>The SCSI midlayer provides infrastructure I need -- which is not 
>>specific to SCSI at all.
> 
> 
> If it isn't specific to SCSI, then it sure as hell shouldn't BE THERE!
> 
> My point is that it's _wrong_ to make non-SCSI drivers use the SCSI layer, 
> because that shows that something is misdesigned.
> 
> And I bet there isn't all that much left that really helps.
> 
> You adding more "pseudo-SCSI" crap just _makes_things_worse. It does not 
> advance anything, it regresses. 


As you see from Alan's message and others, it isn't pseudo-SCSI.

Besides what he mentioned, there is Serial Attached SCSI (SAS), where a 
host controller can simultaneously support SAS disks and SATA disks.  So 
it's either an IDE driver that does SCSI, or a SCSI driver that does 
IDE, or a driver that's in both IDE and SCSI subsystems, or... ?  Having 
fun yet?  :)


> On 27 May 2003, Alan Cox wrote:
>>> I actually think thats a positive thing. It means 2.5 drivers/scsi is
>>> now very close to being the "native queueing driver" with some
>>> additional default plugins for doing scsi scanning, scsi error recovery 
>>> and a few other scsi bits.
> 
> Hey, that may well be the way to go, in which case the core stuff should
> be renamed and moved off somewhere else. Leaving drivers/scsi with just 
> the actual low-level SCSI drivers. 

For all these reasons, I continue to maintain that starting out as a 
SCSI driver, and then evolving, is the best route.  The non-SCSI parts 
leave drivers/scsi, as they should.  The SCSI parts stay.  The SCSI 
mid-layer gets smaller.  All the while, the driver continues to work. 
Everybody wins.

Starting out as a native block driver and _then_ adding SCSI support and 
native queueing and jazz does not sound even remotely like a good path 
to follow.

	Jeff



