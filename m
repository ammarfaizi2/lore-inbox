Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRDQM2f>; Tue, 17 Apr 2001 08:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDQM2Z>; Tue, 17 Apr 2001 08:28:25 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:18546 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S132539AbRDQM2S>; Tue, 17 Apr 2001 08:28:18 -0400
Date: Tue, 17 Apr 2001 07:28:17 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200104171228.HAA00656@tomcat.admin.navo.hpc.mil>
To: lsawyer@gci.com, Ian Stirling <root@mauve.demon.co.uk>,
        linux-kernel@vger.kernel.org
Subject: RE: IP Acounting Idea for 2.5
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Leif Sawyer <lsawyer@gci.com>:
> > From: Ian Stirling [mailto:root@mauve.demon.co.uk]
> > > Manfred Bartz responded to
> > > > Russell King <rmk@arm.linux.org.uk> who writes:
> > <snip>
> > > > You just illustrated my point.  While there is a reset capability
> > > > people will use it and accounting/logging programs will get wrong
> > > > data.  Resetable counters might be a minor convenience 
> > when debugging
> > > > but the price is unreliable programs and the loss of the 
> > ability of
> > > > several programs to use the same counters.
> > > 
> > > You of course, are commenting from the fact that your 
> > applications are
> > > stupid, written poorly, and cannot handle 'wrapped' data.  Take MRTG
> > <snip>
> > > Similarly, if my InPackets are at 102345 at one read, and 
> > 2345 the next
> > > read,
> > > and I know that my counter is 32 bits, then I know i've 
> > wrapped and can do
> > 
> > I think the point being made is that if InPackets are at 
> > 102345 at one read,
> > and 2345 the next, and you know it's a 32 bit counter, it's completely
> > unreliable to assume that you have in fact recieved 4294867295
> > packets, if the counter can be zeroed.
> > You can say nothing other than at least 2345 packets, at most 
> > 2345+n*2^32 have been got since you last checked.
> 
> Ah, yes.. I seem to have misplaced a bit of text in my reply.
> 
> The continuation of thought:
> 
> How the application derives the status of a wrapped counter or
> a zero'ed counter is dependant on the device being monitored.
> 
> Yes, you have to know what your interface is capable of (maxbytes/sec)
> so that you can do a simple calculation where:
> 
> maximum_throughput = maxbytes_sec * (time_now - time_last_read)
> 
> and if your previous good counter + the maximum throughput wraps the
> counter, you have a good chance that you've simply wrapped.
> 
> If not, then you can assume that your counters were cleared at some point,
> log the data you've got, and keep moving forward.

And that introduces errors in measurement. It also depends on how frequently
an uncontroled process is clearing the counters. You may never be able to
get a valid measurement.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
