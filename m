Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUGaRWC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUGaRWC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 13:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUGaRWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 13:22:01 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:10723 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S266137AbUGaRV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 13:21:58 -0400
Message-ID: <410BD525.3010102@candelatech.com>
Date: Sat, 31 Jul 2004 10:21:41 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, Jeff Garzik <jgarzik@pobox.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, akpm@osdl.org,
       alan@redhat.com, jgarzik@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040730121004.GA21305@alpha.home.local> <E1BqkzY-0003mK-00@gondolin.me.apana.org.au> <20040731083308.GA24496@alpha.home.local> <410B67B1.4080906@pobox.com> <20040731101152.GG1545@alpha.home.local> <20040731141222.GJ2429@mea-ext.zmailer.org> <410BD0E3.2090302@candelatech.com> <20040731170551.GA27559@alpha.home.local>
In-Reply-To: <20040731170551.GA27559@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> Hi Ben,
> 
> On Sat, Jul 31, 2004 at 10:03:31AM -0700, Ben Greear wrote:
>  
> 
>>VLAN allows you to continue using the ethX interface as a regular
>>ethernet interface, so you do not generally want it's MTU to be set
>>to 1504 because then the other peer ethernet interfaces would also
>>have to be set to 1504.  I believe it is much better to silently let
>>the extra 4 bytes pass but NOT advertise this extra 4 bytes to
>>anything that actually cares about MTU.
> 
> 
> I 100% agree with you on this one, but I don't see how playing with
> change_mtu() would change anything. Ideally, we would need to export
> the level 2 limit (imposed by hardware and intermediate switches) to
> other drivers such as 802_1q, and let only the IP stack rely on dev->mtu.

Ok, I agree that it would be good to have a hard limit exported.
I am less certain that VLAN should modify any MTU based on this
information, but at the very least, it could warn the user that
some action needs to be taken and let the user make an informed
decision.

Also, it seems that most (all?) ethernet chips can handle the extra
4 bytes, but the patches are varying degrees of ugliness and so
many have not made it into the kernel proper.


> I've seen several drivers which silently add 4 bytes to the hardware
> config when CONFIG_VLAN is set. I find it better than fooling the IP
> stack into using 1504 bytes, which is a disaster on UDP !

It would be a disaster with any IP protocol, not just UDP.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

