Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318210AbSHNNbM>; Wed, 14 Aug 2002 09:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSHNNbM>; Wed, 14 Aug 2002 09:31:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49391 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318210AbSHNNbL>; Wed, 14 Aug 2002 09:31:11 -0400
Subject: Re: [RFC] timer-changes_A0
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>
In-Reply-To: <1029283137.4692.119.camel@cog>
References: <1029283137.4692.119.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 14 Aug 2002 14:32:54 +0100
Message-Id: <1029331974.26358.42.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 00:58, john stultz wrote:
> where you have clock_tsc.c, clock_pit.c, clock_cyclone.c etc. Each one
> implementing init_clock_xxxx, mark_timeoffset_xxxx, and
> do_gettimeoffset_xxxx (possibly probing functions too?).  But for now I
> just kept it all in time.c 

Longer term a struct timer_ops would indeed be really clean. Splitting
it makes sense

>  }
>  
> +enum clock_type {CLOCK_PIT, CLOCK_TSC};
> +enum clock_type select_clock(void)
> +{
> +	if(cpu_has_tsc)
> +		return CLOCK_TSC;
> +	return CLOCK_PIT;
> +}

I put this in setup.c in my case so I could also cover the VISWS more
nicely, and also because of the 2.5 plans to do a nice architecture
split


Pulling the other code out of the switch into functions is definitely
good. I'll go apply that bit now

