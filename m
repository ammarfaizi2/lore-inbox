Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbRGOKQF>; Sun, 15 Jul 2001 06:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266044AbRGOKPz>; Sun, 15 Jul 2001 06:15:55 -0400
Received: from over.ny.us.ibm.com ([32.97.182.111]:19137 "EHLO
	over.ny.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266041AbRGOKPn>; Sun, 15 Jul 2001 06:15:43 -0400
Importance: Normal
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Larry McVoy <lm@bitmover.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF0C6F5F92.24F5EA98-ON85256A88.006DDC58@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Fri, 13 Jul 2001 16:17:42 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 07/13/2001 04:17:44 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

> Global scheduling decisions should be triggered in response of load
unbalancing
> and not at each schedule() run otherwise we're going to introduce a
common lock
> that will limit the overall scalability.

Thats correct. Though it beggars the question : who will define
"load-imbalance" and at what granularity ? In the Loadbalancing extensions
to MQ (http://lse.sourceforge.net/scheduling/LB/poolMQ.html) load balancing
is done at a frequency specified at the time the loadbalancing module is
loaded. The parameter can be changed dynamically through a /proc interface.
So we are providing a knob for the user/sysadmin to control the
loadbalancing desired.

> My idea about the future of the scheduler is to have a config options
users can
> chose depending upon the machine use.
> By trying to keep a unique scheduler for both UP and MP is like going to
give
> the same answer to different problems and the scaling factor ( of the
scheduler
> itself ) on SMP will never improve.

That is true to an extent. It would be convenient for us as scheduler
rewriters to have neatly differentiated classes like UP, SMP, BIG_SMP, NUMA
etc. But it forces all other scheduler-sensitive code to think of each of
these cases separately and is exactly the reason why #ifdef's are
discouraged for critical kernel code like the scheduler.

Its certainly a challenge to provide SMP/NUMA scalability in the scheduler
(and elsewhere in the kernel) without having to resort to an #ifdef.

Shailabh



