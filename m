Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVLEEFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLEEFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 23:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVLEEFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 23:05:09 -0500
Received: from smtpout.mac.com ([17.250.248.73]:14784 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932294AbVLEEFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 23:05:08 -0500
In-Reply-To: <dmvk9i$631$1@terminus.zytor.com>
References: <20051204192958.64093.qmail@web60214.mail.yahoo.com> <Pine.LNX.4.63.0512041520320.29211@cuia.boston.redhat.com> <dmvk9i$631$1@terminus.zytor.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4CA89BCD-690D-45F8-864C-E0CE1CCC832C@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: virtual interface mac adress
Date: Sun, 4 Dec 2005 22:05:07 -0600
To: "H. Peter Anvin" <hpa@zytor.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 4, 2005, at 2:41 PM, H. Peter Anvin wrote:

> Followup to:  <Pine.LNX. 
> 4.63.0512041520320.29211@cuia.boston.redhat.com>
> By author:    Rik van Riel <riel@redhat.com>
> In newsgroup: linux.dev.kernel
>>
>> On Sun, 4 Dec 2005, anil dahiya wrote:
>>
>>> I want to assign mac addres to virtual adpater and mac
>>> address should be like that if it should not create
>>> problem in arp resoultion(i.e. mac address should be
>>> as real card which able to comunicate  on lan )
>>
>> You may be able to get away with using a MAC address
>> inside the OUI range that XenSource registered.
>
> Any MAC with bit 0 clear and bit 1 set in the first octet is "local
> use"; the best thing to do (unless you have your own OUI) is just to
> pick a random address inside this range.  You should only run into
> collision problems when you get close to 2^23 hosts on a network.

Theoretically that is true, however there are usages that have been  
approved that violate that principal. One was for TI Token Ring  
chips. They were completely unable to use "global" MAC addresses -  
the local bit always had to be set. Since TI could/would not fix  
their chips, using the local address became allowed for a universally  
unique address.

This method was later used by Apple on Ethernet for their DOS card.  
The Macintosh environment would get the global address and the DOS  
card would get the local one through the shared ethernet port. You  
might think that you can ignore the token ring case, but you'd be  
wrong - there are ethernet/token ring bridges deployed. The Apple  
case is also best not ignored. I don't know how many others may be  
doing similar things.

So, I would not advise anyone to simply believe that they can use the  
entire local MAC address space safely. You are also very likely to  
have trouble if there is any DECnet usage in the area. Anyone else  
notice that DECnet kernel patch recently? Someone must still be using  
it...

This is an instance where Linus' comment a few weeks ago regarding  
specs vs. reality comes into play. This is kind of an obscure area so  
not a whole lot of people know about some of these things. Don't  
believe everything you read in magazines regarding MAC addresses  
either. I've seen some very bad advice there from time to time in  
this particular area.

I would recommend using the same MAC address with the local bit set  
(as Apple did) for a single additional address. If you need more  
addresses and need them to be visible on the LAN, I don't know of a  
reliable, generic solution off the top of my head.

-- 
Mark Rustad, MRustad@mac.com

