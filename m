Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbVHZD3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbVHZD3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 23:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbVHZD3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 23:29:40 -0400
Received: from web33303.mail.mud.yahoo.com ([68.142.206.118]:55217 "HELO
	web33303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751437AbVHZD3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 23:29:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=n2JWPm004+/7UrGzCxnzyTUTZLUtB2Gms1qmadV7jdND6kRyxevkwSmpzEQSO2ausUsLL53lgkZrx6PF9pu8Wzbfb+4FGkmgcokcgZojliq9Id4vJHY66+ImtZOYUH7m+kkjP46WSTU+CycSlk0Fvr+Z7oyiEwI69J8dphEwUnY=  ;
Message-ID: <20050826032938.59796.qmail@web33303.mail.mud.yahoo.com>
Date: Thu, 25 Aug 2005 20:29:38 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Ben Greear <greearb@candelatech.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <430D620A.6050204@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ben Greear <greearb@candelatech.com> wrote:

> Danial Thom wrote:
> > 
> > --- Ben Greear <greearb@candelatech.com>
> wrote:
> > 
> > 
> >>Danial Thom wrote:
> >>
> >>
> >>>I think the concensus is that 2.6 has made
> >>
> >>trade
> >>
> >>>offs that lower raw throughput, which is
> what
> >>
> >>a
> >>
> >>>networking device needs. So as a router or
> >>>network appliance, 2.6 seems less suitable.
> A
> >>
> >>raw
> >>
> >>>bridging test on a 2.0Ghz operton system:
> >>>
> >>>FreeBSD 4.9: Drops no packets at 900K pps
> >>>Linux 2.4.24: Starts dropping packets at
> 350K
> >>
> >>pps
> >>
> >>>Linux 2.6.12: Starts dropping packets at
> 100K
> >>
> >>pps
> >>
> >>I ran some quick tests using kernel 2.6.11,
> 1ms
> >>tick (HZ=1000), SMP kernel.
> >>Hardware is P-IV 3.0Ghz + HT on a new
> >>SuperMicro motherboard with 64/133Mhz
> >>PCI-X bus.  NIC is dual Intel pro/1000. 
> Kernel
> >>is close to stock 2.6.11.
> 
> > What GigE adapters did you use? Clearly every
> > driver is going to be different. My
> experience is
> > that a 3.4Ghz P4 is about the performance of
> a
> > 2.0Ghz Opteron. I have to try your tuning
> script
> > tomorrow.
> 
> Intel pro/1000, as I mentioned.  I haven't
> tried any other
> NIC that comes close in performance to the
> e1000.
> 
> > If your test is still set up, try compiling
> > something large while doing the test. The
> drops
> > go through the roof in my tests.
> 
> Installing RH9 on the box now to try some
> tests...
> 
> Disk access always robs networking, in my
> experience, so
> I am not supprised you see bad ntwk performance
> while
> compiling.
> 
> Ben

It would be useful if there were some way to find
out "what" is getting "robbed". If networking has
priority, then what is keeping it from getting
back to processing the rx interrupts? 

Ah, the e1000 has built-in interrupt moderation.
I can't get into my lab until tomorrow afternoon,
but if you get a chance try setting ITR in
e1000_main.c to something larger, like 20K. and
see if it makes a difference. At 200K pps that
would cause an interrupt every 10 packets, which
may allow the routine to grab back the cpu more
often.


Danial

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
