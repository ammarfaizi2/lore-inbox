Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271957AbRH2M7j>; Wed, 29 Aug 2001 08:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271958AbRH2M73>; Wed, 29 Aug 2001 08:59:29 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:64547 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S271957AbRH2M7K>; Wed, 29 Aug 2001 08:59:10 -0400
Date: Wed, 29 Aug 2001 07:58:07 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200108291258.HAA66579@tomcat.admin.navo.hpc.mil>
To: VDA@port.imtp.ilyichevsk.odessa.ua, Jesse Pollard <jesse@cats-chateau.net>
Subject: Re: Shutting down NFS
CC: linux-kernel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VDA <VDA@port.imtp.ilyichevsk.odessa.ua>:
> Hello Jesse,
> 
> Tuesday, August 28, 2001, 4:42:48 AM, you wrote:
> JP> On Mon, 27 Aug 2001, VDA wrote:
> >>...
> >>  killall5 -15; sleep 2; killall5 -9:
> >>    1st run - nothing
> >>    2nd run - nfsd dies
> >>    3rd run - lockd/statd die
> >>    (This is strange. Complicates shutdown script)
> 
> JP> You are using 2 second delay, which might be a bit short, but not unreasonable.
> 
> I have tested this not by shutting down my system but by running a
> test script, watching "ps -AH e" after each run.
> After first run of "killall5 -15; sleep 2; killall5 -9" NFS daemons
> DON'T die at all. After second run only nfsd dies. Only third run
> kills lockd and statd. It does not matter how long I wait between
> runs. (however I didn't wait for minutes. Do you want me to try it?)
> Am I supposed to do the same in shutdown script, i.e.
> 
> killall5 -15; sleep 5; killall5 -9; sleep 5
> killall5 -15; sleep 5; killall5 -9; sleep 5
> killall5 -15; sleep 5; killall5 -9 ?
> 
> This looks ugly and total sleep time is 25 sec.
> A better way is to make NFS daemons understand what user wants after
> first call, not a third.

This already looks like overkill :-) Only the first one should be
needed. I can understand that NFSD could disable signal 15, but not
how it can disable 9... The only way I know for that to happen is
if the process is in an uninterruptable sleep for some reason (and
that should only delay signal delivery, not eliminate it).

I'll have to look at the sources  to get more details.

Everything else looks reasonable (even with a two second sleep).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
