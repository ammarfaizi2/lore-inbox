Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318174AbSHIHyH>; Fri, 9 Aug 2002 03:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318175AbSHIHyH>; Fri, 9 Aug 2002 03:54:07 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:248 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318174AbSHIHyH>; Fri, 9 Aug 2002 03:54:07 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <1028860246.1117.34.camel@cog>
References: <1028771615.22918.188.camel@cog> 
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk> 
	<1028860246.1117.34.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 10:17:45 +0100
Message-Id: <1028884665.28882.173.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 03:30, john stultz wrote:
> Not sure I followed that, do you mean per-cpu TSC management for
> gettimeofday? 

We have some x86 setups where people plug say a 300MHhz and a 450MHz
celeron into the same board. This works because they are same FSB,
different multiplier (works and intel certify being two different
things)

Needless to say tsc does not work well on such boxes. Thats why I don't
trust the tsc at all in such cases. Since you'll have the nice cyclone
timer for the Summit it seems best not to trust it, and on the summit to
use the cyclone for udelay as well ?

I agree dodgy_tsc needs to change name. Perhaps we actually want

	int tsc = select_tsc();

	switch(tsc)
	{
		case TSC_CYCLONE:
		case TSC_PROCESSOR:
		case TSC_NONE:
		..
	}

Alan

