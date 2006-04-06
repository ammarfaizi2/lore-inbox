Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWDFQUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWDFQUy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWDFQUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:20:53 -0400
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:29712
	"EHLO avtrex.com") by vger.kernel.org with ESMTP id S1751265AbWDFQUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:20:52 -0400
Message-ID: <44353F36.9070404@avtrex.com>
Date: Thu, 06 Apr 2006 09:17:58 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Janos Farkas <chexum+dev@gmail.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       pgf@foxharp.boston.ma.us, freek@macfreek.nl
Subject: Re: Broadcast ARP packets on link local addresses (Version2).
References: <17460.13568.175877.44476@dl2.hq2.avtrex.com> <priv$efbe06144502$2d51735f79@200604.gmail.com>
In-Reply-To: <priv$efbe06144502$2d51735f79@200604.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2006 16:20:51.0412 (UTC) FILETIME=[12545140:01C65996]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janos Farkas wrote:
> On 2006-04-05 at 14:22:08, David Daney wrote:
> 
>>The changes in this version are that it tests the source IP address
>>instead of the destination.  The test now matches the test described
>>in the RFC.  Also a small cleanup as suggested by Herbert Xu.
>>
>>Some comments on the first version of the patch suggested that I do
>>'X' instead.  Where 'X' was behavior different than that REQUIRED by
>>the RFC (the RFC's always seem to capitalize the word 'required').
>>
>>The reason that I implemented the behavior required by the RFC is so
>>that a device running the kernel can pass compliance tests that
>>mandate RFC compliance.
> 
> 
> Sorry for chiming in this late in the discussion, but...  Shouldn't it
> be more correct to not depend on the ip address of the used network,
> but to use the "scope" parameter of the given address?
> 

RFC 3927 specifies the Ethernet arp broadcast behavior for only 
169.254.0.0/16.  Presumably you could set the scope parameter to local 
for addresses outside of that range or even for protocols other than 
Ethernet.  Since broadcasting ARP packets usually adversely effects 
usable network bandwidth, we should probably only do it where it is 
absolutely required.  The overhead of testing the value required by the 
RFC is quite low (3 machine instructions on i686 is the size of the 
entire patch), so using some proxy like the scope parameter would not 
even be a performance win.

David Daney
