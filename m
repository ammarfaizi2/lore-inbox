Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbSKOAU4>; Thu, 14 Nov 2002 19:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKOAU4>; Thu, 14 Nov 2002 19:20:56 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:54241 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265333AbSKOAUz>;
	Thu, 14 Nov 2002 19:20:55 -0500
Date: Fri, 15 Nov 2002 00:27:30 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, John Alvord <jalvo@mbay.net>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: module mess in -CURRENT
Message-ID: <20021115002730.GA22547@bjl1.asuk.net>
References: <p731y5owj0x.fsf@oldwotan.suse.de> <Pine.LNX.4.20.0211140929080.28420-100000@otter.mbay.net> <20021114184049.A28183@wotan.suse.de> <20021114180117.GM31697@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021114180117.GM31697@dualathlon.random>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 1msec still leave a reasonable window open IMHO. this problem would need
> sequence numbers updated atomically to be solved correctly without
> regard to the timing

I agree 100% - it would be nice to be correct instead of "usually
works".

Once you're talking about nanoseconds, you can have both: each time
you store an mtime, make sure the value is at least 1 nanosecond
greater than the previously stored mtime for any file in the
serialisation domain.  If it is not, simply _wait_ for up to a
nanosecond until the value has advanced enough.

-- Jamie
