Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTHSIbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 04:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263997AbTHSIbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 04:31:36 -0400
Received: from unthought.net ([212.97.129.24]:22198 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263990AbTHSIbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 04:31:34 -0400
Date: Tue, 19 Aug 2003 10:31:32 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: David Schwartz <davids@webmaster.com>, Mike Fedyk <mfedyk@matchmail.com>,
       Hank Leininger <hlein@progressive-comp.com>,
       linux-kernel@vger.kernel.org
Subject: Proposal (was: Why are exceptions such as SIGSEGV not logged)
Message-ID: <20030819083131.GB28162@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	David Schwartz <davids@webmaster.com>,
	Mike Fedyk <mfedyk@matchmail.com>,
	Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org
References: <MDEHLPKNGKAHNMBLJOLKIEFLFDAA.davids@webmaster.com> <200308190654.h7J6sIL07040@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200308190654.h7J6sIL07040@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 09:54:17AM +0300, Denis Vlasenko wrote:
> On 19 August 2003 01:39, David Schwartz wrote:
...[snip]...
> > 	This is a perfectly sensible thing for a program to do with well-defined
> > semantics. If a program wants to create a child every minute like this and
> > kill it, that's perfectly fine. We should be able to do that in the default
> > configuration without a sysadmin complaining that we're DoSing his syslogs.
> 
> I disagree. _exit(2) is the most sensible way to terminate.
> 
> Logginh kernel-induced SEGVs and ILLs are definitely a help when you hunt
> daemons mysteriously crashing. This outweighs DoS hazard.


Ok guys - we will never come to an agreement on what would be the
sensible thing to do.

For good reasons, too: the purposes and uses of the systems out there,
and the minds of the people administering them, will be as different as
anything.

This reminds me of the "core naming wars", the "vm overcommit wars", and
other "big" (in the minds of people) issues that were solved to
everyones satisfaction with an entry in /proc.

May I suggest:
  /proc/sys/kernel/log_signals

Semantics:  Numbers can be written to log_signals - these are signal
numbers that will cause a log entry to be written, when the given signal
is delivered. The file can be read, in which case it will list the
signal numbers that cause log entries to be written.

Examples:

]$ cat /proc/sys/kernel/log_signals
   4
   7
]$ echo +15 > /proc/sys/kernel/log_signals
]$ cat /proc/sys/kernel/log_signals
   4
   7
   15
]$ echo -4 > /proc/sys/kernel/log_signals
]$ cat /proc/sys/kernel/log_signals
   7
   15
]$

Possible extension:

]$ echo '*' > /proc/sys/kernel/log_signals
]$ cat /proc/sys/kernel/log_signals
 ... lists all signals ...
]$ echo '-*' > /proc/sys/kernel/log_signals
]$ cat /proc/sys/kernel/log_signals
]$


In my oppinion it does not make sense to distinguish between signals
sent from process to process, and from kernel to process.  Some garbage
collectors, for example, depend on the kernel sending the SIGSEGV and do
their own handling of that - while for many other processes that
situation indicates a problem.   Better to handle that kind of thing in
user space log auditing tools.

An implementation of the above is left as an exercise for the reader  :)

Comments?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
