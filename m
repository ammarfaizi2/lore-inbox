Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWHaP3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWHaP3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWHaP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:29:36 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:22492 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S1751501AbWHaP3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:29:36 -0400
Message-ID: <44F70092.3030300@candelatech.com>
Date: Thu, 31 Aug 2006 08:30:26 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mark Evans <evansmp@uhura.aston.ac.uk>,
       "Fred N. van Kempen" <waltje@uWalt.NL.Mugnet.ORG>,
       Ross Biro <ross.biro@gmail.com>, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org
Subject: Re: Unable to halt or reboot due to - unregister_netdevice: waiting
 for eth0.20 to become free. Usage count = 1
References: <9a8748490608310817v7d722f88u167b5a84d0ff67e8@mail.gmail.com>
In-Reply-To: <9a8748490608310817v7d722f88u167b5a84d0ff67e8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> Hi,
> 
> I've got a small problem with 2.6.18-rc5-git2.
> 
> I've got a vlan setup on eth0.20, eth0 does not have an IP.
> 
> When I attempt to reboot or halt the machine I get the following
> message from the loop in net/core/dev.c::netdev_wait_allrefs() where
> it waits for the ref-count to drop to zero.
> Unfortunately the ref-count stays at 1 forever and the server never
> gets any further.
> 
>  unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1
> 
> I googled a bit and found that people have had similar problems in the
> past and could work around them by shutting down the vlan interface
> before the 'lo' interface. I tried that and indeed, it works.
> 
> Any idea how we can get this fixed?

This is usually a ref-count leak somewhere.  Used to be IPv6 had 
issues..then there were some neighbor leaks...but these were fixed as 
far as I know.

Can you reproduce this on older kernels?

Ben

> 
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

