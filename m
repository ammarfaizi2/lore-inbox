Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263133AbUCSXKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUCSXKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:10:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:18172 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263133AbUCSXKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:10:25 -0500
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@muc.de>
Cc: LKML <linux-kernel@vger.kernel.org>, pj@sgi.com
In-Reply-To: <m37jxhvbgm.fsf@averell.firstfloor.org>
References: <1BeOx-7ax-55@gated-at.bofh.it> <1BgGq-DU-5@gated-at.bofh.it>
	 <1BgZN-Vk-1@gated-at.bofh.it>  <m37jxhvbgm.fsf@averell.firstfloor.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1079737773.17841.67.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 19 Mar 2004 15:09:33 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 18:04, Andi Kleen wrote:
> Matthew Dobson <colpatch@us.ibm.com> writes:
> 
> >> Chris Hellwig responded to it at the time asking why I didn't provide a
> >> single generic mask ADT, and make cpumask and nodemask instances of
> >> that.
> >
> > That is a better idea, if it can be made to work.  My goal is to stop
> 
> It already exists in linux/bitmap.h. I use that in NUMA API for the node masks.
> 
> It's just a bit ugly to write because you have to always pass MAX_NUMNODES.
> Some wrappers would be prettier.
> 
> -Andi

For MAX_NUMNODES > BITS_PER_LONG, thats just what these are.  There are
just built-in optimizations for the single bit (UP for cpumask, non-NUMA
for nodemask) case and the single unsigned long case.  For the case of a
single unsigned long, the bitmap operations aren't as efficient as just
doing a 
	res = (mask1 & mask2);
vs. 
	bitmask_and(&res, &mask1, &mask2);

Maybe I'm overly concerned about the speed of these ops at the expense
of code size.  If that's the consensus, I'll gladly look at a simpler
implementation.  As I said, my only real goal is to stop people open
coding these types of operations.

-Matt

