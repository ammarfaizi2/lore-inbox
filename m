Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVDADez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVDADez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 22:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbVDADez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 22:34:55 -0500
Received: from mail.cs.wm.edu ([128.239.2.107]:42431 "EHLO mail.cs.wm.edu")
	by vger.kernel.org with ESMTP id S261526AbVDADey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 22:34:54 -0500
Date: Thu, 31 Mar 2005 22:34:52 -0500
From: "Serge E. Hallyn" <hallyn@cs.wm.edu>
To: Chris Wright <chrisw@osdl.org>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: LSM hooks
Message-ID: <20050401033452.GA16549@escher.cs.wm.edu>
References: <424B78F9.2040606@comcast.net> <20050331062843.GR28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331062843.GR28536@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Wright (chrisw@osdl.org):
> * John Richard Moser (nigelenki@comcast.net) wrote:
> > So, Which version of Linux will first implement stacking in LSM as per
> > Serge Hallyn's patches?
> 
> None are ready yet.  Serge is still wading through performance testing.
> There's no telling about merging without a magic eightball, a handle on
> the performance issues, and some bonafide users.

Oh, just to keep anyone interested up to date:  It turns out nearly all
of the inordinate performance degredation I was seeing in the last set
of results which I reported was due to a prefetch weirdness on my ppc64
test system.  In particular, the hlist_for_each_entry macro automatically
prefetches tmp->next.  Since my tests were done with selinux+capability,
it was the case that tmp->next was always NULL (which always causes a
bad prefetch case on ppc64) and, to boot, never used, since the
comparison inside the loop always succeeded and immediately returned
the first entry.

A new set of results should hopefully be coming next week.

-serge
