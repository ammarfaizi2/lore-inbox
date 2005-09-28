Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbVI1AZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbVI1AZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbVI1AZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:25:46 -0400
Received: from marasystems.com ([83.241.133.2]:40086 "EHLO
	filer.marasystems.com") by vger.kernel.org with ESMTP
	id S1751167AbVI1AZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:25:45 -0400
Date: Wed, 28 Sep 2005 02:25:16 +0200 (CEST)
From: Henrik Nordstrom <hno@marasystems.com>
To: Andi Kleen <ak@suse.de>
cc: Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <200509271823.19365.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0509280219110.25500@filer.marasystems.com>
References: <432EF0C5.5090908@cosmosbay.com> <200509221503.21650.ak@suse.de>
 <20050923170911.GN731@sunbeam.de.gnumonks.org> <200509271823.19365.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005, Andi Kleen wrote:

> That could be special cased and done lockless, with the counting
> done per CPU.

It's also not very hard for iptables when verifying the table to conclude 
that there really isn't any "real" rules for a certain hook and then 
delete that hook registration (only policy ACCEPT rule found). Allowing 
you to have as many ip tables modules you like in the kernel, but only 
using the hooks where you have rules.  Drawback is that you loose the 
packet counters on the policy.

Exception: iptable_nat. Needs the hooks for other purposes as well, not 
just the iptable so here the hooks can not be deactivated when there is no 
rules.

Regards
Henrik
