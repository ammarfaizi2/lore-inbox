Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbVIRLh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbVIRLh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 07:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVIRLh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 07:37:59 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:48613 "HELO
	develer.com") by vger.kernel.org with SMTP id S1751173AbVIRLh7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 07:37:59 -0400
Message-ID: <432D517F.2000604@develer.com>
Date: Sun, 18 Sep 2005 13:37:35 +0200
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Development discussions related to Fedora Core 
	<fedora-devel-list@redhat.com>,
       Nalin Dahyabhai <nalin@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: RFA: Changing scheduler quantum (Was: REQUEST: OpenLDAP 2.3.7)
References: <432B9F4A.6070805@develer.com> <1126982265.3010.12.camel@localhost.localdomain> <432CBABC.8090906@develer.com> <20050918013247.GA31974@devserv.devel.redhat.com> <432CD09A.2060201@develer.com> <20050918110524.GA23910@devserv.devel.redhat.com>
In-Reply-To: <20050918110524.GA23910@devserv.devel.redhat.com>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=FC6A66CA;
	url=https://www.develer.com/~bernie/gpgkey.txt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> On Sun, Sep 18, 2005 at 04:27:38AM +0200, Bernardo Innocenti wrote:
> 
>>It's more meaningful to interpret sched_yield() as "give up the processor,
>>as if the scheduler quantum had expired".
> 
> afaik this is *exactly* what the new sched_yield() does ;)

Oops :-)


>>The scheduler wouldn't normally allow a lower priority process to
>>preempt a high-priority ready process for 30+ ms.  Unless I'm
>>mistaken about Linux's scheduling policy...
> 
> if your quantum is up... all other tasks get theirs of course

I assumed dynamic priorities affected the length of the
quantum, but maybe it just changes the number of times
the process is scheduled wrt other processes, with the
quantum being fixed at 20-30ms.

(...a few seconds later...)

Skimming through sched.c, it seems my first guess was
right: the quantum varies with the priority from 5ms
to 800ms.

The DEF_TIMESLICE of 400ms looks a bit too gross for
most applications and the maximum 800ms is just
ridicolously high.

IIRC, the 7.14MHz 68000 in the Amiga 500 did task-switching
at 20ms intervals, with a negligible performance hit.
Couldn't do much better on today's CPUs?

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

