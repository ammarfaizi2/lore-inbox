Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265354AbUHCKgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbUHCKgv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUHCKgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:36:51 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:49418 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265354AbUHCKgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:36:49 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton)
Subject: Re: ixgb boolean typo ?
Cc: davej@redhat.com, linux.nics@intel.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040802230307.6a26dac0.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1Brwe9-0007WA-00@gondolin.me.apana.org.au>
Date: Tue, 03 Aug 2004 20:35:53 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> Dave Jones <davej@redhat.com> wrote:
>>
>> Is this perhaps what was meant to be here ?
>> 
>>               Dave
>> 
>>  --- 1/drivers/net/ixgb/ixgb_main.c~  2004-08-03 01:18:00.000000000 +0100
>>  +++ 2/drivers/net/ixgb/ixgb_main.c   2004-08-03 01:53:46.653695768 +0100
>>  @@ -1615,7 +1615,7 @@
>>       }
>>   #else
>>       for (i = 0; i < IXGB_MAX_INTR; i++)
>>  -            if (!ixgb_clean_rx_irq(adapter) & !ixgb_clean_tx_irq(adapter))
>>  +            if (!ixgb_clean_rx_irq(adapter) && !ixgb_clean_tx_irq(adapter))
>>                       break;
>>       /* if RAIDC:EN == 1 and ICR:RXDMT0 == 1, we need to
>>        * set IMS:RXDMT0 to 1 to restart the RBD timer (POLL)
> 
> Both versions will do the same thing, inefficiently: keep going until both
> functions return false.  And keep pointlessly calling a functions which is
> returning FALSE all the time.
> 
> I think this would be better:

Please note that ixgb_clean_rx_irq/ixgb_clean_tx_irq are not pure functions.
Their return values can change.

The original intention appears to be this: keep processing until both
RX and TX runs out of things to do.

Both of your patches do something different.

Perhaps we should add a comment instead.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
