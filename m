Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267850AbUJRUJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267850AbUJRUJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJRUI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:08:28 -0400
Received: from mail.citnet.ru ([212.1.224.54]:31399 "HELO mail.ti.ru")
	by vger.kernel.org with SMTP id S267633AbUJRUFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:05:51 -0400
Message-ID: <41742215.8020005@quadra.ru>
Date: Tue, 19 Oct 2004 00:05:41 +0400
From: Oleg Makarenko <mole@quadra.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Matt Domsch <Matt_Domsch@dell.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: using crypto_digest() on non-kmalloc'd memory failures
References: <Xine.LNX.4.44.0410181534180.24062-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0410181534180.24062-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

>On Mon, 18 Oct 2004, Matt Domsch wrote:
>
>  
>
>>James, David,
>>
>>Oleg noted that when we call crypto_digest() on memory allocated as a
>>static array in a module, rather than kmalloc(GFP_KERNEL), it returns
>>incorrect data, and with other functions, a kernel panic.
>>
>>Thoughts as to why this may be?  Oleg's test patch appended.
>>    
>>
>
>I don't recall the exact details, but it's related to using kmap in the 
>core crypto code.
>
>
>- James
>  
>
So to calculate digest on some static data I need to copy them to 
kmalloc'ed memory first, right?

Can this copying be somehow avoided?

And one more question on crypto api. It looks like it is not very 
effective for a single byte "block" ciphers as arc4. The overhead is 
probably too big. Just look at the loop in cipher.c/crypt() and the code 
in arc4.c/arc4_crypt(). All this code is called for every single clear 
text byte. Right? Looks like an overkill for bsize == 1.

Is there any better way to use crypto api for arc4 or similar ciphers? 
Cipher block size is not always a natural choice for the crypto_yield(). 
Especially for fast ciphers (arc4) and small "block" sizes (arc4 again).

Or have I missed something obvious?

=oleg

