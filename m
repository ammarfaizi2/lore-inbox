Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262120AbREXP51>; Thu, 24 May 2001 11:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262125AbREXP5H>; Thu, 24 May 2001 11:57:07 -0400
Received: from ns.suse.de ([213.95.15.193]:44555 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262120AbREXP5E>;
	Thu, 24 May 2001 11:57:04 -0400
Date: Thu, 24 May 2001 17:56:00 +0200
From: Andi Kleen <ak@suse.de>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Dying disk and filesystem choice.
Message-ID: <20010524175600.A14584@gruyere.muc.suse.de>
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int> <20010524103145.A9521@gruyere.muc.suse.de> <p05100301b732c8715ebd@[207.213.214.37]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <p05100301b732c8715ebd@[207.213.214.37]>; from jlundell@pobox.com on Thu, May 24, 2001 at 08:50:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 08:50:04AM -0700, Jonathan Lundell wrote:
> At 10:31 AM +0200 2001-05-24, Andi Kleen wrote:
> >reiserfs doesn't, but the HD usually has transparently in its firmware.
> >So it hits a bad block; you see an IO error and the next time you hit
> >the block the firmware has mapped in a fresh one from its internal
> >reserves.
> 
> Drives have remapping capability, but it's the first I've heard of HD 
> firmware doing it automatically. I'd be very interested in reading 
> the relevant documentation, if you could provide a pointer. Seems to 
> me if a drive *could* do this, you'd certainly want to turn it 
> (automatic remapping) off. There's way too much chance that a system 
> will read the remapped sector and assume that it contains the 
> original data. That would be hopelessly corrupting.

There are two scenarios: read and write. For write doing remapping transparent
is all fine, as the data is destroyed anyways.
For read it returns an IO error once and the next time you read from that 
block it contains fresh (or partly recovered) data.

-Andi
