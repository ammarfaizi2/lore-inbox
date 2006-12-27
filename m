Return-Path: <linux-kernel-owner+w=401wt.eu-S1754694AbWL0RyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbWL0RyN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbWL0RyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:54:13 -0500
Received: from homer.mvista.com ([63.81.120.158]:59079 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754694AbWL0RyN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:54:13 -0500
Subject: Re: [PATCH -rt] disconnect warp check from hrtimers
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20061227173957.GA18900@elte.hu>
References: <20061227172828.998757000@mvista.com>
	 <20061227173957.GA18900@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 09:53:30 -0800
Message-Id: <1167242010.14081.31.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 18:39 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > These calls were getting inconsistent wrt. the xtime_lock. The 
> > xtime_lock should be held when doing the warp check update, and 
> > interrupts should be off.
> 
> thanks, applied. Does this solve some warnings that you saw trigger?

I saw some unexplained time warping while using the source at this url,

http://www.atnf.csiro.au/people/rgooch/benchmarks/linux-scheduler.html

it was on an older 2.6.18 based -rt .. The system would print the time
warp warning, then hang .. I applied something similar to the patch I
just sent, and the time warp warning was gone but the system still hung.

New -rt version don't hang, and I don't see the warning .. However, I
suspect the time warp warning was a side effect of the hang..

The system hang was resolved by changing the irq threads to all prio
50 ..

Daniel

