Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVAJCu5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVAJCu5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 21:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVAJCu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 21:50:57 -0500
Received: from gold.muskoka.com ([216.123.107.5]:4050 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id S262055AbVAJCut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 21:50:49 -0500
Message-ID: <41E1EB68.5000709@muskoka.com>
Date: Sun, 09 Jan 2005 21:41:44 -0500
From: Paul Gortmaker <penguin@muskoka.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c
References: <41DED9FA.7080106@pobox.com>  <41DF9AC1.2010609@muskoka.com> <1105197689.10505.22.camel@localhost.localdomain>
In-Reply-To: <1105197689.10505.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sad, 2005-01-08 at 08:33, Paul Gortmaker wrote:
>  
>
>>Is it possible that skb_padto has since got its act together?   Reason I
>>ask is that I just dusted off a crusty 386dx40 (doesn't get much older
>>    
>
>Could be - kmalloc has probably improved but the skbuffs have got far
>more complex
>
>
>>than that) with a wd8013.  As a basic test, I did ttcp Tx tests with small
>>packets and they came out to all intents and purposes, identical.   Kernel 
>>was 2.6.10, with stack vs skb_padto, each size test ran 3 times, even tested
>>packets bigger than ETH_ZLEN as a (hopefully) invariant.  I've attached the
>>edited down results below.
>>    
>
>What are you testing ? I don't see the relationship between network
>throughput and efficiency on this device.

I was thinking that for a sufficiently slow CPU running at 100% (hence the
lowly 386),  the throughput would be influenced by how efficiently we can
get in, get the Tx set up and get out.

>Drop it on a pentium or late 486 and use the tsc to compare the two code
>paths. One is much much more efficienct.

Using rdtscl over the  area affected by the patch on the two variants for a
sample  of 234 small packets, I see an average of 4141 for using the
existing stack scratch area, and 4162 for using skb_padto.   That is a
difference of about 0.5%, which is significantly less than the typical
spread in the samples themselves.  To help give a relevant scale,  feeding
it a larger 1400 byte packet comes in at around 60,000 cycles on this
particular box.   Am I being optimistic to see this as good news -- meaning
that there is no longer a need for driver specific padto implementations,
whereas it looks like there was back when you did your tests? 

Paul.




