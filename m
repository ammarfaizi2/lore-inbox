Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282998AbRLQWwg>; Mon, 17 Dec 2001 17:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283003AbRLQWw0>; Mon, 17 Dec 2001 17:52:26 -0500
Received: from harddata.com ([216.123.194.198]:11529 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S282998AbRLQWwK>;
	Mon, 17 Dec 2001 17:52:10 -0500
Date: Mon, 17 Dec 2001 15:52:03 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Peter Rival <frival@zk3.dec.com>
Subject: Re: 2.4.17-rc1 does not boot my Alphas
Message-ID: <20011217155203.B14805@mail.harddata.com>
In-Reply-To: <20011216160404.A2945@mail.harddata.com> <3C1D4871.82053E7A@zk3.dec.com> <20011216225013.A4984@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011216225013.A4984@mail.harddata.com>; from michal@harddata.com on Sun, Dec 16, 2001 at 10:50:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 10:50:13PM -0700, Michal Jaegermann wrote:
> 
> Tommorow I will try to graft 'arch/alpha' from 2.4.13-ac8 to 2.4.17rc1
> just to see what will happen.

Not much is left from these changes if one wants to stay within
"reasonable and compilable". :-)  Anyway, even after this compiles my
Nautilus boxes still do not boot nor show any inclinations to inform why
they are unhappy.

At the very bottom of arch/alpha/kernel/setup.c one can find the
following:

static int alpha_panic_event(struct notifier_block *this,
                             unsigned long event,
                             void *ptr)
{
#if 1
        /* FIXME FIXME FIXME */
        /* If we are using SRM and serial console, just hard halt here. */
        if (alpha_using_srm && srmcons_output)
                __halt();
#endif
        return NOTIFY_DONE;
}

After I changed "#if 1" to "#if 0" results were that most of the time,
although not always, after aboot loader messages I was sooner or later
quietly back at SRM prompt and yes - "srmcons" was given in boot flags.
On some occasions an attempt to boot would simply lock up.  To be sure
this was happening both with CONFIG_ALPHA_LEGACY_START_ADDRESS set
and not set.

Anybody with some ideas where I should really look?

  Michal
