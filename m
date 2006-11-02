Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752785AbWKBXQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbWKBXQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWKBXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:16:38 -0500
Received: from smtp18.dc2.safesecureweb.com ([65.36.255.252]:14828 "EHLO
	smtp18.dc2.safesecureweb.com") by vger.kernel.org with ESMTP
	id S1750698AbWKBXQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:16:37 -0500
Message-ID: <014101c6fed4$d0e4b850$0732700a@djlaptop>
From: "Richard B. Johnson" <jmodem@AbominableFirebug.com>
To: "David Rientjes" <rientjes@cs.washington.edu>, <muli@il.ibm.com>
Cc: <ak@suse.de>, <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>,
       <jdmason@kudzu.us>
References: <11625041803066-git-send-email-muli@il.ibm.com> <11625041802816-git-send-email-muli@il.ibm.com> <Pine.LNX.4.64N.0611021401180.1797@attu4.cs.washington.edu>
Subject: Re: [PATCH 1/4] Calgary: phb_shift can be int
Date: Thu, 2 Nov 2006 18:04:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "David Rientjes" <rientjes@cs.washington.edu>
To: <muli@il.ibm.com>
Cc: <ak@suse.de>; <linux-kernel@vger.kernel.org>; <discuss@x86-64.org>; 
<jdmason@kudzu.us>
Sent: Thursday, November 02, 2006 5:12 PM
Subject: Re: [PATCH 1/4] Calgary: phb_shift can be int


> On Thu, 2 Nov 2006, muli@il.ibm.com wrote:
>
>> diff --git a/arch/x86_64/kernel/pci-calgary.c 
>> b/arch/x86_64/kernel/pci-calgary.c
>> index 37a7708..31d5758 100644
>> --- a/arch/x86_64/kernel/pci-calgary.c
>> +++ b/arch/x86_64/kernel/pci-calgary.c
>> @@ -740,7 +740,7 @@ static void __init calgary_increase_spli
>>  {
>>  u64 val64;
>>  void __iomem *target;
>> - unsigned long phb_shift = -1;
>> + unsigned int phb_shift = ~0; /* silence gcc */
>>  u64 mask;
>>
>>  switch (busno_to_phbid(busnum)) {
>>
>
> There's been a suggestion to add
>
> #define SILENCE_GCC(x) = x

This was previously discussed. To quiet gcc warnings, one can use "var=var", 
but you do not want  to hide it in a macro! That hides bonafide bugs. If you 
carefully review code and see that there is absolutely no possibility of 
using an uninitialized variable in any execution path, then you can assign 
it to itself to quiet the compiler.

>
> for these silencing cases with the advantage that all the cases are marked
> for an easy grep and the purpose of such an initialization is known by
> the code reader.
>
> http://lkml.org/lkml/2006/10/31/106
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 (somewhere). IT took away email 
"privileges" to engineers.
New Book: http://www.AbominableFirebug.com


