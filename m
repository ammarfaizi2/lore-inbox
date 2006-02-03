Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWBCECY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWBCECY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 23:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWBCECY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 23:02:24 -0500
Received: from sitemail2.everyone.net ([216.200.145.36]:12973 "EHLO
	omta16.mta.everyone.net") by vger.kernel.org with ESMTP
	id S964781AbWBCECY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 23:02:24 -0500
X-Eon-Dm: dm18
X-Eon-Sig: AQHOS7ND4tXLhOJQ5wIAAAAF,956835e07a88ba19eb86599809156abe
Date: Thu, 2 Feb 2006 23:00:18 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, sds@epoch.ncsc.mil,
       jmorris@namei.org
Subject: Re: Size-128 slab leak
Message-ID: <20060203040018.GA3757@double.lan>
References: <20060131024928.GA11395@double.lan> <20060201231001.0ca96bf0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201231001.0ca96bf0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 11:10:01PM -0800, Andrew Morton wrote:
> "Kevin O'Connor" <kevin@koconnor.net> wrote:
> >
> > I have an annoying slab leak on my kernel.  Every day, I lose about
> >  50Megs of memory to the leak.  It seems to be related to disk
> >  accesses, because the count only goes up noticeable around 4:00am when
> >  the system locate utility runs.
> > 
> >  I can tell there is a leak because /proc/slabinfo shows "size-128"
> >  growing continuously.  For example, it currently reads:
>
> -mm kernels have a patch (slab-leak-detector.patch) which will help. 
> Here's a version for 2.6.16-rc1.  It requires CONFIG_DEBUG_SLAB.  Thanks.

Thanks Andrew.

I've applied the patch and found the leak.  It's in kzalloc.  :-)

With kzalloc inlined, however, it appears that selinux is the likely
culprit.  I would not have expected that.

After running updatedb I got 23530 occurrences of:

kernel: obj ffff81003f04f000/12: ffffffff801ed7b7 <selinux_inode_alloc_security+0x37/0x100>

I'm not sure how to debug selinux issues, but at least I can disable
it.

-Kevin
