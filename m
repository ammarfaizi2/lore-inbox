Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVKORcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVKORcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVKORcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:32:19 -0500
Received: from hera.kernel.org ([140.211.167.34]:3742 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751454AbVKORcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:32:18 -0500
Date: Tue, 15 Nov 2005 10:20:35 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
Message-ID: <20051115122035.GB32373@logos.cnet>
References: <43796596.2010908@watson.ibm.com> <20051114202017.6f8c0327.akpm@osdl.org> <20051115064954.GB31904@logos.cnet> <4379FC75.80704@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4379FC75.80704@watson.ibm.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 10:19:17AM -0500, Shailabh Nagar wrote:
> Marcelo Tosatti wrote:
> > On Mon, Nov 14, 2005 at 08:20:17PM -0800, Andrew Morton wrote:
> > 
> >>Shailabh Nagar <nagar@watson.ibm.com> wrote:
> >>
> >>>+	*ts = sched_clock();
> >>
> >>I'm not sure that it's kosher to use sched_clock() for fine-grained
> >>timestamping like this.  Ingo had issues with it last time this happened?  

Maybe Ingo had some other issue other than !use_rtc ? Better check.

> > If the system boots with use_rtc == 0 you're going to get jiffies based
> > resolution from sched_clock(). I have a 1GHz Pentium 3 around here which
> > does that.
> 
> Good point, thanks. This reemphasizes the need for better normalization
> at output time.

> > Maybe use do_gettimeofday() for such systems?
> 
> Perhaps getnstimeofday() so resolution isn't reduced to msec level unnecessarily.
> In these patches, userspace takes responsibility for handling wraparound so
> delivering a reasonably high-resolution delay data from the kernel is preferable.
> 
> > 
> > Would be nice to have a sort of per-arch overridable "gettime()" function?
> > 
> 
> Provided as part of this patch ?

Yep, think so. My comment meant that its nice to hide away architecture 
speficic code from generic code, so you don't have to add #ifdef's and 
such.

Not sure about the nicer way to do that.

