Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVFHQBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVFHQBS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVFHQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:01:17 -0400
Received: from reserv5.univ-lille1.fr ([193.49.225.19]:17383 "EHLO
	reserv5.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261338AbVFHP43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:56:29 -0400
Message-ID: <42A714B7.8010105@lifl.fr>
Date: Wed, 08 Jun 2005 17:54:31 +0200
From: Eric Piel <Eric.Piel@lifl.fr>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "Paul E. McKenney" <paulmck@us.ibm.com>
CC: linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, karim@opersys.com, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org
Subject: Re: Attempted summary of "RT patch acceptance" thread
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-MailScanner-From: eric.piel@lifl.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney said:
> Hello!
> 
> Midway through the recent "RT patch acceptance" thread, someone mentioned
> that it might be good to summarize the various approaches.  The following
> is an attempt to do just this, with an eye to providing a reasonable
> framework for future discussion.
> 
> Thoughts?  Errors?  Omissions?

Hi Paul,

I haven't yet gone through all your email in detail but it seems very 
well documented and precise.

I'd like to add some information about your section "7.  Migration 
Within OS". I've now been working for more than a year on a project 
called ARTiS which precisely implements this approach. A announced was 
recently posted on the LKML :-) . You can find more information in this 
tread : http://lkml.org/lkml/2005/5/3/50 as well on our webpage 
www.lifl.fr/west/artis .

Concerning the QoS, we have been able to obtain hard realtime, at least 
very firm real-time. Tests were conducted over 8 hours on IA-64 and x86 
and gave respectively 105µs and 40µs of maximum latency. Not as good as 
you have mentioned but mostly of the same order :-)

Concerning the "e. fault isolation", on our implementation, holding a 
lock, mutex or semaphore will automatically migrate the task, therefore 
it's not a problem. Of course, some parts of the kernel that cannot be 
migrated might take a lock, namely the scheduler. For the scheduler, we 
modified most of the data structures requiring a lock so that they can 
be accessed locklessly (it's the hardest part of the implementation).

Concerning the weaknesses, one point that you didn't mention is the 
difficulty to fully load the realtime dedicated CPUs. Tasks tends to 
migrate more away from the RT CPUs than they come back. In ARTiS, a 
modification of the load-balancer permits to keep most of the power but 
there is still probably some loss. Concerning the migration overhead, 
there must be some, but it's not very big and quite difficult to 
measure. Actually, the migration itself is light in CPU usage, the 
problem is that it unschedules the task so that it might take some time 
before the task is scheduled again (but if there is enough load on the 
computer, we lose mostly nothing).

Finally, as you pointed out, one major requirement is obiously to have 
several CPUs. Luckily, SMT and dual core processors are more and more 
common (ARTiS was succesfully tested on Pentium HT). Still, in the 
embedded market this is not so usual, so that's a weakeness point if you 
target very devices. Our implementation is oriented toward big 
applications that requires both RT properties and high performance 
(that's why it was developped on IA-64).

That's my 2 cents for your summary :-)

Eric

PS: please CC me when replying to the lkml.
