Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267919AbUGaJca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267919AbUGaJca (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 05:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267920AbUGaJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 05:32:30 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:45738 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S267919AbUGaJc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 05:32:27 -0400
Subject: Re: drm - first steps towards 64-bit correctness..
From: Eric Anholt <eta@lclark.edu>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, DRI <dri-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0407310940540.6368@skynet>
References: <Pine.LNX.4.58.0407310940540.6368@skynet>
Content-Type: text/plain
Message-Id: <1091266345.425.34.camel@leguin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 02:32:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 02:13, Dave Airlie wrote:
> Hi,
>         As a first step towards sorting getting the DRM into shape for
> proper use on 32/64-bit systems, I'd like to sort out all the type
> definitions in drivers/char/drm/drm.h, this file is also included in
> userspace and BSD builds...
> 
> After reading the thread "32/64bit issues in ioctl struct passing" on
> dri-devel, I'm still not 100% sure what we need to do, I just know we to
> do something sooner rather than later!! we are getting more and more
> 32/64-bit users everyday....
> While avoiding breakage of current users is "a good thing" I'm not sure it
> overrides "getting it right", at the moment mixed 32/64-bit is broken for
> most cards anyways... I'd like to try and not break pure-32 or pure-64 bit
> setups alright but I think pure-64 bit might take some collateral damage
> :-(..
> 
> I've looked across the SuSE patch[1] for 64-bit, but it looks like it will
> add complexity and making future maintenance nightmareish...
> 
> We do need to sort this out ASAP, and I also would like to say I'm
> probably not the best person to do the work, I've no non-32bit hardware to
> test this stuff on, I've little 32/64 mixed environment experience,
> everytime I think I've grasped the issues I dig a bit further :-), though
> I also believe this is the single biggest issue with the DRM currently (as
> the maintainer..)

I've got a 64-bit cleanliness patch for SiS that I'd like to either get
someone else to review (preferable) or find time to re-read myself.  I
replace the memory management code that existed with much less code
(using bsd queue macros that I'm more familiar with).

Once the flames die down in X.Org I'll isolate the diff from my very
dirty local drm tree and post it again.

I'm hoping that most of the general DRM fixes will be replacing longs
with fixed-size types that are the same on x86, but I haven't looked at
Egbert's diffs yet, unfortunately.  As long as you don't use the linux-y
"u32"-type types, BSD should be happy with the changes.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org


