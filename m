Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267150AbRGPAhk>; Sun, 15 Jul 2001 20:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbRGPAha>; Sun, 15 Jul 2001 20:37:30 -0400
Received: from geos.coastside.net ([207.213.212.4]:33694 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267150AbRGPAhM>; Sun, 15 Jul 2001 20:37:12 -0400
Mime-Version: 1.0
Message-Id: <p05100322b777ddf1626d@[207.213.214.37]>
In-Reply-To: <200107152314.f6FNEM904281@rvanmete.iprg.nokia.com>
In-Reply-To: <200107152314.f6FNEM904281@rvanmete.iprg.nokia.com>
Date: Sun, 15 Jul 2001 17:37:00 -0700
To: rdv@cips.nokia.com, "Justin T. Gibbs" <gibbs@scsiguy.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 4:14 PM -0700 2001-07-15, Rod Van Meter wrote:
>You can commit an individual write with the FUA (force unit access)
>bit.  The command for this is not WRITE EXTENDED, but WRITE(10) or
>WRITE(12).  I don't think WRITE(6) has room for the bit, and WRITE(6)
>is useless nowadays, anyway.  WRITE EXTENDED lets you write over the
>ECC bits -- it's a raw write to the platter.  Dunno that anyone
>implements it any more.

WRITE EXTENDED is WRITE(10), I believe. The ECC-writing version is 
WRITE LONG; IBM (at least) implements it.

At 11:47 AM -0600 2001-07-15, Justin T. Gibbs wrote:
>As the soft reset section also specifies how to deal with initiators
>that are not expecting soft reset semantics, I believe this applies to
>either reset model.
>
>If we look at the section on caching for direct access devices we see,
>"[write-back cached] data may be lost if power to the device is lost or
>a hardware failure occurs".  There is no mention of a bus reset having
>any effect on commands already acked as completed to the intiator.

I'd very much like to think so; thanks for the reference. I'd feel a 
little more sanguine about the subject if there were some explicit 
guarantee of the desired behavior, either in the SCSI spec or in an 
implementer's functional spec. Nonetheless, it's testable behavior, 
and it's a reasonable inference that drives should behave correctly. 
Thanks again.
-- 
/Jonathan Lundell.
