Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbVD2VZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbVD2VZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVD2VVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:21:50 -0400
Received: from waste.org ([216.27.176.166]:12963 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263005AbVD2VVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:21:06 -0400
Date: Fri, 29 Apr 2005 14:20:52 -0700
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sean <seanlkml@sympatico.ca>, linux-kernel <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Message-ID: <20050429212052.GD21897@waste.org>
References: <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org> <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org> <20050429191207.GX21897@waste.org> <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org> <20050429202341.GB21897@waste.org> <Pine.LNX.4.58.0504291338540.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504291338540.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 01:49:18PM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Apr 2005, Matt Mackall wrote:
> > 
> > The changeset log (and everything else) has an external index.
> 
> I don't actually know exactly how the BK changeset file works, but your 
> explanation really sounds _very_ much like it.

I've never used BK, but I got the impression that it was all SCCS
under the covers, which means adding stuff and reconstructing random
versions is expensive (just as it is in CVS). The split between index
and data in Mercurial is intended to address that.
 
> I didn't want to do anything that even smelled of BK. Of course, part of
> my reason for that is that I didn't feel comfortable with a delta model at
> all (I wouldn't know where to start, and I hate how they always end up
> having different rules for "delta"ble and "non-delta"ble objects).

There aren't really any such rules here. While the index contains a
full DAG, the deltas are done opportunistically on a linearized
(topologically sorted) version of it. We try to make a delta against
the previous tip (regardless of whether or not it's the parent), and
if that is a win, we store it.

> So it sounds like it could work fine, but it in fact sounds so much like 
> the ChangeSet file that I'd personally not have done it that way. 

Well I originally set out to do it differently, but I decided my
current approach was the fastest route to something that actually
worked.

-- 
Mathematics is the supreme nostalgia of our time.
