Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278078AbRJPDnn>; Mon, 15 Oct 2001 23:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278079AbRJPDne>; Mon, 15 Oct 2001 23:43:34 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:3529 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278078AbRJPDnT>; Mon, 15 Oct 2001 23:43:19 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Date: Tue, 16 Oct 2001 13:43:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15307.44268.700557.852375@notabene.cse.unsw.edu.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: very slow RAID-1 resync
In-Reply-To: message from Jeffrey W. Baker on Monday October 15
In-Reply-To: <Pine.LNX.4.33.0110151653120.13462-100000@windmill.gghcwest.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 15, jwbaker@acm.org wrote:
> I just plugged in a new RAID-1(+0, 2 2-disk stripe sets mirrored) to a
> 2.4.12-ac3 machine.  The md code decided it was going to resync the mirror
> at between 100KB/sec and 100000KB/sec.  The actual rate was 100KB/sec,
> while the device was otherwise idle.  By increasing
> /proc/.../speed_limit_min, I was able to crank the resync rate up to
> 20MB/sec, which is slightly more reasonable but still short of the
> ~60MB/sec this RAID is capable of.
> 
> So, two things: there is something wrong with the resync code that makes
> it run at the minimum rate even when the device is idle, and why is the
> resync proceeding so slowly?

The way that it works out where there is other activity on the drives
is a bit fragile.  It works particularly badly when the underlying
devices are md devices.

I would recommend that instead of mirroring 2 stipe sets, you stripe
two mirrored pairs.  The resync should be faster and the resilience to
failure is much better.

NeilBrown
