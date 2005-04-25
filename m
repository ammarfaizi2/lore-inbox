Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVDYRdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVDYRdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVDYRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 13:33:03 -0400
Received: from smarthost4.mail.uk.easynet.net ([212.135.6.14]:17669 "EHLO
	smarthost4.mail.uk.easynet.net") by vger.kernel.org with ESMTP
	id S262728AbVDYR3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 13:29:06 -0400
Message-ID: <426D28B5.8050207@treblig.org>
Date: Mon, 25 Apr 2005 18:28:21 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040804
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jschopp@austin.ibm.com
CC: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Hotplug CPU and setaffinity?
References: <20050423173514.GA7111@gallifrey> <20050423182227.GE18688@otto> <20050424123501.GB7111@gallifrey> <426D1402.5050509@austin.ibm.com>
In-Reply-To: <426D1402.5050509@austin.ibm.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-TL-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Schopp wrote:

> On ppc64 we have CPU guard, which would remove a processor if it is 
> failing.  Of course, the implications of not removing such a CPU are 
> pretty terrible.

Indeed.

>>>> In particular I was thinking of the cases where a thread has a
>>>> functional reason for remaining on one particular CPU (e.g. if you
>>>> had calibrated for some feature of that CPU say its time stamp
>>>> counter skew/speed). Another case would be a set of threads which
>>>> had set their affinity to the same CPU and then made memory
>>>> consistency or locking assumptions that wouldn't be valid
>>>> if they got rescheduled onto different CPUs.
> 
> 
> This sounds like a theoretical problem.  Can you think of any real 
> examples?  The only cases I can think of cause performance hits, but not 
> functional problems.

Well I'm not aware of anything that currently would break with it; but I 
was gently thinking of whether it would be possible to read cycle 
counters (as a faster gettimeofday) even on systems which had 
unsynchronised counters if you could lock the thread that did it to a 
particular physical cpu.
But this behaviour currently makes that a bad idea; in this case it 
would be nicer if the kernel either just killed my process or just 
unscheduled it or sent it a signal.

Dave
