Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbREXQO7>; Thu, 24 May 2001 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262169AbREXQOt>; Thu, 24 May 2001 12:14:49 -0400
Received: from geos.coastside.net ([207.213.212.4]:35500 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S262168AbREXQOl>; Thu, 24 May 2001 12:14:41 -0400
Mime-Version: 1.0
Message-Id: <p05100305b732e0c1151b@[207.213.214.37]>
In-Reply-To: <20010524175600.A14584@gruyere.muc.suse.de>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au>
 <200105240658.f4O6wEWq031945@webber.adilger.int>
 <20010524103145.A9521@gruyere.muc.suse.de>
 <p05100301b732c8715ebd@[207.213.214.37]>
 <20010524175600.A14584@gruyere.muc.suse.de>
Date: Thu, 24 May 2001 09:13:52 -0700
To: Andi Kleen <ak@suse.de>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Dying disk and filesystem choice.
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:56 PM +0200 2001-05-24, Andi Kleen wrote:
>On Thu, May 24, 2001 at 08:50:04AM -0700, Jonathan Lundell wrote:
>  > At 10:31 AM +0200 2001-05-24, Andi Kleen wrote:
>>  >reiserfs doesn't, but the HD usually has transparently in its firmware.
>>  >So it hits a bad block; you see an IO error and the next time you hit
>>  >the block the firmware has mapped in a fresh one from its internal
>>  >reserves.
>>
>>  Drives have remapping capability, but it's the first I've heard of HD
>>  firmware doing it automatically. I'd be very interested in reading
>>  the relevant documentation, if you could provide a pointer. Seems to
>>  me if a drive *could* do this, you'd certainly want to turn it
>>  (automatic remapping) off. There's way too much chance that a system
>>  will read the remapped sector and assume that it contains the
>>  original data. That would be hopelessly corrupting.
>
>There are two scenarios: read and write. For write doing remapping transparent
>is all fine, as the data is destroyed anyways.
>For read it returns an IO error once and the next time you read from that
>block it contains fresh (or partly recovered) data.

What HDs are we talking about, specifically?

WRT writes, how does the drive detect the error?

WRT reads, there are too many filesystems that would accept the 
second (no-IO-error) read as being the original good data.

IBM's UltraStar drives have an option (a bit in a vendor-unique mode 
page) that enables automatic reassignment, but it's done safely. If 
an unrecoverable read error is reported, the block is entered in a 
list of reassignment candidates. If that block is subsequently 
written, it's written back to the original location, and then 
verified. If the verify fails, the block is reassigned and rewritten; 
if it succeeds, it's left in the original location, and the block is 
removed from the reassignment candidate list.

Notice that invalid data is never returned without an error 
indication. That's critical.
-- 
/Jonathan Lundell.
