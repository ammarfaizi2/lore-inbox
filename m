Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129368AbQJ0KuR>; Fri, 27 Oct 2000 06:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129866AbQJ0KuG>; Fri, 27 Oct 2000 06:50:06 -0400
Received: from styx.suse.cz ([195.70.145.226]:57085 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129368AbQJ0Ktv>;
	Fri, 27 Oct 2000 06:49:51 -0400
Date: Fri, 27 Oct 2000 12:49:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Mares <mj@suse.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Yoann Vandoorselaere <yoann@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible critical VIA vt82c686a chip bug (private question)
Message-ID: <20001027124947.A476@suse.cz>
In-Reply-To: <m3d7gnd31m.fsf@test1.mandrakesoft.com> <Pine.LNX.3.95.1001026115039.12337A-100000@chaos.analogic.com> <20001026190309.A372@suse.cz> <20001027120220.A5741@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001027120220.A5741@atrey.karlin.mff.cuni.cz>; from mj@suse.cz on Fri, Oct 27, 2000 at 12:02:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 12:02:20PM +0200, Martin Mares wrote:

> > So this is not our problem here. Anyway I guess it's time to hunt for
> > i8259 accesses in the kernel that lack the necessary spinlock, even when
> > they're not probably the cause of the problem we see here.
> 
> BTW what about trying to modify your work-around code to make it
> attempt to read the timer again? This way we could test whether it was
> a race condition during timer read or really timer jumping to a bogus
> value.

Actually if I don't reprogram the timer (and just ignore the value for
example), the work-around code keeps being called again and again very
often (between 1x/minute to 100x/second) after the first failure, even
when the system is idle.

When reprogramming, next failure happens only after stressing the system
again.

So it's not just a race, the impact of the failure on the chip is
permanent and stays till it's reprogrammed.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
