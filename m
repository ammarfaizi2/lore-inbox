Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSKUNPo>; Thu, 21 Nov 2002 08:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSKUNPo>; Thu, 21 Nov 2002 08:15:44 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:9618 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266649AbSKUNPm>;
	Thu, 21 Nov 2002 08:15:42 -0500
Date: Thu, 21 Nov 2002 13:20:14 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Bill Davidsen <davidsen@tmr.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
Message-ID: <20021121132014.GC9883@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Aaron Lehmann <aaronl@vitelus.com>,
	Con Kolivas <conman@kolivas.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com> <3DDC1480.402A0E5B@digeo.com> <20021121000811.GQ23425@holomorphy.com> <3DDC8330.FE066815@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDC8330.FE066815@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 10:54:40PM -0800, Andrew Morton wrote:
 > > I think this merits some investigation. I, for one, am a big user of
 > > SIGIO in userspace C programs...
 > OK, got it back to 119000.  Each signal was calling copy_*_user 24 times.
 > This gets it down to six.

Good eyes. But.. this also applies to 2.4 (which should also then
get faster). So the gap between 2.4 & 2.5 must be somewhere else ?

Also maybe we can do something about that multiple memcpy in copy_fpu_fxsave()
In fact, that looks a bit fishy. We copy 10 bytes each memcpy, but
advance the to ptr 5 bytes each iteration. What gives here ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
