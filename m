Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbSJDJZ1>; Fri, 4 Oct 2002 05:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJDJZ1>; Fri, 4 Oct 2002 05:25:27 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:44528 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S261391AbSJDJZ1>; Fri, 4 Oct 2002 05:25:27 -0400
Subject: Re: [rfc] [patch] kernel hooks
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Michael Grundy <vamsi_krishna@in.ibm.com>,
       suparna <bsuparna@in.ibm.com>, vamsi@linux.ibm.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF2808A5A.15BF3213-ON80256C48.003070FC@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Fri, 4 Oct 2002 10:23:54 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 04/10/2002 10:26:13
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Why do we need a spinlock? We change one byte, we are not concerned
about
>> when exactly that takes effect, only that there are always valid
>> instructions in the pipeline.
>
> Because you are programming for real silicon not for the imaginary
> perfect processor. Read the x86 errata

OK I see what you're getting at here  -you're talking about the XMC
algorithm.

However, I'm not convinced that we will hit E49 in our specific case - we
looked at this some time ago and felt that because we are not altering
instruction length or boundary, and that even if there is a score-boarding
effect on the register value stored, we still wouldn't generate exceptions
from  intermediates. There are apparent  inconsistencies in the
architecture manuals; in the past when I've found these and queried the
processor behaviour with Intel's  microarchitecture guys they've provided
clarification. I'll do the same  here and see what they say. It's no big
deal whatever their response as kernel hooks has two mechanisms: generic,
which is architecturally independent and doesn't use self-modifying code;
and architecturally specific, which does. We can always restrict the IA32
mechanism for processors < P3 to use the generic hook or implement the XMC
algorithm.

Richard




