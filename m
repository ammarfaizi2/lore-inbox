Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276032AbRJ3IVf>; Tue, 30 Oct 2001 03:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276843AbRJ3IVP>; Tue, 30 Oct 2001 03:21:15 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:19744 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S276032AbRJ3IVD>; Tue, 30 Oct 2001 03:21:03 -0500
Date: Tue, 30 Oct 2001 10:21:25 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: J Sloan <jjs@lexus.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nasty suprise with uptime
Message-ID: <20011030102124.H1598@niksula.cs.hut.fi>
In-Reply-To: <3BDDBC90.7E16E492@lexus.com> <20011029151036.F20280@mikef-linux.matchmail.com> <3BDDE422.938C1D95@lexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BDDE422.938C1D95@lexus.com>; from jjs@lexus.com on Mon, Oct 29, 2001 at 03:20:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:20:02PM -0800, you [J Sloan] claimed:
> Mike Fedyk wrote:
> 
> > On Mon, Oct 29, 2001 at 12:31:12PM -0800, J Sloan wrote:
> > > Say it ain't so! maybe I'm a bit dense, but is the 2.4 kernel also going
> > > to wrap around after 497 days uptime? I'd be glad if someone would
> > > point out the error in my understanding.
> >
> > Ahh, so that's why there haven't been any reports of higher uptimes... ;)
> 
> Yes, it all makes sense now -
> 
> Say, if the uptime field were unsigned it could
> reach 995 days uptime before wraparound -

AFAIK, the jiffies field _is_ unsigned already. In fact 2.0 kernels had some
problems at 2^31 HZ as well. (Stuff like select misbehaving, and some
procps utils giving incorrect results). 

2^32 HZ is 2^32/100 seconds is 2^32/3600/100/24 = 497.1 days.
2^31 HZ is 2^31/100 seconds is 2^31/3600/100/24 = 248.55 days.

(HZ=1/100 by default on x86 etc, it is 1/1024 or 1/1000 at least on alpha).

You need 64 bit jiffies for longer uptimes.

BTW, on win95 the HZ is 1024, which caused it to _always_ crash if it ever
reached 48.5 days of uptime. I've seen NT4 SMP to to crash at same point as
well (though it doesn't do it always).

 
-- v --

v@iki.fi
