Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVKOMBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVKOMBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 07:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVKOMBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 07:01:00 -0500
Received: from hera.kernel.org ([140.211.167.34]:45442 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932372AbVKOMA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 07:00:59 -0500
Date: Tue, 15 Nov 2005 04:49:54 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Message-ID: <20051115064954.GB31904@logos.cnet>
References: <43796596.2010908@watson.ibm.com> <20051114202017.6f8c0327.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114202017.6f8c0327.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 08:20:17PM -0800, Andrew Morton wrote:
> Shailabh Nagar <nagar@watson.ibm.com> wrote:
> >
> > +	*ts = sched_clock();
> 
> I'm not sure that it's kosher to use sched_clock() for fine-grained
> timestamping like this.  Ingo had issues with it last time this happened?  

If the system boots with use_rtc == 0 you're going to get jiffies based
resolution from sched_clock(). I have a 1GHz Pentium 3 around here which
does that.

Maybe use do_gettimeofday() for such systems?

Would be nice to have a sort of per-arch overridable "gettime()" function?

> <too lazy to read all the code> Do you normalise these numbers in some
> manner before presenting them to userspace?  If so, by what means?
