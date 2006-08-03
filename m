Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWHCOtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWHCOtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWHCOtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:49:24 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:41683 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S932510AbWHCOtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:49:23 -0400
Date: Thu, 3 Aug 2006 16:49:15 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Arnd Hannemann <arnd@arndnet.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
In-Reply-To: <20060803142412.GA14997@kvack.org>
Message-ID: <Pine.LNX.4.64.0608031646110.8443@bizon.gios.gov.pl>
References: <44D1FEB7.2050703@arndnet.de> <20060803142412.GA14997@kvack.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1911520086-1154616555=:8443"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1911520086-1154616555=:8443
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 3 Aug 2006, Benjamin LaHaise wrote:

> On Thu, Aug 03, 2006 at 03:48:39PM +0200, Arnd Hannemann wrote:
>> However the box is a VIA Epia MII12000 with 1 GB of Ram and 1 GB of swap
>> enabled, so there should be plenty of memory available. HIGHMEM support
>> is off. The e1000 nic seems to be an 82540EM, which to my knowledge
>> should support jumboframes.
>
>> However I can't always reproduce this on a freshly booted system, so
>> someone else may be the culprit and leaking pages?
>>
>> Any ideas how to debug this?
>
> This is memory fragmentation, and all you can do is work around it until
> the e1000 driver is changed to split jumbo frames up on rx.  Here are a
> few ideas that should improve things for you:
>
> =09- switch to a 2GB/2GB split to recover the memory lost to highmem
> =09  (see Processor Type and Features / Memory split)
With 1 GB of RAM full 1GB/3GB (CONFIG_VMSPLIT_3G_OPT) seems to be=20
enough...

> =09- increase /proc/sys/vm/min_free_kbytes -- more free memory will
> =09  improve the odds that enough unfragmented memory is available for
> =09  incoming network packets

True. IMO, 65535 is a good starting point.

Best regards,
 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1911520086-1154616555=:8443--
