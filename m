Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTHTMzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbTHTMzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:55:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13462 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261934AbTHTMzF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:55:05 -0400
Message-ID: <3F436EF9.1040502@us.ibm.com>
Date: Wed, 20 Aug 2003 08:52:09 -0400
From: Harley Stenzel <hstenzel@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Richard Underwood <richard@aspectgroup.co.uk>, skraw@ithnet.com,
       willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
References: <353568DCBAE06148B70767C1B1A93E625EAB5D@post.pc.aspectgroup.co.uk> <20030819112103.373fce27.davem@redhat.com>
In-Reply-To: <20030819112103.373fce27.davem@redhat.com>
X-MIMETrack: Itemize by SMTP Server on D03NM118/03/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 08/20/2003 06:52:10,
	Serialize by Router on D03NM118/03/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 08/20/2003 06:52:50,
	Serialize complete at 08/20/2003 06:52:50
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 19 Aug 2003 19:05:13 +0100
> Richard Underwood <richard@aspectgroup.co.uk> wrote:
> 
>>	The ARP request represents all FUTURE
>>packets being sent out that interface, not just the one single packet that
>>happened to kick of this ARP request.
> 
> That's RIGHT!  And by your own argument the source address
> in the ARP request IS IRRELEVANT and is to be ignored!
> 

The source address in the ARP request is not irrelevant, because a 
broadcast arp request causes all recipients of that broadcast request to 
update their arp cache entry (if they have a cache entry for that IP) 
for the IP specified in the source with the MAC specified in the request.

So, in an environment where a single address is aliased in multiple 
places, such as tunnel endpoints and loopback aliases, and in 
multi-homed same-segment configs, it is unpredictable asto which IP will 
be bound to which MAC for every machine (or arp cache) on the network.

--Harley




