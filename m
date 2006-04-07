Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWDGQSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWDGQSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 12:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGQSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 12:18:23 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:8989
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S932341AbWDGQSX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 12:18:23 -0400
Message-ID: <443690C9.5090500@avtrex.com>
Date: Fri, 07 Apr 2006 09:18:17 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hadi@cyberus.ca
CC: Janos Farkas <chexum+dev@gmail.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, pgf@foxharp.boston.ma.us,
       freek@macfreek.nl
Subject: Re: Broadcast ARP packets on link local addresses (Version2).
References: <17460.13568.175877.44476@dl2.hq2.avtrex.com>	 <priv$efbe06144502$2d51735f79@200604.gmail.com>	 <44353F36.9070404@avtrex.com> <1144416638.5082.33.camel@jzny2>
In-Reply-To: <1144416638.5082.33.camel@jzny2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2006 16:18:18.0016 (UTC) FILETIME=[E14FB200:01C65A5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> On Thu, 2006-06-04 at 09:17 -0700, David Daney wrote:
> 
>>Janos Farkas wrote:
> 
> 
>>>Sorry for chiming in this late in the discussion, but...  Shouldn't it
>>>be more correct to not depend on the ip address of the used network,
>>>but to use the "scope" parameter of the given address?
>>>
>>
> 
> Excellent point! It was bothering me as well but i couldnt express my
> view eloquently as you did.
> 
> 
>>RFC 3927 specifies the Ethernet arp broadcast behavior for only 
>>169.254.0.0/16.
> 
> 
> Thats besides the point. You could, for example, use 1.1.1.1/24 in your
> network instead of the 10.x or 192.x; and i have seen people use 10.x
> in what appears to be public networks. We dont have speacial checks for 
> RFC 1918 IP addresses for example.
> 

Following your logic through, It seems that you are advocating 
broadcasting *all* ARP packets on *all* link local addresses.  That 
would mean that on a 192.168.* switched Ethernet network with DHCP that 
twice as many ARP packets would be broadcast.

I don't think that is a good idea.  On networks with DHCP or statically 
allocated addresses, it would be a hard sell to tell people that they 
have to broadcast *all* ARP traffic even though there are neither 
standards that require nor suggest such action.

The scope parameter, as far as I can tell, is used to make routing 
decisions.  Overloading it to also implement the RFC 3927 ARP 
broadcasting requirement would result in generation of unnecessary 
network traffic in configurations that are probably the majority of 
Linux deployments.

> 169.254.0.0/16 is by definition link local. I think point made by Janos
> is we should look at the attributes rather than value.
> 

The converse is not true.  And that is my problem with this idea.

> Have your user space set it to be link local and then fix the kernel if
> it doesnt do the right thing.
> 

I could see adding an additional interface attribute that specifies link 
local, and then testing that.  But that adds substantially more overhead 
as you would have to allocate space for the attribute somewhere, and 
have extra code to allow setting/querying of the attribute from user space.

The requirement of RFC 3927 is very tightly targeted.  My patch does 
only what is required, no more.  It does not change ARP behavior for 
commonly deployed configurations.

> 
>>  Presumably you could set the scope parameter to local 
>>for addresses outside of that range or even for protocols other than 
>>Ethernet.  Since broadcasting ARP packets usually adversely effects 
>>usable network bandwidth, we should probably only do it where it is 
>>absolutely required.  The overhead of testing the value required by the 
>>RFC is quite low (3 machine instructions on i686 is the size of the 
>>entire patch), so using some proxy like the scope parameter would not 
>>even be a performance win.
>>
> 
> 
> Again, that is beside the point. 

It may be beside your point, I happen to think that it has some relevance.

David Daney
