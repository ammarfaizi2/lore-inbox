Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSLBRS7>; Mon, 2 Dec 2002 12:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264915AbSLBRS7>; Mon, 2 Dec 2002 12:18:59 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:54954 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264903AbSLBRS5>;
	Mon, 2 Dec 2002 12:18:57 -0500
Date: Mon, 2 Dec 2002 17:23:31 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: Split AGP GART device lists.
Message-ID: <20021202172331.GA30694@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, dri-devel@lists.sf.net
References: <20021202164158.GC30351@suse.de> <Pine.LNX.4.44.0212020850530.13962-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212020850530.13962-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[taking this to the lists, to keep anyone who cares about this in the loop]

This conversation evolved out of my split-agpgart-device-list patch.
Linus' proposal is to take this a step further and split each of
the chipsets into a seperate module.  I'm about to tackle this,
but in case there's some hidden gotchas that myself and Linus have
overlooked, I figured I'd give a 'heads up'.

Any comments?

		Dave.

On Mon, Dec 02, 2002 at 08:55:24AM -0800, Linus Torvalds wrote:

 > > I'm worrying about breaking existing behaviour.
 > > X loads /dev/agpgart, which pulls in agpgart.o, but what pulls
 > > in via.o, amd.o etc.. ?
 > 
 > Done right, the regular PCI driver detection should load the thing 
 > automatically without X needing to do anything at all. With the AGP 
 > drivers showing up with the PCI entries they can drive, all the normal 
 > auto-loading should just work _without_ having any special cases.
 > 
 > I really think this is worth doing _right_, without stupid (and incorrect)  
 > module dependencies. Even if it breaks something, it's worth doing:  
 > people who compile their own kernels can just compile the AGP driver
 > statically, the way all sane people - me - do, and people who don't 
 > compile their own kernels obviously get them from distributions that can 
 > trivially make modprobe do the right thing.
 > 
 > We get "eth0" behaviour right without having to have some "eth0" driver 
 > that knows about all the devices that might be networking devices. 
 > Similarly, we should get agp behaviour right without having to have some 
 > silly central thing.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
