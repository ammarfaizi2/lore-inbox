Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbTA3QuM>; Thu, 30 Jan 2003 11:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267553AbTA3QuM>; Thu, 30 Jan 2003 11:50:12 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:50707 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267547AbTA3QuL>; Thu, 30 Jan 2003 11:50:11 -0500
Message-ID: <3E3959CA.5040907@google.com>
Date: Thu, 30 Jan 2003 08:58:50 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BUG: [2.4.18+] IDE Race Condition
References: <3E356854.1090100@google.com> <1043948091.31674.8.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>st should be replaced with
>>if (!masked_irq || hwif->irq != masked_irq)
>>in two places.
>>    
>>
>
>Which would also shorten to if (hwif->irq != masked_irq) it seems
>
>  
>
With the assumption that hwif->irq != 0 which is implicit now.  Perhaps 
we should make the assumption explicit,

if (unlikely(hwif->irq == 0)) {
    BUG();
}
if (hwif->irq != masked_irq) ....

    Ross



