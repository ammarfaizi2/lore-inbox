Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSHIR5z>; Fri, 9 Aug 2002 13:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSHIR5y>; Fri, 9 Aug 2002 13:57:54 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:6851 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315437AbSHIR5y>;
	Fri, 9 Aug 2002 13:57:54 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <1028884665.28882.173.camel@irongate.swansea.linux.org.uk>
References: <1028771615.22918.188.camel@cog> 
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk> 
	<1028860246.1117.34.camel@cog> 
	<1028884665.28882.173.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Aug 2002 10:46:53 -0700
Message-Id: <1028915214.1117.46.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 02:17, Alan Cox wrote:
> On Fri, 2002-08-09 at 03:30, john stultz wrote:
> > Not sure I followed that, do you mean per-cpu TSC management for
> > gettimeofday? 
> 
> We have some x86 setups where people plug say a 300MHhz and a 450MHz
> celeron into the same board. This works because they are same FSB,
> different multiplier (works and intel certify being two different
> things)

Oh yes, with the old NUMAQ hardware here, one can mix nodes of different
speed cpus. Once I get a chance, I'm going to begin working on this
issue for 2.5. My plan right now is to keep per-cpu last_tsc_low and 
fast_gettimeoffset_quotient values, then round robin the timer
interrupt. 

 
> Needless to say tsc does not work well on such boxes. Thats why I don't
> trust the tsc at all in such cases. Since you'll have the nice cyclone
> timer for the Summit it seems best not to trust it, and on the summit to
> use the cyclone for udelay as well ?
> 
> I agree dodgy_tsc needs to change name. Perhaps we actually want
> 
> 	int tsc = select_tsc();
> 
> 	switch(tsc)
> 	{
> 		case TSC_CYCLONE:
> 		case TSC_PROCESSOR:
> 		case TSC_NONE:
> 		..
> 	}

Sounds good. I'll re-work my patch and resubmit. 

thanks!
-john

