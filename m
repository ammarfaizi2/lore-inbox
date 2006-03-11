Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWCKX3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWCKX3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWCKX3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:29:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:64219 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751187AbWCKX3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:29:14 -0500
From: Andreas Schwab <schwab@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
       akpm@osdl.org
Subject: Re: [PATCH] crypto: fix key alignment in tcrypt
References: <20060308.231155.63512624.nemoto@toshiba-tops.co.jp>
	<20060311231238.GJ7110@waste.org>
X-Yow: SANTA CLAUS comes down a FIRE ESCAPE wearing bright
 blue LEG WARMERS..  He scrubs the POPE with a mild
 soap or detergent for 15 minutes, starring JANE FONDA!!
Date: Sun, 12 Mar 2006 00:29:07 +0100
In-Reply-To: <20060311231238.GJ7110@waste.org> (Matt Mackall's message of
	"Sat, 11 Mar 2006 17:12:38 -0600")
Message-ID: <jeirqktvb0.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> writes:

> On Wed, Mar 08, 2006 at 11:11:55PM +0900, Atsushi Nemoto wrote:
>> Force 32-bit alignment on keys in tcrypt test vectors.
>> 
>> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
>> 
>> diff --git a/crypto/tcrypt.h b/crypto/tcrypt.h
>> index 733d07e..050f852 100644
>> --- a/crypto/tcrypt.h
>> +++ b/crypto/tcrypt.h
>> @@ -31,7 +31,7 @@ struct hash_testvec {
>>  	char digest[MAX_DIGEST_SIZE];
>>  	unsigned char np;
>>  	unsigned char tap[MAX_TAP];
>> -	char key[128]; /* only used with keyed hash algorithms */
>> +	char key[128] __attribute__((__aligned__(4))); /* only used with keyed hash algorithms */
>>  	unsigned char ksize;
>>  };
>>  
>> @@ -48,7 +48,7 @@ struct hmac_testvec {
>>  struct cipher_testvec {
>>  	unsigned char fail;
>>  	unsigned char wk; /* weak key flag */
>> -	char key[MAX_KEYLEN];
>> +	char key[MAX_KEYLEN] __attribute__((__aligned__(4)));
>>  	unsigned char klen;
>>  	char iv[MAX_IVLEN];
>>  	char input[48];
>
> Wouldn't it be better to simply move this to the head of the structure?

That wouldn't help, since the whole structure will still be only 8-bit
aligned.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
