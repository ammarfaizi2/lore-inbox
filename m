Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUJSFlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUJSFlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 01:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUJSFlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 01:41:39 -0400
Received: from mail.citnet.ru ([212.1.224.54]:42714 "HELO mail.ti.ru")
	by vger.kernel.org with SMTP id S267994AbUJSFlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 01:41:37 -0400
Message-ID: <4174A90E.5080505@quadra.ru>
Date: Tue, 19 Oct 2004 09:41:34 +0400
From: Oleg Makarenko <mole@quadra.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Matt Domsch <Matt_Domsch@dell.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
References: <Xine.LNX.4.44.0410181859030.25082-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0410181859030.25082-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

On Tue, 19 Oct 2004, Oleg Makarenko wrote:


>>Is there any better way to use crypto api for arc4 or similar ciphers? 
>>Cipher block size is not always a natural choice for the crypto_yield(). 
>>Especially for fast ciphers (arc4) and small "block" sizes (arc4 again).
>>    
>>
>
>ARC4 is a bit strange because it's a stream cipher.  I guess we could add 
>another encryption mode 'stream' which is optimized for one byte at a time 
>operation.
>
>
>- James
>  
>
That would probably require one more parameter to 
cin_encrypt/cia_decrypt, something like "nblocks" which currently is 
always 1 and one more struct crypto_alg field that would help upper 
level to decide how many blocks it can safely encrypt/decrypt() at a 
time before crypto_yield(). This value depends on algorithm speed and 
should be chosen to make overhead smaller. It could  be > 1 even for 
fast block ciphers and should be > 1 for stream ciphers.

=oleg



