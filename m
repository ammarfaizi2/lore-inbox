Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967322AbWKZHUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967322AbWKZHUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 02:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967326AbWKZHUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 02:20:48 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:53136 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S967322AbWKZHUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 02:20:47 -0500
Date: Sun, 26 Nov 2006 01:20:46 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
In-reply-to: <fa.n9vySiI9RS2MCl0DZPDzxZEPiFw@ifi.uio.no>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Wink Saville <wink@saville.com>, Arjan van de Ven <arjan@infradead.org>
Message-id: <4569404E.20402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa./NRPJg+JjfSQLUVwnX1GpHGIojQ@ifi.uio.no>
 <fa.Y0RKABHd+7qnbGQYBAGPvlJ0Qic@ifi.uio.no>
 <fa.fD3WSpNqEJ4736vYzEak5Gf3xTw@ifi.uio.no>
 <fa.A+gkQAO1DLThaxJxPLPl3yE1CGo@ifi.uio.no>
 <fa.INurNKWdUKAEULTHyfpSW65a/Ng@ifi.uio.no>
 <fa.n9vySiI9RS2MCl0DZPDzxZEPiFw@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wink Saville wrote:
> Arjan van de Ven wrote:
>>> Actually, we need to ask the CPU/System makers to provide a system wide
>>> timer that is independent of the given CPU. I would expect it quite 
>>> simple
>>
>> they exist. They're called pmtimer and hpet.
>> pmtimer is port io. hpet is memory mapped io.
> 
> Thanks for the info. I took a look at Documentation/hpet.txt and 
> drivers/char/hpet.c
> and see that hpet_mmap is implemented in the driver but nothing hpet.txt 
> indicates
> what is being mapped.
> 
> Could you point me to any other documentation? I did find the following:
> 
> http://www.intel.com/hardwaredesign/hpetspec_1.pdf
> 
> Are you aware of any example user code that uses the mmap capability of 
> hpet?

Generally user mode code should just be using gettimeofday. When the TSC 
is usable as a sane time source, the kernel will use it. When it's not, 
it will use something else like the HPET, ACPI PM Timer or (at last 
resort) the PIT, in increasing degrees of slowness.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

