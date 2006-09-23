Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWIWUm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWIWUm6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964846AbWIWUm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:42:58 -0400
Received: from smtpout.mac.com ([17.250.248.183]:43474 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964843AbWIWUm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:42:57 -0400
In-Reply-To: <0C3FEC03-29A8-49B0-9D12-BBFA4AE99A78@mac.com>
References: <20060922.223136.41635862.davem@davemloft.net> <20060923124633.GA2567@gondor.apana.org.au> <20060923125458.GA2682@gondor.apana.org.au> <20060923144041.GA3540@gondor.apana.org.au> <0C3FEC03-29A8-49B0-9D12-BBFA4AE99A78@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <818B7FCF-3713-42E8-8EFF-2ECC98217BEE@mac.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH]: Fix ALIGN() macro
Date: Sat, 23 Sep 2006 16:42:47 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 23, 2006, at 16:36:33, Kyle Moffett wrote:
> On Sep 23, 2006, at 10:40:41, Herbert Xu wrote:
>> diff --git a/crypto/hmac.c b/crypto/hmac.c
>> index f403b69..d52b234 100644
>> --- a/crypto/hmac.c
>> +++ b/crypto/hmac.c
>> @@ -98,7 +98,7 @@ static int hmac_init(struct hash_desc *p
>>  	sg_set_buf(&tmp, ipad, bs);
>>
>>  	return unlikely(crypto_hash_init(&desc)) ?:
>> -	       crypto_hash_update(&desc, &tmp, 1);
>> +	       crypto_hash_update(&desc, &tmp, bs);
>>  }
>>
>>  static int hmac_update(struct hash_desc *pdesc,
>
> Quick question:  does "crypto_hash_init()" ever return anything  
> other than 0 or 1?  If so this is a subtle bug, as "unlikely()" is  
> implemented like this:
>
> # define unlikely(x) __builtin_expect(!!(x), 0)
>
> IMO any usage of likely/unlikely other than if(unlikely()), if 
> (likely()) is probably a bug.

With a bit more contemplation, I think this is one place where (if  
the compiler or sparse are cooperative) we should really look at the  
_Bool type or similar.  If we could cast likely()/unlikely() to  
return (_Bool), then these sorts of problems would be caught at  
compile time, and likewise for other functions which return boolean  
values.

Cheers,
Kyle Moffett

