Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRJPDvO>; Mon, 15 Oct 2001 23:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278082AbRJPDvD>; Mon, 15 Oct 2001 23:51:03 -0400
Received: from c009-h018.c009.snv.cp.net ([209.228.34.131]:54225 "HELO
	c009.snv.cp.net") by vger.kernel.org with SMTP id <S278081AbRJPDut>;
	Mon, 15 Oct 2001 23:50:49 -0400
X-Sent: 16 Oct 2001 03:51:16 GMT
Date: Mon, 15 Oct 2001 20:52:41 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@desktop>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: very slow RAID-1 resync
In-Reply-To: <15307.44268.700557.852375@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.33.0110152050120.415-100000@desktop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, Neil Brown wrote:

> On Monday October 15, jwbaker@acm.org wrote:
> > I just plugged in a new RAID-1(+0, 2 2-disk stripe sets mirrored) to a
> > 2.4.12-ac3 machine.  The md code decided it was going to resync the mirror
> > at between 100KB/sec and 100000KB/sec.  The actual rate was 100KB/sec,
> > while the device was otherwise idle.  By increasing
> > /proc/.../speed_limit_min, I was able to crank the resync rate up to
> > 20MB/sec, which is slightly more reasonable but still short of the
> > ~60MB/sec this RAID is capable of.
> >
> > So, two things: there is something wrong with the resync code that makes
> > it run at the minimum rate even when the device is idle, and why is the
> > resync proceeding so slowly?
>
> The way that it works out where there is other activity on the drives

There wasn't any activity at all.

> is a bit fragile.  It works particularly badly when the underlying
> devices are md devices.

Bummer.

> I would recommend that instead of mirroring 2 stipe sets, you stripe
> two mirrored pairs.  The resync should be faster and the resilience to
> failure is much better.

I did eventually do it that way, but the sync speed was the same.  I'm
very curious to know why you think striping mirrors is more reliable than
mirroring stripes.  Either way, you can lose any one drive and some
combinations of two drives.  Either way you can hot-swap the bad disk.

-jwb

