Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbTJHTQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTJHTQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:16:40 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47561 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261755AbTJHTQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:16:38 -0400
Subject: Re: [PATCH] Time precision, adjtime(x) vs. gettimeofday
From: john stultz <johnstul@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031008112510.06ae1ebd.shemminger@osdl.org>
References: <1065619951.25818.15.camel@gaston>
	 <20031008112510.06ae1ebd.shemminger@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065640261.1033.90.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Oct 2003 12:11:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 11:25, Stephen Hemminger wrote:
> On Wed, 08 Oct 2003 15:32:31 +0200
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > That means that if, for example, adjtimex was called with a factor
> > that is trying to slow you down a bit, and you call gettimeofday
> > right before the end of a jiffy period, you may calculate an offset
> > based on the HW timer that is actually higher than what will be
> > really added to xtime on the next interrupt.
[snip]
> The following will prevent adjtime from causing time regression.
> It delays starting the adjtime mechanism for one tick, and 
> keeps gettimeofday inside the window.

Hmm. Looks good to me. If we're losing ticks, it would make time
stair-step somewhat, but it doesn't seem to affect the actual time
accumulation. 

thanks
-john



