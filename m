Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751584AbWBQT4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbWBQT4p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 14:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWBQT4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 14:56:45 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:17857 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1750899AbWBQT4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 14:56:43 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYz/ELgzYRxKb4uR8qP7k7MDhybhg==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F62A73.3090509@bfh.ch>
Date: Fri, 17 Feb 2006 20:56:35 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam Kropelin" <akropel1@rochester.rr.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 2/2] pcnet32: PHY selection support
References: <20060217134938.B24429@mail.kroptech.com>
In-Reply-To: <20060217134938.B24429@mail.kroptech.com>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 19:56:36.0820 (UTC) FILETIME=[4290D140:01C633FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Adam Kropelin wrote:
> Seewer Philippe wrote:
> 
>>Most AMD pcnet chips support up to 32 external PHYs. This patch
>>introduces basic PHY selection/switching support, by adding two
>>new module parameters:
>>-maxphy: how many PHYs the card supports
>>-usephy: which phy to use instead of eeprom default
>>
>>Maxphy is necessary in order to check the range of usephy and may
>>be overriden inside the module.
> 
> 
> It seems a bit pointless for the range check of a user-supplied value to
> be driven by another user-supplied value.
I just want to make sure and there's the possibility of supplying only maxphy
and let the autoswitch algorithm decide...
> 
> 
>>If only maxphy is present I've implemented an algorithm which checks
>>the link state on all PHYs and uses the one that has a link.
> 
> 
> Knowing how many PHYs to scan is potentially useful, but how about
> determining that at runtime? Missing PHYs should be detectable with a
> timeout or similar. Too risky?
Actually its possible to query them with mii and all non-present phy's
should "return" 0xffff. I wanted my changes to have no impact on pcnet
cards with only one phy, thats why.

> 
> --Adam
> 
