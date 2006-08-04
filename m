Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWHDPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWHDPQp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 11:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHDPQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 11:16:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:18202 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932421AbWHDPQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 11:16:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TO2QGw9NtAYb52Rspsza3rGTF7dXQ3diFGS8wNWCb4tCEg9FvIksHnfPI/OwmH4qJhl84eCjrBSNm++ZNPxY460XVg2O/+GTFqxFcqOs1rs//A0ieNQVbVA4wE7kQEFTuyX//wDc5ueUnT2DOB9dkIY1JleJVoHTi3/vLKy8CXw=
Message-ID: <41b516cb0608040816o63ac2f72q20add7619734906@mail.gmail.com>
Date: Fri, 4 Aug 2006 08:16:42 -0700
From: "Chris Leech" <chris.leech@gmail.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Subject: Re: problems with e1000 and jumboframes
Cc: "Krzysztof Oledzki" <olel@ans.pl>, "Arnd Hannemann" <arnd@arndnet.de>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060804062008.GC413@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru>
	 <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru>
	 <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
	 <20060803151631.GA14774@2ka.mipt.ru>
	 <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com>
	 <20060803161046.GA703@2ka.mipt.ru>
	 <41b516cb0608031332v9cc383bq37a13254f25f45a9@mail.gmail.com>
	 <20060804062008.GC413@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > You're changing the size of the buffer without telling the hardware.
> > In the interrupt context e1000 knows the size of what was DMAed into
> > the skb, but that's after the fact.  So e1000 could detect that memory
> > was corrupted, but not prevent it if you don't give it power of 2
> > buffers.  Actually, the power of 2 thing doesn't hold true for all
> > e1000 devices.  Some have 1k granularity, but not Arnd's 82540.
>
> I can not change it - code checks if requested mtu and additional size
> is less than allocated aligned buffer it tricks allocator.
> Or do you mean that even after 9k mtu was setup it is possible that card
> can receive packets up to 16k?

Yes, that's exactly what I mean.  For anything above the standard 1500
bytes the e1000 _hardware_ has no concept of MTU, only buffer length.
So even if the driver is set to an MTU of 9000, the NIC will still
receive 16k frames.  Otherwise the driver would simply allocate MTU
sized buffers.

-Chris
