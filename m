Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750796AbWFDRnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWFDRnD (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 13:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWFDRnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 13:43:03 -0400
Received: from terminus.zytor.com ([192.83.249.54]:33754 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750796AbWFDRnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 13:43:02 -0400
Message-ID: <44831B8F.2060205@zytor.com>
Date: Sun, 04 Jun 2006 10:42:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: maks@sternwelten.at, linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [PATCH] klibc
References: <20060602081416.GA11358@nancy>	<44820C7D.6080501@zytor.com> <20060603.233034.59468148.davem@davemloft.net>
In-Reply-To: <20060603.233034.59468148.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
>  
>> __arch64__ is ugly; it doesn't say it's a sparc thing.  I have added 
>> -D__sparc_v9__ to the sparc64 MCONFIG file, so I think that's fine.
>>
>> Perhaps the right thing to do is to make this an archconfig.h configurable.
> 
> Please don't do this, I'll explain why.
> 
> Using __sparc_v9__ is incorrect, here is the lowdown on these defines:
> 
> 1) __sparc_v9__ means "-mcpu={ultrasparc*,niagara}" or "-mcpu=v9".
>    Although this is implied by "-m64" it can be used for 32-bit
>    code too.
> 
>    __sparc_v9__ means "using v9 instructions" which does not
>    necessarily mean 64-bit
> 
> 2) "__sparc__ && __arch64__" means 64-bit sparc
> 
> People often get this wrong, and it certainly is confusing.
> 

Okay, how about __sparc64__ then (via -D in the MCONFIG file.)

I did change this particular instance to be a archconfig variable, so it 
doesn't exist (I try very much to avoid architecture-specific #ifdefs in 
bulk code.)

	-hpa

