Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311664AbSCXHFw>; Sun, 24 Mar 2002 02:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311683AbSCXHFm>; Sun, 24 Mar 2002 02:05:42 -0500
Received: from c17736.belrs2.nsw.optusnet.com.au ([211.28.31.90]:48769 "EHLO
	bozar") by vger.kernel.org with ESMTP id <S311664AbSCXHFf>;
	Sun, 24 Mar 2002 02:05:35 -0500
Date: Sun, 24 Mar 2002 18:05:16 +1100
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Cc: Steven Walter <srwalter@yahoo.com>,
        Danijel Schiavuzzi <dschiavu@public.srce.hr>
Subject: Re: Screen corruption in 2.4.18
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Steven Walter <srwalter@yahoo.com>,
	Danijel Schiavuzzi <dschiavu@public.srce.hr>
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <200203222204.XAA01121@jagor.srce.hr> <20020322232304.GA19579@hapablap.dyn.dhs.org> <200203231526.QAA09302@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Message-Id: <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 10:06:47AM -0600, Steven Walter wrote:

> > Don't get it wrong. I *do have* an VT8365. VT8365 (ProSavage KM133) is 
> > somewhat the same as VT8363 (KT133), except that 8365 has an integrated 
> > Savage graphics card (which *I use*).
> 
> Aha... I see.  And in thinking about it, I realize that my motherboard
> also has this integrated graphics card.  Perhaps this is the difference?
> Unfortunately, it seems they both report the same PCI id, so I don't
> really know of a way to differentiate them.

I can verify Danijel's report -- I have the same setup
(VT8363+VT8353, a.k.a. ProSavage KM133), and I experience the
same screen corruption.  Clearing only bit 7 of register 55 fixes
the problem; clearing bits 5 and 6 causes the video to go all
borky.  There's been another thread about it on lkml over the
last week or so.

> I looked at that datasheet, and the datasheet for the 8363.  Both said
> not to program offset 55, and both said the bits we are clearing are
> "reserved."  Perhaps we should contact VIA directly, tell them the
> problem we're having with their current fix, tell them our theory, and
> ask if we're right.

Heh, a VIA contact who knows what the hell that register does
would be nice :).

In the meantime, I'd probably suggest a patch which looks for
clears only bit 7 of Rx55 if an 8363 and an 8365 is found.  I'll
whip one up later today.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
