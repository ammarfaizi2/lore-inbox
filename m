Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVCDGHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVCDGHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVCDGHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:07:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:41890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbVCDGHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:07:08 -0500
Date: Thu, 3 Mar 2005 22:06:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: olof@austin.ibm.com, paulus@samba.org, jgarzik@pobox.com,
       rene@exactcode.de, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       greg@kroah.com, chrisw@osdl.org
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/
 Altivec
Message-Id: <20050303220631.79a4be7b.akpm@osdl.org>
In-Reply-To: <20050304055451.GN5389@shell0.pdx.osdl.net>
References: <422751D9.2060603@exactcode.de>
	<422756DC.6000405@pobox.com>
	<16935.36862.137151.499468@cargo.ozlabs.ibm.com>
	<20050303225542.GB16886@austin.ibm.com>
	<20050303175951.41cda7a4.akpm@osdl.org>
	<20050304022424.GA26769@austin.ibm.com>
	<20050304055451.GN5389@shell0.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Olof Johansson (olof@austin.ibm.com) wrote:
> > Hi,
> > 
> > On Thu, Mar 03, 2005 at 05:59:51PM -0800, Andrew Morton wrote:
> > > This patch doesn't seem right - current 2.6.11 has:
> > > 
> > >         return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
> > 
> > The patch was against what Greg had already pushed into the
> > linux-release.bkbits.net 2.6.11 tree, i.e. not what's in mainline.
> > You're right, your revised patch would apply against mainline.
> > 
> > However: This patch shouldn't go to mainline, since
> > ppc-ppc64-abstract-cpu_feature-checks.patch in your tree takes care of
> > the problem. I'd like the abstraction/cleanup patch to be merged upstream
> > instead of the #ifdef hack once the tree opens up.
> 
> Olof's patch is in the linux-release tree, so this brings up a point
> regarding merging.  If the quick fix is to be replaced by a better fix
> later (as in this case) there's some room for merge conflict.  Does this
> pose a problem for either -mm or Linus' tree?

It depends who gets to Linus's tree first.  If linux-release merges first,
I just revert the temp fix while adding the real fix.  But the temp fix
should never have gone into Linus's tree in the first place.

If I merge before linux-release, I guess Linus has some conflict resolving
to do when he pulls from linux-release.  That's OK for an obvious
two-liner, but would get out of control for more substantial things.

Neither solution is acceptable, really.  I suspect the idea of pulling
linux-release into mainline won't work very well, and that making it a
backport tree would be more practical.
