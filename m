Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161261AbWBUBTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWBUBTJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWBUBTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 20:19:09 -0500
Received: from stinky.trash.net ([213.144.137.162]:1156 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1161261AbWBUBTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 20:19:08 -0500
Message-ID: <43FA6A2C.8000905@trash.net>
Date: Tue, 21 Feb 2006 02:17:32 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.16-rc4-mm1
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9BDDA.1060508@reub.net> <43F9CE18.10709@trash.net> <20060220204456.GG4661@stusta.de>
In-Reply-To: <20060220204456.GG4661@stusta.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, Feb 20, 2006 at 03:11:36PM +0100, Patrick McHardy wrote:
> 
>>Ideally this dependency should be enforced by Kconfig. I'm not sure
>>if it is possible to express something like "IP_DCCP_CCID2 and
>>IP_DCCP_CCID3 depend on DCCP, DCCP requires at least one of both
>>to be enabled". Can someone more familiar with Kconfig than me
>>comment on this? Otherwise the #error should be moved to
>>net/dccp/options.c to keep dccp.h usable without dccp enabled.
> 
> 
> I can try to do it, but I need the exact semantics.
> 
> Should all of the following stay allowed configurations?
> 
> CONFIG_IP_DCCP=y
> CONFIG_IP_DCCP_CCID2=m
> CONFIG_IP_DCCP_CCID3=n
> 
> CONFIG_IP_DCCP=y
> CONFIG_IP_DCCP_CCID2=y
> CONFIG_IP_DCCP_CCID3=m

Arnaldo apparently wants to fix it differently, but maybe you could help
us with conntrack :) CONFIG_IP_NF_CONNTRACK and CONFIG_NF_CONNTRACK
should be mutually exclusive. Specifying

CONFIG_IP_NF_CONNTRACK
	depends on CONFIG_NF_CONNTRACK=n

CONFIG_NF_CONNTRACK
	depends on CONFIG_IP_NF_CONNTRACK=n

will avoid asking for NF_CONNTRACK when IP_NF_CONNTRACK is set, but not
the other way around.
