Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129285AbQJ0LCS>; Fri, 27 Oct 2000 07:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130108AbQJ0LCJ>; Fri, 27 Oct 2000 07:02:09 -0400
Received: from styx.suse.cz ([195.70.145.226]:23536 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129285AbQJ0LB4>;
	Fri, 27 Oct 2000 07:01:56 -0400
Date: Fri, 27 Oct 2000 13:01:51 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Yoann Vandoorselaere <yoann@mandrakesoft.com>
Cc: Martin Mares <mj@suse.cz>, "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001027130151.A607@suse.cz>
In-Reply-To: <m3d7gnd31m.fsf@test1.mandrakesoft.com> <Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com> <20001026190309.A372@suse.cz> <20001027120220.A5741@atrey.karlin.mff.cuni.cz> <20001027124947.A476@suse.cz> <m38zrablff.fsf@test1.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m38zrablff.fsf@test1.mandrakesoft.com>; from yoann@mandrakesoft.com on Fri, Oct 27, 2000 at 12:58:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 12:58:12PM +0200, Yoann Vandoorselaere wrote:

> > > > So this is not our problem here. Anyway I guess it's time to hunt for
> > > > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > > > they're not probably the cause of the problem we see here.
> > > 
> > > BTW what about trying to modify your work-around code to make it
> > > attempt to read the timer again? This way we could test whether it was
> > > a race condition during timer read or really timer jumping to a bogus
> > > value.
> > 
> > Actually if I don't reprogram the timer (and just ignore the value for
> > example), the work-around code keeps being called again and again very
> > often (between 1x/minute to 100x/second) after the first failure, even
> > when the system is idle.
> > 
> > When reprogramming, next failure happens only after stressing the system
> > again.
> > 
> > So it's not just a race, the impact of the failure on the chip is
> > permanent and stays till it's reprogrammed.
> 
> Are you sure there is not an error in the way the 
> chipset is programmed ?

Which part of the chipset you mean? The PIT (programmable interrupt
timer)? That one is standard since XT times. The rest of the ISA bridge?
Maybe, but that's mostly BIOS work and shouldn't impact the PIT
under sane conditions.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
