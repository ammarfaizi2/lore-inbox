Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267825AbUHWWrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267825AbUHWWrf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUHWWrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:47:06 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:9417 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267930AbUHWWfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:35:12 -0400
Message-ID: <412A70ED.3070306@ttnet.net.tr>
Date: Tue, 24 Aug 2004 01:34:21 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH 2.4] gcc-3.4 more fixes
References: <4129F41A.3070805@ttnet.net.tr> <20040823123430.GD4569@logos.cnet> <4129FB86.40508@ttnet.net.tr> <20040823131137.GA1779@logos.cnet>
	 <412A6D2F.1030704@pobox.com>
In-Reply-To: <412A6D2F.1030704@pobox.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Marcelo Tosatti wrote:
> 
>> On Mon, Aug 23, 2004 at 05:13:26PM +0300, O.Sezer wrote:
>>
>>> Marcelo Tosatti wrote:
>>>
>>>> On Mon, Aug 23, 2004 at 04:41:46PM +0300, O.Sezer wrote:
>>>>
>>>>
>>>>>>> Ozkan,
>>>>>>>
>>>>>>> This are just warning fixes right?
>>>>>>>
>>>>>>> I dont like this patches, that is, I'm not confident about them.
>>>>>>>
>>>>>>> Let the warnings be.
>>>>>>
>>>>>>
>>>>>> For gcc-3.4 they're warnings. For gcc-3.5 they'll cause compiler
>>>>>> failures (that's what mikpe says on cset-1.1490, too)
>>>>>
>>>>>
>>>>> As a side note, almost all of them are in 2.6 anyway (can't
>>>>> honestly remember which aren't)
>>>>
>>>>
>>>>
>>>> Have you nocited the deadly mistake you made I showed with the grep?
>>>>
>>>
>>> Oopss :/  Than 2.6 has the same deadly thing. I'm too trusting I
>>> guess..  The correct thing should be to change "if (!(PRIV(dev) ="
>>> into "if (!(dev->phy_data =", right?
>>
>>
>>
>> I think so yes. A network driver expert can confirm this for us.
> 
> 
> 
> Not enough context is quoted for me to decipher what this refers to :(
> 
> URL?
> 
>     Jeff

To fix the gcc-3.4 lvalue warnings in drivers/atm/idt77105.c, 2.6 does:
at line 267:
-	if (!(PRIV(dev) = kmalloc(sizeof(struct ......
+	if (!(dev->dev_data = kmalloc(sizeof(struct ......
and at line 345:
-		PRIV(dev) = NULL;
+		dev->dev_data = NULL;
(see 2.6 bk-repo, cset-1.1371.280.43)

But the define for PRIV is (2.6, line 44):
#define PRIV(dev) ((struct idt77105_priv *) dev->phy_data)

So it seems the correct change should be change those "PRIV(dev) ="
into "dev->phy_data =" not "dev->dev_data =".
