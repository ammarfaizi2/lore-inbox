Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTIXAPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbTIXAPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 20:15:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59314 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261162AbTIXAPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 20:15:00 -0400
Date: Wed, 24 Sep 2003 01:14:56 +0100
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, willy@debian.org, schwab@suse.de,
       bcrl@kvack.org, tony.luck@intel.com, davidm@hpl.hp.com,
       davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au, ak@suse.de,
       iod00d@hp.com, peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030924001456.GI13172@parcelfarce.linux.theplanet.co.uk>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org> <jehe3372th.fsf@sykes.suse.de> <20030923115200.1f5b44df.davem@redhat.com> <20030923192804.GG13172@parcelfarce.linux.theplanet.co.uk> <20030923122200.258215a3.davem@redhat.com> <20030923161529.5203ce4d.akpm@osdl.org> <20030923163744.4b9bb4c7.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923163744.4b9bb4c7.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 04:37:44PM -0700, David S. Miller wrote:
> > >  Not only sparc would be effected by this.  Using {get,put}_unaligned()
> > >  all over the networking would incur a penalty for many platforms, not
> > >  just sparc.
> > 
> > Really?  I'd have thought that get/put_unaligned would be a simple
> > load/store for architectures which wish to implement it in that manner.
> 
> Only on systems that have the "load upper/lower-unaligned"
> instructions.  On others it's a memmove().

It is at the moment, but why should it be?  Why can't it be implemented
as load-and-trap if that's the fastest way to do it?

(I can see this descending into get_unaligned_likely() and
get_aligned_unlikely() which i'd rather avoid ...)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
