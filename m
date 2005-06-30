Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVF3LyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVF3LyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVF3LyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:54:12 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:47007 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262944AbVF3LyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:54:06 -0400
In-Reply-To: <200506301015.j5UAFMOn023481@harpo.it.uu.se>
References: <200506301015.j5UAFMOn023481@harpo.it.uu.se>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2D8EB556-7189-481F-8278-B4B17CCE339E@freescale.com>
Cc: <benh@kernel.crashing.org>, <johnstul@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <paulus@samba.org>,
       <linuxppc-dev@ozlabs.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [RFC][PATCH] ppc misusing NTP's time_offset value
Date: Thu, 30 Jun 2005 06:53:50 -0500
To: "Mikael Pettersson" <mikpe@csd.uu.se>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you forgot the patch.

- kumar

On Jun 30, 2005, at 5:15 AM, Mikael Pettersson wrote:

> On Wed, 29 Jun 2005 15:05:51 -0700, john stultz wrote:
>
>>     As part of my timeofday rework, I've been looking at the NTP
>>
> code and I
>
>> noticed that the PPC architecture is apparently misusing the NTP's
>> time_offset (it is a terrible name!) value as some form of timezone
>> offset. This could cause problems when time_offset changed by the NTP
>> code.
>>
>>     This patch changes the PPC code so it uses a more clear local
>>
> variable:
>
>> timezone_offset.
>>
>> Could a PPC maintainer verify this is correct?
>>
>> Let me know if you have any comments or feedback.
>>
>
> arch/ppc/kernel/time.c used to have a 'static long time_offset;'
> variable. Ulthough unrelated, this declaration clashed with the
> one for kernel/time.c, causing compile-time errors with gcc4.
> I submitted a fix for this in February, which renamed ppc's local
> variable, and it was ACKed by Tom Rini and queued for 2.6.12.
>
> However, the patch that actually went into 2.6.12 was different:
> it just removed ppc's local variable, making arch/ppc/kernel/time.c
> now share kernel/time.c's variable. At the time I assumed someone
> had proved that the two modules _should_ share state, so I didn't
> make a fuss about it.
>
> Your patch brings the semantics back to what it was prior to 2.6.12.
>
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux- 
> kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

