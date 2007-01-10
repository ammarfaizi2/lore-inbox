Return-Path: <linux-kernel-owner+w=401wt.eu-S932804AbXAJNF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbXAJNF1 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbXAJNF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:05:27 -0500
Received: from stinky.trash.net ([213.144.137.162]:34330 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932806AbXAJNF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:05:26 -0500
Message-ID: <45A4E491.90106@trash.net>
Date: Wed, 10 Jan 2007 14:05:21 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Starvik <mikael.starvik@axis.com>
CC: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       Edgar Iglesias <edgar.iglesias@axis.com>,
       "'Netfilter Development Mailinglist'" 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Iptable loop during kernel startup
References: <BFECAF9E178F144FAEF2BF4CE739C66803BEED34@exmail1.se.axis.com>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66803BEED34@exmail1.se.axis.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Starvik wrote:
> Ok, this is what happens:
> 
> iptable_filter sets up initial_table.
> The part that says { IPT_ALIGN(sizeof(struct ipt_standard_target)), "" }
>   initializes a xt_entry_target struct. target_size gets the value 
>   0x24 and name "". 
> This is copied to loc_cpu_entry in iptables.c:ipt_register_table() 
>   and translate_table is called
> translate_table calls IPT_ENTRY_ITERATE with the 
>   check_entry_function
> check_entry does t->u.kernel.target = target;
> 
> On this particular architecture u.user.name and u.kernel.target in 
> struct xt_entry_target has the same address (because of the union). So 
> name that was previously "" gets mangled here.
> 
> check_entry returns into translate_table which calls mark_source_chains
> mark_source_chains compares t->target.u.user.name with 
> IPT_STANDARD_TARGET. name has been mangled above and the comparision 
> fails. On my ARM platform name has not been mangled (I guess this is 
> because target and name doesn't share address by I haven't checked).
> 
> So... Is it really correct to modify the target pointer there?


Please try the latest -stable kernel, this should be fixed already.
