Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135645AbRANWcc>; Sun, 14 Jan 2001 17:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135625AbRANWcX>; Sun, 14 Jan 2001 17:32:23 -0500
Received: from styx.suse.cz ([195.70.145.226]:9465 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S135645AbRANWcM>;
	Sun, 14 Jan 2001 17:32:12 -0500
Date: Sun, 14 Jan 2001 23:32:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount, getting closer
Message-ID: <20010114233208.A2487@suse.cz>
In-Reply-To: <Pine.LNX.4.30.0101141636350.6714-301000@svea.tellus> <Pine.LNX.4.30.0101141848330.7031-100000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101141848330.7031-100000@svea.tellus>; from tori@tellus.mine.nu on Sun, Jan 14, 2001 at 06:59:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2001 at 06:59:57PM +0100, Tobias Ringstrom wrote:
> 
> I should also add that the 3.11 driver seems to make things better, but
> not yet perfect.  My intuition tells me that I get CRC errors much sooner
> with 2.1e than with 3.11.
> 
> Has the timings changed from 2.1e to 3.11, and would it be easy to modify
> 3.11 to get extra safe/paranoid, but less high performance, timings?

If you use 'idebus=40' or 'idebus=50', the driver will add an extra
margin to the timings, trying to compensate for the 40 or 50 MHz PCI bus
it will be tricked to think it's working with.

This could add a data point, yes.

> Some extra data:
> * B seems to work in 2 with udma2
> * A seems to work in 2 with udma1, but not with udma2.

UDMA1 is 22.2 MB/sec, UDMA2 is 33.3. UDMA0 is 16.6.

Could you (if didn't already) send me the lspci -vvxxx after the -X65
(UDMA1) command, together with the one before? That also could tell
something.

> I wouldn't say it's rock solid, and I would not trust my data to any of
> these combinations, but at least it not break immmediately (i.e. for less
> than 1 GB written).

Actually, the CRC messages are safe and only mean a data transfer is
retried. That is, only if it doesn't fail every time. They happen on
many boards and drives using UDMA even under normal correct operation :(

> The worst combination is 2.4.0 with VIA 2.1e and A in 1.  Going from 2.1e
> to 3.11 helps, but it is still very bad.
> 
> I'd really like to be more precise, but there are too many combinations to
> try to try them all, and sometimes it fails right away, and sometimes
> after several hundred megabytes.

If 'fails after several hundred megabytes' only means a single CRC error
which is recovered from correctly, then that actually means 'working and
probably would work perfect with a shorter cable'.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
