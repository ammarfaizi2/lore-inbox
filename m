Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVLZQAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVLZQAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 11:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVLZQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 11:00:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45523 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750853AbVLZQAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 11:00:55 -0500
Message-ID: <43B01390.6010206@zytor.com>
Date: Mon, 26 Dec 2005 08:00:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: Axel Kittenberger <axel.kernel@kittenberger.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Possible Bootloader Optimization in inflate (get rid of unnecessary
 32k Window)
References: <200512221352.23393.axel.kernel@kittenberger.net> <2cd57c900512251815r16422013p@mail.gmail.com>
In-Reply-To: <2cd57c900512251815r16422013p@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
>>
>>What would the optimization be worth?
>>* A faster uncompressing of the kernel, since a total 1-time memcopy of the
>>whole kernel is been optimized away.
>>* I'm not sure about the size, the memory or disk footprint. If the 32k static
>>(!) memory array in compressed/misc.c, I don't know if it safes 32k running
>>memory, or 32k on-disk size. Since I don't know the indepth working of these 
> 
> Neither for saving running memory (discarded), nor on-disk size
> (window[WSIZE] resides in BSS).
> 

I've actually implemented this for another application (where BSS was at 
a premium.)  It even has some nice benefits for code size if you do it 
right.

It indeed would avoid a cache-to-memory copy, but that's not really a 
huge deal, which is why noone has worried too much about it.

	-hpa
