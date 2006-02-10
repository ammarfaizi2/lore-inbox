Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWBJNEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWBJNEn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWBJNEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:04:43 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:9373 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751258AbWBJNEm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:04:42 -0500
Subject: Re: preempt-rt, NUMA and strange latency traces
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1139511262.28536.10.camel@cog.beaverton.ibm.com>
References: <1139311689.19708.36.camel@frecb000686>
	 <Pine.LNX.4.58.0602080436190.8578@gandalf.stny.rr.com>
	 <1139395534.21471.13.camel@frecb000686>
	 <1139417369.16302.1.camel@leatherman>
	 <1139483492.5706.12.camel@frecb000686>
	 <1139511262.28536.10.camel@cog.beaverton.ibm.com>
Date: Fri, 10 Feb 2006 14:07:45 +0100
Message-Id: <1139576865.5706.68.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/02/2006 14:05:38,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/02/2006 14:05:42,
	Serialize complete at 10/02/2006 14:05:42
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-09 at 10:54 -0800, john stultz wrote:
> >
> >   I think it's an RSA1 card, but no certainty here. I don't think
> > the x440 came with the RSA2. Is there a way to check for sure without
> > unplugging everything (It's such a mess of cables behind the box)?
> 
> No, you're right, the x445 was the box that could have either RSA1 or
> RSA2. The x440 can only have an RSA1.
> 
> 
> >   Whats the SMI issue with the RSA? Could the RSA generate bursts of SMI
> > that could be enough to freeze the CPUs?
> 
> SMIs effectively freeze all cpus while the BIOS code executes. With the
> RSA1, there are two main causes of SMIs:
> 1) Periodic SMI: Which occurs every 15 minutes as the RSA checks various
> hardware status and lasts for ~30ms.
> 
> 2) Console Redirection SMIs: This occurs only when you use the console
> redirection feature from the RSA. You'll see ~30ms stalls ~once a second
> while the SMI screen-scrapes the console text buffer and sends it out
> over the serial line.

  That must be what I've been hitting in my tests and will check soon.

> 
> The console redirection one is easy to avoid: just don't use that
> feature if you care about low latencies. The periodic SMI is more
> difficult to work around. With RSA2 based systems, there is a BIOS
> update that allows you to disable this functionality (and on newer
> systems it ships disabled), however I don't believe there is any such
> feature for the older RSA1 based systems.

  I'll have to live with it then.

> 
> 
> >   When I ran those tests I was logged on the RSA (serial line). I will
> > try to run the tests again without being connected when I can manage to
> > get some CPU time (eh! shared machine)...
> 
> Yes, not using the console redirection feature will definitly help the
> situation, but there still will be the possibility of ~30ms stalls every
> 15 minutes on the x440.

  That's the problem and I'll have to synchronize for a proper window
for running my tests.

  Is this SMI thing IBM's eyes only stuff or is it documented somewhere?


  Thanks for that valuable info.

  Sébastien.



