Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267539AbSLLWaq>; Thu, 12 Dec 2002 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbSLLWap>; Thu, 12 Dec 2002 17:30:45 -0500
Received: from mail.zmailer.org ([62.240.94.4]:13267 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S267535AbSLLWan>;
	Thu, 12 Dec 2002 17:30:43 -0500
Date: Fri, 13 Dec 2002 00:38:30 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andreani Stefano <stefano.andreani.ap@h3g.it>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Kernel bug handling TCP_RTO_MAX?
Message-ID: <20021212223830.GH32122@mea-ext.zmailer.org>
References: <047ACC5B9A00D741927A4A32E7D01B73D66176@RMEXC01.h3g.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <047ACC5B9A00D741927A4A32E7D01B73D66176@RMEXC01.h3g.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 08:15:42PM +0100, Andreani Stefano wrote:
> Problem: I need to change the max value of the TCP retransmission timeout. 
...
> #define TCP_RTO_MAX	((unsigned)(6*HZ)) //It was: ((unsigned)(120*HZ))
> 
> Then I recompiled the kernel, rebooted the machine and tested the 
> solution. The result I obtained was the same I had before this 
> modification. 

  Oh, you want to cap the retransmit time to 6 seconds so that
  TCP works (at least somehow) in a terribly lossy network ?

  Having that _low_ value at it isn't advisable in the general
  internet, but these modern mobile networks with paketized data
  are pain with dramatically varying latencies.  TCP works
  badly in such environments.  X.25 works better - to a degree..


  Changeing the value, and doing "make clean; make bzImage"
  should give you a kernel with it in.


..
> Could it be a bug on the RTO calculation algorithm, or there is 
> something I mistook?

  Possibly omitting "make clean" -- short-cutting it can be done
  by:  "rm net/ipv4/*.o"   I think..

> This is the first time I get into the linux kernel, so please be 
> patient!
> 
> Thanks,
> Stefano.
> -------------------------------
>         Stefano Andreani
>     Freelance ICT Consultant
>       H3G IOT Team - Italy
>       tel. +39 347 8215965
>    stefano.andreani.ap@h3g.it

/Matti Aarnio  
