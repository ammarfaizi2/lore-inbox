Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTHOPt2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 11:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTHOPt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 11:49:28 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4106 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262116AbTHOPt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 11:49:26 -0400
Date: Fri, 15 Aug 2003 11:28:59 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Yury Umanets <umka@namesys.com>, Daniel Egger <degger@fhm.edu>,
       Hans Reiser <reiser@namesys.com>, Nikita Danilov <Nikita@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1060870255.4803.49.camel@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.3.96.1030815111741.20604A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, David Woodhouse wrote:

> The raw hardware driver provides only raw read/write/erase
> functionality; no caching is appropriate. 

Okay, that's the model I have in mind as the driver, assuming you included
seek in that list.
> 
> The optional translation layer which simulates a block device provides
> far more than simple caching -- it provides wear levelling, bad block
> management, etc. All using a standard layout on the flash hardware for
> portability.
> 
> (Except in the special case of the 'mtdblock' translation layer, which
> is not suitable for anything but read-only operation on devices without
> any bad blocks to be worked around.)

> If you want to teach a file system about flash and wear levelling, you
> end up ditching the pretence that it's a block device entirely and
> working directly with the flash hardware driver. 

I don't think that's right. A file system may very well be *optimized* for
performance on a certain class of device, but that doesn't make it device
dependent. For example some early SysV filesystems had the directory in
the middle of the platters to minimize seek distance when the partition
was only partially filled. I'd bet I could run JFFS2 on a normal drive,
and I know I can run FAT, ext2, etc on a CF. Now if Linux only knew how to
read SysV.4 drives I could save some critical old data from the 90's, but
that's another issue...
> 
> Either that or use a translation layer which does it _all_ for the file
> system and then just use a standard file system on that simulated block
> device.

That sounds like a loopback mount, sort of. At least a feature which could
be added fairly easily, like crypto mounts.
> 
> Between those two extremes, very little actually makes sense.
> 
> If you introduce the gratuitous extra 'block device' abstraction layer
> which doesn't really fit the reality of flash hardware very well at all,
> you end up wanting to violate the layering in so many ways that you
> realise you really shouldn't have been pretending to be a block device
> in the first place.

Agreed, if you're going to do that type of fakery it's probably better to
take some overhead and not give up good design in the name of performance
for something which is usually limited by other factors like device
performance, or seldom used. Slow and robust is easier to maintain.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

