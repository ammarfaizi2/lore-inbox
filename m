Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVDKNId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVDKNId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 09:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDKNIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 09:08:32 -0400
Received: from hermes.domdv.de ([193.102.202.1]:44294 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261574AbVDKNIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 09:08:30 -0400
Message-ID: <425A76CD.5030905@domdv.de>
Date: Mon, 11 Apr 2005 15:08:29 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: folkert@vanheusden.com
CC: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <20050411102550.GD1353@elf.ucw.cz> <20050411103608.GA5610@vanheusden.com>
In-Reply-To: <20050411103608.GA5610@vanheusden.com>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folkert@vanheusden.com wrote:
>>>The following patch adds the core functionality for the encrypted
>>>suspend image.
>>
>>[Please inline patches, it makes it easier to comment on them.]

Aiyeeh - good ole Mozilla tends to reformat things when inlining...

>>You seem to reuse same key/iv for all the blocks. I'm no crypto
>>expert, but I think that is seriously wrong... You probably should use
>>block number as a IV or something like that.
> 
> 
> Or use a feedback loop: xor your data with the outcome of the previous
> round. And for the initial block use 0x00...00 for 'previous block'-
> value.

I'm already using cipher block chaining, look for CRYPTO_TFM_MODE_CBC in
swsusp.c. You may want to have a look at cbc_process in crypto/cipher.c.
Thus using the same key is ok. The only known drawback is a watermarking
"attack" but this can only used to look for the existence of specially
crafted files which are not stored on disk during software suspend.

I should, however, use crypto_cipher_en/decrypt instead of
crypto_cipher_en/decrypt_iv as I actually wanted to use the iv in the
tfm I did set up with crypto_cipher_set_iv instead of the local copy.

Going to fix that.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
