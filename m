Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262423AbTDAMAs>; Tue, 1 Apr 2003 07:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbTDAMAs>; Tue, 1 Apr 2003 07:00:48 -0500
Received: from f91.pav2.hotmail.com ([64.4.37.91]:14859 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262423AbTDAMAq>;
	Tue, 1 Apr 2003 07:00:46 -0500
X-Originating-IP: [129.219.25.77]
X-Originating-Email: [bhushan_vadulas@hotmail.com]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: matti.aarnio@zmailer.org
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Deactivating TCP checksumming
Date: Tue, 01 Apr 2003 12:12:04 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F91mkXMUIhAumscmKC00000f517@hotmail.com>
X-OriginalArrivalTime: 01 Apr 2003 12:12:04.0665 (UTC) FILETIME=[E87CBA90:01C2F847]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get that. I can talk with the driver vendor. But to gain the usefulness of 
caculation of CSUM in HW we need to disable the software CSUM calculation in 
TCP layer in the kernel. Am I correct? I am trying to find that and I ma 
stuck there. How to disble the software TCP CSUM calculation? and later I 
can talk with driver vendor to enable it in hardware. I wanted help from 
linux gurus in disabling TCP csum calculation in the kernel.

Thanking You
Shesha






>From: Matti Aarnio <matti.aarnio@zmailer.org>
>To: shesha bhushan <bhushan_vadulas@hotmail.com>
>Subject: Re: Deactivating TCP checksumming
>Date: Tue, 1 Apr 2003 15:00:08 +0300
>
>On Tue, Apr 01, 2003 at 11:22:50AM +0000, shesha bhushan wrote:
> > Ok I will. Is there any other material which I can reffer?
> > I am using Intel pro1000 GBE
> >
> > Thank you very much for providing me the below information.
>
>You will need to talk with the driver author then.
>In 2.4.20 kernels (at least RedHat version) there is directory
>   drivers/net/e1000/
>in which the driver code resides.
>
>The  e1000_main.c  has:
>
>         if(adapter->hw.mac_type >= e1000_82543) {
>                 netdev->features = NETIF_F_SG |
>                                    NETIF_F_HW_CSUM |
>                                    NETIF_F_HW_VLAN_TX |
>                                    NETIF_F_HW_VLAN_RX |
>                                    NETIF_F_HW_VLAN_FILTER;
>         } else {
>                 netdev->features = NETIF_F_SG;
>         }
>
>
>   ... so, if your card isn't with that chip, then perhaps that is
>the reason for not doing checksums in HW ?
>
>Existence of that kind of test is telling to me, that "E1000" name
>is used to refer to a series of cards with varying properties.
>(Like there are a whole family of cards driven by  3c59x driver,
>  and even larger one referred as "tulip".)
>
>/Matti Aarnio
>
> > >From: Matti Aarnio <matti.aarnio@zmailer.org>
> > >To: shesha bhushan <bhushan_vadulas@hotmail.com>
> > >CC: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
> > >Subject: Re: Deactivating TCP checksumming
> > >Date: Tue, 1 Apr 2003 13:58:21 +0300
> > >
> > >On Tue, Apr 01, 2003 at 09:47:30AM +0000, shesha bhushan wrote:
> > >> Hello all,
> > >>  I am trying to de-activate the TCP checksumming and allow hardware 
>(GBE
> > >to
> > >> compute it for me). But can any one let me know how to do it.
> > >
> > >GBE ?  Likely device feature flags are wrong -- See examples
> > >from   drivers/net/sunhme.c,  acenic.c,  tg3.c  for various ways
> > >to use  NETIF_F_*_CSUM  feature flags.
> > >
> > >For (some of) explanations:  include/linux/netdevice.h
> > >(for NETIF_F_* flags)
> > >
> > >> All suggestion are highly apperciated.
> > >>
> > >> Thanking You
> > >> Shesha
> > >
> > >/Matti Aarnio


_________________________________________________________________


