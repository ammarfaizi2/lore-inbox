Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFNMjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFNMjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 08:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVFNMjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 08:39:35 -0400
Received: from [195.23.16.24] ([195.23.16.24]:24470 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261208AbVFNMjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 08:39:32 -0400
Message-ID: <42AECFF3.7030604@grupopie.com>
Date: Tue, 14 Jun 2005 13:39:15 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Christian Leber <christian@leber.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lzma support: decompression lib, initrd support
References: <20050607213204.GA2645@core.home> <20050607145903.4b2ac9bf.akpm@osdl.org>
In-Reply-To: <20050607145903.4b2ac9bf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Christian Leber <christian@leber.de> wrote:
> [...]
>>+	for (pb = 0; prop0 >= (9 * 5); pb++, prop0 -= (9 * 5));
>>+	for (lp = 0; prop0 >= 9; lp++, prop0 -= 9);
> 
> Put the ";" on a line of its own.
> 
> I'd have thought the above could be done arithmetically?

I just tried a small test program to see the speed/code size difference 
to this code, which is the arithmetic equivalent:

   pb = prop0 / (9 * 5);
   prop0 %= (9 * 5);
   lp = prop0 / 9;
   prop0 %= 9;

This code runs a lot faster than the original. This is not very 
important since it runs only once AFAICT.

As for the code size, it is smaller if compiled with -Os, but larger 
when compiled with -O2 or -O3.

When compiled with -Os, gcc uses the idiv instruction and it even uses 
its reminder so that it only does 2 idiv instructions to do the 4 
operations above.

With -O2 or -O3, it does a hard to follow division "by hand" using 
several instructions, rendering the code about 2.5x larger (but 
amazingly a lot faster).

The tests were done with gcc 3.3.2.

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
