Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUKFBv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUKFBv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbUKFBv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:51:57 -0500
Received: from smtp09.auna.com ([62.81.186.19]:23693 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261284AbUKFBvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:51:51 -0500
Message-ID: <418C2EAA.7050507@eurodev.net>
Date: Sat, 06 Nov 2004 02:53:46 +0100
From: Pablo Neira <pablo@eurodev.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>, linux-net@vger.kernel.org,
       Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks
 amanda dumps
References: <20041104121522.GA16547@merlin.emma.line.org>	<418A7B0B.7040803@trash.net>	<20041104231734.GA30029@merlin.emma.line.org>	<418AC0F2.7020508@trash.net> <418BE156.4020400@eurodev.net> <418BFC5C.20201@trash.net>
In-Reply-To: <418BFC5C.20201@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:

> Pablo Neira wrote:
>
>> Patrick, what about this? this way we save a copy to a buffer for 
>> linear skbs.
>>
>> Signed-off-by: Pablo Neira Ayuso <pablo@eurodev.net>
>>
>> @@ -74,12 +75,17 @@
>>                  skb->len - dataoff, amanda_buffer);
>>     BUG_ON(amp == NULL);
>>     data = amp;
>> -    data_limit = amp + skb->len - dataoff;
>> -    *data_limit = '\0';
>>
>>     /* Search for the CONNECT string */
>> -    data = strstr(data, "CONNECT ");
>> -    if (!data)
>> +    while((data = memchr(data, 'C', skb->len - dataoff)) != NULL) {
>> +        if (strncmp(data, "CONNECT ", 8) == 0) {
>>  
>>
> What if the C is the last byte ? There are also more str* commands below
> that need a terminating 0-byte.


you both are right. Patrick's patch is the best way to fix this problem.

Pablo
