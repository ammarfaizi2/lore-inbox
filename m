Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVFLFGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVFLFGE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 01:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVFLFGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 01:06:04 -0400
Received: from opersys.com ([64.40.108.71]:11529 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261734AbVFLFF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 01:05:58 -0400
Message-ID: <42ABC523.1020205@opersys.com>
Date: Sun, 12 Jun 2005 01:16:19 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org, sdietrich@mvista.com,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.44.0506112151090.24837-100000@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.44.0506112151090.24837-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Walker wrote:
> My reasoning is that Linux doesn't run in ring 0 . That to me makes linux 
> and ADEOS two different entities. That's my way of looking at it. 
[snip]
> I haven't looked at the code, I would like to . I have read about 
> the ADEOS implementation .

*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*WARNING*

ok, now that I've got the attention of anyone reading this post,
here goes:

The paper entitled "Adaptive Domain Environment for Operating
Systems", which I published in February 2001 presents a design
*PLAN*. The actual implementation is based on this paper, but
differs *SIGNIFICANTLY* from it. Hence, read the paper to
understand how the ipipe works *ONLY*. All this stuff about
ring 0 / ring 1 was *NEVER* implemented.

To understand what's in the current *PATCH*, please read this
instead:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102309348817485&w=2
Here's the relevant passage:
> The complete Adeos approach has been thoroughly documented in a whitepaper
> published more than a year ago entitled "Adaptive Domain Environment
> for Operating Systems" and available here: http://www.opersys.com/adeos
> The current implementation is slightly different. Mainly, we do not
> implement the functionality to move Linux out of ring 0. Although of
> interest, this approach is not very portable.
> 
> Instead, our patch taps right into Linux's main source of control
> over the hardware, the interrupt dispatching code, and inserts an
> interrupt pipeline which can then serve all the nanokernel's clients,
> including Linux.

Again, Adeos does not play *ANY* ring tricks. It just hooks
onto the kernel's *EXISTING* cli/sti/int-delivery mechanisms
using a *PATCH*.

Hope this helps dissipate some misconceptions about what Adeos
is *TODAY*.

P.S.: Sorry Daniel, none of the above emphasis is directed
personally towards you. I just know from talking to quite a
few people that my original paper *CONTINUES* to *MISLEAD*
people about what Adeos currently is. So I just thought I'd
make it clear at this point for those interested.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
