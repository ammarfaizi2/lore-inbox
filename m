Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbTDAMRE>; Tue, 1 Apr 2003 07:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTDAMRD>; Tue, 1 Apr 2003 07:17:03 -0500
Received: from mail.zmailer.org ([62.240.94.4]:32725 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S262478AbTDAMRD>;
	Tue, 1 Apr 2003 07:17:03 -0500
Date: Tue, 1 Apr 2003 15:28:24 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
Cc: matti.aarnio@zmailer.org, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
Message-ID: <20030401122824.GY29167@mea-ext.zmailer.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F91mkXMUIhAumscmKC00000f517@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 12:12:04PM +0000, shesha bhushan wrote:
> I get that. I can talk with the driver vendor. But to gain the usefulness 
> of caculation of CSUM in HW we need to disable the software CSUM 
> calculation in TCP layer in the kernel. Am I correct? I am trying to find 
> that and I ma stuck there. How to disble the software TCP CSUM calculation? 
> and later I can talk with driver vendor to enable it in hardware. I wanted 
> help from linux gurus in disabling TCP csum calculation in the kernel.

The kernel code is already smart enough of detect that the outbound
device will handle the checksum calculations all by itself, and not
do it in that case.

Testing of  dev->features   is done in files:
   net/core/dev.c
   net/ipv4/tcp.c
(depending what protocol is in question.)
in the latter case, actually in common tcp path with route-cached 
route_caps flags.

I did
   egrep 'NETIF_F_.._CSUM' net/*/*.c
to find those.
(and a number of other subset searches finding nothing)

Grep is your friend.

This whole "zero-copy" infastructure was implemented during
development in 2.3 series.

> Thanking You
> Shesha

/Matti Aarnio
