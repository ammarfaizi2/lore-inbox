Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275903AbTHOLRz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 07:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275910AbTHOLRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 07:17:54 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:1702 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S275903AbTHOLRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 07:17:52 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Daniel Egger <degger@fhm.edu>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <1060870255.4803.49.camel@passion.cambridge.redhat.com>
References: <Pine.LNX.3.96.1030813160910.12417A-100000@gatekeeper.tmr.com>
	 <1060837469.17622.6.camel@haron.namesys.com>
	 <1060870255.4803.49.camel@passion.cambridge.redhat.com>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1060946100.14824.13.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 15 Aug 2003 15:15:01 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 18:10, David Woodhouse wrote:
> On Thu, 2003-08-14 at 06:04, Yury Umanets wrote:
> > Yes, you are right. Device driver cannot take care about leveling.
> 
> The hardware device driver doesn't. The 'translation layer' does, in the
> case where you are using a traditional block-based file system. 
> 
> If you consider the translation layer and the underlying raw hardware
> driver together to form the 'device driver' from the filesystem's
> perspective and in the context of the above sentence, then you're
> incorrect -- it can, and in general it _does_ take care of wear
> levelling.
> 
> > It is able only to take care about simple caching (one erase block) in 
> > order to make wear out smaller and do not read/write whole block if one 
> > sector should be written.
> 
> Whatever meaning of 'device driver' you meant to use -- no.
> 
> The raw hardware driver provides only raw read/write/erase
> functionality; no caching is appropriate. 
> 
> The optional translation layer which simulates a block device provides
> far more than simple caching -- it provides wear levelling, bad block
> management, etc. All using a standard layout on the flash hardware for
> portability.
> 
> (Except in the special case of the 'mtdblock' translation layer, which
> is not suitable for anything but read-only operation on devices without
> any bad blocks to be worked around.)
> 
> > Part of a filesystem called "block allocator" should take care about 
> > leveling.
> 
> That's insufficient. In a traditional file system, blocks get
> overwritten without being freed and reallocated -- the allocator isn't
> always involved. 
> 
> If you want to teach a file system about flash and wear levelling, you
> end up ditching the pretence that it's a block device entirely and
> working directly with the flash hardware driver. 
> 
> Either that or use a translation layer which does it _all_ for the file
> system and then just use a standard file system on that simulated block
> device.
> 
> Between those two extremes, very little actually makes sense.
> 
> If you introduce the gratuitous extra 'block device' abstraction layer
> which doesn't really fit the reality of flash hardware very well at all,
> you end up wanting to violate the layering in so many ways that you
> realise you really shouldn't have been pretending to be a block device
> in the first place.

Agreed fully with you David. Thanks for explanation. 

Only there are probably cannot be so fair borders between levels. Thus,
some functions of translation layer may be passed to filesystem level
(higher one). For instance some things about block allocating. And some
other functions may be passed to device driver layer (lower one). 


Regards.

