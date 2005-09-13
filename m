Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbVIMQfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbVIMQfh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbVIMQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:35:36 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:51683 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S964867AbVIMQff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:35:35 -0400
Message-ID: <4326FFC2.7030803@candelatech.com>
Date: Tue, 13 Sep 2005 09:35:14 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [patch 7/11] net: Use bigrefs for net_device.refcount
References: <20050913155112.GB3570@localhost.localdomain>	<20050913161012.GI3570@localhost.localdomain> <20050913092659.791bddec@localhost.localdomain>
In-Reply-To: <20050913092659.791bddec@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Tue, 13 Sep 2005 09:10:12 -0700
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> 
> 
>>The net_device has a refcnt used to keep track of it's uses.
>>This is used at the time of unregistering the network device
>>(module unloading ..) (see netdev_wait_allrefs) .
>>For loopback_dev , this refcnt increment/decrement  is causing
>>unnecessary traffic on the interlink for NUMA system
>>affecting it's performance.  This patch improves tbench numbers by 6% on a
>>8way x86 Xeon (x445).
>>
> 
> 
> Since when is bringing a network device up/down performance critical?

We grab and drop a reference for each poll of a device, roughly.

See dev_hold in _netif_rx_schedule(struct net_device *dev)
in include/netdevice.h, for instance.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

