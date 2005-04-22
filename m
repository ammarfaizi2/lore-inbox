Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVDVKZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVDVKZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 06:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDVKZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 06:25:18 -0400
Received: from hermes.domdv.de ([193.102.202.1]:1036 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S262023AbVDVKZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 06:25:06 -0400
Message-ID: <4268D0D8.7050104@domdv.de>
Date: Fri, 22 Apr 2005 12:24:24 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: herbert@gondor.apana.org.au, davem@davemloft.net,
       linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: do not open-code be<->cpu
References: <200504221259.03878.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504221259.03878.vda@port.imtp.ilyichevsk.odessa.ua>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Patch replaces numerous be<->cpu and le<->cpu
> conversions in crypto. Per lkml comments,
> it is done with macros:
> 
> block[i] = load_be64(ptr,i);
> store_be64(out,i, block[i]);
> 
> where i is an index: load_be64 will load i'th
> big-endian value pointed by ptr (typically a char*).
> Same for store.
> 
> This results in smaller and cleaner code.
> 
> Patch also adds BYTEn(x) macros for extracting n'th byte from
> u32 and u64 memory operand. Currently used experssions like
> ((K >> 40) & 0xff) are not optimal (gcc will load entire word
> and then shift and/or mask it).
> 
> Macros can be conditionally defined for different arches
> for performance. Ones from this patch are found to be best
> for i386.
> 
> BYTEn macros are used only by next patches.

Not good if you use a crypto private header as long as there's arch and
device specific crypto which is left out cold this way.

I'd suggest either some header in include/linux or, in my opinion
better, open a crypto related include directory as include/crypto. The
latter would make sense as there probably will be algorithm specific
headers when the arch and driver specific versions will be harmonized,
thus these headers need to be globally available to crypto sources but
otherwise would pollute the common include directory.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
