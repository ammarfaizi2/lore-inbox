Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131806AbRCOVDQ>; Thu, 15 Mar 2001 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131815AbRCOVDG>; Thu, 15 Mar 2001 16:03:06 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:53388 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S131806AbRCOVCt>;
	Thu, 15 Mar 2001 16:02:49 -0500
Date: Thu, 15 Mar 2001 16:01:00 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Jonathan Morton <chromi@cyberspace.org>, <linux-kernel@vger.kernel.org>
Subject: Re: How to optimize routing performance
In-Reply-To: <15025.7653.808956.553263@robur.slu.se>
Message-ID: <Pine.GSO.4.30.0103151555210.28888-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 15 Mar 2001, Robert Olsson wrote:

>
>
> Jonathan Morton writes:
>
>  > Nice.  Any chance of similar functionality finding its' way outside the
>  > Tulip driver, eg. to 3c509 or via-rhine?  I'd find those useful, since one
>  > or two of my Macs appear to be capable of generating pseudo-DoS levels of
>  > traffic under certain circumstances which totally lock a 486 (for the
>  > duration) and heavily load a P166 - even though said Macs "only" have
>  > 10baseT Ethernet.
>
>  I'm not the one to tell. :-)
>
>  First its kind of experimental. Jamal has talked about putting together
>  a proposal for enhancing RX-process for inclusion in the 2.5 kernels.
>  There is meeting soon for this.
>
>
>  But why not experiment a bit?

I think one of the immediate things usable to drivers is to check the
netif_rx() return value and yield the CPU if the system is congested.
This is hardware independent. For the Tulip, since it knows how to do
mitigation, it infact reduces it's interupt rate. An even simpler thing is
to use HW_FLOW_CONTROL where you shutdown rx_interupt based on system
congestion (and get worken up later when things get better).

For 2.5 the plan is to work around any hardware dependencies.

cheers,
jamal

