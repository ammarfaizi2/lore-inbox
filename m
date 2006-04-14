Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWDNQIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWDNQIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 12:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDNQIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 12:08:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59297 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751256AbWDNQIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 12:08:09 -0400
Date: Fri, 14 Apr 2006 17:07:56 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc1-mm1
Message-ID: <20060414160756.GG10725@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org> <20060413073958.GB9428@osiris.boeblingen.de.ibm.com> <20060413011303.668fe5c1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413011303.668fe5c1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 01:13:03AM -0700, Andrew Morton wrote:
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >
> > > +md-dm-reduce-stack-usage-with-stacked-block-devices.patch
> > >  MD update.
> > 
> > Any chance to see this merged? I think this one is pending for quite a while.
 
I looked at this in detail last month, hoping to get it
out of the way, but unfortunately found that, in dm-crypt:

  Instead of the stack growing, we'll be allocating successive
  bios out of the *same* mempool and, without the recursion, we'll
  have lost the possibility of a later allocation waiting for an
  earlier one to be released after its endio.

In other words, I think part of dm-crypt needs re-writing to avoid problems
under memory pressure after this patch is applied.  And on the face of it,
__clone_and_map() may suffer from similar problems should a bio need to be
split into several pieces.

Alasdair
-- 
agk@redhat.com
