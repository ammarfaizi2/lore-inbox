Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbTCZXls>; Wed, 26 Mar 2003 18:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbTCZXlr>; Wed, 26 Mar 2003 18:41:47 -0500
Received: from sj-core-5.cisco.com ([171.71.177.238]:61605 "EHLO
	sj-core-5.cisco.com") by vger.kernel.org with ESMTP
	id <S262656AbTCZXkI>; Wed, 26 Mar 2003 18:40:08 -0500
Message-Id: <5.1.0.14.2.20030327104129.032dee90@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 27 Mar 2003 10:49:55 +1100
To: ptb@it.uc3m.es
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [PATCH] ENBD for 2.5.64
Cc: Jeff Garzik <jgarzik@pobox.com>, Matt Mackall <mpm@selenic.com>,
       ptb@it.uc3m.es, Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200303262202.h2QM2Pg29846@oboe.it.uc3m.es>
References: <5.1.0.14.2.20030327083757.037c0760@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

At 11:02 PM 26/03/2003 +0100, Peter T. Breuer wrote:
>I'll content myself with mentioning that ENBD has /always/ throughout
>its five years of life had automatic failover between channels.  Mind
>you, I don't think anybody makes use of the multichannel architecture in
>practice for the purposes of redundancy (i.e.  people using multiple
>channels don't pass them through different interfaces or routes, which
>is the idea!), they may do it for speed/bandwidth.
>
>But then surely they might as well use channel bonding in the network layer?
>I've never tried it, or possibly never figured out how ..

"channel bonding" can handle cases whereby you lose a single NIC or port -- 
but typically channeling means that you need multiple paths into a single 
ethernet switch.
single ethernet switch = single point of failure.

hence, from a high-availability (HA) perspective, you're better off 
connecting N NICs into N switches -- and then load-balance (multipath) 
across those.

an interesting side-note is that channel-bonding doesn't necessarily mean 
higher performance.
i haven't looked at linux's channel-bonding, but many NICs on higher-end 
servers offer this as an option, and when enabled, you end up with multiple 
NICs with the same MAC address.  typically only one NIC is used for one 
direction of traffic.

> > the reason why goes back to how SCSI works.  take a ethereal trace of 
> iSCSI
> > and you'll see the way that 2 round-trips are used before any typical i/o
> > operation (read or write op) occurs.
>
>Hmm.
>I have some people telling me that I should pile up network packets
>in order to avoid too many interrupts firing on Ge cards, and other
>people telling me to send partial packets as soon as possible in order
>to avoid buffer buildup.  My head spins.

:-)
most "storage" people care more about latency than they do about raw 
performance.  coalescing packets = bad for latency.

i figure there has to be middle ground somewhere -- implement both and have 
it as a config option.

decent GE cards will do coalescing themselves anyway.


cheers,

lincoln.

