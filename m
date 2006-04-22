Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWDVSLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWDVSLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 14:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWDVSLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 14:11:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:34722 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750878AbWDVSLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 14:11:07 -0400
Message-ID: <4449E197.1020102@steudten.org>
Date: Sat, 22 Apr 2006 09:56:07 +0200
From: "alpha @ steudten Engineering" <alpha@steudten.com>
Organization: Steudten Engineering
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Oeser <netdev@axxeo.de>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Richard Henderson <rth@twiddle.net>, shemminger@osdl.org,
       p_gortmaker@yahoo.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, ioe-lkml@rameria.de
Subject: Re: Fw: [Bug 6421] New: kernel 2.6.10-2.6.16 on alpha: arch/alpha/kernel/io.c,
 iowrite16_rep() BUG_ON((unsigned long)src & 0x1) triggered
References: <20060421102757.45d26db0@localhost.localdomain>	<200604211945.37129.netdev@axxeo.de> <20060421161227.00d688d6.akpm@osdl.org>
In-Reply-To: <20060421161227.00d688d6.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Mailer
X-Check: 43c12a7010885d7ffef0a7e757629a8f on steudten.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running this on my alpha gives (gcc 4.0.2):

3000
0123456A01234567


Andrew Morton wrote:

>> Because networking does read/write "short" fields in various packet
>> header structures. Results are illustrated in a following example:
>>
>> char foo[] __attribute__((aligned(8))) = "0123456701234567";
>>
>> int main()
>> {
>> 	short *bar = (short *)&foo[7];
>> 	printf("%04x\n", *bar); /* 3037 */
>> 	*bar = 0x4241; /* "AB" */
>> 	printf("%s\n", foo);
>> 	return 0;
>> }
>> --------
>> 0037
>> ^^
>> 0123456A01234567
>>         ^
>> Misalignment by two bytes for ints and longs is often unavoidable in
>> networking and we can cope with it, but there is no excuse of 1-byte
>> misalignment.


