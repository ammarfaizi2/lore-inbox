Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSHYQdb>; Sun, 25 Aug 2002 12:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSHYQdb>; Sun, 25 Aug 2002 12:33:31 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:43908 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S317402AbSHYQda>;
	Sun, 25 Aug 2002 12:33:30 -0400
Message-ID: <3D6907BA.5020603@colorfullife.com>
Date: Sun, 25 Aug 2002 18:37:14 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Andrew Morton <akpm@zip.com.au>, ink@jurassic.park.msu.ru,
       ggs@shiresoft.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       dhinds@zen.stanford.edu
Subject: Re: [Fwd: [PATCH] reduce size of bridge regions for yenta.c]
References: <3D6874A0.5B110F6@zip.com.au> <20020825075729.A14924@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:
> I don't like it at all. That change is not right. Usually the PCI
> bridge before the CardBus bridge is transparent.

And what if the PCI bridge is not transparent? What if it's a server 
with a riser card, and a cardbus bridge to attach a WLAN card? That 
setup is quite common.

yenta.c doesn't contain error handling, and that should be fixed.

> 
> H.J.
> On Sat, Aug 24, 2002 at 11:09:36PM -0700, Andrew Morton wrote:
> 
>>You guys may need this...

IMHO both patches are needed:

The current code that detects transparent bridges [bridges that 
implement subtractive decoding would be a better name] is bad, Ivan's 
patch fixes that.

My patch adds error handling to yenta.c. It's not strictly needed, 
because most PCI bridges in laptops forward all requests, and thus there 
is enough iomem space for the 8 MB allocation, but the lack of error 
handling [and lack of printks] just asks for trouble.

--
	Manfred

