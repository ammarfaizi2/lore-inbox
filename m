Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264188AbRFFVyk>; Wed, 6 Jun 2001 17:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264189AbRFFVya>; Wed, 6 Jun 2001 17:54:30 -0400
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:11529 "EHLO
	moisil.badula.org") by vger.kernel.org with ESMTP
	id <S264188AbRFFVyW>; Wed, 6 Jun 2001 17:54:22 -0400
Date: Wed, 6 Jun 2001 14:54:14 -0700
Message-Id: <200106062154.f56LsE115507@moisil.badula.org>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: "Tom Sightler" <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac9
In-Reply-To: <002e01c0eead$03c6d890$26040a0a@zeusinc.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001 13:20:41 -0400, Tom Sightler <ttsig@tuxyturvy.com> wrote:
>> 2.4.5-ac9
> 
>> o Fix xircom_cb problems with some cisco kit (Ion Badulescu)
> 
> I'm not sure what this is supposed to fix, but it makes my Xircom
> RBEM56G-100 almost useless on my network at the office.  Actually, I can't
> quite blame just this patch, it only makes the problem worse, the driver
> from 2.4.5-ac3 worked, but with 1 second ping times, the new driver barely
> works at all, it seems to think the link is not there, at least not enough
> to pull an IP address.

The patch does only one thing: it instructs the card not to negotiate
full-duplex modes, because (for undocumented and yet unexplained reasons)
full-duplex modes don't work well on this card.

If you had problems before, then their cause is most likely elsewhere.
1-second ping time is definitely wrong.

> The last driver that worked moderately well for me was the one from
> 2.4.4-ac11, it still had a few issues, mostly when resuming, but everything
> worked at home on my 10Mb hub, and at the office on my 10/100Mb FD Cisco
> 6509.  I must admist that I haven't tested every version in between.

The thing is, I don't really see any significant differences between the
2.4.4-ac11 driver and the 2.4.5-ac9 driver. I see lots of clean-ups, some
power management stuff, and the half-duplex stuff. None of them should
affect the core functionality directly..

Please do me a favor: comment out the call to set_half_duplex() (in
xircom_up), recompile and see if it makes a difference.

> One other note, the version in 2.4.4-ac11 is listed as 1.33 while the
> version in 2.4.5-ac9 is 1.11, why did we go backwards?  Were there
> significant problems with the newer version?  The 1.33 sure seems to work
> better for me.

The CVS version is almost irrelevant, I guess Arjan simply rebuild his
repository.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
