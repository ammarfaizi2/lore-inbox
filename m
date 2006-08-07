Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWHGOq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWHGOq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWHGOq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:46:59 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42976 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750964AbWHGOq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:46:58 -0400
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: x86_64 command line truncated II
Date: Mon, 7 Aug 2006 16:46:53 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <p73slk8pq6s.fsf_-_@verdi.suse.de> <44D75151.5070504@shadowen.org>
In-Reply-To: <44D75151.5070504@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071646.53886.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 16:42, Andy Whitcroft wrote:
> Andi Kleen wrote:
> > Andi Kleen <ak@suse.de> writes:
> > 
> >> Andy Whitcroft <apw@shadowen.org> writes:
> >>
> >>> It seems that the command line on x86_64 is being truncated during boot:
> >> in mm right?
> >>> Will try and track it down.
> >> Don't bother, it is likely "early-param" (the patch from
> >> hell). I'll investigate.
> > 
> > Following up myself ... 
> > 
> > Are you sure it's a regression? 2.6.17 does the same
> > and we always had that 255 character limit (I tried 
> > to increase it once, but it broke some old lilo setups) 
> > 
> > i386 should be the same btw.
> 
> Its not being truncated at 255 characters, its being truncated at the 
> first space.  This is coming out of parse_args, which dumps '\0's into 
> the command_line as it rips it apart.  We now only have one copy of the 
> command line (in x86_64) instead of two, so we now expose this trashed 
> copy in /proc/cmdline.

I don't see this in my version; so it's likely fixed already. I did quite
a lot of changes on this patch already.

Please test

ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/early-param

-Andi

